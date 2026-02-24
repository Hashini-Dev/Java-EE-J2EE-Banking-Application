package lk.jiat.app.ejb.bean;

import jakarta.annotation.PostConstruct;
import jakarta.ejb.Singleton;
import jakarta.ejb.Startup;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.app.core.model.AccountType;
import lk.jiat.app.core.model.Status;
import lk.jiat.app.core.model.UserType;

@Singleton
@Startup
public class DatabaseSeederBean {

    @PersistenceContext
    private EntityManager em;

    @PostConstruct
    public void init() {
        seedUserTypes();
        seedStatuses();
        seedAccountTypes();
    }

    private void seedUserTypes() {
        seedUserType("Admin");
        seedUserType("Customer");
    }

    private void seedUserType(String type) {
        Long count = em.createQuery("SELECT count(ut) FROM UserType ut WHERE ut.type = :type", Long.class)
                .setParameter("type", type)
                .getSingleResult();
        if (count == 0) {
            em.persist(new UserType(type));
        }
    }

    private void seedStatuses() {
        seedStatus("Active");
        seedStatus("Inactive");
        seedStatus("Pending");
        seedStatus("Success");
        seedStatus("Failed");
    }

    private void seedStatus(String status) {
        Long count = em.createQuery("SELECT count(s) FROM Status s WHERE s.status = :status", Long.class)
                .setParameter("status", status)
                .getSingleResult();
        if (count == 0) {
            em.persist(new Status(status));
        }
    }

    private void seedAccountTypes() {
        seedAccountType("Savings");
        seedAccountType("Current");
    }

    private void seedAccountType(String type) {
        Long count = em.createQuery("SELECT count(at) FROM AccountType at WHERE at.type = :type", Long.class)
                .setParameter("type", type)
                .getSingleResult();
        if (count == 0) {
            em.persist(new AccountType(type));
        }
    }
}
