<%-- 
    Document   : listSneaker
    Created on : May 17, 2023, 10:57:56 PM
    Author     : DaiThanh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <div class="container" style="width: 700px">
            <div style="display: flex; align-items: center; justify-content: space-between">
                <h2>MAGAZINE LIST</h2>
            </div>
            
           
            <br/><br/><br/>
            <table class="table table-bordered table-striped" >
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Publisher</th>
                        <th>Price</th>
                        <th style="width: 150px">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="sneaker" items="${sneakers}">
                        <c:url var="tempLink" value="SneakerController">
                            <c:param name="command" value="LOAD"></c:param>
                            <c:param name="id" value="${sneaker.id}"></c:param>
                        </c:url>
                        
                       
                        <c:url var="deleteLink" value="SneakerController">
                            <c:param name="command" value="DELETE"></c:param>
                            <c:param name="id" value="${sneaker.id}"></c:param>

                        </c:url>
                        <tr>
                            <td>${sneaker.id}</td>
                            <td>${sneaker.name}</td>
                            <td>${sneaker.category}</td>
                            <td>${sneaker.price}</td>
                            <td>
                                <a type="button" class="btn btn-primary btn-sm" href="${tempLink}">Update</a>
                                <a type="button" class="btn btn-danger btn-sm" href="${deleteLink}"
                                   onclick="if (!(confirm('Do you want to delete magazine??')))
                                               return false">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <br><!-- comment -->
             <a type="button" class="btn btn-info" href="add-maz.jsp">CREATE MAGAZINE</a>
        </div>
    </body>
</html>
