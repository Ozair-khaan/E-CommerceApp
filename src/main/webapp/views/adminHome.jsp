<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
    />
    <link
      rel="stylesheet"
      href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@600&family=Montserrat:wght@700&display=swap"
      rel="stylesheet"
    />

    <style>
      body {
        background-color: #f8f9fa;
      }
      .admin-heading {
        font-family: "Poppins", sans-serif;
        font-weight: 700;
        color: #2c3e50;
      }
      .card {
        border: none;
        transition: transform 0.3s;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      }
      .card:hover {
        transform: scale(1.05);
      }
      .dashboard-summary {
        background: linear-gradient(45deg, #ffa500, #ff5733);
        color: white;
        padding: 20px;
        border-radius: 10px;
      }
      .snapkart-brand {
        font-weight: bold;
        background: linear-gradient(45deg, #ffa500, #ffd700);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        font-size: 1.5rem;
      }
      .dark-mode {
        background-color: #343a40 !important;
        color: white !important;
      }
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
    </style>
    <title>Admin Dashboard | SnapKart</title>
  </head>

  <body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
      <div class="container-fluid">
        <a class="navbar-brand snapkart-brand" href="/admin/">
          <i class="fas fa-shopping-cart"></i> SnapKart
        </a>
        <button
          class="navbar-toggler"
          type="button"
          data-toggle="collapse"
          data-target="#navbarNav"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link" href="/admin/">Home</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/admin/logout">Logout</a>
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
      <div class="dashboard-summary text-center">
        <h2>Welcome Back, ${admin}</h2>
        <p>Empower your business with seamless management.</p>
      </div>
      <br />
      <div class="row text-center">
        <div class="col-md-4">
          <div class="card p-4">
            <h4>Total Orders</h4>
            <p class="lead">1,234</p>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card p-4">
            <h4>Total Revenue</h4>
            <p class="lead">$12,345</p>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card p-4">
            <h4>Active Users</h4>
            <p class="lead">567</p>
          </div>
        </div>
      </div>
      <br />
      <div class="row">
        <div class="col-md-4">
          <div class="card text-center p-4">
            <h4>Categories</h4>
            <i class="fas fa-th-large fa-3x"></i>
            <a href="/admin/categories" class="btn btn-primary mt-2">Manage</a>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card text-center p-4">
            <h4>Products</h4>
            <i class="fas fa-box fa-3x"></i>
            <a href="/admin/products" class="btn btn-primary mt-2">Manage</a>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card text-center p-4">
            <h4>Customers</h4>
            <i class="fas fa-users fa-3x"></i>
            <a href="/admin/customers" class="btn btn-primary mt-2">Manage</a>
          </div>
        </div>
      </div>
    </div>

    <script>
      document
        .getElementById("toggleMode")
        .addEventListener("click", function () {
          document.body.classList.toggle("dark-mode");
        });
    </script>

    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
  </body>
</html>
