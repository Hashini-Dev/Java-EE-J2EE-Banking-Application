package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.core.model.User;
import lk.jiat.app.ejb.bean.AccountServiceBean;

import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/admin/account/delete")
public class AdminAccountActionServlet extends HttpServlet {

    @EJB
    private AccountServiceBean accountServiceBean;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedUser = (User) session.getAttribute("loggedUser");

        if (loggedUser == null || (loggedUser.getUserType() != null && !loggedUser.getUserType().getType().equals("Admin"))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }

        try {
            Long accountId = Long.parseLong(request.getParameter("accountId"));
            String accountNo = request.getParameter("accountNo");

            Account account = accountServiceBean.findById(accountId);
            if (account != null) {
                if (account.getBalance().compareTo(BigDecimal.ZERO) != 0) {
                    // Cannot delete account with a balance, matches the image requested output exactly
                    response.sendRedirect(request.getContextPath() + "/admin/accounts?error=balance_not_zero&accNo=" + accountNo);
                    return;
                } else {
                    accountServiceBean.delete(accountId);
                    response.sendRedirect(request.getContextPath() + "/admin/accounts?success=deleted");
                    return;
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/accounts");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
        }
    }
}
