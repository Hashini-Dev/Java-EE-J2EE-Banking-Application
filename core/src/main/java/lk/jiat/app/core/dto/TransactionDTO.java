package lk.jiat.app.core.dto;

import java.math.BigDecimal;
import java.time.LocalDate;

public class TransactionDTO {
    private LocalDate transactionDate;
    private String transactionType;
    private BigDecimal amount;
    private String description;

    public TransactionDTO() {
    }

    public TransactionDTO(LocalDate transactionDate, String transactionType, BigDecimal amount, String description) {
        this.transactionDate = transactionDate;
        this.transactionType = transactionType;
        this.amount = amount;
        this.description = description;
    }

    public LocalDate getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(LocalDate transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
