package lk.jiat.app.core.service;

import jakarta.ejb.Remote;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.core.model.User;

@Remote
public interface UserService {
    User getUserById(Long id);

    User getUserByUsername(String username);

    void addUser(User user);

    void registerUser(User user);

    void updateUser(User user);

    void deleteUser(User user);

    boolean validate(String username, String password);

    boolean existsByEmail(String email);

    boolean existsByNic(String nic);

    boolean existsByContact(String contact);

    Account getAccountByUserId(Long id);

}
