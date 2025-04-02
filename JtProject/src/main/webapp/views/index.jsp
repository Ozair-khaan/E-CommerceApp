<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Products - SnapKart</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <!-- Include jQuery (only once) -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <style>
        body.dark-mode {
            background-color: #121212;
            color: #ffffff;
        }
        .card-img-top {
            width: 100%;
            height: 160px; /* Adjust the height as needed */
            object-fit: cover;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">SnapKart</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item"><a class="nav-link" href="#">Home</a></li>
                    <!-- Updated the Cart link to point to the cart page -->
                    <li class="nav-item"><a class="nav-link" href="showCart">Cart</a></li>
                    <li class="nav-item"><a class="nav-link" href="profileDisplay">Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
                    <li class="nav-item">
                        <button class="btn btn-warning btn-sm" id="toggleMode">Dark Mode</button>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mt-4">
        <h2>Products</h2>
        <div class="row">
            <!-- Loop through products passed by the controller -->
            <c:forEach var="product" items="${products}">
                <div class="col-md-3">
                    <div class="card mb-4">
                        <img class="card-img-top" src="${product.image}" alt="${product.name}">
                        <div class="card-body">
                            <h4 class="card-title">${product.name}</h4>
                            <p class="card-text">${product.description}</p>
                            <p class="card-text">$${product.price}</p>
                            <!-- Button triggers addToCart() -->
                            <button class="btn btn-primary" onclick="addToCart('${product.image}', '${product.name}', '${product.price}')">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <script>
        // Toggle dark mode
        document.getElementById('toggleMode').addEventListener('click', function() {
            document.body.classList.toggle('dark-mode');
        });

        function addToCart(productImage, productName, productPrice) {
            // Create a new product object
            var newProduct = {
                image: productImage,
                name: productName,
                quantity: 1,
                price: Number(productPrice)
            };

            // Send the new product to the server via AJAX.
            $.ajax({
                url: '<c:url value="/addToCart"/>',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(newProduct),
                success: function(response) {
                    console.log('Cart updated successfully:', response);
                },
                error: function(xhr, status, error) {
                    console.error('Error updating cart:', error);
                }
            });
        }
    </script>

    <!-- Include Popper and Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</body>
</html>
