<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ page import="java.util.*" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Purchase Confirmation - SnapKart</title>
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
    />

    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

    <style>
      /* Base (Light) Mode */
      body {
        background-color: #f8f9fa;
        color: #000;
        transition: background 0.4s, color 0.4s;
      }

      /* Dark Mode */
      .dark-mode {
        background: linear-gradient(135deg, #232526, #414345) !important;
        color: #fff;
      }

      .dark-mode .navbar,
      .dark-mode .table {
        background-color: #1e1e1e !important;
        color: white;
      }

      .dark-mode .table th,
      .dark-mode .table td {
        color: white;
      }

      .dark-mode .card,
      .dark-mode .alert {
        background-color: #2c2c2c;
        color: white;
        border-color: #444;
      }

      /* SnapKart Navbar Styling */
      .snapkart-logo {
        font-size: 2rem;
        margin-right: 10px;
        color: #ffc107; /* Bootstrap warning color */
      }

      .snapkart-text {
        font-weight: bold;
        font-size: 1.5rem;
        color: #ffc107;
      }

      .navbar-nav .nav-link {
        font-size: 1rem;
      }

      /* Button Styling */
      .btn-primary {
        background-color: #ff9900 !important;
        border-color: #ff9900;
        color: white !important;
      }

      .btn-primary:hover {
        background-color: #e68a00 !important;
      }

      .btn-warning {
        background-color: #ff9900 !important;
        border-color: #ff9900;
        color: white !important;
      }
    </style>
  </head>

  <body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
      <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="#">
          <i class="fas fa-shopping-cart snapkart-logo"></i>
          <span class="snapkart-text">SnapKart</span>
        </a>
        <button
          class="navbar-toggler"
          type="button"
          data-toggle="collapse"
          data-target="#navbarNav"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div
          class="collapse navbar-collapse justify-content-end"
          id="navbarNav"
        >
          <ul class="navbar-nav align-items-center">
            <li class="nav-item"><a class="nav-link px-3" href="/">Home</a></li>
            <li class="nav-item">
              <a class="nav-link px-3" href="showCart"
                ><i class="fas fa-shopping-cart"></i> Cart</a
              >
            </li>
            <li class="nav-item">
              <a class="nav-link px-3" href="profileDisplay">Profile</a>
            </li>
            <li class="nav-item">
              <a class="nav-link px-3" href="logout">Logout</a>
            </li>
            <li class="nav-item">
              <button class="btn btn-warning btn-sm" id="toggleMode">
                Dark Mode
              </button>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <div class="container mt-4">
      <h2>${message}</h2>

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
          <c:set var="purchasedItems" value="${purchasedItems}" />
          <c:set var="totalAmount" value="${totalAmount}" />
          <c:if test="${not empty purchasedItems}">
            <c:forEach var="item" items="${purchasedItems}">
              <c:set var="price" value="${item.price}" />
              <c:set var="quantity" value="${item.quantity}" />
              <c:set var="subtotal" value="${price * quantity}" />
              <tr>
                <td>
                  <img
                    src="${item.image}"
                    width="50"
                    height="50"
                    alt="Product Image"
                  />
                </td>
                <td>${item.name}</td>
                <td>${quantity}</td>
                <td>$ ${price}</td>
                <td>$ ${subtotal}</td>
              </tr>
            </c:forEach>
          </c:if>
          <c:if test="${empty purchasedItems}">
            <tr>
              <td colspan="5" class="text-center">No items purchased.</td>
            </tr>
          </c:if>
        </tbody>
      </table>

      <div class="alert alert-info">
        <h4>Total Amount Paid: $ ${totalAmount}</h4>
      </div>

      <a href="${pageContext.request.contextPath}/" class="btn btn-primary"
        >Continue Shopping</a
      >
    </div>

    <script>
      document
        .getElementById("toggleMode")
        .addEventListener("click", function () {
          document.body.classList.toggle("dark-mode");
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
  </body>
</html>
