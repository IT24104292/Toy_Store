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
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <title>Toy Store</title>
</head>
<body>
<h1>Toy Store Inventory</h1>

<!-- Display all toys -->
<table border="1">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Actions</th>
    </tr>
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
                <button type="submit">Delete</button>
            </form>
            <button onclick="editToy('<%= toy.getId() %>', '<%= toy.getName() %>', '<%= toy.getPrice() %>', '<%= toy.getQuantity() %>')">Edit</button>
        </td>
    </tr>
    <%
            }
        }
    %>
</table>

<h2>Add a New Toy</h2>
<form action="toy-servlet" method="post">
    <input type="hidden" name="action" value="add">
    <label>ID:</label> <input type="number" name="id" required><br>
    <label>Name:</label> <input type="text" name="name" required><br>
    <label>Price:</label> <input type="number" step="0.01" name="price" required><br>
    <label>Quantity:</label> <input type="number" name="quantity" required><br>
    <button type="submit">Add Toy</button>
</form>

<h2>Edit Toy</h2>
<form action="toy-servlet" method="post">
    <input type="hidden" name="action" value="update">
    <label>ID:</label> <input type="number" name="id" id="editId" readonly><br>
    <label>Name:</label> <input type="text" name="name" id="editName" required><br>
    <label>Price:</label> <input type="number" step="0.01" name="price" id="editPrice" required><br>
    <label>Quantity:</label> <input type="number" name="quantity" id="editQuantity" required><br>
    <button type="submit">Update Toy</button>
</form>

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
