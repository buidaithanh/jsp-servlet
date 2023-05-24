<%@page import="model.User"%>
<style>
    .navbar {
        overflow: hidden;
        background-color:#3CB371;
        position: fixed;
        z-index: 1;/* Set the navbar to fixed position */
        top: 0; /* Position the navbar at the top of the page */
        width: 100%;


    }
    .navbar a {
        color: white;
    }
    .search-container {
        display: flex;
        align-items: center;
        background-color: #f2f2f2;
        padding: 10px;
        margin-bottom: 20px;
    }

    .sneaker-title {
        margin-right: 10px;
    }

    .search-wrapper {
        display: flex;
    }

    .search-input {
        padding: 6px 10px;
        border: none;
        border-radius: 4px 0 0 4px;
    }

    .search-button {
        padding: 6px 12px;
        border: none;
        background-color: #ccc;
        border-radius: 0 4px 4px 0;
        cursor: pointer;
    }

    .search-button i {
        color: #fff;
    }
</style>
<nav class="navbar navbar-expand-lg  nb">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">Sneaker DT</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse"
                data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="search-wrapper">
            <input type="text" class="search-input" placeholder="Search...">
            <button type="submit" class="search-button">
                <i class="fas fa-search"></i>
            </button>
        </div>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active"><a class="nav-link" href="index.jsp">Home

                    </a></li>
                <li class="nav-item"><a class="nav-link" href="cart.jsp">Cart <span class="badge badge-danger">${cart_list.size()}</span> </a></li>


                <%

                                            if (auth != null) {%>
                <li class="nav-item"><a class="nav-link" href="orders.jsp">Orders</a>
                </li>

                <li class="nav-item"><a class="nav-link" href="log-out">Log Out</a>
                </li>
                <% } else {%>
                <li class="nav-item"><a class="nav-link" href="login.jsp">Log In</a>
                </li>
                <%   }


                %>

            </ul>

        </div>
    </div>
</nav>