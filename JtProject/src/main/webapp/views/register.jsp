<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Sign Up - SnapKart</title>

    <!-- Bootstrap and Font Awesome -->
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
    />

    <style>
      /* Light Mode Styles */
      body {
        background: linear-gradient(135deg, #2c3e50, #34495e);
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        transition: 0.4s;
        font-family: 'Poppins', sans-serif;
        color: #fff;
      }

      .register-container {
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

      .register-container h2 {
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
        background: rgba(255, 255, 255, 0.6);
        border: 1px solid rgba(255, 255, 255, 0.8);
      }

      .btn-custom {
        background: #ff9900;
        border: none;
        padding: 10px;
        font-size: 18px;
        border-radius: 30px;
        transition: 0.3s;
        width: 100%;
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
        color: #fff;
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

      /* Dark Mode Overrides */
      .dark-mode {
        background: linear-gradient(135deg, #121212, #1e1e1e) !important;
        color: white;
      }

      .dark-mode .register-container {
        background: rgba(30, 30, 30, 0.8);
      }
    </style>
  </head>

  <body>
    <!-- Dark Mode Toggle Icon -->
    <i class="fa-solid fa-moon toggle-mode" id="toggleDarkMode"></i>

    <div class="register-container">
      <h2>Sign Up</h2>
      <p>Join SnapKart today!</p>

      <form action="newUserRegister" method="post">
        <div class="form-group">
          <input
            type="text"
            name="username"
            required
            placeholder="Username"
            class="form-control form-control-lg"
          />
        </div>

        <div class="form-group">
          <input
            type="email"
            id="email"
            name="email"
            required
            placeholder="Email Address"
            class="form-control form-control-lg"
          />
          <small class="form-text text-light">
            We'll never share your email.
          </small>
        </div>

        <div class="form-group position-relative">
          <input
            type="password"
            id="password"
            name="password"
            required
            placeholder="Password"
            class="form-control form-control-lg"
          />
          <i class="fa fa-eye password-toggle" id="togglePassword"></i>
          <small id="passwordStrength" class="form-text"></small>
        </div>

        <div class="form-group">
          <textarea
            name="address"
            rows="3"
            placeholder="Enter Your Address"
            class="form-control form-control-lg"
          ></textarea>
        </div>

        <p>
          Already have an account?
          <a href="/login" style="color: #fff; text-decoration: underline;">
            Login here</a
          >
        </p>

        <button type="submit" class="btn btn-custom">
          Register
        </button>
        <h5 class="text-danger mt-3 error-message">${msg}</h5>
      </form>
    </div>

    <!-- jQuery & Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script
      src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
    ></script>
    <script
      src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
    ></script>

    <script>
      // On page load, set dark mode if previously enabled
      $(document).ready(function () {
        if (localStorage.getItem("darkMode") === "enabled") {
          $("body").addClass("dark-mode");
          $("#toggleDarkMode").removeClass("fa-moon").addClass("fa-sun");
        }
      });

      // Toggle Dark Mode
      $("#toggleDarkMode").click(function () {
        $("body").toggleClass("dark-mode");
        $(this).toggleClass("fa-sun fa-moon");
        localStorage.setItem(
          "darkMode",
          $("body").hasClass("dark-mode") ? "enabled" : "disabled"
        );
      });

      // Toggle Password Visibility
      $("#togglePassword").click(function () {
        let passwordField = $("#password");
        let type =
          passwordField.attr("type") === "password" ? "text" : "password";
        passwordField.attr("type", type);
        $(this).toggleClass("fa-eye fa-eye-slash");
      });

      // Password Strength Indicator
      $("#password").on("input", function () {
        let strength = ["Weak", "Moderate", "Strong"];
        let value = $(this).val();
        let strengthIndex = value.length > 8
          ? 2
          : value.length > 5
            ? 1
            : 0;
        $("#passwordStrength").text("Strength: " + strength[strengthIndex]);
        $("#passwordStrength").css("color", ["red", "orange", "green"][strengthIndex]);
      });

      // Email Validation
      $("#email").on("input", function () {
        let email = $(this).val();
        let regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        $(this).toggleClass("is-invalid", !regex.test(email));
      });
    </script>
  </body>
</html>
