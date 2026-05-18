package Dal;

import Model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

public class UserDAO extends DBContext {

    /**
     * Register a new user into the database
     */
    public boolean register(User user) {
        if (connection == null) {
            System.err.println(">>> ERROR: Cannot register because database connection is null!");
            return false;
        }
        String sql = "INSERT INTO users (username, email, password, full_name) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user.getUsername());
            st.setString(2, user.getEmail());
            st.setString(3, user.getPassword());
            st.setString(4, user.getFullName());
            
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Register Error: " + e.getMessage());
        }
        return false;
    }

    /**
     * Check if email already exists
     */
    public boolean checkEmailExist(String email) {
        if (connection == null) {
            System.err.println(">>> ERROR: Cannot check email because database connection is null!");
            return false;
        }
        String sql = "SELECT * FROM users WHERE email = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println("CheckEmail Error: " + e.getMessage());
        }
        return false;
    }

    /**
     * Check if username already exists
     */
    public boolean checkUsernameExist(String username) {
        if (connection == null) {
            System.err.println(">>> ERROR: Cannot check username because database connection is null!");
            return false;
        }
        String sql = "SELECT * FROM users WHERE username = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println("CheckUsername Error: " + e.getMessage());
        }
        return false;
    }
    /**
     * Helper to get user role name by User ID
     */
    public String getUserRole(long userId) {
        if (connection == null) return "";
        String sql = "SELECT r.name FROM roles r " +
                     "JOIN user_roles ur ON r.id = ur.role_id " +
                     "WHERE ur.user_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setLong(1, userId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getString("name");
            }
        } catch (SQLException e) {
            System.out.println("GetUserRole Error: " + e.getMessage());
        }
        return "";
    }

    /**
     * Check login credentials
     */
    public User login(String email, String password) {
        if (connection == null) {
            System.err.println(">>> ERROR: Cannot login because database connection is null!");
            return null;
        }
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getLong("id"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setFullName(rs.getString("full_name"));
                u.setPhone(rs.getString("phone"));
                u.setRoleName(getUserRole(u.getId()));
                return u;
            }
        } catch (SQLException e) {
            System.out.println("Login Error: " + e.getMessage());
        }
        return null;
    }

    /**
     * Get user by ID
     */
    public User getUserById(long id) {
        if (connection == null) return null;
        String sql = "SELECT * FROM users WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setLong(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getLong("id"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setFullName(rs.getString("full_name"));
                u.setPhone(rs.getString("phone"));
                u.setStatus(rs.getString("status"));
                u.setCreatedAt(rs.getTimestamp("created_at"));
                u.setRoleName(getUserRole(u.getId()));
                return u;
            }
        } catch (SQLException e) {
            System.out.println("GetUserById Error: " + e.getMessage());
        }
        return null;
    }

    /**
     * Get user by Email
     */
    public User getUserByEmail(String email) {
        if (connection == null) return null;
        String sql = "SELECT * FROM users WHERE email = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getLong("id"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setFullName(rs.getString("full_name"));
                u.setPhone(rs.getString("phone"));
                u.setStatus(rs.getString("status"));
                u.setCreatedAt(rs.getTimestamp("created_at"));
                u.setRoleName(getUserRole(u.getId()));
                return u;
            }
        } catch (SQLException e) {
            System.out.println("GetUserByEmail Error: " + e.getMessage());
        }
        return null;
    }

    /**
     * Update user profile information
     */
    public boolean updateProfile(User user) {
        if (connection == null) return false;
        String sql = "UPDATE users SET full_name = ?, phone = ? WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user.getFullName());
            st.setString(2, user.getPhone());
            st.setLong(3, user.getId());
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("UpdateProfile Error: " + e.getMessage());
        }
        return false;
    }

    /**
     * Register a Google user (no password, username = email prefix)
     * Returns the auto-generated user ID, or -1 on failure
     */
    public long registerGoogleUser(String email, String fullName) {
        if (connection == null) return -1;
        // Use email prefix as username, ensure uniqueness
        String baseUsername = email.split("@")[0].replaceAll("[^a-zA-Z0-9_]", "_");
        String username = baseUsername;
        int suffix = 1;
        while (checkUsernameExist(username)) {
            username = baseUsername + suffix++;
        }
        String sql = "INSERT INTO users (username, email, password, full_name) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            st.setString(1, username);
            st.setString(2, email);
            st.setString(3, "GOOGLE_OAUTH"); // placeholder, not used for login
            st.setString(4, fullName);
            int rows = st.executeUpdate();
            if (rows > 0) {
                ResultSet keys = st.getGeneratedKeys();
                if (keys.next()) return keys.getLong(1);
            }
        } catch (SQLException e) {
            System.out.println("RegisterGoogleUser Error: " + e.getMessage());
        }
        return -1;
    }

    /**
     * Update password for a user by email
     */
    public boolean updatePassword(String email, String newPassword) {
        if (connection == null) {
            System.err.println(">>> ERROR: Cannot update password because database connection is null!");
            return false;
        }
        String sql = "UPDATE users SET password = ? WHERE email = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, newPassword);
            st.setString(2, email);
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("UpdatePassword Error: " + e.getMessage());
        }
        return false;
    }

    /**
     * Get all real Admin and Partner users from the database for chat
     */
    public List<User> getChatAgents() {
        List<User> list = new ArrayList<>();
        if (connection == null) return list;
        String sql = "SELECT u.*, r.name AS role_name FROM users u " +
                     "JOIN user_roles ur ON u.id = ur.user_id " +
                     "JOIN roles r ON ur.role_id = r.id " +
                     "WHERE r.name IN ('ROLE_ADMIN', 'ROLE_PARTNER')";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getLong("id"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setFullName(rs.getString("full_name"));
                u.setPhone(rs.getString("phone"));
                u.setStatus(rs.getString("status"));
                u.setRoleName(rs.getString("role_name"));
                list.add(u);
            }
        } catch (SQLException e) {
            System.out.println("GetChatAgents Error: " + e.getMessage());
        }
        return list;
    }
}
