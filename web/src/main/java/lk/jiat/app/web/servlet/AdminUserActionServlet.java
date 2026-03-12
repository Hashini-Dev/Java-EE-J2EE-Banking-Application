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
import lk.jiat.app.core.service.UserService;
import lk.jiat.app.ejb.bean.AccountServiceBean;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/user/delete")
public class AdminUserActionServlet extends HttpServlet {

    @EJB
    private UserService userService;

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
            Long userId = Long.parseLong(request.getParameter("userId"));

            if (userId.equals(loggedUser.getId())) {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=cannot_delete_self");
                return;
            }

            User targetUser = userService.getUserById(userId);
            if (targetUser != null) {
                
                // Check if user has active accounts, block deletion if so
                List<Account> userAccounts = accountServiceBean.getAccountsByUser(targetUser);
                if (userAccounts != null && !userAccounts.isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/admin/users?error=has_accounts");
                    return;
                }

                userService.deleteUser(targetUser);
                response.sendRedirect(request.getContextPath() + "/admin/users?success=deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/users");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
}
