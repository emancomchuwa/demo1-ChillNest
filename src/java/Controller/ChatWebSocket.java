package Controller;

import Dal.MessageDAO;
import Model.Message;
import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;

@ServerEndpoint("/chat/{userId}")
public class ChatWebSocket {

    // Keep track of all active client connections (User ID -> WebSocket Session)
    private static final Map<Long, Session> sessions = new ConcurrentHashMap<>();

    @OnOpen
    public void onOpen(Session session, @PathParam("userId") String userIdStr) {
        try {
            long userId = Long.parseLong(userIdStr);
            sessions.put(userId, session);
            System.out.println(">>> WebSocket connected: User ID = " + userId + " (Session: " + session.getId() + ")");
        } catch (NumberFormatException e) {
            System.err.println(">>> WebSocket error: Invalid User ID string: " + userIdStr);
        }
    }

    @OnMessage
    public void onMessage(String message, Session session, @PathParam("userId") String senderIdStr) {
        try {
            long senderId = Long.parseLong(senderIdStr);
            
            // Simple robust JSON extraction to avoid external library dependency issues
            long receiverId = -1;
            String text = "";

            // Parse receiverId: {"receiverId":3,"text":"message"}
            int rIndex = message.indexOf("\"receiverId\":");
            if (rIndex != -1) {
                int start = rIndex + 13;
                int end = message.indexOf(",", start);
                if (end == -1) end = message.indexOf("}", start);
                String rIdStr = message.substring(start, end).trim().replace("\"", "").replace(":", "");
                receiverId = Long.parseLong(rIdStr);
            }

            // Parse text
            int tIndex = message.indexOf("\"text\":");
            if (tIndex != -1) {
                int start = tIndex + 7;
                // handle starting quotes
                if (message.charAt(start) == '"') {
                    start++;
                    int end = message.indexOf("\"", start);
                    text = message.substring(start, end);
                } else {
                    int end = message.indexOf("}", start);
                    text = message.substring(start, end).trim();
                }
            }

            if (receiverId == -1 || text.trim().isEmpty()) {
                return;
            }

            // 1. Save Chat Message to SQL Server Database
            MessageDAO dao = new MessageDAO();
            Message msg = new Message(senderId, receiverId, text);
            dao.saveMessage(msg);

            // 2. Deliver message instantly in real-time if receiver is online
            Session receiverSession = sessions.get(receiverId);
            if (receiverSession != null && receiverSession.isOpen()) {
                String payload = "{" +
                        "\"senderId\":" + senderId + "," +
                        "\"receiverId\":" + receiverId + "," +
                        "\"text\":\"" + escapeJson(text) + "\"," +
                        "\"createdAt\":\"" + new java.sql.Timestamp(System.currentTimeMillis()).toString() + "\"" +
                        "}";
                receiverSession.getBasicRemote().sendText(payload);
                System.out.println(">>> Real-time WebSocket message delivered from " + senderId + " to " + receiverId);
            } else {
                System.out.println(">>> Receiver " + receiverId + " is offline. Message saved in DB.");
            }

        } catch (Exception e) {
            System.err.println(">>> WebSocket onMessage error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @OnClose
    public void onClose(Session session, @PathParam("userId") String userIdStr) {
        try {
            long userId = Long.parseLong(userIdStr);
            sessions.remove(userId);
            System.out.println(">>> WebSocket disconnected: User ID = " + userId);
        } catch (NumberFormatException e) {
            // ignore
        }
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        System.err.println(">>> WebSocket session error: " + throwable.getMessage());
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
