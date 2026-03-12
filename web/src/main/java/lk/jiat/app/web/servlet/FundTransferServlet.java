package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;

import lk.jiat.app.core.model.FundTransfer;
import lk.jiat.app.core.model.TransferType;
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

        java.util.List<TransferType> transferTypes = fundTransferService.getAllTransferTypes();
        request.setAttribute("transferTypes", transferTypes);

        request.getRequestDispatcher("transfers.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        lk.jiat.app.core.model.User user = (lk.jiat.app.core.model.User) session.getAttribute("loggedUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String fromAccountId = request.getParameter("fromAccount");
            String toAccountId = request.getParameter("toAccount");
            BigDecimal amount = new BigDecimal(request.getParameter("amount"));

            String dateStr = request.getParameter("paymentDate");
            LocalDate paymentDate = (dateStr == null || dateStr.isEmpty()) ? LocalDate.now() : LocalDate.parse(dateStr);

            String description = request.getParameter("description");
            String transferTypeStr = request.getParameter("type"); // INSTANT or SCHEDULED
            
            // Find transfer type ID based on the string name from form
            Integer transferTypeId = null;
            StringBuilder availableTypes = new StringBuilder();

            java.util.List<TransferType> transferTypes = fundTransferService.getAllTransferTypes();
            for (TransferType t : transferTypes) {
                availableTypes.append("'").append(t.getType()).append("' ");
                if (t.getType().equalsIgnoreCase(transferTypeStr)) {
                    transferTypeId = t.getId();
                    break;
                }
            }
            
            if (transferTypeId == null && !transferTypes.isEmpty()) {
                // If we can't find 'INSTANT', grab the first one as a safe fallback
                transferTypeId = transferTypes.get(0).getId();
                System.out.println("Warning: Falling back to transfer type ID " + transferTypeId + ". Available types were: " + availableTypes.toString());
            } else if (transferTypeId == null) {
                throw new IllegalArgumentException("No transfer types found in database! Please check schema seeding.");
            }

            FundTransfer transfer = fundTransferService.scheduleFundTransfer(
                    fromAccountId, toAccountId, amount, paymentDate, description, transferTypeId);

            request.setAttribute("transfer", transfer);
            request.getRequestDispatcher("transfer_success_receipt.jsp").forward(request, response);

        } catch (Exception e) {
            Throwable cause = e;
            while (cause.getCause() != null) {
                cause = cause.getCause();
            }
            String errorMessage = cause.getMessage();
            if (errorMessage == null) {
                errorMessage = "An unexpected error occurred during transfer.";
            }

            request.setAttribute("error", "Transfer failed: " + errorMessage);

            // Re-populate data for transfers.jsp
            java.util.List<lk.jiat.app.core.model.FundTransfer> history = fundTransferService
                    .getTransferHistory(user.getId());
            request.setAttribute("history", history);

            java.util.List<lk.jiat.app.core.model.Account> userAccounts = accountService.getAccountsByUser(user);
            request.setAttribute("userAccounts", userAccounts);

            java.util.List<TransferType> transferTypes = fundTransferService.getAllTransferTypes();
            request.setAttribute("transferTypes", transferTypes);

            request.getRequestDispatcher("transfers.jsp").forward(request, response);
        }
    }
}
