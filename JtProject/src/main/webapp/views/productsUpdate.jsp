<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<%@page import="java.sql.*"%>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
	crossorigin="anonymous">
<title>SnapKart - Update Product</title>

<style>
    /* body { background-color: #121212; color: white; }
    .navbar { background-color: #1f1f1f !important; }
    .snapkart-logo { font-weight: bold; background: linear-gradient(45deg, #FFA500, #FFD700); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
    .btn-primary { background-color: #ff9900 !important; border-color: #ff9900; }
    .border-success { border-color: #ff9900 !important; }
    .custom-file-label { background-color: #1e1e1e; color: white; border: 1px solid #ff9900; }
    .dark-mode table { background-color: #222 !important; color: #fff !important; }
	 */
	body { 
    background-color: #121212; 
    color: white; 
}

.navbar { 
    background-color: #1f1f1f !important; 
}

.snapkart-logo { 
    font-weight: bold; 
    background: linear-gradient(45deg, #FFA500, #FFD700); 
    -webkit-background-clip: text; 
    -webkit-text-fill-color: transparent; 
}

.btn-primary { 
    background-color: #ff9900 !important; 
    border-color: #ff9900;
    font-weight: bold;
    padding: 10px 20px;
    border-radius: 8px;
}

.border-success { 
    border-color: #ff9900 !important; 
}

.custom-file-label { 
    background-color: #1e1e1e; 
    color: white; 
    border: 1px solid #ff9900; 
    padding: 10px;
}

.custom-file-input {
    cursor: pointer;
}

.custom-file-input:focus ~ .custom-file-label {
    border-color: #ff9900;
}

.dark-mode table { 
    background-color: #222 !important; 
    color: #fff !important; 
}

.jumbotron {
    padding: 30px;
    border-radius: 10px;
    background: rgba(255, 255, 255, 0.1);
}

.form-group label {
    font-weight: bold;
}

.form-control {
    background: #1e1e1e;
    color: white;
    border: 1px solid #ff9900;
    padding: 8px;
    border-radius: 6px;
}

select.form-control {
    appearance: none;
    background-image: url('data:image/svg+xml;charset=US-ASCII,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 4 5"><path fill="%23ff9900" d="M2 0L0 2h4zM2 5l2-2H0z"/></svg>');
    background-repeat: no-repeat;
    background-position: right .75rem center;
    background-size: 8px 10px;
    padding-right: 2rem;
}

#imgPreview {
    display: block;
    margin: 20px auto;
    border-radius: 10px;
    box-shadow: 0px 0px 10px #ff9900;
}
input, select, textarea {
    color: white !important;
}

input::placeholder, select {
    color: #aaa !important;
}

input:focus, select:focus, textarea:focus {
    color: white !important;
    border-color: #ff9900 !important;
}
input, select, textarea {
    background-color: #1e1e1e !important;
    border: 1px solid #ff9900;
    padding: 8px;
    border-radius: 6px;
}
select {
    background-color: #1e1e1e !important;
    color: white !important;
}

</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<a class="navbar-brand snapkart-brand" href="/admin/"> 
                <i class="fas fa-shopping-cart"></i> 
                <span class="snapkart-logo">SnapKart</span>
            </a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link" href="/admin/">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="/admin/logout">Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<br>
	<div class="jumbotron container border border-info">
		<h3>Update Existing Product</h3>
		<form action="/admin/products/update/${product.id}" method="post">
			<div class="row">
				<div class="col-sm-5">
					<div class="form-group">
						<label for="name">Id</label> 
						<input type="number" readonly="readonly" class="form-control border border-success" name="id"  value="${product.id}">
					</div>
					<div class="form-group">
						<label for="name">Name</label> 
						<input type="text" class="form-control border border-success" required name="name" value="${product.name }" placeholder="Enter name">
					</div>
					<div class="form-group">
						<label for="category">Select Category</label> 
						<select class="form-control border border-success" name="categoryid" readonly>
							<option selected>Select a Category</option>
							<c:forEach var="category" items="${categories}">
								<option value="${category.id}">${category.name}</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-group">
						<label for="price">Price</label> 
						<input type="number" class="form-control border border-success" required name="price" value="${ product.price }" min="1" placeholder="Price">
					</div>
					<div class="form-group">
						<label for="weight">Weight in grams</label> 
						<input type="number" class="form-control border border-success" required name="weight" value="${product.weight }" min="1" placeholder="Weight">
					</div>
				</div>
				<div class="col-sm-5">
					<div class="form-group">
						<label for="description">Product Description</label>
						<textarea class="form-control border border-success" rows="4" name="description" placeholder="Product Details">${ product.description }</textarea>
					</div>
					<p>Product Image</p>
					<div class="custom-file">
						<input type="file" class="custom-file-input" name="productImage" accept="image/jpeg, image/png" id="productImage"  onchange="loadfile(event)"/>
						<label class="custom-file-label" for="productImage">Choose file</label>
					</div>
					<div class="form-group">
						<img src="${product.image}" id="imgPreview" height="100px" width="100px" style="margin-top: 20px" alt="Product Image">
					</div>
					<input type="submit" value="Update Details" class="btn btn-primary">
				</div>
			</div>
		</form>
	</div>
</body>
<script>
	document.querySelector(".custom-file-input").addEventListener("change", function(e) {
    let fileName = e.target.files[0] ? e.target.files[0].name : "Choose file";
    document.querySelector(".custom-file-label").textContent = fileName;
});

function loadfile(event) {
    let output = document.getElementById('imgPreview');
    output.src = URL.createObjectURL(event.target.files[0]);
    output.onload = function() {
        URL.revokeObjectURL(output.src);
    }
}

</script>
</html>
