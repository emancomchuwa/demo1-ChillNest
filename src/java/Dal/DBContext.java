package Dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Lớp thiết lập kết nối tới cơ sở dữ liệu SQL Server.
 * Các lớp DAO khác sẽ kế thừa lớp này để sử dụng đối tượng 'connection'.
 */
public class DBContext {
    protected Connection connection;

    /**
     * Constructor khởi tạo kết nối database.
     */
    public DBContext() {
        try {
            // CẤU HÌNH KẾT NỐI DATABASE
            // Bạn cần thay đổi thông tin bên dưới cho khớp với máy của mình
            String user = "sa";
            String pass = "sa"; 
            String databaseName = "chill_nest";
            
            // Cấu hình URL kết nối
            String url = "jdbc:sqlserver://localhost:1433;databaseName=" + databaseName + ";encrypt=true;trustServerCertificate=true;";

            // Nạp Driver SQL Server
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            // Mở kết nối
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            // Ghi log chi tiết để dễ debug
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, "Lỗi kết nối Database! Vui lòng kiểm tra lại password trong DBContext.java", ex);
        }
    }
}
