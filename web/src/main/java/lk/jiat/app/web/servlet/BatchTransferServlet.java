package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.app.ejb.bean.BmtTransactionBean;

import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/triggerBatch")
public class BatchTransferServlet extends HttpServlet {

    @EJB
    private BmtTransactionBean bmtBean;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // For demo purposes, we simulate a batch loan disbursement
            // In a real scenario, this would iterate through a list of approved loans
            // Here we use static IDs from the seed data (Account 1 to Account 2)
            bmtBean.processManualTransfer(1, 2, new BigDecimal("5000.00"));

            request.setAttribute("success", "Batch Loan Disbursement processed successfully using BMT.");
            request.getRequestDispatcher("interest.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Batch processing failed: " + e.getMessage());
            request.getRequestDispatcher("interest.jsp").forward(request, response);
        }
    }
}
