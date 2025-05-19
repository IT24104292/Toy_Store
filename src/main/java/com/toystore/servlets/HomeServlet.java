package com.toystore.servlets;

import com.toystore.models.Toy;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "HomeServlet", value = "/home-servlet")
public class HomeServlet extends HttpServlet {
    private static final String TOYS_FILE = "F:/Programming Files/1.project/ToyStore/src/main/resources/storage/toys.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Toy> toys = getAllToys();
        request.setAttribute("toys", toys);
        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }

    private List<Toy> getAllToys() throws IOException {
        List<Toy> toys = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(TOYS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;

                String[] data = line.split(",");
                if (data.length >= 4) {
                    try {
                        Toy toy = new Toy(
                                Integer.parseInt(data[0].trim()),
                                data[1].trim(),
                                Double.parseDouble(data[2].trim()),
                                Integer.parseInt(data[3].trim())
                        );
                        toys.add(toy);
                    } catch (NumberFormatException e) {
                        System.err.println("Invalid toy data: " + line);
                    }
                } else {
                    System.err.println("Incorrect format: " + line);
                }
            }
        }

        return toys;
    }
}
