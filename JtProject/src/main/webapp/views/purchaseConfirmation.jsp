<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Purchase Confirmation - SnapKart</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2>${message}</h2>

        <!-- Purchased Items Table -->
        <table class="table table-bordered mt-3">
            <thead class="thead-dark">
                <tr>
                    <th>Image</th>
                    <th>Item Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Subtotal</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Map<String, Object>> purchasedItems = (List<Map<String, Object>>) request.getAttribute("purchasedItems");
                    double totalAmount = (double) request.getAttribute("totalAmount");

                    if (purchasedItems != null && !purchasedItems.isEmpty()) {
                        for (Map<String, Object> item : purchasedItems) {
                            double price = (double) item.get("price");
                            int quantity = (int) item.get("quantity");
                            double subtotal = price * quantity;
                %>
                <tr>
                    <td><img src="<%= item.get("image") %>" width="50" height="50" alt="Product Image"/></td>
                    <td><%= item.get("name") %></td>
                    <td><%= quantity %></td>
                    <td>$ <%= price %></td>
                    <td>$ <%= subtotal %></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="5" class="text-center">No items purchased.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <!-- Total Amount -->
        <div class="alert alert-info">
            <h4>Total Amount Paid: $ <%= totalAmount %></h4>
        </div>

        <!-- Continue Shopping Button -->
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Continue Shopping</a>
    </div>
</body>
</html>
