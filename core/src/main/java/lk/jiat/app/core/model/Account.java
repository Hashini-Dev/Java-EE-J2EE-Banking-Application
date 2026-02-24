package lk.jiat.app.core.model;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "account")
@NamedQueries({
        @NamedQuery(name = "Account.findByAccountNo", query = "SELECT a FROM Account a WHERE a.accountNo=:accountNo")
})
@Cacheable(false)
public class Account implements java.io.Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "account_no", unique = true, nullable = false)
    private Long accountNo;

    @Column(nullable = false, precision = 19, scale = 4)
    private BigDecimal balance = BigDecimal.ZERO;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "users_id")
    private User user;

    @Column(name = "interest_rate", nullable = false)
    private BigDecimal interestRate;

    @ManyToOne
    @JoinColumn(name = "account_type_id")
    private AccountType accountType;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Long getAccountNo() {
        return accountNo;
    }

    public void setAccountNo(Long accountNo) {
        this.accountNo = accountNo;
    }

    public BigDecimal getBalance() {
        return balance;
    }

    public void setBalance(BigDecimal balance) {
        this.balance = balance;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public BigDecimal getInterestRate() {
        return interestRate;
    }

    public void setInterestRate(BigDecimal interestRate) {
        this.interestRate = interestRate;
    }

    public AccountType getAccountType() {
        return accountType;
    }

    public void setAccountType(AccountType accountType) {
        this.accountType = accountType;
    }
}
