package Dal;

import Model.Message;
import Model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MessageDAO extends DBContext {

    public MessageDAO() {
        super();
        checkAndCreateTable();
    }

    /**
     * Self-healing check: Automatically creates the chat_messages table if missing
     */
    private void checkAndCreateTable() {
        if (connection == null) return;
        try {
            // Check if table chat_messages exists in SQL Server
            String checkSql = "SELECT * FROM sys.tables WHERE name = 'chat_messages'";
            PreparedStatement st = connection.prepareStatement(checkSql);
            ResultSet rs = st.executeQuery();
            if (!rs.next()) {
                System.out.println(">>> SQL Server Table 'chat_messages' does not exist. Creating table...");
                String createSql = "CREATE TABLE chat_messages (" +
                                   "id BIGINT PRIMARY KEY IDENTITY(1,1)," +
                                   "sender_id BIGINT," +
                                   "receiver_id BIGINT," +
                                   "message_text NVARCHAR(MAX)," +
                                   "created_at DATETIME DEFAULT GETDATE()," +
                                   "is_read BIT DEFAULT 0," +
                                   "FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE NO ACTION," +
                                   "FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE NO ACTION" +
                                   ")";
                PreparedStatement createSt = connection.prepareStatement(createSql);
                createSt.executeUpdate();
                System.out.println(">>> SQL Server Table 'chat_messages' created successfully!");
            }
        } catch (SQLException e) {
            System.err.println("checkAndCreateTable Error: " + e.getMessage());
        }
    }

    /**
     * Save a message into the database
     */
    public boolean saveMessage(Message msg) {
        if (connection == null) return false;
        String sql = "INSERT INTO chat_messages (sender_id, receiver_id, message_text) VALUES (?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            st.setLong(1, msg.getSenderId());
            st.setLong(2, msg.getReceiverId());
            st.setString(3, msg.getMessageText());
            int rows = st.executeUpdate();
            if (rows > 0) {
                ResultSet rs = st.getGeneratedKeys();
                if (rs.next()) {
                    msg.setId(rs.getLong(1));
                }
                return true;
            }
        } catch (SQLException e) {
            System.out.println("saveMessage Error: " + e.getMessage());
        }
        return false;
    }

    /**
     * Get chat history between two users, ordered chronologically
     */
    public List<Message> getChatHistory(long u1, long u2) {
        List<Message> list = new ArrayList<>();
        if (connection == null) return list;
        String sql = "SELECT * FROM chat_messages " +
                     "WHERE (sender_id = ? AND receiver_id = ?) " +
                     "   OR (sender_id = ? AND receiver_id = ?) " +
                     "ORDER BY created_at ASC";
         try {
             PreparedStatement st = connection.prepareStatement(sql);
             st.setLong(1, u1);
             st.setLong(2, u2);
             st.setLong(3, u2);
             st.setLong(4, u1);
             ResultSet rs = st.executeQuery();
             while (rs.next()) {
                 Message m = new Message();
                 m.setId(rs.getLong("id"));
                 m.setSenderId(rs.getLong("sender_id"));
                 m.setReceiverId(rs.getLong("receiver_id"));
                 m.setMessageText(rs.getString("message_text"));
                 m.setCreatedAt(rs.getTimestamp("created_at"));
                 m.setIsRead(rs.getBoolean("is_read"));
                 list.add(m);
             }
         } catch (SQLException e) {
             System.out.println("getChatHistory Error: " + e.getMessage());
         }
         return list;
    }

    /**
     * Get unique client users who have active conversations with this agent
     */
    public List<User> getChattingUsers(long agentId) {
        List<User> list = new ArrayList<>();
        if (connection == null) return list;
        
        // Fetch unique users who are either the sender or receiver, excluding the agent itself.
        // If a guest has no record in the 'users' table, we can fetch unique guest hashes from the messages log.
        // We do a LEFT JOIN or fetch guest details dynamically.
        String sql = "SELECT DISTINCT u.id, u.username, u.email, u.full_name " +
                     "FROM users u " +
                     "WHERE u.id IN (" +
                     "    SELECT sender_id FROM chat_messages WHERE receiver_id = ? AND sender_id <> ? " +
                     "    UNION " +
                     "    SELECT receiver_id FROM chat_messages WHERE sender_id = ? AND receiver_id <> ?" +
                     ")";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setLong(1, agentId);
            st.setLong(2, agentId);
            st.setLong(3, agentId);
            st.setLong(4, agentId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getLong("id"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setFullName(rs.getString("full_name"));
                list.add(u);
            }
            
            // Also append guest hashed session IDs that are active in messages
            String guestSql = "SELECT DISTINCT sender_id FROM chat_messages " +
                              "WHERE receiver_id = ? AND sender_id NOT IN (SELECT id FROM users)";
            PreparedStatement gst = connection.prepareStatement(guestSql);
            gst.setLong(1, agentId);
            ResultSet grs = gst.executeQuery();
            while (grs.next()) {
                long guestId = grs.getLong("sender_id");
                User u = new User();
                u.setId(guestId);
                u.setUsername("guest_" + guestId);
                u.setEmail("guest@chillnest.com");
                u.setFullName("Khách Vãng Lai (" + guestId + ")");
                list.add(u);
            }
        } catch (SQLException e) {
            System.out.println("getChattingUsers Error: " + e.getMessage());
        }
        return list;
    }
}
