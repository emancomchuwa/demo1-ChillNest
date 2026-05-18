package Controller;

import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ChatUserController", urlPatterns = {"/ChatUserController"})
public class ChatUserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");
        
        long userId;
        boolean isGuest = false;
        String fullName = "Guest";
        String roleName = "";
        if (loggedInUser != null) {
            userId = loggedInUser.getId();
            fullName = loggedInUser.getFullName();
            roleName = loggedInUser.getRoleName() != null ? loggedInUser.getRoleName() : "";
        } else {
            userId = Math.abs((long) session.getId().hashCode());
            isGuest = true;
        }

        PrintWriter out = response.getWriter();
        out.print("{");
        out.print("\"userId\":" + userId + ",");
        out.print("\"isGuest\":" + isGuest + ",");
        out.print("\"fullName\":\"" + fullName.replace("\"", "\\\"") + "\",");
        out.print("\"roleName\":\"" + roleName.replace("\"", "\\\"") + "\"");
        out.print("}");
        out.flush();
    }
}
