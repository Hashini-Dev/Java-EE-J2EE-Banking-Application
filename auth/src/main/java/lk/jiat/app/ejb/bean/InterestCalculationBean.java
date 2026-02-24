package lk.jiat.app.ejb.bean;

import jakarta.ejb.Schedule;
import jakarta.ejb.Singleton;
import jakarta.ejb.Startup;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.math.BigDecimal;
import java.util.List;
import lk.jiat.app.core.model.Account;

/**
 * Automates interest calculations and periodic balance updates.
 * Demonstrates @Schedule for Task 1 and Task 2.
 */
@Singleton
@Startup
public class InterestCalculationBean {

    @PersistenceContext
    private EntityManager em;

    // Run at midnight every day
    @Schedule(second = "0", minute = "0", hour = "0", persistent = false)
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void calculateDailyInterest() {
        System.out.println("Starting daily interest calculation...");

        List<Account> accounts = em.createQuery("SELECT a FROM Account a", Account.class).getResultList();
        BigDecimal interestRate = new BigDecimal("0.0001"); // 0.01% daily interest for demo

        for (Account account : accounts) {
            BigDecimal interest = account.getBalance().multiply(interestRate);
            account.setBalance(account.getBalance().add(interest));
            em.merge(account);
            System.out.println("Applied interest to Account ID: " + account.getId());
        }

        System.out.println("Interest calculation completed for " + accounts.size() + " accounts.");
    }
}
