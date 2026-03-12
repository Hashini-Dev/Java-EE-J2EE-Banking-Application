package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.app.core.model.User;
import lk.jiat.app.core.service.UserService;
import lk.jiat.app.core.util.Encryption;

import java.io.IOException;

@WebServlet("/admin-register")
public class AdminRegisterServlet extends HttpServlet {

    @EJB
    private UserService userService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String contact = request.getParameter("contact");
        String nic = request.getParameter("nic");

        // Server-side validation
        if (firstName == null || firstName.trim().isEmpty() ||
                lastName == null || lastName.trim().isEmpty() ||
                username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                contact == null || contact.trim().isEmpty() ||
                nic == null || nic.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin-register.jsp?error=missing_fields");
            return;
        }

        String passwordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
        if (!password.matches(passwordPattern)) {
            response.sendRedirect(request.getContextPath() + "/admin-register.jsp?error=invalid_password");
            return;
        }

        // Email validation
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            response.sendRedirect(request.getContextPath() + "/admin-register.jsp?error=invalid_email");
            return;
        }

        try {
            String encryptedPassword = Encryption.encrypt(password);
            User user = new User(firstName, lastName, username, email, encryptedPassword, contact, nic);

            // KEY DIFFERENCE: CALL REGISTER ADMIN
            userService.registerAdmin(user);

            // Redirect back to login with success parameter
            response.sendRedirect(request.getContextPath() + "/login.jsp?registered=true");
        } catch (lk.jiat.app.core.exception.DuplicateUserException e) {
            response.sendRedirect(request.getContextPath() + "/admin-register.jsp?error=already_exists&message="
                    + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin-register.jsp?error=registration_failed");
        }
    }
}
