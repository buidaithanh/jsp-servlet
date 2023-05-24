/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import connection.ConnectDB;
import dao.OrderDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import model.Cart;
import model.Order;
import model.User;

/**
 *
 * @author DaiThanh
 */
@WebServlet("/order")
public class OrderController extends HttpServlet {
private static final long serialVersionUID = 1L;
    

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      try(PrintWriter out = response.getWriter()){
          SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
          Date date = new Date();
          User auth = (User) request.getSession().getAttribute("auth");
          if(auth != null){
              String productId = request.getParameter("id");
              int productQuantity = Integer.parseInt(request.getParameter("quantity"));
              if(productQuantity <= 0){
                  productQuantity = 1;
              }
              
              Order order = new Order();
              order.setId(Integer.parseInt(productId));
              order.setUid(auth.getId());
              order.setQuantity(productQuantity);
              order.setDate(formatter.format(date));
              
              OrderDao orderDao = new OrderDao(ConnectDB.getConnection());
              boolean result =  orderDao.insertOrder(order);
              
              if(result){
                  ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
                if(cart_list != null){
                    for(Cart c:cart_list){
                        if(c.getId() == Integer.parseInt(productId)){
                            cart_list.remove(cart_list.indexOf(c));
                            break;
                        }
                    }
                }
                  
                  response.sendRedirect("orders.jsp");
              }else{
                  out.print("fail to order");
              }
              
          }else{
              response.sendRedirect("login.jsp");
          }
      } catch (Exception ex) {
          ex.printStackTrace();
      } 
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
