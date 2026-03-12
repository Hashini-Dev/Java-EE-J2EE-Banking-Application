package lk.jiat.app.ejb.bean;

import jakarta.ejb.Schedule;
import jakarta.ejb.Singleton;
import jakarta.ejb.Startup;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.interceptor.Interceptors;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.app.ejb.interceptor.LoggingInterceptor;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import lk.jiat.app.core.model.Account;

/**
 * Automates interest calculations and periodic balance updates.
 * Demonstrates @Schedule for Task 1 and Task 2.
 */
@Singleton
@Startup
@Interceptors(LoggingInterceptor.class)
public class InterestCalculationBean {

    @PersistenceContext
    private EntityManager em;

    /**
     * Run at midnight every day.
     * Demonstrates @Schedule for Task 1 and Task 2.
     */
    @Schedule(second = "0", minute = "0", hour = "0", persistent = false)
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void calculateDailyInterest() {
        System.out.println("Starting automated daily interest calculation...");

        List<Account> accounts = em.createQuery("SELECT a FROM Account a", Account.class).getResultList();

        for (Account account : accounts) {
            if (account.getInterestRate() != null && account.getInterestRate().compareTo(BigDecimal.ZERO) > 0) {
                BigDecimal interest = account.getBalance()
                        .multiply(account.getInterestRate())
                        .divide(new BigDecimal("100"), 2, RoundingMode.HALF_UP);

                account.setBalance(account.getBalance().add(interest));
                em.merge(account);
                System.out.println(
                        "Applied " + account.getInterestRate() + "% interest to Account ID: " + account.getId());
            }
        }

        System.out.println("Interest calculation completed for " + accounts.size() + " accounts.");
    }
}
