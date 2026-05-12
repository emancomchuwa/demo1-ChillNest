package Controller;

import Dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Util.EmailUtil;
import jakarta.servlet.http.HttpSession;

/**
 * ForgotPasswordController - Step 1: Verify email and send OTP
 */
@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/ForgotPasswordController"})
public class ForgotPasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Please enter your email address!");
            request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
            return;
        }

        email = email.trim();
        UserDAO dao = new UserDAO();
        boolean exists = dao.checkEmailExist(email);

        if (exists) {
            // Email exists → Generate OTP and send email
            EmailUtil emailUtil = new EmailUtil();
            String otp = emailUtil.generateOTP();
            
            String subject = "Password Reset Verification Code - Chill Nest";
            String body = "<h3>Hello,</h3>"
                    + "<p>You have requested to reset your password. Your verification code is: "
                    + "<b style='color: blue; font-size: 1.2em;'>" + otp + "</b></p>"
                    + "<p>Please enter this code on the verification page to continue.</p>";
            
            boolean emailSent = emailUtil.sendEmail(email, subject, body);
            
            if (emailSent) {
                HttpSession session = request.getSession();
                session.setAttribute("resetEmail", email);
                session.setAttribute("otpCode", otp);
                session.setAttribute("otpTime", System.currentTimeMillis());
                response.sendRedirect("VerifyCodeController");
            } else {
                request.setAttribute("error", "Failed to send email! Please check your Gmail configuration.");
                request.setAttribute("emailValue", email);
                request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
            }
        } else {
            // Email not found
            request.setAttribute("error", "This email is not registered in our system!");
            request.setAttribute("emailValue", email);
            request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
        }
    }
}
