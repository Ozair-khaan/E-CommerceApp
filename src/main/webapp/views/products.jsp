<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import ="java.io.FileOutputStream" %>
<%@page import="java.io.ObjectOutputStream" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    
    <title>SnapKart - Admin Panel</title>


    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    

    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

    <style>
        body { background-color: #f8f9fa; }
        .admin-heading { font-family: 'Poppins', sans-serif; font-weight: 700; color: #2c3e50; }
        .card { border: none; transition: transform 0.3s; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .card:hover { transform: scale(1.05); }
        .snapkart-brand { font-weight: bold; font-size: 2rem; color: white; }
        .dark-mode { background-color: #343a40 !important; color: white !important; }
        body.dark-mode { background-color: #121212 !important; color: #ffffff; }
        .dark-mode .card { background-color: #1e1e1e !important; color: #ffffff; border: 1px solid #333; }
        .dark-mode .btn-primary { background-color: #ff9900 !important; border-color: #ff9900; }
		.dark-mode table { 
        background-color: #222 !important; 
        color: #fff !important;
        border-collapse: collapse;
    }

/* .dark-mode th, .dark-mode td {
    border: 1px solid #777 !important;
    color: #fff !important;
}

.dark-mode thead {
    background-color: #444 !important;
}

.dark-mode img {
    filter: brightness(90%);
} */


/* .navbar {
    padding: 15px 20px;
    height: 65px;
} */


/* .snapkart-brand {
    font-weight: bold;
    font-size: 1.5rem;
    display: flex;
    align-items: center;
} */

/* .snapkart-brand i {
    margin-right: 8px;
    font-size: 28px;
    color: #FFA500;
} */

/* .snapkart-logo {
    font-weight: bold;
    background: linear-gradient(45deg, #FFA500, #FFD700);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
} */


.navbar-nav .nav-link {
    font-size: 16px;
    padding: 10px 15px;
}


.dark-mode {
    background-color: #121212 !important;
    color: #ffffff !important;
}

.dark-mode .navbar {
    background-color: #1e1e1e !important;
}

.dark-mode .snapkart-logo {
    -webkit-text-fill-color: white;
}

.dark-mode .btn-warning {
    background-color: #ff9900 !important;
    border-color: #ff9900;
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



    </style>
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


<div class="container-fluid mt-4">
    <a class="btn btn-primary mb-3" href="/admin/products/add">Add Product</a>
    
    <table class="table table-bordered">
        <thead class="thead-dark">
            <tr>
                <th scope="col">Serial No.</th>
                <th scope="col">Product Name</th>
                <th scope="col">Category</th>
                <th scope="col">Preview</th>
                <th scope="col">Quantity</th>
                <th scope="col">Price</th>
                <th scope="col">Weight</th>
                <th scope="col">Description</th>
                <th scope="col">Delete</th>
                <th scope="col">Update</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="product" items="${products}">
                <tr>
                    <td>${product.id}</td>
                    <td>${product.name}</td>
                    <td>${product.category.name}</td>
                    <td><img src="${product.image}" height="100px" width="100px"></td>
                    <td>${product.quantity}</td>
                    <td>${product.price}</td>
                    <td>${product.weight}</td>
                    <td>${product.description}</td>
                    <td>
                        <form action="products/delete" method="get">
                            <input type="hidden" name="id" value="${product.id}">
                            <input type="submit" value="Delete" class="btn btn-danger">
                        </form>
                    </td>
                    <td>
                        <form action="products/update/${product.id}" method="get">
                            <input type="submit" value="Update" class="btn btn-warning">
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>


<script>
    document.getElementById('toggleMode').addEventListener('click', function () {
        document.body.classList.toggle('dark-mode');
    });
</script>


<!-- <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
        integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
        integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script> -->

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

</body>
</html>
