package lk.jiat.app.ejb.bean;

import jakarta.ejb.Stateless;
import jakarta.persistence.*;
import lk.jiat.app.core.dto.TransactionDTO;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Stateless
public class TransactionHistoryService {

    @PersistenceContext
    private EntityManager em;

    public List<TransactionDTO> getFilteredTransactions(
            int accountId,
            LocalDate fromDate,
            LocalDate toDate,
            BigDecimal minAmount,
            String transactionType,
            int page,
            int pageSize
    ) {
        String baseQuery =
                "SELECT new lk.jiat.app.core.dto.TransactionDTO(" +
                        "f.paymentDate, " +
                        "CASE WHEN f.fromAccount.id = :accountId THEN 'DEBIT' ELSE 'CREDIT' END, " +
                        "f.amount, " +
                        "f.description) " +
                        "FROM FundTransfer f " +
                        "WHERE (f.fromAccount.id = :accountId OR f.toAccount.id = :accountId)";

        if (fromDate != null) baseQuery += " AND f.paymentDate >= :fromDate";
        if (toDate != null) baseQuery += " AND f.paymentDate <= :toDate";
        if (minAmount != null) baseQuery += " AND f.amount >= :minAmount";
        if (transactionType != null && !transactionType.isEmpty()) {
            if (transactionType.equals("CREDIT")) {
                baseQuery += " AND f.toAccount.id = :accountId";
            } else if (transactionType.equals("DEBIT")) {
                baseQuery += " AND f.fromAccount.id = :accountId";
            }
        }

        baseQuery += " ORDER BY f.paymentDate DESC";

        TypedQuery<TransactionDTO> query = em.createQuery(baseQuery, TransactionDTO.class);
        query.setParameter("accountId", accountId);

        if (fromDate != null) query.setParameter("fromDate", fromDate);
        if (toDate != null) query.setParameter("toDate", toDate);
        if (minAmount != null) query.setParameter("minAmount", minAmount);

        query.setFirstResult((page - 1) * pageSize);
        query.setMaxResults(pageSize);

        return query.getResultList();
    }

    public long countFilteredTransactions(
            int accountId,
            LocalDate fromDate,
            LocalDate toDate,
            BigDecimal minAmount,
            String transactionType
    ) {
        String baseQuery =
                "SELECT COUNT(f) " +
                        "FROM FundTransfer f " +
                        "WHERE (f.fromAccount.id = :accountId OR f.toAccount.id = :accountId)";

        if (fromDate != null) baseQuery += " AND f.paymentDate >= :fromDate";
        if (toDate != null) baseQuery += " AND f.paymentDate <= :toDate";
        if (minAmount != null) baseQuery += " AND f.amount >= :minAmount";
        if (transactionType != null && !transactionType.isEmpty()) {
            if (transactionType.equals("CREDIT")) {
                baseQuery += " AND f.toAccount.id = :accountId";
            } else if (transactionType.equals("DEBIT")) {
                baseQuery += " AND f.fromAccount.id = :accountId";
            }
        }

        TypedQuery<Long> query = em.createQuery(baseQuery, Long.class);
        query.setParameter("accountId", accountId);

        if (fromDate != null) query.setParameter("fromDate", fromDate);
        if (toDate != null) query.setParameter("toDate", toDate);
        if (minAmount != null) query.setParameter("minAmount", minAmount);

        return query.getSingleResult();
    }
}
