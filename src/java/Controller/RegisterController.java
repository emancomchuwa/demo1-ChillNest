package Controller;

import Dal.UserDAO;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * RegisterController for Tomcat 10 (using jakarta.servlet)
 */
@WebServlet(name = "RegisterController", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String user = request.getParameter("username");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String confirm = request.getParameter("confirm");
        
        if (!pass.equals(confirm)) {
            request.setAttribute("error", "Confirm password does not match!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        UserDAO dao = new UserDAO();
        
        // 1. Check Username
        if (dao.checkUsernameExist(user)) {
            request.setAttribute("error", "This username already exists!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // 2. Check Email
        if (dao.checkEmailExist(email)) {
            request.setAttribute("error", "This email is already in use!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        User u = new User(user, email, pass, name);
        if (dao.register(u)) {
            response.sendRedirect("login.jsp?success=true");
        } else {
            request.setAttribute("error", "Registration failed. Please try again!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
