<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
import="com.jtspringproject.JtSpringProject.models.CartProduct" %> <%@ page
import="java.util.List" %>
<html>
  <head>
    <title>Your Cart</title>
  </head>
  <body>
    <h1>Your Cart</h1>
    <table border="1">
      <tr>
        <th>Product</th>
        <th>Quantity</th>
      </tr>
      <c:forEach var="item" items="${cartItems}">
        <tr>
          <td>${item.product.name}</td>
          <td>${item.quantity}</td>
        </tr>
      </c:forEach>
    </table>
  </body>
</html>
