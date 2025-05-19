package com.toystore.servlets;

import com.toystore.utils.FileHandler;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet(name = "UserManagementServlet", value = "/user-management")
public class UserManagementServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in and is an admin
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get all users
        List<Map<String, String>> users = FileHandler.getAllUsers();
        request.setAttribute("users", users);
        
        // Forward to the user management page
        request.getRequestDispatcher("usermanagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in and is an admin
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String username = request.getParameter("username");
        String role = request.getParameter("role");

        if ("delete".equals(action) && username != null && role != null) {
            boolean deleted = FileHandler.deleteUser(username, role);
            if (deleted) {
                request.setAttribute("message", "User deleted successfully");
            } else {
                request.setAttribute("error", "Failed to delete user");
            }
        }

        // Redirect back to the user management page
        response.sendRedirect("user-management");
    }
} 