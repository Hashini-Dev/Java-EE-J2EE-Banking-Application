package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.ejb.bean.AccountServiceBean;
import lk.jiat.app.ejb.bean.InterestCalculationBean;

import java.io.IOException;
import java.util.List;

@WebServlet("/triggerInterest")
public class InterestTriggerServlet extends HttpServlet {

    @EJB
    private InterestCalculationBean interestBean;

    @EJB
    private AccountServiceBean accountService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            interestBean.calculateDailyInterest();

            List<Account> updatedAccounts = accountService.getAllAccounts();
            request.setAttribute("accounts", updatedAccounts);
            request.getRequestDispatcher("interest.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Interest calculation failed: " + e.getMessage());
            request.getRequestDispatcher("interest.jsp").forward(request, response);
        }
    }
}
