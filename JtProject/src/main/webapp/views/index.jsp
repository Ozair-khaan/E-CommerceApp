<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org"
      xmlns:sec="http://www.thymeleaf.org/thymeleaf-extras-springsecurity3">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
          integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
          <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
    <title>Document</title>
    <style>
        body { background-color: #f8f9fa; }
        .admin-heading { font-family: 'Poppins', sans-serif; font-weight: 700; color: #2c3e50; }
        .card { border: none; transition: transform 0.3s; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .card:hover { transform: scale(1.05); }
        .dashboard-summary { background: linear-gradient(45deg, #FFA500, #FF5733); color: white; padding: 20px; border-radius: 10px; }
        .snapkart-brand { font-weight: bold; background: linear-gradient(45deg, #FFA500, #FFD700); -webkit-background-clip: text; -webkit-text-fill-color: transparent; font-size: 1.5rem; }
        .dark-mode { background-color: #343a40 !important; color: white !important; }
        body.dark-mode {
            background-color: #121212 !important;
            color: #ffffff;
        }
        .dark-mode .card {
            background-color: #1e1e1e !important;
            color: #ffffff;
            border: 1px solid #333;
        }
        .dark-mode .btn-primary {
            background-color: #ff9900 !important;
            border-color: #ff9900;
        }
        .dark-mode .jumbotron {
            background: linear-gradient(45deg, #ff7700, #ff5500);
            color: white;
        }
        .product-card {
            width: 100%;
            height: 400px; /* Adjust as needed */
            display: flex;
            flex-direction: column;
        }
        .product-card .card-img-top {
            max-height: 150px; /* Adjust as needed */
            object-fit: contain;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand snapkart-brand" href="#">
            <i class="fas fa-shopping-cart"></i> SnapKart
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link" href="#">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
                <li class="nav-item"><button class="btn btn-warning btn-sm" id="toggleMode">Dark Mode</button></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="dashboard-summary text-center">
        <h2>Welcome Back, ${username}</h2>
        <p>Empower your business with seamless management.</p>
    </div>
    <br>
    <div class="row">
        <c:forEach var="product" items="${products}">
        <div class="col-md-3 product-card">
          <div class="card mb-4">
            <img class="card-img-top" src="${product.image}" alt="Product 1">
            <div class="card-body">
             <b> <h4 class="card-title">${product.name}</h4></b>
              <h5 class="card-text">Category: ${product.category.name}</h5>
              <h5 class="card-text">Price: ${product.price}</h5>
              <p class="card-text">Description: ${product.description}</p>
              <a id="addToCartBtn1" onclick="addToCart('${product.image}','${product.name}', '${product.price}')"  class="btn btn-primary">Add to Cart</a>
            </div>
          </div>
        </div> </c:forEach>
    </div>

    <div class="container mt-4">
        <div class="row">
          <div class="col-md-12">
            <h2 class="text-center mb-4 cart-header" style="color:red;">Your Cart</h2>
          </div>
        </div>
        <table class="shopping-cart table">
            <thead>
                <tr>
                    <th>Image</th>
                    <th>Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                </tr>
            </thead>
            <tbody>
                </tbody>
        </table>
    </div>
</div>

<script>
    document.getElementById('toggleMode').addEventListener('click', function() {
        document.body.classList.toggle('dark-mode');
    });

    function addToCart(productImage, productName, productPrice) {
        console.log(productImage + ', ' + productName + ', ' + productPrice);
        // Get the table body where cart items will be added
        var cartTableBody = document.querySelector('.shopping-cart tbody');
        console.log(cartTableBody);

        // Check if product already exists in the cart
        var existingRow = null;
        for (var i = 0; i < cartTableBody.rows.length; i++) {
            var row = cartTableBody.rows[i];
            var nameCell = row.cells[1]; // assuming second cell holds the product name
            if (nameCell.textContent === productName) {
                existingRow = row;
                break;
            }
        }

        if (existingRow) {
            // Product exists, so increase the quantity
            var quantityCell = existingRow.cells[2];
            var currentQuantity = parseInt(quantityCell.textContent) || 1;
            var newQuantity = currentQuantity + 1;
            quantityCell.textContent = newQuantity;

            // Update the price cell based on the new quantity
            var priceCell = existingRow.cells[3];
            var unitPrice = Number(productPrice);
            priceCell.textContent = '$' + (unitPrice * newQuantity).toFixed(2);
        } else {
            // Product doesn't exist; create a new row in the cart
            var newRow = cartTableBody.insertRow();
            // Create cells for product image, name, quantity, and price
            var productImageCell = newRow.insertCell(0);
            var productNameCell = newRow.insertCell(1);
            var quantityCell = newRow.insertCell(2);
            var productPriceCell = newRow.insertCell(3);

            // Create an image element for the product
            var imgElement = document.createElement('img');
            imgElement.src = productImage;
            imgElement.alt = productName;
            imgElement.style.width = "50px";
            imgElement.style.height = "50px";
            productImageCell.appendChild(imgElement);

            // Set the content for the remaining cells
            productNameCell.textContent = productName;
            quantityCell.textContent = 1; // initial quantity is 1
            productPriceCell.textContent = '$' + Number(productPrice).toFixed(2);
        }
    }
</script>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</body>
</html>