package Controller;

import Dal.MessageDAO;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ChattingClientsController", urlPatterns = {"/ChattingClientsController"})
public class ChattingClientsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");
        
        long agentId = 1; // Default to Admin user id = 1
        String agentIdStr = request.getParameter("agentId");
        if (agentIdStr != null && !agentIdStr.isEmpty()) {
            try {
                agentId = Long.parseLong(agentIdStr);
            } catch (NumberFormatException e) {
                // ignore
            }
        } else if (loggedInUser != null) {
            agentId = loggedInUser.getId();
        }

        MessageDAO dao = new MessageDAO();
        List<User> list = dao.getChattingUsers(agentId);

        PrintWriter out = response.getWriter();
        out.print("[");
        for (int i = 0; i < list.size(); i++) {
            User u = list.get(i);
            out.print("{");
            out.print("\"id\":" + u.getId() + ",");
            out.print("\"username\":\"" + escapeJson(u.getUsername()) + "\",");
            out.print("\"email\":\"" + escapeJson(u.getEmail()) + "\",");
            out.print("\"fullName\":\"" + escapeJson(u.getFullName()) + "\"");
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
