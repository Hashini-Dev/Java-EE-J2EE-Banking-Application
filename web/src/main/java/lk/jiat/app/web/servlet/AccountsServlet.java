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
import java.util.List;

@WebServlet("/accounts")
public class AccountsServlet extends HttpServlet {

    @EJB
    private AccountServiceBean accountServiceBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User loggedUser = (User) session.getAttribute("loggedUser");

        if (loggedUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Account> userAccounts = accountServiceBean.getAccountsByUser(loggedUser);
        request.setAttribute("userAccounts", userAccounts);

        // Fetch primary account for top-right display if available
        if (userAccounts != null && !userAccounts.isEmpty()) {
            session.setAttribute("userAccount", userAccounts.get(0));
        }

        request.getRequestDispatcher("/accounts.jsp").forward(request, response);
    }
}
