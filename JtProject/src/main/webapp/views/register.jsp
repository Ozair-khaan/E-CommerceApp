<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Sign Up - SnapKart</title>

   
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
       
        body {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            transition: 0.4s;
            font-family: 'Poppins', sans-serif;
        }

        
        .dark-mode {
            background: linear-gradient(135deg, #121212, #243b55) !important;
            color: white;
        }

        
        .register-container {
            width: 400px;
            padding: 20px;
            border-radius: 15px;
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.1);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            text-align: center;
            color: #fff;
            transition: 0.3s;
        }

        .dark-mode .register-container {
            background: rgba(0, 0, 0, 0.3);
        }

        .register-container h2 {
            font-weight: bold;
            margin-bottom: 15px;
        }

        
        .form-control {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            color: white;
            padding: 10px;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .form-control:focus {
            box-shadow: none;
            background: rgba(255, 255, 255, 0.3);
        }

       
        .btn-custom {
            background: #007bff;
            border: none;
            padding: 10px;
            font-size: 18px;
            border-radius: 30px;
            transition: 0.3s;
        }

        .btn-custom:hover {
            background: #0056b3;
            transform: scale(1.05);
        }

       
        .toggle-mode {
            position: absolute;
            top: 15px;
            right: 20px;
            cursor: pointer;
            font-size: 1.5rem;
            transition: 0.3s;
        }

        
        .password-toggle {
            cursor: pointer;
            position: absolute;
            right: 15px;
            top: 12px;
            color: white;
        }

        .dark-mode .password-toggle {
            color: #ddd;
        }

       
        .error-message {
            display: ${not empty msg ? 'block' : 'none'};
        }

       
        input, textarea, button {
            transition: 0.3s;
        }
    </style>
</head>

<body>

<i class="fa-solid fa-moon toggle-mode" id="toggleDarkMode"></i>

<div class="register-container">
    <h2>Sign Up</h2>
    <p>Join SnapKart today!</p>

    <form action="newuserregister" method="post">
        <div class="form-group position-relative">
            <input type="text" name="username" required placeholder="Username" class="form-control form-control-lg">
        </div>

        <div class="form-group position-relative">
            <input type="email" id="email" name="email" required placeholder="Email Address" class="form-control form-control-lg">
            <small class="form-text text-light">We'll never share your email.</small>
        </div>

        <div class="form-group position-relative">
            <input type="password" id="password" name="password" required placeholder="Password" class="form-control form-control-lg">
            <i class="fa fa-eye password-toggle" id="togglePassword"></i>
            <small id="passwordStrength" class="form-text"></small>
        </div>

        <div class="form-group">
            <textarea name="address" rows="3" placeholder="Enter Your Address" class="form-control form-control-lg"></textarea>
        </div>

        <p>Already have an account? <a href="/" style="color: #fff; text-decoration: underline;">Login here</a></p>

        <button type="submit" class="btn btn-custom btn-block">Register</button>
        <h5 class="text-danger mt-3 error-message">${msg}</h5>
    </form>
</div>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

<script>
   
    $(document).ready(function () {
        if (localStorage.getItem("darkMode") === "enabled") {
            $("body").addClass("dark-mode");
            $("#toggleDarkMode").addClass("fa-sun");
        }
    });

    $("#toggleDarkMode").click(function () {
        $("body").toggleClass("dark-mode");
        $(this).toggleClass("fa-sun fa-moon");
        localStorage.setItem("darkMode", $("body").hasClass("dark-mode") ? "enabled" : "disabled");
    });

   
    $("#togglePassword").click(function () {
        let passwordField = $("#password");
        let type = passwordField.attr("type") === "password" ? "text" : "password";
        passwordField.attr("type", type);
        $(this).toggleClass("fa-eye fa-eye-slash");
    });

   
    $("#password").on("input", function () {
        let strength = ["Weak", "Moderate", "Strong"];
        let value = $(this).val();
        let strengthIndex = value.length > 8 ? 2 : value.length > 5 ? 1 : 0;
        $("#passwordStrength").text("Strength: " + strength[strengthIndex]);
        $("#passwordStrength").css("color", ["red", "orange", "green"][strengthIndex]);
    });

    
    $("#email").on("input", function () {
        let email = $(this).val();
        let regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        $(this).toggleClass("is-invalid", !regex.test(email));
    });
</script>

</body>
</html>
