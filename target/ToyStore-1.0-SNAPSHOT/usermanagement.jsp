<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Map" %>
<html>
<head>
    <title>User Management - ToyStore</title>
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

        .back-link {
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

        .users-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .users-table th,
        .users-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        .users-table th {
            background-color: #f8f9fa;
            color: #2c3e50;
            font-weight: 600;
        }

        .users-table tr:hover {
            background-color: #f8f9fa;
        }

        .role-badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }

        .role-user {
            background-color: #e3f2fd;
            color: #1976d2;
        }

        .role-admin {
            background-color: #fff3e0;
            color: #f57c00;
        }

        .delete-btn {
            padding: 6px 12px;
            background-color: #e74c3c;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .delete-btn:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>User Management</h1>
        <a href="admin.jsp" class="back-link">← Back to the Dashboard</a>
    </div>

    <% if (request.getAttribute("message") != null) { %>
        <div class="message success-message">
            <%= request.getAttribute("message") %>
        </div>
    <% } %>

    <% if (request.getAttribute("error") != null) { %>
        <div class="message error-message">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <table class="users-table">
        <thead>
            <tr>
                <th>Username</th>
                <th>Role</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<Map<String, String>> users = (List<Map<String, String>>) request.getAttribute("users");
                if (users != null && !users.isEmpty()) {
                    for (Map<String, String> user : users) {
            %>
                <tr>
                    <td><%= user.get("username") %></td>
                    <td>
                        <span class="role-badge role-<%= user.get("role") %>">
                            <%= user.get("role") %>
                        </span>
                    </td>
                    <td>
                        <form action="user-management" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="username" value="<%= user.get("username") %>">
                            <input type="hidden" name="role" value="<%= user.get("role") %>">
                            <button type="submit" class="delete-btn" 
                                    onclick="return confirm('Are you sure you want to delete this user?')">
                                Delete
                            </button>
                        </form>
                    </td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="3" style="text-align: center;">No users found</td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>
</body>
</html> 