<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.toystore.models.Cart, com.toystore.models.Toy, java.util.List, jakarta.servlet.http.HttpSession" %>
<html>
<head>
    <title>Shopping Cart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .cart-container {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            border-bottom: 1px solid #eee;
        }
        .cart-item:last-child {
            border-bottom: none;
        }
        .item-details {
            flex-grow: 1;
        }
        .item-actions {
            margin-left: 20px;
        }
        .remove-link {
            color: #ff4444;
            text-decoration: none;
        }
        .remove-link:hover {
            text-decoration: underline;
        }
        .cart-actions {
            margin-top: 20px;
            text-align: right;
        }
        .action-button {
            padding: 8px 15px;
            margin-left: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .clear-cart {
            background-color: #ff4444;
            color: white;
        }
        .checkout {
            background-color: #4CAF50;
            color: white;
        }
        .empty-cart {
            text-align: center;
            padding: 20px;
            color: #666;
        }
        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            color: #333;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<a href="home-servlet" class="back-link">← Back to Home</a>

<div class="cart-container">
    <h2>Your Shopping Cart</h2>
    <%
        HttpSession userSession = request.getSession(false);
        Cart cart = (Cart) (userSession != null ? userSession.getAttribute("cart") : null);

        if (cart == null || cart.getItems().isEmpty()) {
    %>
    <div class="empty-cart">
        <p>Your cart is empty.</p>
        <p>Start shopping to add items to your cart!</p>
    </div>
    <%
    } else {
        double total = 0.0;
        for (Toy toy : cart.getItems()) {
            total += toy.getPrice() * toy.getQuantity();
    %>
    <div class="cart-item">
        <div class="item-details">
            <h3><%= toy.getName() %></h3>
            <p>Price: $<%= String.format("%.2f", toy.getPrice()) %></p>
            <p>Quantity: <%= toy.getQuantity() %></p>
        </div>
        <div class="item-actions">
            <a href="cart-servlet?action=remove&toyId=<%= toy.getId() %>" class="remove-link">Remove</a>
        </div>
    </div>
    <%
        }
    %>
    <div class="cart-actions">
        <p><strong>Total: $<%= String.format("%.2f", total) %></strong></p>
        <a href="cart-servlet?action=clear" class="action-button clear-cart">Clear Cart</a>
        <a href="order-servlet" class="action-button checkout">Proceed to Checkout</a>
    </div>
    <%
        }
    %>
</div>
</body>
</html>
