<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="ISO-8859-1" />
    <title>403 - Forbidden</title>
    <style>
      body {
        font-family: "Poppins", sans-serif;
        background: linear-gradient(135deg, #2c3e50, #34495e);
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        text-align: center;
        color: white;
        transition: 0.4s;
      }

      .container {
        max-width: 600px;
        padding: 30px;
        border-radius: 15px;
        backdrop-filter: blur(10px);
        background: rgba(255, 255, 255, 0.1);
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
        transition: 0.3s;
      }

      h1 {
        font-size: 3em;
        color: #ff9900;
        animation: fadeInDown 1s ease-in-out;
      }

      p {
        font-size: 1.5em;
        color: rgba(255, 255, 255, 0.8);
        animation: fadeIn 1.5s ease-in-out;
      }

      .button {
        display: inline-block;
        margin-top: 20px;
        padding: 12px 25px;
        font-size: 1.2em;
        font-weight: bold;
        background: #ff7700;
        color: white;
        text-decoration: none;
        border-radius: 30px;
        transition: all 0.3s ease-in-out;
        animation: fadeInUp 1s ease-in-out;
      }

      .button:hover {
        background: #ff9900;
        transform: scale(1.05);
      }

      @keyframes fadeInDown {
        from {
          opacity: 0;
          transform: translateY(-20px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }

      @keyframes fadeIn {
        from {
          opacity: 0;
        }
        to {
          opacity: 1;
        }
      }

      @keyframes fadeInUp {
        from {
          opacity: 0;
          transform: translateY(20px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h1>403 - Forbidden</h1>
      <p>Sorry, you do not have permission to access this page.</p>
      <a href="/login" class="button">Go to User Login</a>
    </div>
  </body>
</html>
