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

    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public FundTransfer scheduleFundTransfer(String fromAccountNoStr, String toAccountNoStr,
            BigDecimal amount, LocalDate paymentDate, String description) {

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

        if (fromAccount.getBalance().compareTo(amount) < 0) {
            throw new IllegalArgumentException("Insufficient funds in fromAccount");
        }

        fromAccount.setBalance(fromAccount.getBalance().subtract(amount));
        toAccount.setBalance(toAccount.getBalance().add(amount));

        em.merge(fromAccount);
        em.merge(toAccount);

        FundTransfer transfer = new FundTransfer();
        transfer.setFromAccount(fromAccount);
        transfer.setToAccount(toAccount);
        transfer.setAmount(amount);
        transfer.setPaymentDate(paymentDate);
        transfer.setDescription(description);
        Status completedStatus;
        try {
            completedStatus = em.createQuery("SELECT s FROM Status s WHERE s.status = :name", Status.class)
                    .setParameter("name", "Success")
                    .getSingleResult();
        } catch (NoResultException e) {
            // Fallback or better error
            throw new IllegalStateException(
                    "Status 'Success' not found in database. Please ensure data seeding is complete.", e);
        }
        transfer.setStatus(completedStatus);

        em.persist(transfer);

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
        Long transferId = (Long) timer.getInfo();
        System.out.println("Executing scheduled fund transfer ID: " + transferId);

        FundTransfer transfer = em.find(FundTransfer.class, transferId);
        if (transfer != null && transfer.getStatus() != null && "Pending".equals(transfer.getStatus().getStatus())) {
            // Logic for actual transfer if it wasn't processed immediately
            // In this specific implementation, it seems transferFunds marks it as COMPLETED
            // This timeout would be used for truly delayed execution.
            System.out.println("Processing pending transfer ID: " + transferId);
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
