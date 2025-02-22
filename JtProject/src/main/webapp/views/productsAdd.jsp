<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <title>SnapKart</title>
    <style>
        
        body {
            background-color: #1c1c1c; /* Dark background */
            color: #ffffff;
            font-family: 'Poppins', sans-serif;
            transition: 0.4s;
        }

        
        .navbar {
            background-color: #2a2a2a; /* Dark Gray Navbar */
        }

        .navbar-brand {
            color: #ffc107 !important;
            font-weight: bold;
        }

        .nav-link {
            color: #ffffff !important;
        }

        .nav-link:hover {
            color: #ffc107 !important;
        }

       
        .container {
            max-width: 900px;
            background: #2a2a2a; /* Dark gray card */
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0px 4px 10px rgba(255, 255, 255, 0.1);
        }

        
        .form-control {
            border-radius: 8px;
            background-color: #3b3b3b;
            color: white;
            border: 1px solid #555;
        }

        .form-control::placeholder {
            color: #aaa;
        }

       
        .btn-primary {
            background-color: #ffc107; /* SnapKart Yellow */
            color: #000000;
            border: none;
            padding: 12px;
            font-size: 18px;
            border-radius: 8px;
            transition: 0.3s;
        }

        .btn-primary:hover {
            background-color: #ffdb58;
        }

        
        .card {
            background: #333; 
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0px 4px 8px rgba(255, 255, 255, 0.1);
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">SnapKart</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" th:href="@{/cart}">Cart</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" th:href="@{/profileDisplay}">Profile</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" sec:authorize="isAuthenticated()" th:href="@{/logout}">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h3 class="text-center">Add a New Product</h3>
    <div class="card">
        <form action="/admin/products/add" method="post">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="name">Product Name</label>
                        <input type="text" class="form-control" name="name" required placeholder="Enter product name">
                    </div>
                    <div class="form-group">
                        <label for="category">Select Category</label>
                        <select class="form-control" name="categoryid" required>
                            <option selected>Select a Category</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="price">Price</label>
                        <input type="number" class="form-control" name="price" required min="1" placeholder="Enter price">
                    </div>
                    <div class="form-group">
                        <label for="quantity">Available Quantity</label>
                        <input type="number" class="form-control" name="quantity" required min="1" placeholder="Enter quantity">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="description">Product Description</label>
                        <textarea class="form-control" name="description" rows="4" placeholder="Enter product details"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="image">Product Image URL</label>
                        <input type="text" class="form-control" name="productImage" required placeholder="Enter image URL">
                    </div>
                    <div class="form-group text-center">
                        <img src="" id="imgPreview" height="100px" width="100px" style="margin-top: 10px; border-radius: 10px; display: none;" />
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Add Product</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    document.querySelector("input[name='productImage']").addEventListener("input", function() {
        let imgPreview = document.getElementById("imgPreview");
        imgPreview.src = this.value;
        imgPreview.style.display = this.value ? "block" : "none";
    });
</script>
</body>
</html>
