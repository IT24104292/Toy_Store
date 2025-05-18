<%--
  Created by IntelliJ IDEA.
  User: Ishan Kanishka
  Date: 3/29/2025
  Time: 6:45 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Error</title>
</head>
<body>
<h2 style="color: red;">An error occurred!</h2>

<% if (request.getParameter("error") != null) { %>
<p style="color: red;">Invalid username or password.</p>
<% } else if (request.getParameter("registerError") != null) { %>
<p style="color: red;">Registration failed. Username already exists.</p>
<% } else { %>
<p style="color: red;">Something went wrong. Please try again.</p>
<% } %>

<a href="login.jsp">Go Back to Login</a>
</body>
</html>
