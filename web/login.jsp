<%@page import="java.util.ArrayList"%>
<%@page import="model.Cart"%>
<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        response.sendRedirect("index.jsp");
    }
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if (cart_list != null) {
        request.setAttribute("cart_list", cart_list);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Shopping cart login</title>
        <%@include file="includes/header.jsp" %>
        <style>
            .vh-100{
                height: 720px;
            }
        </style>
    </head>
    <body>
<!--        <div class="container">
            <div class="card w-50 mx-auto my-5">
                <div class="card-header text-center">User Login</div>
                <div class="card-body">
                    <form action="user-login" method="post">
                        <div class=form-group>
                            <label>Email:</label>
                            <input type="email" class="form-control" name="login-email" placeholder="Enter your email..." required>
                        </div>
                        <div class=form-group>
                            <label>Password:</label>
                            <input type="password" class="form-control" name="login-password" placeholder="Enter your password..." required>
                        </div>


                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">Login</button>
                        </div>

                    </form>
                </div>
            </div>
        </div>-->
        <section class="vh-100" style="background-color: #508bfc;">
            <div class="container py-5 h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                        <div class="card shadow-2-strong" style="border-radius: 1rem;">
                            <div class="card-body p-5 text-center">

                                <h3 class="mb-5">Sign in</h3>
                                <form action="user-login" method="post">
                        <div class=form-group>
                            <label class="form-label" for="typeEmailX-2">Email</label>
                            <input type="email" class="form-control" name="login-email" placeholder="Enter your email..." required>
                        </div>
                        <div class=form-group>
                            <label>Password:</label>
                            <input type="password" class="form-control" name="login-password" placeholder="Enter your password..." required>
                        </div>


                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">Login</button>
                        </div>

                    </form>
                                <hr class="my-4">

                                <button class="btn btn-lg btn-block btn-primary" style="background-color: #dd4b39;"
                                        type="submit"><i class="fab fa-google me-2"></i> Sign in with google</button>
                                <button class="btn btn-lg btn-block btn-primary mb-2" style="background-color: #3b5998;"
                                        type="submit"><i class="fab fa-facebook-f me-2"></i>Sign in with facebook</button>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <%@include file="includes/footer.jsp" %>
    </body>
</html>