<%@page import="java.text.DecimalFormat"%>
<%@page import="connection.ConnectDB"%>
<%@page import="dao.ProductDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Cart"%>
<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    DecimalFormat dcf = new DecimalFormat("#.##");
    request.setAttribute("dcf", dcf);
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("auth", auth);
    }
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    List<Cart> cartProduct = null;
    if (cart_list != null) {
        ProductDao pDao = new ProductDao(ConnectDB.getConnection());
        cartProduct = pDao.getCartProducts(cart_list);
        double total = pDao.getTotalCartPrice(cart_list);
        request.setAttribute("total", total);
        request.setAttribute("cart_list ", cart_list);
    }
%>
<!DOCTYPE html>
<html>

    <head>
        <title>Insert title here</title>
        <%@include file="includes/header.jsp" %>
        <style type="text/css">
            .payment:hover{
              color: white;
                text-decoration: none;  
            }
            .payment{
                color: white;
                text-decoration: none;
            }
            .table tbody td{
                vertical-align: middle;
            }
            .btn-incre, .btn-decre{
                box-shadow: none;
                font-size: 25px;
            }
            .cart {
                padding: 50px;
            }
            .btn-cal{
                width: 40px;
                height: 40px;
                margin:0 10px 0 10px;
            }
        </style>    
    </head>

    <body>
        <%@include file="includes/navbar.jsp"%>
        <!--        <div class="container cart my-3">
                    
                    <table class="table table-light">
                        <thead>
                            <tr>
                                <th scope="col">Name</th>
                                <th scope="col">Category</th>
                                <th scope="col">Price</th>
                                <th scope="col">Buy Now</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>
        <%                        if (cart_list != null) {
                for (Cart c : cartProduct) {
        %>
        <tr>
            <td><%=c.getName()%></td>
            <td><%=c.getCategory()%></td>
            <td><%= dcf.format(c.getPrice())%></td>
            <td>
                <form action="order" method="post" class="form-inline">
                    <input type="hidden" name="id" value="<%= c.getId()%>" class="form-input">
                    <div class="form-group d-flex justify-content-between">
                        <a class="btn bnt-sm btn-incre" href="quantity-cal?action=inc&id=<%=c.getId()%>"><i class="fas fa-plus-square"></i></a> 
                        <input type="text" name="quantity" class="form-control"  value="<%=c.getQuantity()%>" readonly> 
                        <a class="btn btn-sm btn-decre" href="quantity-cal?action=dec&id=<%=c.getId()%>"><i class="fas fa-minus-square"></i></a>
                    </div>
                    <button type="submit" class="btn btn-primary btn-sm">Buy</button>
                    <a href="order?quantity=1&id=<%= c.getId()%>">buydđ</a>
                </form>
            </td>
            <td><a href="delete-from-cart?id=<%=c.getId()%>" class="btn btn-sm btn-danger">Delete</a></td>
        </tr>

        <%
                }
            }%>
    </tbody>
</table>
    <div class="d-flex  py-3"><h3>Total Price: $ ${(total>0)?dcf.format(total):0} </h3> <a class="mx-3 btn btn-primary" href="payment">Check Out</a></div>
