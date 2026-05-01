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
            System.err.println(">>> LỖI: Không thể thực hiện Đăng ký do không có kết nối Database!");
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
            System.err.println(">>> LỖI: Không thể kiểm tra Email do không có kết nối Database!");
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
            System.err.println(">>> LỖI: Không thể kiểm tra Username do không có kết nối Database!");
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
            System.err.println(">>> LỖI: Không thể thực hiện Đăng nhập do không có kết nối Database!");
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
                return u;
            }
        } catch (SQLException e) {
            System.out.println("Login Error: " + e.getMessage());
        }
        return null;
    }
}
