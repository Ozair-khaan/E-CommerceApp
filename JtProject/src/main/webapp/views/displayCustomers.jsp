<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Customer Management - SnapKart</title>


    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

    <style>
        body { background-color: #f8f9fa; transition: 0.3s; }
        .dark-mode { background-color: #121212 !important; color: white !important; }
        .dark-mode table { background-color: #1e1e1e !important; color: white; }
        .dark-mode th, .dark-mode td { border-color: #555; }
        .dark-mode .navbar { background-color: #1e1e1e !important; }
        .dark-mode .btn-warning { background-color: #ff9900 !important; border-color: #ff9900; }
        .snapkart-brand {
            font-weight: bold;
            font-size: 1.5rem;
            background: linear-gradient(45deg, #FFA500, #FFD700);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
    </style>
</head>
<body>


<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <i class="fas fa-shopping-cart"></i> <span class="snapkart-brand">SnapKart</span>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link active" href="Dashboard">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
                <li class="nav-item">
                    <button class="btn btn-warning btn-sm" id="toggleMode">Dark Mode</button>
                </li>
            </ul>
        </div>
    </div>
</nav>


<div class="container-fluid mt-4">
    <h2 class="text-center mb-4">Customer Management</h2>

    <table class="table table-striped table-hover">
        <thead class="thead-dark">
            <tr>
                <th>Customer Name</th>
                <th>Email</th>
                <th>Address</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="customer" items="${customers}">
                <tr>
                    <td>${customer.username}</td>
                    <td>${customer.email}</td>
                    <td>${customer.address}</td>
                    <td>
                        <button class="btn btn-danger btn-sm delete-btn" data-id="${customer.id}">
                            <i class="fas fa-trash"></i> Delete
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

<script>
   
    document.getElementById("toggleMode").addEventListener("click", function() {
        document.body.classList.toggle("dark-mode");
    });

    
    $(".delete-btn").click(function() {
        let customerId = $(this).data("id");
        if (confirm("Are you sure you want to delete this customer?")) {
            window.location.href = "deleteCustomer?id=" + customerId;
        }
    });
</script>

</body>
</html>
