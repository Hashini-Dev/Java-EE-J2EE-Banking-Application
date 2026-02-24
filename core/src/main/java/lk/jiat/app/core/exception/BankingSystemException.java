package lk.jiat.app.core.exception;

import jakarta.ejb.ApplicationException;

/**
 * Custom application exception for banking operations.
 * Annotated with @ApplicationException(rollback=true) to ensure
 * that any transaction is rolled back when this exception is thrown.
 */
@ApplicationException(rollback = true)
public class BankingSystemException extends RuntimeException {

    public BankingSystemException(String message) {
        super(message);
    }

    public BankingSystemException(String message, Throwable cause) {
        super(message, cause);
    }
}
