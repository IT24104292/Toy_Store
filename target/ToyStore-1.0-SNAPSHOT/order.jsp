<%--
  Created by IntelliJ IDEA.
  User: Ishan Kanishka
  Date: 3/29/2025
  Time: 7:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.toystore.models.Order, com.toystore.models.Toy" %>
<html>
<head>
    <title>Order Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .order-container {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            max-width: 800px;
            margin: 0 auto;
        }
        .order-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .order-details {
            margin-bottom: 20px;
        }
        .order-item {
            display: flex;
            justify-content: space-between;
            padding: 10px;
            border-bottom: 1px solid #eee;
        }
        .order-item:last-child {
            border-bottom: none;
        }
        .item-details {
            flex-grow: 1;
        }
        .item-price {
            text-align: right;
        }
        .order-total {
            text-align: right;
            font-size: 18px;
            font-weight: bold;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 2px solid #eee;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #333;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
        .status-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 14px;
            font-weight: bold;
        }
        .status-pending {
            background-color: #ffd700;
            color: #000;
        }
    </style>
</head>
<body>
<div class="order-container">
    <div class="order-header">
        <h1>Order Confirmation</h1>
        <p>Thank you for your purchase!</p>
    </div>

    <%
        Order order = (Order) session.getAttribute("order");
        if (order == null) {
    %>
        <div class="order-details">
            <p>No order found. Please try again.</p>
        </div>
    <%
        } else {
    %>
        <div class="order-details">
            <p><strong>Order ID:</strong> #<%= order.getOrderId() %></p>
            <p><strong>Status:</strong> <span class="status-badge status-pending"><%= order.getStatus() %></span></p>
            
            <h3>Order Items:</h3>
            <%
                for (Toy toy : order.getToys()) {
            %>
                <div class="order-item">
                    <div class="item-details">
                        <h4><%= toy.getName() %></h4>
                        <p>Quantity: <%= toy.getQuantity() %></p>
                    </div>
                    <div class="item-price">
                        $<%= String.format("%.2f", toy.getPrice() * toy.getQuantity()) %>
                    </div>
                </div>
            <%
                }
            %>
            
            <div class="order-total">
                Total: $<%= String.format("%.2f", order.getTotalPrice()) %>
            </div>
        </div>
    <%
        }
    %>
    
    <a href="home-servlet" class="back-link">← Back to Home</a>
</div>
</body>
</html>
