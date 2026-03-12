package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import lk.jiat.app.core.service.UserService;
import lk.jiat.app.ejb.bean.AccountServiceBean;
import java.io.IOException;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @EJB
    private UserService userService;

    @EJB
    private AccountServiceBean accountServiceBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        int totalUsers = userService.getAllUsers().size();
        int totalAccounts = accountServiceBean.getAllAccounts().size();

        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalAccounts", totalAccounts);

        request.getRequestDispatcher("/admin-dashboard.jsp").forward(request, response);
    }
}
