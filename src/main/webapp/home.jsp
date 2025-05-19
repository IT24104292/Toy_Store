<%--
  Created by IntelliJ IDEA.
  User: Ishan Kanishka
  Date: 3/29/2025
  Time: 2:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession, com.toystore.models.Cart, com.toystore.models.Toy, java.util.List, com.toystore.utils.FileHandler" %>
<html>
<head>
    <title>Welcome to ToyStore</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .cart-link {
            text-decoration: none;
            color: #333;
            padding: 8px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #f8f8f8;
        }
        .cart-link:hover {
            background-color: #e8e8e8;
        }
        .welcome-message {
            color: #333;
            font-size: 24px;
        }
        .toys-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .toy-card {
            background-color: white;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .toy-name {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .toy-price {
            color: #4CAF50;
            font-size: 16px;
            margin-bottom: 10px;
        }
        .toy-quantity {
            color: #666;
            margin-bottom: 10px;
        }
        .add-to-cart {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .add-to-cart:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    Cart cart = (Cart) userSession.getAttribute("cart");
    if (cart == null && userSession.getAttribute("userId") != null) {
        // Try to load cart from file if not in session
        cart = FileHandler.loadCart((Integer) userSession.getAttribute("userId"));
        if (cart != null) {
            userSession.setAttribute("cart", cart);
        }
    }
    int cartItemCount = (cart != null) ? cart.getItems().size() : 0;
    List<Toy> toys = (List<Toy>) request.getAttribute("toys");
%>

<div class="header">
    <h1 class="welcome-message">Welcome, <%= userSession.getAttribute("username") %>!</h1>
    <div>
        <a href="profile.jsp">👤 My Profile</a>
        <a href="cart.jsp" class="cart-link">Cart (<%= cartItemCount %> items)</a>
        <a href="logout.jsp" class="cart-link">Logout</a>
    </div>
</div>

<div class="toys-container">
    <%
        if (toys != null && !toys.isEmpty()) {
            for (Toy toy : toys) {
    %>
        <div class="toy-card">
            <img src="images/<%= toy.getName().toLowerCase().replace(" ", "-") %>.jpg" 
                 alt="<%= toy.getName() %>" 
                 style="width: 100%; height: 200px; object-fit: cover; border-radius: 5px; margin-bottom: 10px;"
                 onerror="this.src='https://placehold.co/300x200?text=<%= toy.getName().replace(" ", "+") %>'">
            <div class="toy-name"><%= toy.getName() %></div>
            <div class="toy-price">$<%= String.format("%.2f", toy.getPrice()) %></div>
            <div class="toy-quantity">Available: <%= toy.getQuantity() %></div>
            <a href="cart-servlet?action=add&toyId=<%= toy.getId() %>&name=<%= toy.getName() %>&price=<%= toy.getPrice() %>&quantity=1" 
               class="add-to-cart">Add to Cart</a>
        </div>
    <%
            }
        }
        else {
    %>
        <p>No toys available at the moment.</p>
    <%
        }
    %>
</div>

</body>
</html>
