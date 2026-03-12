package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import lk.jiat.app.core.model.FundTransfer;
import lk.jiat.app.core.model.User;
import lk.jiat.app.ejb.bean.FundTransferServiceBean;

import java.io.IOException;
import java.util.List;

@WebServlet("/reports")
public class ReportsServlet extends HttpServlet {

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

        List<FundTransfer> fullHistory = fundTransferService.getTransferHistory(loggedUser.getId());
        request.setAttribute("history", fullHistory);

        request.getRequestDispatcher("/reports.jsp").forward(request, response);
    }
}
