package lk.jiat.app.ejb.bean;

import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.core.model.User;

@Stateless
@RolesAllowed({ "CUSTOMER", "ADMIN" })
public class AccountServiceBean {

    @PersistenceContext
    private EntityManager em;

    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public List<Account> getAllAccounts() {
        return em.createQuery("SELECT a FROM Account a", Account.class)
                .getResultList();
    }

    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public Account findById(Long id) {
        return em.find(Account.class, id);
    }

    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    @RolesAllowed("ADMIN")
    public void save(Account account) {
        if (account.getId() == null) {
            em.persist(account);
        } else {
            em.merge(account);
        }
    }

    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    @RolesAllowed("ADMIN")
    public void delete(Long id) {
        Account acc = em.find(Account.class, id);
        if (acc != null) {
            em.remove(acc);
        }
    }

    public Account getAccountByUser(User user) {
        try {
            return em.createQuery("SELECT a FROM Account a WHERE a.user = :user", Account.class)
                    .setParameter("user", user)
                    .getSingleResult();
        } catch (jakarta.persistence.NoResultException e) {
            return null;
        }
    }

    public List<Account> getAccountsByUser(User user) {
        return em.createQuery("SELECT a FROM Account a JOIN FETCH a.accountType WHERE a.user = :user", Account.class)
                .setParameter("user", user)
                .getResultList();
    }

}
