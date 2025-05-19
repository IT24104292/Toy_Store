package com.toystore.servlets;

import com.toystore.utils.FileHandler;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.*;
//@WebServlet(name = "ToyServlet", value ="/toy-servlet")
@WebServlet(name ="ProfileServlet", value="/profile-servlet")
public class ProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        String action = request.getParameter("action");

        if ("Update".equals(action)) {
            String newPassword = request.getParameter("password");

            boolean updated = FileHandler.updateUser(username, newPassword, role);
            if (updated) {
                request.setAttribute("message", "Password updated successfully.");
            } else {
                request.setAttribute("message", "Update failed.");
            }
            request.getRequestDispatcher("profile.jsp").forward(request, response);

        } else if ("Delete".equals(action)) {
            boolean deleted = FileHandler.deleteUser(username, role);
            session.invalidate();
            if (deleted) {
                response.sendRedirect("login.jsp");
            } else {
                response.getWriter().println("Account deletion failed.");
            }
        }
    }
}
