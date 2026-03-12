package lk.jiat.app.ejb.bean;

import jakarta.annotation.Resource;
import jakarta.ejb.Stateless;
import jakarta.ejb.Timeout;
import jakarta.ejb.Timer;
import jakarta.ejb.TimerConfig;
import jakarta.ejb.TimerService;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.NoResultException;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.core.model.FundTransfer;
import lk.jiat.app.core.model.Status;
import lk.jiat.app.core.model.TransferType;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

import jakarta.annotation.security.RolesAllowed;
import jakarta.interceptor.Interceptors;
import lk.jiat.app.ejb.interceptor.LoggingInterceptor;

@Stateless
@Interceptors(LoggingInterceptor.class)
@RolesAllowed({ "CUSTOMER", "ADMIN" })
public class FundTransferServiceBean {

    @PersistenceContext
    private EntityManager em;

    @Resource
    private TimerService timerService;

    public java.util.List<TransferType> getAllTransferTypes() {
        return em.createQuery("SELECT t FROM TransferType t", TransferType.class).getResultList();
    }

    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public FundTransfer scheduleFundTransfer(String fromAccountNoStr, String toAccountNoStr,
            BigDecimal amount, LocalDate paymentDate, String description, Integer transferTypeId) {

        Long fromAccountNo;
        Long toAccountNo;

        try {
            fromAccountNo = Long.valueOf(fromAccountNoStr);
            toAccountNo = Long.valueOf(toAccountNoStr);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Invalid account number format", e);
        }

        Account fromAccount;
        Account toAccount;

        try {
            fromAccount = em.createNamedQuery("Account.findByAccountNo", Account.class)
                    .setParameter("accountNo", fromAccountNo)
                    .getSingleResult();

            toAccount = em.createNamedQuery("Account.findByAccountNo", Account.class)
                    .setParameter("accountNo", toAccountNo)
                    .getSingleResult();
        } catch (NoResultException e) {
            throw new IllegalArgumentException("Account not found with provided account number", e);
        }

        if (fromAccount.getAccountNo().equals(toAccount.getAccountNo())) {
            throw new IllegalArgumentException("BENEFICIARY ACCOUNT NO and FROM ACCOUNT can't be the same");
        }

        if (amount.compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Amount must be greater than zero");
        }

        if (fromAccount.getBalance().compareTo(amount) < 0) {
            throw new IllegalArgumentException("Insufficient funds to complete the transfer");
        }

        boolean isToday = paymentDate.isEqual(LocalDate.now());

        if (isToday) {
            fromAccount.setBalance(fromAccount.getBalance().subtract(amount));
            toAccount.setBalance(toAccount.getBalance().add(amount));

            em.merge(fromAccount);
            em.merge(toAccount);
        }
        TransferType transferType = em.find(TransferType.class, transferTypeId);
        if (transferType == null) {
            throw new IllegalArgumentException("Invalid transfer type selected");
        }

        FundTransfer transfer = new FundTransfer();
        if (isToday) {
            if (fromAccount.getBalance().compareTo(amount) < 0) {
                throw new IllegalArgumentException("Insufficient funds for instant transfer");
            }
            fromAccount.setBalance(fromAccount.getBalance().subtract(amount));
            toAccount.setBalance(toAccount.getBalance().add(amount));
            em.merge(fromAccount);
            em.merge(toAccount);
        }

        transfer.setFromAccount(fromAccount);
        transfer.setToAccount(toAccount);
        transfer.setAmount(amount);
        transfer.setPaymentDate(paymentDate);
        transfer.setDescription(description);
        transfer.setProcessed(isToday);
        transfer.setTransferType(transferType);

        Status status;
        try {
            String statusName = isToday ? "Success" : "Pending";
            status = em.createQuery("SELECT s FROM Status s WHERE s.status = :name", Status.class)
                    .setParameter("name", statusName)
                    .getSingleResult();
        } catch (NoResultException e) {
            throw new IllegalStateException(
                    "Required status not found in database. Please ensure data seeding is complete.", e);
        }
        transfer.setStatus(status);

        em.persist(transfer);

        if (!isToday) {
            // Schedule timer for future execution (1 MINUTE FROM NOW FOR DEMO/TESTING)
            LocalDateTime triggerTime = LocalDateTime.now().plusMinutes(1);
            Date triggerDate = Date.from(triggerTime.atZone(ZoneId.systemDefault()).toInstant());
            TimerConfig config = new TimerConfig(transfer.getId(), true); // Made persistent just in case
            timerService.createSingleActionTimer(triggerDate, config);
        }

        return transfer;
    }

    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void transferFunds(FundTransfer transfer, LocalDate paymentDate) {
        Account fromAccount = em.find(Account.class, transfer.getFromAccount().getId());
        Account toAccount = em.find(Account.class, transfer.getToAccount().getId());

        if (fromAccount.getBalance().compareTo(transfer.getAmount()) < 0) {
            throw new IllegalArgumentException("Insufficient funds");
        }

        fromAccount.setBalance(fromAccount.getBalance().subtract(transfer.getAmount()));
        toAccount.setBalance(toAccount.getBalance().add(transfer.getAmount()));

        em.merge(fromAccount);
        em.merge(toAccount);

        Status completedStatus;
        try {
            completedStatus = em.createQuery("SELECT s FROM Status s WHERE s.status = :name", Status.class)
                    .setParameter("name", "Success")
                    .getSingleResult();
        } catch (NoResultException e) {
            throw new IllegalStateException("Status 'Success' not found in database.", e);
        }
        transfer.setStatus(completedStatus);
        em.merge(transfer);

        // Schedule timer
        LocalDateTime triggerTime = paymentDate.atTime(0, 1);
        LocalDateTime now = LocalDateTime.now();

        if (triggerTime.isBefore(now.plusMinutes(1))) {
            triggerTime = now.plusMinutes(1);
        }

        Date triggerDate = Date.from(triggerTime.atZone(ZoneId.systemDefault()).toInstant());
        TimerConfig config = new TimerConfig(transfer.getId(), false);
        timerService.createSingleActionTimer(triggerDate, config);
    }

