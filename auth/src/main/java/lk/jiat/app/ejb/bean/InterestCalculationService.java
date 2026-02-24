package lk.jiat.app.ejb.bean;

import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.*;
import jakarta.interceptor.Interceptors;
import jakarta.persistence.EntityManager;
import lk.jiat.app.ejb.interceptor.LoggingInterceptor;
import jakarta.persistence.PersistenceContext;
import lk.jiat.app.core.model.Account;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

@Stateless
@Interceptors(LoggingInterceptor.class)
public class InterestCalculationService {

    @PersistenceContext
    private EntityManager em;

    /**
     * Automatically applies interest to all accounts daily at midnight.
     * Demonstrates EJB Timer Service (@Schedule).
     */
    @Schedule(second = "0", minute = "0", hour = "0", dayOfMonth = "*", month = "*", year = "*", persistent = false)
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void scheduledInterestCalculation() {
        System.out.println("Executing scheduled interest calculation at: " + new java.util.Date());
        applyInterestToAllAccounts();
    }

    @RolesAllowed("ADMIN")
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void applyInterestToAllAccounts() {
        List<Account> accounts = em.createQuery("SELECT a FROM Account a", Account.class).getResultList();

        for (Account acc : accounts) {
            if (acc.getInterestRate() != null && acc.getInterestRate().compareTo(BigDecimal.ZERO) > 0) {
                BigDecimal interest = acc.getBalance()
                        .multiply(acc.getInterestRate())
                        .divide(new BigDecimal("100"), 2, RoundingMode.HALF_UP);

                acc.setBalance(acc.getBalance().add(interest));
                em.merge(acc);
            }
        }
    }
}
