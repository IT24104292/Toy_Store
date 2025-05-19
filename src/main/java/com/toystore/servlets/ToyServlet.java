package com.toystore.servlets;

import java.io.*;
import com.toystore.models.Toy;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ToyServlet", value ="/toy-servlet")
public class ToyServlet extends HttpServlet {

    // Kavindu — Common constant
    private static final String FILE_PATH = "F:/Programming Files/1.project/ToyStore/src/main/resources/storage/toys.txt";

    // Nimesh — doPost handles all POST actions
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addToy(request, response);       
        } else if ("delete".equals(action)) {
            deleteToy(request, response);    
        } else if ("update".equals(action)) {
            updateToy(request, response);    /
        }
    }

    // Kavindu — View toys (GET request)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Toy> toys = getAllToys();
        request.setAttribute("toys", toys);
        request.getRequestDispatcher("toys.jsp").forward(request, response);
    }

    // Kavindu — Add toy (Create)
    private void addToy(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Toy toy = new Toy(id, name, price, quantity);
        saveToyToFile(toy);

        response.sendRedirect("toy-servlet");
    }

    // Kavindu — Save one toy to file
    private void saveToyToFile(Toy toy) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(toy.toString());
            writer.newLine();
        }
    }

    // Kavindu — Load all toys from file
    private List<Toy> getAllToys() throws IOException {
        List<Toy> toys = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
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
                }
            }
        }
        return toys;
    }
    // Nimesh — Delete toy (Delete)
    private void deleteToy(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        List<Toy> toys = getAllToys();

        toys.removeIf(toy -> toy.getId() == id);
        saveAllToys(toys);

        response.sendRedirect("toy-servlet");
    }

    //  Nimesh — Update toy (Update)
    private void updateToy(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idStr = request.getParameter("id");

        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect("toy-servlet?error=Invalid ID");
            return;
        }

        int id = Integer.parseInt(idStr);
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        List<Toy> toys = getAllToys();
        for (Toy toy : toys) {
            if (toy.getId() == id) {
                toy.setName(name);
                toy.setPrice(price);
                toy.setQuantity(quantity);
                break;
            }
        }
        saveAllToys(toys);

        response.sendRedirect("toy-servlet");
    }

    // Nimesh — Save all toys (used for update and delete)
    private void saveAllToys(List<Toy> toys) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Toy toy : toys) {
                writer.write(toy.toString());
                writer.newLine();
            }
        }
    }
}
