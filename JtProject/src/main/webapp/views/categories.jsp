<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categories | SnapKart</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
            transition: background 0.3s, color 0.3s;
        }
        .dark-mode {
            background-color: #121212;
            color: #ffffff;
        }
        .dark-mode .card, .dark-mode .modal-content, .dark-mode .table {
            background-color: #1e1e1e;
            color: #ffffff;
            border-color: #333;
        }
        .dark-mode .btn-primary {
            background-color: #ff9900;
            border-color: #ff9900;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">SnapKart</a>
            <button class="btn btn-outline-light" id="darkModeToggle">Dark Mode</button>
        </div>
    </nav>
    
    <div class="container mt-4">
        <h2 class="text-center">Manage Categories</h2>
        <button class="btn btn-primary my-3" data-bs-toggle="modal" data-bs-target="#addCategoryModal">Add Category</button>
        
        <table class="table table-hover">
            <thead class="table-dark">
                <tr>
                    <th>SN</th>
                    <th>Category Name</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="category" items="${categories}">
                    <tr>
                        <td>${category.id}</td>
                        <td>${category.name}</td>
                        <td>
                            <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#updateCategoryModal"
                                onclick="document.getElementById('updateCategoryName').value = '${category.name}';
                                         document.getElementById('updateCategoryId').value = '${category.id}';">Update</button>
                            <form action="categories/delete" method="get" class="d-inline">
                                <input type="hidden" name="id" value="${category.id}">
                                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Add Category Modal -->
    <div class="modal fade" id="addCategoryModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add Category</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="categories" method="post">
                    <div class="modal-body">
                        <input type="text" name="categoryname" class="form-control" required placeholder="Category Name">
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Update Category Modal -->
    <div class="modal fade" id="updateCategoryModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Update Category</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="categories/update" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="categoryid" id="updateCategoryId">
                        <input type="text" name="categoryname" id="updateCategoryName" class="form-control" required>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Update</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        document.getElementById("darkModeToggle").addEventListener("click", function() {
            document.body.classList.toggle("dark-mode");
        });
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
