package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Utility class for managing database connections and queries.
 * Bug fix: Refactored code to centralize and improve database access.
 */
public class Database {

    /*private static final String DB_URL = "jdbc:mysql://localhost:3306/substitutemanagement";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "admin";*/
    private static final String DB_URL = System.getenv("DB_URL");
    private static final String DB_USERNAME = System.getenv("DB_USERNAME");
    private static final String DB_PASSWORD = System.getenv("DB_PASSWORD");

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            return DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            throw new SQLException("Failed to establish database connection.", e);
        }
    }
}
