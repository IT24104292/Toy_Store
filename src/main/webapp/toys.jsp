<%--
  Created by IntelliJ IDEA.
  User: Ishan Kanishka
  Date: 3/22/2025
  Time: 3:56 PM
  To change this template use File | Settings | File Templates.
--%>

<%--            ################# 1st CODE CODE CODE CODE##################
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Toys</title>
</head>
<body>

</body>
</html>
--%>

                  <%--    ######### 2nd CODE#####        --%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.util.List, com.toystore.models.Toy" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<!DOCTYPE html>
<html>
<head>
    <title>Toy Store</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
            color: #333;
        }

        .container {
            max-width: 1200px;
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

        .toys-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .toys-table th,
        .toys-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        .toys-table th {
            background-color: #f8f9fa;
            color: #2c3e50;
            font-weight: 600;
        }

        .toys-table tr:hover {
            background-color: #f8f9fa;
        }

        .form-container {
            margin-top: 30px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
        }

        .form-container h2 {
            color: #2c3e50;
            margin-top: 0;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #2c3e50;
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .btn {
            padding: 8px 16px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #2980b9;
        }

        .btn-danger {
            background-color: #e74c3c;
        }

        .btn-danger:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>Toy Store Inventory</h1>
        <div class="nav-links">
            <a href="admin.jsp" class="nav-link">Admin Dashboard</a>
            <% 
                if (session != null && "admin".equals(session.getAttribute("role"))) {
            %>
                <a href="user-management" class="nav-link">User Management</a>
            <% } %>
            <a href="logout.jsp" class="nav-link">Logout</a>
        </div>
    </div>

    <!-- Display all toys -->
    <table class="toys-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<Toy> toys = (List<Toy>) request.getAttribute("toys");
                if (toys != null) {
                    for (Toy toy : toys) {
            %>
                <tr>
                    <td><%= toy.getId() %></td>
                    <td><%= toy.getName() %></td>
                    <td>$<%= toy.getPrice() %></td>
                    <td><%= toy.getQuantity() %></td>
                    <td>
                        <form action="toy-servlet" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= toy.getId() %>">
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form>
                        <button onclick="editToy('<%= toy.getId() %>', '<%= toy.getName() %>', '<%= toy.getPrice() %>', '<%= toy.getQuantity() %>')" 
                                class="btn">Edit</button>
                    </td>
                </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>

    <div class="form-container">
        <h2>Add a New Toy</h2>
        <form action="toy-servlet" method="post">
            <input type="hidden" name="action" value="add">
            <div class="form-group">
                <label>ID:</label>
                <input type="number" name="id" required>
            </div>
            <div class="form-group">
                <label>Name:</label>
                <input type="text" name="name" required>
            </div>
            <div class="form-group">
                <label>Price:</label>
                <input type="number" step="0.01" name="price" required>
            </div>
            <div class="form-group">
                <label>Quantity:</label>
                <input type="number" name="quantity" required>
            </div>
            <button type="submit" class="btn">Add Toy</button>
        </form>
    </div>

    <div class="form-container">
        <h2>Edit Toy</h2>
        <form action="toy-servlet" method="post">
            <input type="hidden" name="action" value="update">
            <div class="form-group">
                <label>ID:</label>
                <input type="number" name="id" id="editId" readonly>
            </div>
            <div class="form-group">
                <label>Name:</label>
                <input type="text" name="name" id="editName" required>
            </div>
            <div class="form-group">
                <label>Price:</label>
                <input type="number" step="0.01" name="price" id="editPrice" required>
            </div>
            <div class="form-group">
                <label>Quantity:</label>
                <input type="number" name="quantity" id="editQuantity" required>
            </div>
            <button type="submit" class="btn">Update Toy</button>
        </form>
    </div>
</div>

<script>
    function editToy(id, name, price, quantity) {
        document.getElementById("editId").value = id;
        document.getElementById("editName").value = name;
        document.getElementById("editPrice").value = price;
        document.getElementById("editQuantity").value = quantity;
    }
</script>
</body>
</html>
