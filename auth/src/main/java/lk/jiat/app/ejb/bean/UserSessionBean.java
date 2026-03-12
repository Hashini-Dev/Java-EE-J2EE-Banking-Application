package lk.jiat.app.ejb.bean;

import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import lk.jiat.app.core.exception.DuplicateUserException;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.core.model.AccountType;
import lk.jiat.app.core.model.User;
import lk.jiat.app.core.model.UserType;
import lk.jiat.app.core.service.UserService;
import java.util.List;

@Stateless
public class UserSessionBean implements UserService {

    @PersistenceContext
    private EntityManager em;

    @jakarta.annotation.Resource
    private jakarta.ejb.SessionContext ctx;

    /**
     * Demonstrates programmatic authorization as required for Task 2.
     */
    public void performHighSecurityAction() {
        if (!ctx.isCallerInRole("ADMIN")) {
            throw new SecurityException("Access Denied: Caller does not have ADMIN role");
        }
        System.out.println("Administrative action authorized via programmatic check.");
    }

    @Override
    public User getUserById(Long id) {
        return em.find(User.class, id);
    }

    @Override
    public List<User> getAllUsers() {
        return em.createQuery("SELECT u FROM User u", User.class).getResultList();
    }

    @Override
    public User getUserByUsername(String username) {
        try {
            return em.createNamedQuery("User.findByUsername", User.class)
                    .setParameter("username", username).getSingleResult();
        } catch (jakarta.persistence.NoResultException e) {
            return null;
        }
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void addUser(User user) {
        em.persist(user);
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void registerUser(User user) {
        // Check for existing users
        if (existsByUsername(user.getUsername())) {
            throw new DuplicateUserException("Already have account for this username");
        }
        if (existsByEmail(user.getEmail())) {
            throw new DuplicateUserException("Already have account for this email");
        }
        if (existsByNic(user.getNic())) {
            throw new DuplicateUserException("Already have account for this nic");
        }
        if (existsByContact(user.getContact())) {
            throw new DuplicateUserException("Already have account for this mobile");
        }

        // Find default User Type
        UserType customerType = em.createQuery("SELECT ut FROM UserType ut WHERE ut.type = :type", UserType.class)
                .setParameter("type", "Customer")
                .getSingleResult();
        user.setUserType(customerType);

        // Persist User
        em.persist(user);

        // Create Default Account
        Account account = new Account();
        account.setUser(user);
        account.setBalance(new java.math.BigDecimal("1000.00"));
        account.setInterestRate(new java.math.BigDecimal("2.5"));

        AccountType savingsType = em
                .createQuery("SELECT at FROM AccountType at WHERE at.type = :type", AccountType.class)
                .setParameter("type", "Savings")
                .getSingleResult();
        account.setAccountType(savingsType);
        account.setAccountNo(System.currentTimeMillis());

        // Persist Account
        em.persist(account);
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void registerAdmin(User user) {
        // Check for existing users
        if (existsByUsername(user.getUsername())) {
            throw new DuplicateUserException("Already have account for this username");
        }
        if (existsByEmail(user.getEmail())) {
            throw new DuplicateUserException("Already have account for this email");
        }
        if (existsByNic(user.getNic())) {
            throw new DuplicateUserException("Already have account for this nic");
        }
        if (existsByContact(user.getContact())) {
            throw new DuplicateUserException("Already have account for this mobile");
        }

        // Find Admin User Type
        UserType adminType = em.createQuery("SELECT ut FROM UserType ut WHERE ut.type = :type", UserType.class)
                .setParameter("type", "Admin")
                .getSingleResult();
        user.setUserType(adminType);

        // Persist User ONLY (No Account)
        em.persist(user);
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void updateUser(User user) {
        em.merge(user);
    }

    @RolesAllowed({ "CUSTOMER", "ADMIN", "SUPER_ADMIN" })
    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void deleteUser(User user) {
        User managedUser = em.merge(user);
        em.remove(managedUser);
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public boolean validate(String username, String password) {
        try {
            User user = em.createNamedQuery("User.findByUsername", User.class)
                    .setParameter("username", username).getSingleResult();

            return user != null && user.getPassword().equals(password);
        } catch (NoResultException e) {
            return false;
        }
    }

    @Override
    public boolean existsByUsername(String username) {
        Long count = em.createQuery("SELECT COUNT(u) FROM User u WHERE u.username = :username", Long.class)
                .setParameter("username", username)
                .getSingleResult();
        return count > 0;
    }

    @Override
    public boolean existsByEmail(String email) {
        Long count = em.createQuery("SELECT COUNT(u) FROM User u WHERE u.email = :email", Long.class)
                .setParameter("email", email)
                .getSingleResult();
        return count > 0;
    }

    @Override
    public boolean existsByNic(String nic) {
        Long count = em.createQuery("SELECT COUNT(u) FROM User u WHERE u.nic = :nic", Long.class)
                .setParameter("nic", nic)
                .getSingleResult();
        return count > 0;
    }

    @Override
    public boolean existsByContact(String contact) {
        Long count = em.createQuery("SELECT COUNT(u) FROM User u WHERE u.contact = :contact", Long.class)
                .setParameter("contact", contact)
                .getSingleResult();
        return count > 0;
    }

    public Account getAccountByUserId(Long userId) {
        try {
            return em.createQuery("SELECT a FROM Account a WHERE a.user.id = :userId", Account.class)
                    .setParameter("userId", userId)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

}