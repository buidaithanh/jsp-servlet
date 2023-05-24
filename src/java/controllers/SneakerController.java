/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Product;
import dao.ProductDao;
import java.util.List;
import javax.servlet.RequestDispatcher;

/**
 *
 * @author DaiThanh
 */
public class SneakerController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       try {
			String theCommand = request.getParameter("command");
			if (theCommand == null) {
				theCommand = "LIST";
			}
			switch (theCommand) {
			case "LIST" -> listProduct(request, response);
			case "ADD" -> addProduct(request, response);
                        case "LOAD" ->loadProduct(request, response);
			case "UPDATE" -> updateProduct(request, response);
			case "DELETE" -> deleteProduct(request, response);
			default -> listProduct(request, response);
			}

		} catch (Exception ex) {

			System.out.println(ex);
		}
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }
    private void listProduct(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ProductDao dao = new ProductDao();
		List<Product> list = dao.getAllProducts();

		request.setAttribute("sneakers", list);

		RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
		dispatcher.forward(request, response);
	}
    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int id = Integer.parseInt(request.getParameter("id"));
		String name = request.getParameter("name");
		String category = request.getParameter("category");
		double price = Double.parseDouble(request.getParameter("price"));
                String image = request.getParameter("image");

		Product sneaker = new Product(id, name, category, price,image);
		ProductDao dao = new ProductDao();
		dao.addProduct(sneaker);

		
	}

	private void loadProduct(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int idSneaker = Integer.parseInt(request.getParameter("id"));

		Product product = new ProductDao().getSingleProduct(idSneaker);
		request.setAttribute("THE_SNEAKER_UPDATE", product);
		RequestDispatcher dispatcher = request.getRequestDispatcher("update-sneaker.jsp");
		dispatcher.forward(request, response);
	}

	private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int idSneaker = Integer.parseInt(request.getParameter("id"));
		String name = request.getParameter("name");
		String category = request.getParameter("category");
		double price = Double.parseDouble(request.getParameter("price"));
                String image = request.getParameter("image");
		Product sneaker = new Product(idSneaker, name, category, price,image);


		new ProductDao().updateProduct(sneaker);
		listProduct(request, response);
	}

	private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String idSneaker = request.getParameter("id");
		new ProductDao().deleteProduct(idSneaker);
		listProduct(request, response);

	}

    
   
}
