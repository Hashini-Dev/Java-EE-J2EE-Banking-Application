package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import lk.jiat.app.core.model.Account;
import lk.jiat.app.core.model.FundTransfer;
import lk.jiat.app.core.model.User;
import lk.jiat.app.ejb.bean.AccountServiceBean;
import lk.jiat.app.ejb.bean.FundTransferServiceBean;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @EJB
    private AccountServiceBean accountServiceBean;

    @EJB
    private FundTransferServiceBean fundTransferService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User loggedUser = (User) session.getAttribute("loggedUser");

        if (loggedUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 1. Fetch the user's latest primary account info for balance display
        Account userAccount = accountServiceBean.getAccountByUser(loggedUser);
        if (userAccount != null) {
            session.setAttribute("userAccount", userAccount);
        } else {
            // Handle if a user has zero accounts yet
            request.setAttribute("error", "No accounts found for user");
        }

        // 2. Fetch the transaction history
        List<FundTransfer> fullHistory = fundTransferService.getTransferHistory(loggedUser.getId());

        // 3. Process data for Dashboard
        List<FundTransfer> recentActivity = new ArrayList<>();
        List<FundTransfer> scheduledForToday = new ArrayList<>();
        BigDecimal scheduledTotal = BigDecimal.ZERO;
        LocalDate today = LocalDate.now();

        int count = 0;
        for (FundTransfer transfer : fullHistory) {
            // Pick the first 6 for Recent Activity (as requested)
            if (count < 6) {
                recentActivity.add(transfer);
                count++;
            }

            // Check if it's Scheduled for Today
            // Condition: date == today AND transferType.id == 2 (Scheduled) AND processed
            // == false
            if (transfer.getPaymentDate().isEqual(today) &&
                    transfer.getTransferType() != null && transfer.getTransferType().getId() == 2 &&
                    !transfer.getProcessed()) {

                scheduledForToday.add(transfer);

                // For the UI logic, if the logged-in user is the sender, it's a negative
                // amount.
                // Keep the raw sum, but in UI we display it gracefully.
                // The task description doesn't explicitly mention adjusting the sum if it's
                // incoming,
                // but for "Scheduled For Today" in UI, it normally implies deductions (like
                // bills).
                // Let's just track the raw total amount of scheduled transactions regardless of
                // sender/receiver.
                scheduledTotal = scheduledTotal.add(transfer.getAmount());
            }
        }

        // Set attributes to pass to the JSP
        request.setAttribute("recentActivity", recentActivity);
        request.setAttribute("scheduledForToday", scheduledForToday);
        request.setAttribute("scheduledTotal", scheduledTotal);

        // Forward to the JSP
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
}
