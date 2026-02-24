package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.jiat.app.core.dto.TransactionDTO;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.ejb.bean.TransactionHistoryService;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/TransactionHistoryServlet")
public class TransactionHistoryServlet extends HttpServlet {

    @EJB
    private TransactionHistoryService historyService;

    private static final int PAGE_SIZE = 10;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Account account = (Account) session.getAttribute("userAccount");
        if (account == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int page = 1;
        try {
            page = Integer.parseInt(req.getParameter("page"));
        } catch (Exception ignored) {}

        LocalDate fromDate = parseDate(req.getParameter("fromDate"));
        LocalDate toDate = parseDate(req.getParameter("toDate"));
        BigDecimal minAmount = parseBigDecimal(req.getParameter("minAmount"));
        String transactionType = req.getParameter("transactionType");

        List<TransactionDTO> transactions = historyService.getFilteredTransactions(
                account.getId(), fromDate, toDate, minAmount, transactionType, page, PAGE_SIZE
        );

        long totalCount = historyService.countFilteredTransactions(
                account.getId(), fromDate, toDate, minAmount, transactionType
        );
        int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);

        req.setAttribute("transactions", transactions);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.getRequestDispatcher("interest.jsp").forward(req, resp);
    }

    private LocalDate parseDate(String value) {
        try {
            return value == null || value.isEmpty() ? null : LocalDate.parse(value);
        } catch (Exception e) {
            return null;
        }
    }

    private BigDecimal parseBigDecimal(String value) {
        try {
            return value == null || value.isEmpty() ? null : new BigDecimal(value);
        } catch (Exception e) {
            return null;
        }
    }
}

