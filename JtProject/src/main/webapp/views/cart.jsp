<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Cart</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body>
    <!-- Navigation Bar (for consistency) -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">SnapKart</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item"><a class="nav-link" href="/">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="showCart">Cart</a></li>
                    <li class="nav-item"><a class="nav-link" href="profileDisplay">Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Cart Content -->
    <div class="container mt-4">
        <h2>Shopping Cart</h2>
        <table class="table">
            <thead>
                <tr>
                    <th>Image</th>
                    <th>Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Retrieve cart items from session
                    List<Map<String, Object>> cartItems = (List<Map<String, Object>>) session.getAttribute("cartItems");
                    if (cartItems != null && !cartItems.isEmpty()) {
                        for (Map<String, Object> item : cartItems) {
                %>
                            <tr>
                                <td><img src="<%= item.get("image") %>" width="50" height="50" alt="Product Image"/></td>
                                <td><%= item.get("name") %></td>
                                <td><%= item.get("quantity") %></td>
                                <td>$<%= item.get("price") %></td>
                            </tr>
                <%
                        }
                    } else {
                %>
                        <tr>
                            <td colspan="4">Your cart is empty.</td>
                        </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</body>
</html>
