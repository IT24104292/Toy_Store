<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<marquee>
    <h1>
    <%= "Hello World!" %>
   </h1>
</marquee>

<br/>
<a href="hello-servlet">Hello Servlet</a>
<br/>
<a href="toy-servlet">Go to the toy-servlet</a>
<br/>
<a href="order-servlet">OrderServlet</a>
<br/>
<a href="user-servlet">UserServlet</a>
<br/>
<a href="cart-servlet">CartServlet</a>
<br/>

<%-- link to the toys.jsp --%>

<a href="toy-servlet">View Toys</a>


</body>
</html>