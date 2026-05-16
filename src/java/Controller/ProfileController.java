package Controller;

import Dal.UserDAO;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ProfileController", urlPatterns = {"/ProfileController"})
public class ProfileController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Fetch fresh data from DB
        UserDAO dao = new UserDAO();
        User freshUser = dao.getUserById(user.getId());
        
        if (freshUser != null) {
            session.setAttribute("user", freshUser);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        UserDAO dao = new UserDAO();
        boolean profileUpdated = false;
        boolean passwordUpdated = false;
        String errorMessage = null;

        // 1. Update basic profile info
        User updatedUser = new User();
        updatedUser.setId(user.getId());
        updatedUser.setFullName(fullName);
        updatedUser.setPhone(phone);
        profileUpdated = dao.updateProfile(updatedUser);

        // 2. Handle password change if currentPassword is provided
        if (currentPassword != null && !currentPassword.isEmpty()) {
            // Verify current password
            User verifiedUser = dao.login(user.getEmail(), currentPassword);
            if (verifiedUser == null) {
                errorMessage = "Incorrect current password.";
            } else if (newPassword == null || newPassword.length() < 6) {
                errorMessage = "New password must be at least 6 characters.";
            } else if (!newPassword.equals(confirmPassword)) {
                errorMessage = "New passwords do not match.";
            } else {
                passwordUpdated = dao.updatePassword(user.getEmail(), newPassword);
                if (!passwordUpdated) {
                    errorMessage = "Failed to update password due to a database error.";
                }
            }
        }

        if (errorMessage != null) {
            request.setAttribute("error", errorMessage);
        } else if (profileUpdated || passwordUpdated) {
            // Update session with new data
            User freshUser = dao.getUserById(user.getId());
            session.setAttribute("user", freshUser);
            
            String msg = "Profile updated successfully!";
            if (passwordUpdated) msg = "Profile and password updated successfully!";
            request.setAttribute("message", msg);
        } else {
            request.setAttribute("error", "No changes were made.");
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
