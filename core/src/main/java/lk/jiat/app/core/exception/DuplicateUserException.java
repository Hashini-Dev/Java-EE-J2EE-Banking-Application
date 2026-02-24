package lk.jiat.app.core.exception;

import jakarta.ejb.ApplicationException;

/**
 * Exception thrown when a user registration fails due to duplicate
 * email, NIC, or contact.
 */
@ApplicationException(rollback = true)
public class DuplicateUserException extends BankingSystemException {
    public DuplicateUserException(String message) {
        super(message);
    }
}
