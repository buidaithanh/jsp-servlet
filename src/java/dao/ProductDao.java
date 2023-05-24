/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import connection.ConnectDB;
import java.lang.System.Logger;
import java.lang.System.Logger.Level;
import java.sql.*;
import java.util.*;

import model.Cart;
import model.Product;

public class ProductDao {

    private Connection con;

    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public ProductDao() {

    }

    public ProductDao(Connection con) {
        this.con = con;
    }

    public List<Product> getAllProducts() {
        List<Product> sneakers = new ArrayList<>();
        try {

            query = "select * from product";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();

            while (rs.next()) {
                Product sneakerRow = new Product();
                sneakerRow.setId(rs.getInt("id"));
                sneakerRow.setName(rs.getString("name"));
                sneakerRow.setCategory(rs.getString("category"));
                sneakerRow.setPrice(rs.getDouble("price"));
                sneakerRow.setImage(rs.getString("image"));

                sneakers.add(sneakerRow);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return sneakers;
    }

    public Product getSingleProduct(int id) {
        Product sneakerRow = null;
        try {
            query = "select * from product where id=? ";

            pst = this.con.prepareStatement(query);
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                sneakerRow = new Product();
                sneakerRow.setId(rs.getInt("id"));
                sneakerRow.setName(rs.getString("name"));
                sneakerRow.setCategory(rs.getString("category"));
                sneakerRow.setPrice(rs.getDouble("price"));
                sneakerRow.setImage(rs.getString("image"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }

        return sneakerRow;
    }

    public double getTotalCartPrice(ArrayList<Cart> cartList) {
        double sum = 0;
        try {
            if (cartList.size() > 0) {
                for (Cart item : cartList) {
                    query = "select price from product where id=?";
                    pst = this.con.prepareStatement(query);
                    pst.setInt(1, item.getId());
                    rs = pst.executeQuery();
                    while (rs.next()) {
                        sum += rs.getDouble("price") * item.getQuantity();
                    }

                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return sum;
    }

    public List<Cart> getCartProducts(ArrayList<Cart> cartList) {
        List<Cart> sneakers = new ArrayList<>();
        try {
            if (cartList.size() > 0) {
                for (Cart item : cartList) {
                    query = "select * from product where id=?";
                    pst = this.con.prepareStatement(query);
                    pst.setInt(1, item.getId());
                    rs = pst.executeQuery();
                    while (rs.next()) {
                        Cart cartRow = new Cart();
                        cartRow.setId(rs.getInt("id"));
                        cartRow.setName(rs.getString("name"));
                        cartRow.setCategory(rs.getString("category"));
                        cartRow.setPrice(rs.getDouble("price") * item.getQuantity());
                        cartRow.setQuantity(item.getQuantity());
                        cartRow.setImage(rs.getString("image"));
                        sneakers.add(cartRow);
                    }

                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return sneakers;
    }

    public void addProduct(Product product) {
        String query = "INSERT INTO product(id,name,category, price,image) VALUES (?,?,?,?);";

        try {
            pst = this.con.prepareStatement(query);
            pst.setInt(1, product.getId());
            pst.setString(2, product.getName());
            pst.setString(3, product.getCategory());
            pst.setDouble(4, product.getPrice());
            pst.setString(5, product.getImage());

            pst.execute();

            pst.close();
            con.close();

        } catch (Exception ex) {
            System.out.println(ex);
        }

    }

    public void updateProduct(Product product) {
        String query = "UPDATE product SET name=?, category=?, price=?, image=? WHERE id =?;";

        try {
            pst = this.con.prepareStatement(query);
            pst.setInt(1, product.getId());
            pst.setString(2, product.getName());
            pst.setString(3, product.getCategory());
            pst.setDouble(4, product.getPrice());
            pst.setString(5, product.getImage());
            pst.execute();
            pst.close();
            con.close();
        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    public void deleteProduct(String id) {

        try {

            String query = "DELETE FROM product WHERE id=?";
            PreparedStatement stm = this.con.prepareStatement(query);

            stm.setString(1, id);

            stm.execute();
            con.close();
            stm.close();

        } catch (Exception ex) {
            System.out.println(ex);

        }

    }
}
