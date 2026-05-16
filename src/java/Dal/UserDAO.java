package Dal;

import Model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
                return u;
            }
        } catch (SQLException e) {
            System.out.println("GetUserById Error: " + e.getMessage());
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
}
