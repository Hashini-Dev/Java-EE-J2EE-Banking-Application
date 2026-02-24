package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;

import lk.jiat.app.core.model.FundTransfer;
import lk.jiat.app.ejb.bean.FundTransferServiceBean;

@WebServlet("/transfer")
public class FundTransferServlet extends HttpServlet {

    @EJB
    private FundTransferServiceBean fundTransferService;

    @EJB
    private lk.jiat.app.ejb.bean.AccountServiceBean accountService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        lk.jiat.app.core.model.User user = (lk.jiat.app.core.model.User) session.getAttribute("loggedUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        java.util.List<lk.jiat.app.core.model.FundTransfer> history = fundTransferService
                .getTransferHistory(user.getId());
        request.setAttribute("history", history);

        java.util.List<lk.jiat.app.core.model.Account> userAccounts = accountService.getAccountsByUser(user);
        request.setAttribute("userAccounts", userAccounts);

        request.getRequestDispatcher("transfers.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String fromAccountId = request.getParameter("fromAccount");
            String toAccountId = request.getParameter("toAccount");
            BigDecimal amount = new BigDecimal(request.getParameter("amount"));

            String dateStr = request.getParameter("paymentDate");
            LocalDate paymentDate = (dateStr == null || dateStr.isEmpty()) ? LocalDate.now() : LocalDate.parse(dateStr);

            String description = request.getParameter("description");

            FundTransfer transfer = fundTransferService.scheduleFundTransfer(
                    fromAccountId, toAccountId, amount, paymentDate, description);

            request.setAttribute("transfer", transfer);
            request.getRequestDispatcher("transfer_success_receipt.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Transfer failed: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
