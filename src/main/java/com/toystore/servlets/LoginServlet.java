package com.toystore.servlets;


import com.toystore.utils.FileHandler;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String role = FileHandler.getUserRole(username, password);

        if (role != null) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", role);
            session.setAttribute("userId", Math.abs(username.hashCode()));

            if (role.equals("admin")) {
                response.sendRedirect("admin.jsp");  // Redirect to admin panel
            } else {
                response.sendRedirect("home-servlet");  // Redirect to user homepage
            }
        } else {
            response.sendRedirect("error.jsp"); // Login failed
        }
    }
}


