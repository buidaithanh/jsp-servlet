/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Cart;


@WebServlet("/add-to-cart")
public class AddToCartController extends HttpServlet {
private static final long serialVersionUID = 1L;

    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try(PrintWriter out = response.getWriter()){
            ArrayList<Cart> lsCart = new ArrayList<>();
            
            int id = Integer.parseInt(request.getParameter("id"));
            Cart cart = new Cart();
            cart.setId(id);
            cart.setQuantity(1);
            
            HttpSession ses = request.getSession();
            ArrayList<Cart> cart_list = (ArrayList<Cart>) ses.getAttribute("cart-list");
            
            if(cart_list == null){
                lsCart.add(cart);
                ses.setAttribute("cart-list", lsCart);
                        out.println("session created and added the list");
            }else{
                lsCart = cart_list;
                boolean exist =false;
                
                for(Cart c:cart_list){
                    if(c.getId() == id){
                        exist = true;
                        out.println("item aready exist");
                    }
                }
                if(!exist){
                    lsCart.add(cart);
                    response.sendRedirect("index.jsp");
                }
            }
        }
    }

}
