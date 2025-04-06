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
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
    />
    <title>User Profile</title>
    <style>
      body {
        background: linear-gradient(135deg, #2c3e50, #34495e);
        color: #ffffff;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        font-family: "Poppins", sans-serif;
        transition: 0.4s;
      }
      .dark-mode {
        background: linear-gradient(135deg, #121212, #1e272e) !important;
        color: white;
      }
      .container {
        max-width: 500px;
        background: rgba(255, 255, 255, 0.1);
        padding: 20px;
        border-radius: 15px;
        backdrop-filter: blur(10px);
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.5);
      }
      .dark-mode .container {
        background: rgba(0, 0, 0, 0.3);
      }
      .btn-primary {
        background-color: #ff7700;
        border: none;
        padding: 10px;
        font-size: 18px;
        border-radius: 30px;
        transition: 0.3s;
      }
      .btn-primary:hover {
        background-color: #ff9900;
        transform: scale(1.05);
      }
      input,
      textarea {
        background: rgba(255, 255, 255, 0.2);
        color: #fff;
        border: none;
        padding: 12px;
      }
      input::placeholder,
      textarea::placeholder {
        color: rgba(255, 255, 255, 0.7);
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
      .toggle-mode {
        position: absolute;
        top: 15px;
        right: 20px;
        cursor: pointer;
        font-size: 1.5rem;
        transition: 0.3s;
      }
    </style>
  </head>
  <body>
    <button href="logout" value="Logout"></button>

    <i class="fa-solid fa-moon toggle-mode" id="toggleDarkMode"></i>
    <div class="container">
      <h3 class="text-center">User Profile</h3>
      <form action="updateuser" method="post">
        <div class="form-group">
          <label for="firstName">User Name</label>
          <input type="hidden" name="userid" value="${userid}" />
          <input
            type="text"
            name="username"
            id="firstName"
            required
            placeholder="Your Username*"
            value="${username}"
            class="form-control"
          />
        </div>
        <div class="form-group">
          <label for="email">Email address</label>
          <input
            type="email"
            class="form-control"
            required
            minlength="6"
            placeholder="Email*"
            value="${email}"
            name="email"
            id="email"
          />
          <small class="form-text text-muted"
            >We'll never share your email with anyone else.</small
          >
        </div>
        <div class="form-group position-relative">
          <label for="password">Password</label>
          <input
            type="password"
            class="form-control"
            required
            placeholder="Password*"
            value="${password}"
            name="password"
            id="password"
          />
          <i class="fa fa-eye password-toggle" id="togglePassword"></i>
        </div>
        <div class="form-group">
          <label for="address">Address</label>
          <textarea
            class="form-control"
            rows="3"
            placeholder="Enter Your Address"
            name="address"
          >
${address}</textarea
          >
        </div>
        <input
          type="submit"
          value="Update Profile"
          class="btn btn-primary btn-block"
        />
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
