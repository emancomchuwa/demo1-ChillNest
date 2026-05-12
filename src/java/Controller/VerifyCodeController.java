package Controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "VerifyCodeController", urlPatterns = {"/VerifyCodeController"})
public class VerifyCodeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // If accessed directly via GET without OTP verification, redirect to forgot password page
        HttpSession session = request.getSession();
        if (session.getAttribute("resetEmail") == null || session.getAttribute("otpCode") == null) {
            response.sendRedirect("forgotpassword.jsp");
            return;
        }
        request.getRequestDispatcher("verifycode.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userCode = request.getParameter("authCode");
        String serverCode = (String) session.getAttribute("otpCode");
        Long otpTime = (Long) session.getAttribute("otpTime");
        long currentTime = System.currentTimeMillis();

        // Check 30s expiry (30 * 1000 ms)
        if (otpTime == null || (currentTime - otpTime) > 30000) {
            request.setAttribute("error", "OTP code has expired. Please click 'Resend'!");
            request.getRequestDispatcher("verifycode.jsp").forward(request, response);
            return;
        }

        if (userCode != null && userCode.equals(serverCode)) {
            // Match → Mark as verified
            session.setAttribute("isVerified", true);
            session.removeAttribute("otpCode"); 
            response.sendRedirect("resetpassword.jsp");
        } else {
            // No match
            request.setAttribute("error", "Invalid verification code. Please try again!");
            request.getRequestDispatcher("verifycode.jsp").forward(request, response);
        }
    }
}
