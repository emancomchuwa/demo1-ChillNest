package Controller;

import Dal.UserDAO;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ChatAgentsController", urlPatterns = {"/ChatAgentsController"})
public class ChatAgentsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        UserDAO dao = new UserDAO();
        List<User> list = dao.getChatAgents();
        
        PrintWriter out = response.getWriter();
        out.print("[");
        for (int i = 0; i < list.size(); i++) {
            User u = list.get(i);
            out.print("{");
            out.print("\"id\":" + u.getId() + ",");
            out.print("\"username\":\"" + escapeJson(u.getUsername()) + "\",");
            out.print("\"email\":\"" + escapeJson(u.getEmail()) + "\",");
            out.print("\"fullName\":\"" + escapeJson(u.getFullName()) + "\",");
            out.print("\"roleName\":\"" + escapeJson(u.getRoleName()) + "\"");
            out.print("}");
            if (i < list.size() - 1) {
                out.print(",");
            }
        }
        out.print("]");
        out.flush();
    }

    private String escapeJson(String input) {
        if (input == null) return "";
        return input.replace("\\", "\\\\")
                    .replace("\"", "\\\"")
                    .replace("\b", "\\b")
                    .replace("\f", "\\f")
                    .replace("\n", "\\n")
                    .replace("\r", "\\r")
                    .replace("\t", "\\t");
    }
}
