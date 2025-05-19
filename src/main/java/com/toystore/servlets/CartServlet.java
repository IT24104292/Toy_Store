package com.toystore.servlets;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.ServletException;
import com.toystore.models.Cart;
import com.toystore.models.Toy;
import com.toystore.utils.FileHandler;

import java.io.IOException;

@WebServlet(name = "CartServlet", value = "/cart-servlet")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Do not create a new session if one doesn't exist
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        // Get or create cart
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            // Try to load cart from file
            cart = FileHandler.loadCart(userId);
            if (cart == null) {
                cart = new Cart(userId);
            }
            session.setAttribute("cart", cart);
        }

        // Handle actions
        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "add":
                    handleAddToCart(request, cart);
                    FileHandler.saveCart(userId, cart);
                    break;
                case "remove":
                    handleRemoveFromCart(request, cart);
                    FileHandler.removeToyFromCart(userId, Integer.parseInt(request.getParameter("toyId")));
                    break;
                case "clear":
                    // Return all items' quantities back to inventory before clearing
                    for (Toy item : cart.getItems()) {
                        FileHandler.updateToyQuantity(item.getId(), item.getQuantity());
                    }
                    cart.clearCart();
                    FileHandler.clearCart(userId);
                    break;
            }
            session.setAttribute("cart", cart); // Update session
        }

        response.sendRedirect("cart.jsp");
    }

    private void handleAddToCart(HttpServletRequest request, Cart cart) {
        try {
            int toyId = Integer.parseInt(request.getParameter("toyId"));
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // Check if we have enough items in stock
            int availableQuantity = FileHandler.getToyQuantity(toyId);
            if (availableQuantity < quantity) {
                System.err.println("Not enough items in stock");
                return;
            }

            boolean exists = false;
            for (Toy item : cart.getItems()) {
                if (item.getId() == toyId) {
                    item.setQuantity(item.getQuantity() + quantity);
                    exists = true;
                    break;
                }
            }

            if (!exists) {
                cart.addItem(new Toy(toyId, name, price, quantity));
            }

            // Update the toy quantity in toys.txt
            FileHandler.updateToyQuantity(toyId, -quantity);
        } catch (Exception e) {
            System.err.println("Failed to add item to cart: " + e.getMessage());
        }
    }

    private void handleRemoveFromCart(HttpServletRequest request, Cart cart) {
        try {
            int removeToyId = Integer.parseInt(request.getParameter("toyId"));
            
            // Find the toy in cart to get its quantity
            for (Toy item : cart.getItems()) {
                if (item.getId() == removeToyId) {
                    // Return the quantity back to toys.txt
                    FileHandler.updateToyQuantity(removeToyId, item.getQuantity());
                    break;
                }
            }
            
            cart.removeItem(removeToyId);
        } catch (Exception e) {
            System.err.println("Failed to remove item: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
