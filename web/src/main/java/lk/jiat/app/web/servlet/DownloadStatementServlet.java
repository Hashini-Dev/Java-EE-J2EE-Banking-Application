package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.jiat.app.core.dto.TransactionDTO;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.ejb.bean.TransactionHistoryService;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/DownloadStatementServlet")
public class DownloadStatementServlet extends HttpServlet {

    @EJB
    private TransactionHistoryService historyService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        Account account = (Account) session.getAttribute("userAccount");
        if (account == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        LocalDate now = LocalDate.now();
        LocalDate oneMonthAgo = now.minusMonths(1);

        List<TransactionDTO> transactions = historyService.getFilteredTransactions(
                account.getId(), oneMonthAgo, now, null, null, 1, Integer.MAX_VALUE
        );

        resp.setContentType("text/csv");
        resp.setHeader("Content-Disposition", "attachment;filename=statement.csv");

        PrintWriter writer = resp.getWriter();
        writer.println("Date,Type,Amount,Description");

        for (TransactionDTO txn : transactions) {
            writer.printf("%s,%s,%s,%s%n",
                    txn.getTransactionDate(),
                    txn.getTransactionType(),
                    txn.getAmount(),
                    txn.getDescription() == null ? "" : txn.getDescription()
            );
        }

        writer.flush();
    }
}

