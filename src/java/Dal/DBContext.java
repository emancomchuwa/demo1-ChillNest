package Dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Class to establish connection to SQL Server database.
 * Other DAO classes will inherit this class to use the 'connection' object.
 */
public class DBContext {
    protected Connection connection;

    /**
     * Constructor initializes database connection.
     */
    public DBContext() {
        try {
            // DATABASE CONNECTION CONFIGURATION
            // Change the information below to match your local setup
            String user = "sa";
            String pass = "sa"; 
            String databaseName = "chill_nest";
            
            // Connection URL configuration
            String url = "jdbc:sqlserver://localhost:1433;databaseName=" + databaseName + ";encrypt=true;trustServerCertificate=true;";

            // Load SQL Server Driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            // Open Connection
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            // Log detailed error for debugging
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, "Database connection failed! Please check your credentials in DBContext.java", ex);
        }
    }
}
