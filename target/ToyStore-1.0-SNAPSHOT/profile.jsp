<%--
  Created by IntelliJ IDEA.
  User: Ishan Kanishka
  Date: 5/1/2025
  Time: 1:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    Integer userId = (Integer) session.getAttribute("userId");

    if (username == null || role == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>My Profile</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            color: #333;
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }

        .welcome-message {
            color: #2c3e50;
            font-size: 28px;
            margin-bottom: 10px;
        }

        .role-badge {
            display: inline-block;
            padding: 5px 15px;
            background-color: #3498db;
            color: white;
            border-radius: 20px;
            font-size: 14px;
            margin-top: 10px;
        }

        .section {
            margin-bottom: 30px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
        }

        .section h3 {
            color: #2c3e50;
            margin-top: 0;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }

        .form-group input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .btn-update {
            background-color: #2ecc71;
            color: white;
        }

        .btn-update:hover {
            background-color: #27ae60;
        }

        .btn-delete {
            background-color: #e74c3c;
            color: white;
        }

        .btn-delete:hover {
            background-color: #c0392b;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
            text-align: center;
        }

        .success-message {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1 class="welcome-message">Welcome, <%= username %>!</h1>
        <div style="margin: 10px 0;">
            <span class="role-badge"><%= role %></span>
            <span class="role-badge" style="background-color: #2c3e50; margin-left: 10px;">User ID: <%= userId %></span>
        </div>
    </div>

    <% if (request.getAttribute("message") != null) { %>
        <div class="message <%= request.getAttribute("success") != null ? "success-message" : "error-message" %>">
            <%= request.getAttribute("message") %>
        </div>
    <% } %>

    <div class="section">
        <h3>Update Password</h3>
        <form action="profile-servlet" method="get">
            <div class="form-group">
                <label for="password">New Password:</label>
                <input type="password" id="password" name="password" required />
            </div>
            <input type="submit" name="action" value="Update" class="btn btn-update" />
        </form>
    </div>

    <div class="section">
        <h3>Delete Account</h3>
        <form action="profile-servlet" method="get" onsubmit="return confirm('Are you sure you want to delete your account? This action cannot be undone.');">
            <input type="submit" name="action" value="Delete" class="btn btn-delete" />
        </form>
    </div>

    <a href="home-servlet" class="back-link"> Back to Home</a>
</div>
</body>
</html>