    @Timeout
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void executeScheduledTransfer(Timer timer) {
        Integer transferId = (Integer) timer.getInfo();
        System.out.println("Executing scheduled fund transfer ID: " + transferId);

        FundTransfer transfer = em.find(FundTransfer.class, transferId);
        if (transfer != null && !transfer.getProcessed()) {
            Account fromAccount = transfer.getFromAccount();
            Account toAccount = transfer.getToAccount();
            BigDecimal amount = transfer.getAmount();

            if (fromAccount.getBalance().compareTo(amount) >= 0) {
                fromAccount.setBalance(fromAccount.getBalance().subtract(amount));
                toAccount.setBalance(toAccount.getBalance().add(amount));

                transfer.setProcessed(true);
                try {
                    Status successStatus = em.createQuery("SELECT s FROM Status s WHERE s.status = :name", Status.class)
                            .setParameter("name", "Success")
                            .getSingleResult();
                    transfer.setStatus(successStatus);
                } catch (NoResultException e) {
                    System.err.println("Success status not found during scheduled transfer");
                }

                em.merge(fromAccount);
                em.merge(toAccount);
                em.merge(transfer);
                System.out.println("Successfully processed scheduled transfer ID: " + transferId);
            } else {
                try {
                    Status failedStatus = em.createQuery("SELECT s FROM Status s WHERE s.status = :name", Status.class)
                            .setParameter("name", "Failed")
                            .getSingleResult();
                    transfer.setStatus(failedStatus);
                    em.merge(transfer);
                } catch (NoResultException e) {
                    System.err.println("Failed status not found during scheduled transfer");
                }
                System.out.println("Scheduled transfer ID: " + transferId + " failed due to insufficient funds");
            }
        }
    }

    public java.util.List<FundTransfer> getTransferHistory(Long userId) {
        return em.createQuery(
                "SELECT f FROM FundTransfer f " +
                        "JOIN FETCH f.fromAccount fa " +
                        "JOIN FETCH fa.user " +
                        "JOIN FETCH fa.accountType " +
                        "JOIN FETCH f.toAccount ta " +
                        "JOIN FETCH ta.user " +
                        "JOIN FETCH ta.accountType " +
                        "WHERE fa.user.id = :userId OR ta.user.id = :userId " +
                        "ORDER BY f.paymentDate DESC",
                FundTransfer.class)
                .setParameter("userId", userId)
                .getResultList();
    }
}
