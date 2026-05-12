package Controller;

import Dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * ResetPasswordController - Step 2: Update new password
 */
@WebServlet(name = "ResetPasswordController", urlPatterns = {"/ResetPasswordController"})
public class ResetPasswordController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("resetEmail");

        // Security check: if no email or not verified, redirect to forgot password page
        Boolean isVerified = (Boolean) session.getAttribute("isVerified");
        if (email == null || isVerified == null || !isVerified) {
            response.sendRedirect("forgotpassword.jsp");
            return;
        }

        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate server-side
        if (newPassword == null || newPassword.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters!");
            request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
            return;
        }

        // Update in DB
        UserDAO dao = new UserDAO();
        boolean updated = dao.updatePassword(email, newPassword);

        if (updated) {
            // Clear session
            session.removeAttribute("resetEmail");
            session.removeAttribute("isVerified");
            // Redirect to login with success message
            response.sendRedirect("LoginController?resetSuccess=true");
        } else {
            request.setAttribute("error", "An error occurred while updating your password. Please try again!");
            request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
        }
    }
}