</div>-->
        <section class="h-100 gradient-custom">
            <div class="container py-5">
                <div class="row d-flex justify-content-center my-4">
                    <div class="col-md-8">
                        <div class="card mb-4">
                            <div class="card-header py-3">
                                <h5 class="mb-0">Shopping Cart</h5>
                            </div>
                            <div class="card-body">

                                <%
                                    if (cart_list != null) {
                                        for (Cart c : cartProduct) {
                                %>

                                <!-- Single item -->
                                <div class="row">
                                    <div class="col-lg-3 col-md-12 mb-4 mb-lg-0">
                                        <!-- Image -->
                                        <div class="bg-image hover-overlay hover-zoom ripple rounded" data-mdb-ripple-color="light">
                                            <img src="<%= c.getImage()%>"
                                                 class="w-100" alt="Blue Jeans Jacket" />
                                            
                                        </div>
                                        <!-- Image -->
                                    </div>

                                    <div class="col-lg-5 col-md-6 mb-4 mb-lg-0">
                                        <!-- Data -->
                                        <p><strong><%= c.getName()%></strong></p>

                                        <button class="btn btn-sm me-1 mb-2">
                                            <a href="delete-from-cart?id=<%=c.getId()%>" class="btn btn-sm btn-danger"><i class="fas fa-trash"></i></a>                             
                                        </button>
                                        <button type="button" class="btn btn-danger btn-sm mb-2" data-mdb-toggle="tooltip"
                                                title="Move to the wish list">
                                            <i class="fas fa-heart"></i>
                                        </button>
                                        <!-- Data -->
                                    </div>

                                    <div class="col-lg-4 col-md-6 mb-4 mb-lg-0">
                                        <!-- Quantity -->
                                        <div class="d-flex mb-4" style="max-width: 300px">
                                            <button class="px-3 btn me-2 btn-cal">
                                                <a href="quantity-cal?action=dec&id=<%=c.getId()%>"><i class="fas fa-minus"></i></a> 
                                            </button>
                                            <div class="form-outline">
                                                <input type="text" name="quantity" class="form-control"  value="<%=c.getQuantity()%>" readonly> 
                                                <label class="form-label" for="form1">Quantity</label>
                                            </div>
                                            <button class="btn  px-3 ms-2 btn-cal">
                                                <a href="quantity-cal?action=inc&id=<%=c.getId()%>"><i class="fas fa-plus"></i></a> 

                                            </button>
                                        </div>
                                        <!-- Quantity -->

                                        <!-- Price -->
                                        <p class="text-start text-md-center">
                                            <strong><%=c.getPrice()%></strong>
                                        </p>
                                        <!-- Price -->
                                    </div>
                                </div>
                                        <hr class="my-4" />
                                <%
                                        }
                                    }%>
                                <!-- Single item -->

                                <hr class="my-4" />

                                <!-- Single item -->

                                <!-- Single item -->
                            </div>
                        </div>
                        <div class="card mb-4">
                            <div class="card-body">
                                <p><strong>Expected shipping delivery</strong></p>
                                <p class="mb-0">23/05/2023 - 30/05/2023</p>
                            </div>
                        </div>
                        <div class="card mb-4 mb-lg-0">
                            <div class="card-body">
                                <p><strong>We accept</strong></p>
                                <img class="me-2" width="45px"
                                     src="https://mdbcdn.b-cdn.net/wp-content/plugins/woocommerce-gateway-stripe/assets/images/visa.svg"
                                     alt="Visa" />
                                <img class="me-2" width="45px"
                                     src="https://mdbcdn.b-cdn.net/wp-content/plugins/woocommerce-gateway-stripe/assets/images/amex.svg"
                                     alt="American Express" />
                                <img class="me-2" width="45px"
                                     src="https://mdbcdn.b-cdn.net/wp-content/plugins/woocommerce-gateway-stripe/assets/images/mastercard.svg"
                                     alt="Mastercard" />
                                <img class="me-2" width="45px"
                                     src="https://tse1.mm.bing.net/th?id=OIP.PwHa47hn5bdNXKe6cNe_3QHaEK&pid=Api&P=0&h=180"
                                     alt="PayPal acceptance mark" />
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card mb-4">
                            <div class="card-header py-3">
                                <h5 class="mb-0">Summary</h5>
                            </div>
                            <div class="card-body">
                                <ul class="list-group list-group-flush">
                                    <li
                                        class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 pb-0">
                                        Products
                                        <span>${(total>0)?dcf.format(total):0} $</span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                                        Shipping
                                        <span>Gratis</span>
                                    </li>
                                    <li
                                        class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 mb-3">
                                        <div>
                                            <strong>Total amount</strong>
                                            <strong>
                                                <p class="mb-0">(including VAT)</p>
                                            </strong>
                                        </div>
                                        <span><strong>${(total>0)?dcf.format(total):0} $</strong></span>
                                    </li>
                                </ul>

                                <button type="button" class="btn btn-primary btn-lg btn-block">
                                    <a class="payment" href="payment">
                                        Go to checkout
                                    </a>
                                    
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <%@include file="includes/footer.jsp" %>
    </body>
</html>