<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Your Cart - SnapKart</title>
  <!-- Include Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
  <!-- Include Font Awesome CSS -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <style>
    /* Base styling */
    body {
      background-color: #f8f9fa;
      color: #000;
      transition: background 0.4s, color 0.4s;
    }
    /* Navbar Branding & Link Styles */
    .navbar-brand {
      display: flex;
      align-items: center;
      font-size: 1.5rem;
    }
    .snapkart-logo {
      font-size: 2rem;
      margin-right: 10px;
      color: #ffc107;
    }
    .snapkart-text {
      font-weight: bold;
      color: #ffc107;
      font-size: 1.5rem;
    }
    .navbar-nav .nav-link {
      font-size: 1rem;
    }
    /* Dark Mode */
    .dark-mode {
      background: linear-gradient(135deg, #232526, #414345) !important;
      color: #fff;
    }
    .dark-mode .navbar {
      background-color: #1e1e1e !important;
    }
    .dark-mode .nav-link,
    .dark-mode .navbar-brand {
      color: #fff !important;
    }
    .dark-mode .btn-primary {
      background-color: #ff9900 !important;
      border-color: #ff9900;
    }
    .dark-mode .btn-warning {
      background-color: #ff9900 !important;
      border-color: #ff9900;
      color: #fff !important;
    }
    /* Table in Dark Mode */
    .dark-mode .table {
      background-color: #2c2c2c;
      color: #fff;
    }
    .dark-mode .table thead th,
    .dark-mode .table tbody td {
      border-color: #444;
    }
  </style>
  <!-- Include jQuery -->
  <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
  <!-- Navigation Bar -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
      <!-- Left Side: SnapKart Logo -->
      <a class="navbar-brand d-flex align-items-center" href="#">
        <i class="fas fa-shopping-cart snapkart-logo"></i>
        <span class="snapkart-text">SnapKart</span>
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <!-- Right: Navigation Links & Dark Mode Button -->
      <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
        <ul class="navbar-nav d-flex flex-row align-items-center">
          <li class="nav-item">
            <a class="nav-link px-3" href="/">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link px-3" href="showCart">
              <i class="fas fa-shopping-cart"></i> Cart
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link px-3" href="profileDisplay">Profile</a>
          </li>
          <li class="nav-item">
            <a class="nav-link px-3" href="logout">Logout</a>
          </li>
          <li class="nav-item ms-3">
            <button class="btn btn-warning btn-sm" id="toggleMode" style="font-size: 1rem; padding: 5px 10px;">
              Dark Mode
            </button>
          </li>
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
          <td>$ <%= item.get("price") %></td>
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

    <!-- Purchase Button -->
    <%
      if (cartItems != null && !cartItems.isEmpty()) {
    %>
    <form action="${pageContext.request.contextPath}/purchase" method="post">
      <button type="submit" class="btn btn-success">Purchase</button>
  </form>
    <%
      }
    %>
  </div>

  <!-- Dark Mode Toggle Event with localStorage -->
  <script>
    // On page load, check if dark mode was enabled previously
    $(document).ready(function(){
      if(localStorage.getItem("darkMode") === "enabled"){
        $("body").addClass("dark-mode");
      }
    });

    // Toggle dark mode on button click and store state in localStorage
    document.getElementById('toggleMode').addEventListener('click', function() {
      document.body.classList.toggle('dark-mode');
      if(document.body.classList.contains('dark-mode')){
        localStorage.setItem("darkMode", "enabled");
      } else {
        localStorage.setItem("darkMode", "disabled");
      }
    });
  </script>

  <!-- Include Popper and Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm
::contentReference[oaicite:0]{index=0}