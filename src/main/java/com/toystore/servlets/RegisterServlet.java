package com.toystore.servlets;


import com.toystore.utils.FileHandler;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); // Get role (user/admin)

        if (FileHandler.registerUser(username, password, role)) {
            response.sendRedirect("login.jsp");  // Redirect to login page
        } else {
            response.sendRedirect("error.jsp"); // Registration failed
        }
    }
}
