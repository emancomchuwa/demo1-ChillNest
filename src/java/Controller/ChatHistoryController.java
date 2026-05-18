package Controller;

import Dal.MessageDAO;
import Model.Message;
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

@WebServlet(name = "ChatHistoryController", urlPatterns = {"/ChatHistoryController"})
public class ChatHistoryController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");
        
        String agentIdStr = request.getParameter("agentId");
        long senderId;
        if (agentIdStr != null && !agentIdStr.isEmpty()) {
            try {
                senderId = Long.parseLong(agentIdStr);
            } catch (NumberFormatException e) {
                if (loggedInUser != null) {
                    senderId = loggedInUser.getId();
                } else {
                    senderId = Math.abs((long) session.getId().hashCode());
                }
            }
        } else if (loggedInUser != null) {
            senderId = loggedInUser.getId();
        } else {
            // For guest visitors, hash their HTTP Session ID to a unique positive long
            senderId = Math.abs((long) session.getId().hashCode());
        }

        String receiverIdStr = request.getParameter("receiverId");
        long receiverId = -1;
        try {
            receiverId = Long.parseLong(receiverIdStr);
        } catch (NumberFormatException e) {
            // Invalid receiver, return empty array
        }

        PrintWriter out = response.getWriter();
        if (receiverId == -1) {
            out.print("[]");
            out.flush();
            return;
        }

        MessageDAO dao = new MessageDAO();
        List<Message> list = dao.getChatHistory(senderId, receiverId);

        out.print("[");
        for (int i = 0; i < list.size(); i++) {
            Message m = list.get(i);
            out.print("{");
            out.print("\"id\":" + m.getId() + ",");
            out.print("\"senderId\":" + m.getSenderId() + ",");
            out.print("\"receiverId\":" + m.getReceiverId() + ",");
            out.print("\"text\":\"" + escapeJson(m.getMessageText()) + "\",");
            out.print("\"createdAt\":\"" + m.getCreatedAt().toString() + "\"");
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
