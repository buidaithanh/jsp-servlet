/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.User;

/**
 *
 * @author DaiThanh
 */
public class UserDao {

    private Connection conn;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public UserDao(Connection conn) {
        this.conn = conn;
    }

    public User userLogin(String email, String password) {
        User user = null;

        try {
            query = "select * from user where email=? and password=?";
            pst = this.conn.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            rs = pst.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));

            }

        } catch (Exception e) {
            e.printStackTrace();
            System.out.print(e.getMessage());
        }

        return user;
    }

}
