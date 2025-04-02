<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Products - SnapKart</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

  <!-- Include jQuery (only once) -->
  <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
  
  <style>
    /* Base (Light) Mode */
    body {
      background-color: #f8f9fa; /* Light background */
      color: #000;              /* Dark text for light mode */
      transition: background 0.4s, color 0.4s;
    }
    
    /* Card Image Sizing */
    .card-img-top {
      width: 100%;
      height: 160px; /* Adjust the height as needed */
      object-fit: cover;
    }
    
    /* Custom Cart Link styling */
    .cart-link {
      display: flex;
      align-items: center;
      gap: 5px;
      font-size: 1.1rem;
      color: inherit;
    }
    
    /* Dark Mode */
    .dark-mode {
      background: linear-gradient(135deg, #232526, #414345) !important;
      color: #fff;
    }
    
    /* Adjust card and navbar colors in dark mode if desired */
    .dark-mode .card {
      background-color: #2c2c2c;
      border: 1px solid #444;
    }
    
    .dark-mode .navbar {
      background-color: #1e1e1e !important;
    }
    
    /* Ensure text stands out in dark mode */
    .dark-mode .nav-link,
    .dark-mode .navbar-brand {
      color: #fff !important;
    }
    
    /* Buttons in dark mode */
    .dark-mode .btn-primary {
      background-color: #ff9900 !important;
      border-color: #ff9900;
    }
    
    .dark-mode .btn-warning {
      background-color: #ff9900 !important;
      border-color: #ff9900;
      color: #fff !important;
    }
  </style>
</head>
<body>
  <!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <!-- Left Side: SnapKart Logo -->
        <a class="navbar-brand d-flex align-items-center" href="#">
            <i class="fas fa-shopping-cart text-warning" style="font-size: 2rem; margin-right: 10px;"></i>
            <span class="fw-bold text-warning" style="font-size: 1.5rem;">SnapKart</span>
        </a>
        

        <div class="mx-auto">
            <span class="nav-link text-light fw-bold" style="font-size: 1.3rem;">
                Welcome, <span class="text-warning">${ username }</span>
            </span>
        </div>

        <div>
            <ul class="navbar-nav d-flex flex-row align-items-center">
                <li class="nav-item">
                    <a class="nav-link px-3" href="#" style="font-size: 1.2rem;">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link px-3" href="showCart" style="font-size: 1.2rem;">
                        <i class="fas fa-shopping-cart"></i> Cart
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link px-3" href="profileDisplay" style="font-size: 1.2rem;">Profile</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link px-3" href="logout" style="font-size: 1.2rem;">Logout</a>
                </li>
                <!-- Dark Mode Toggle -->
                <li class="nav-item ms-3">
                    <button class="btn btn-warning btn-sm" id="toggleMode" style="font-size: 1rem; padding: 5px 10px;">
                        Dark Mode
                    </button>
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
