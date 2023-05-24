/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package connection;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.DriverManager;
/**
 *
 * @author DaiThanh
 */
public class ConnectDB {
    private static Connection conn = null;
    
    public static Connection getConnection() throws ClassNotFoundException, SQLException{
        
        if(conn == null ){
        
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dt_sneaker", "root", "");
            
            
            
            System.out.println("connected");
            
        }
        return conn;
    }
    
}
