<%--
  Created by IntelliJ IDEA.
  User: Ishan Kanishka
  Date: 3/22/2025
  Time: 3:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Dashboard - ToyStore</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
            color: #333;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }

        .header h1 {
            color: #2c3e50;
            margin: 0;
        }

        .nav-links {
            display: flex;
            gap: 20px;
        }

        .nav-link {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .nav-link:hover {
            background-color: #f0f0f0;
            text-decoration: none;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }

        .dashboard-card {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .dashboard-card h2 {
            color: #2c3e50;
            margin-top: 0;
            margin-bottom: 15px;
        }

        .dashboard-card p {
            color: #666;
            margin-bottom: 20px;
        }

        .action-btn {
            display: inline-block;
            padding: 8px 16px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .action-btn:hover {
            background-color: #2980b9;
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>Admin Dashboard</h1>
        <div class="nav-links">

            <a href="user-management" class="nav-link">User Management</a>
            <a href="toy-servlet" class="nav-link">Toy Management</a>
            <a href="logout.jsp" class="nav-link">Logout</a>
        </div>
    </div>

    <div class="dashboard-grid">
        <div class="dashboard-card">
            <h2>User Management</h2>
            <p>View and manage all users in the system, including regular users and administrators.</p>
            <a href="user-management" class="action-btn">Manage Users</a>
        </div>

        <div class="dashboard-card">
            <h2>Toy Management</h2>
            <p>Add, edit, or remove toys from the store's inventory.</p>
            <a href="toy-servlet" class="action-btn">Manage Toys</a>
        </div>
    </div>
</div>
</body>
</html>
