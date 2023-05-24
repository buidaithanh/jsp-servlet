<%@page import="dao.ProductDao"%>
<%@page import="connection.ConnectDB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="model.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("auth", auth);
    }

    ProductDao prdao = new ProductDao(ConnectDB.getConnection());
    List<Product> products = prdao.getAllProducts();
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if (cart_list != null) {
        request.setAttribute("cart_list", cart_list);
    }

%>

<!DOCTYPE html>
<html>
    <head>
        <title>Wellcome to DT Sneakers shop</title>
        <%@include file="includes/header.jsp"%>

        <style type="text/css">


            .image-wrapper {
                position: relative;
                overflow: hidden;
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);
            }
            .card-header{
                margin-top: 150px;
            }

            .card-header img{

                color: white;
                width: 100%;
                

            }

            .card-img-top {
                width: 100%;
                height: 250px;
                
                border: 1px solid transparent;
                transition: transform 0.3s ease;
            }

            .card-img-top:hover {
                transform: scale(1.05);
                border-color: #fff;
            }

            .card {
                width: 100%;
                box-shadow: 0 10px 20px rgba(0,0,0,.2);
                border-radius: 1.2rem;
                margin-bottom: 40px;
            }
            .content{
                background: #fff;
                margin:1em;
            }

            .review-container{
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: .6em;
            }
            .star i{
                color: rgb(255,238,0);
                font-size:.8em;
            }
            .star span, .category p {
                font-size: .85em;
                color: rgb(36,36,36);
            }
            .name, .price{
                font-size:1em;
                color:#000;
            }
            
            .img img{
                width: 100%;
                border-radius:1.2em 1.2em 0 0;
            }
            .button-container{
                display: flex;
                justify-content: space-between;
                align-items: center;
                color:#fff;
                margin-top: 1.5em;
            }
            .card-button{
                display: flex;
                align-items: center;
                background: #06d6a0;
                padding: 0px 10px;
                cursor: pointer;
                border-radius: .5em;
            }
            .cart-icon, .like-button{
                width: 33px;
                height: 33px;
                text-align: center;
                cursor: pointer;
                border-radius: 2em;
                padding: 4px;
                background: #06c995;
            }
            
            .card-button a {
                padding: 10px ;
                color: white;
                text-decoration: none;
            }
            .card-button:hover{
                transform: scale(1.08);
            }

        </style>

    </head>
    <body>
        <%@include file="includes/navbar.jsp"%>


        <div class="container">
            <div class="card-header my-3">
                <img src='product-images/sneaker.jpg'/>
            </div>
            <div class="row">
                <% if (!products.isEmpty()) {
                        for (Product p : products) {%>
                <div class="col-md-3">
                    
                    <div class="card">
                        <div class="img">
                            <img class="card-img-top" src="<%= p.getImage()%>" alt="Card image cap">
                        </div>
                        <div class="content">
                            <div class="review-container">
                                <div class="star">
                                    <span> Reviews</span>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star-half"></i>   
                                </div>
                            <h5 class="price">$<%= p.getPrice()%></h5>

                            </div>
                        
                        <h4 class="name"><%= p.getName()%></h4>
                        <div class="category"><p>Category: <%= p.getCategory()%></p></div>
                        <div class="button-container">
                            <div class="like-button">
                                <i class="fa fa-heart"></i>
                            </div>
                            <div class="card-button">
                                <a href="add-to-cart?id=<%= p.getId()%>">Add to cart</a>
                                <div class="cart-icon">
                                    <i class="fa fa-shopping-cart"></i>
                                </div>
                            </div>
                        </div>
                        </div>
                    </div>        

                </div>
                <% }
                    }%>
            </div>
        </div>



          <%@include file="includes/footerbt.jsp"%>
        <%@include file="includes/footer.jsp"%>

    </body>
</html>