package lk.jiat.app.ejb.bean;

import jakarta.annotation.Resource;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionManagement;
import jakarta.ejb.TransactionManagementType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.UserTransaction;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.core.exception.BankingSystemException;

import java.math.BigDecimal;

/**
 * Demonstrates Bean-Managed Transactions (BMT) using UserTransaction.
 * Required for Task 2 assessment.
 */
@Stateless
@TransactionManagement(TransactionManagementType.BEAN)
public class BmtTransactionBean {

    @PersistenceContext
    private EntityManager em;

    @Resource
    private UserTransaction utx;

    public void processManualTransfer(Integer fromId, Integer toId, BigDecimal amount) {
        try {
            utx.begin(); // Manual demarcation

            Account from = em.find(Account.class, fromId);
            Account to = em.find(Account.class, toId);

            if (from.getBalance().compareTo(amount) < 0) {
                throw new BankingSystemException("Insufficient funds for BMT transfer");
            }

            from.setBalance(from.getBalance().subtract(amount));
            to.setBalance(to.getBalance().add(amount));

            em.merge(from);
            em.merge(to);

            utx.commit(); // Explicit commit
            System.out.println("BMT Transfer successful");

        } catch (Exception e) {
            try {
                utx.rollback(); // Explicit rollback on failure
                System.err.println("BMT Transaction rolled back due to: " + e.getMessage());
            } catch (Exception re) {
                re.printStackTrace();
            }
            throw new BankingSystemException("Transaction failed: " + e.getMessage());
        }
    }
}
