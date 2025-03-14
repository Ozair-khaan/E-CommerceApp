<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Login - SnapKart</title>

    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
    />

    <style>
      body {
        background: linear-gradient(135deg, #2c3e50, #34495e);
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        font-family: "Poppins", sans-serif;
        transition: 0.4s;
        color: #ffffff;
      }

      .dark-mode {
        background: linear-gradient(135deg, #121212, #1e1e1e) !important;
        color: white;
      }

      .login-container {
        width: 400px;
        padding: 25px;
        border-radius: 15px;
        backdrop-filter: blur(10px);
        background: rgba(44, 62, 80, 0.8);
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
        text-align: center;
        color: #fff;
        transition: 0.3s;
      }

      .dark-mode .login-container {
        background: rgba(30, 30, 30, 0.8);
      }

      .login-container h2 {
        font-weight: bold;
        margin-bottom: 15px;
      }

      .form-control {
        background: rgba(255, 255, 255, 0.2);
        border: none;
        color: white;
        padding: 12px;
      }

      .form-control::placeholder {
        color: rgba(255, 255, 255, 0.7);
      }

      .form-control:focus {
        box-shadow: none;
        background: rgba(255, 255, 255, 0.3);
      }

      .input-group-text {
        background-color: #ff9900;
        color: white;
        border: none;
      }

      .dark-mode .input-group-text {
        background-color: #ff7700;
      }

      .btn-custom {
        background: #ff9900;
        border: none;
        padding: 10px;
        font-size: 18px;
        border-radius: 30px;
        transition: 0.3s;
      }

      .btn-custom:hover {
        background: #ff7700;
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
      .btn-redirect {
        background-color: ff7700; /* Orange-red background */
        border: 1px solid #ff7700;
        color: #fff;
        font-weight: bold;
        text-transform: uppercase;
        padding: 10px 20px;
        border-radius: 4px;
        transition: background-color 0.3s ease;
      }

      .btn-redirect:hover {
        background-color: #c57c3c; /* Darker shade on hover */
        border-color: #c57c3c;
        color: #fff;
      }
    </style>
  </head>

  <body>
    <i class="fa-solid fa-moon toggle-mode" id="toggleDarkMode"></i>

    <div class="login-container">
      <h2>Login</h2>
      <p>Welcome back to SnapKart</p>

      <form action="/userloginvalidate" method="post">
        <div class="form-group">
          <label for="username">Username</label>
          <div class="input-group">
            <div class="input-group-prepend">
              <span class="input-group-text"><i class="fas fa-user"></i></span>
            </div>
            <input
              type="text"
              name="username"
              id="username"
              required
              placeholder="Enter Username"
              class="form-control form-control-lg"
            />
          </div>
        </div>

        <div class="form-group position-relative">
          <label for="password">Password</label>
          <div class="input-group">
            <div class="input-group-prepend">
              <span class="input-group-text"><i class="fas fa-lock"></i></span>
            </div>
            <input
              type="password"
              name="password"
              id="password"
              required
              placeholder="Enter Password"
              class="form-control form-control-lg"
            />
            <i class="fa fa-eye password-toggle" id="togglePassword"></i>
          </div>
        </div>

        <p>
          Don't have an account?
          <a href="/register" style="color: #fff; text-decoration: underline"
            >Register here</a
          >
        </p>

        <button type="submit" class="btn btn-custom btn-block">Login</button>
        <button
          type="button"
          class="btn btn-redirect btn-block"
          onclick="window.location.href='/admin/login';"
        >
          &#9881; Go to Admin Login
        </button>
      </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
        localStorage.setItem(
          "darkMode",
          $("body").hasClass("dark-mode") ? "enabled" : "disabled"
        );
      });

      $("#togglePassword").click(function () {
        let passwordField = $("#password");
        let type =
          passwordField.attr("type") === "password" ? "text" : "password";
        passwordField.attr("type", type);
        $(this).toggleClass("fa-eye fa-eye-slash");
      });
    </script>
  </body>
</html>
