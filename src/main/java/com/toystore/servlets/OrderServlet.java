package com.toystore.servlets;
import java.io.*;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import com.toystore.models.Cart;
import com.toystore.models.Toy;
import com.toystore.models.Order;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/* OrderServlet.java */
@WebServlet(name = "OrderServlet", value = "/order-servlet")
public class OrderServlet extends HttpServlet {
    private static final String ORDERS_FILE = "F:\\ToyStore\\src\\main\\resources\\storage\\orders.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("cart.jsp?error=Cart is empty");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Toy> toys = new ArrayList<>(cart.getItems());
        double totalPrice = cart.calculateTotal();

        int orderId = (int) (System.currentTimeMillis() % 100000);
        Order order = new Order(orderId, userId, toys, totalPrice, "pending");
        
        // Save order to file
        saveOrderToFile(order);
        
        // Clear cart and update session
        cart.clearCart();
        session.setAttribute("cart", cart);
        session.setAttribute("order", order);

        response.sendRedirect("order.jsp");
    }

    private void saveOrderToFile(Order order) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(ORDERS_FILE, true))) {
            writer.write(order.toString());
            writer.newLine();
        }
    }
}
