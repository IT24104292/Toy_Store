package com.toystore.utils;

import com.toystore.models.Cart;
import com.toystore.models.Toy;

import java.io.*;
import java.util.*;


public class FileHandler {
    private static final String USERS_FILE = "C:\\Users\\miyur\\OneDrive\\Documents\\ToyStore_(0)\\ToyStore\\src\\main\\resources\\storage\\users.txt";
    private static final String ADMINS_FILE = "C:\\Users\\miyur\\OneDrive\\Documents\\ToyStore_(0)\\ToyStore\\src\\main\\resources\\storage\\admins.txt";
    private static final String CART_FILE = "C:\\Users\\miyur\\OneDrive\\Documents\\ToyStore_(0)\\ToyStore\\src\\main\\resources\\storage\\cart.txt";
    private static final String TOYS_FILE = "C:\\Users\\miyur\\OneDrive\\Documents\\ToyStore_(0)\\ToyStore\\src\\main\\resources\\storage\\toys.txt";

    // Method to check if a user is valid and return their role
    public static String getUserRole(String username, String password) {
        if (isUserValid(username, password, USERS_FILE)) {
            return "user";  // User found in users.txt
        }
        if (isUserValid(username, password, ADMINS_FILE)) {
            return "admin"; // User found in admins.txt
        }
        return null; // User not found
    }

    // Helper method to check credentials in a file
    private static boolean isUserValid(String username, String password, String filePath) {
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 2 && parts[0].equals(username) && parts[1].equals(password)) {
                    return true;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to register a user in the correct file
    public static boolean registerUser(String username, String password, String role) {
        String filePath = role.equals("admin") ? ADMINS_FILE : USERS_FILE;

        if (isUserExists(username, filePath)) {
            return false; // User already exists
        }

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath, true))) {
            bw.write(username + "," + password);
            bw.newLine();
            return true; // Registration successful
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to check if a username already exists in the given file
    private static boolean isUserExists(String username, String filePath) {
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length > 0 && parts[0].equals(username)) {
                    return true;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }
    public static boolean updateUser(String username, String newPassword, String role) {
        String file = role.equals("admin") ? ADMINS_FILE : USERS_FILE;
        List<String> lines = new ArrayList<>();
        boolean updated = false;

        // Read all lines and update the matching one
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts[0].equals(username)) {
                    lines.add(username + "," + newPassword);
                    updated = true;
                } else {
                    lines.add(line);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        // Write all lines back to the file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (String line : lines) {
                writer.write(line);
                writer.newLine();
            }
            return updated;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean deleteUser(String username, String role) {
        String file = role.equals("admin") ? ADMINS_FILE : USERS_FILE;
        List<String> lines = new ArrayList<>();
        boolean deleted = false;

        // Read all lines except the one to delete
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts[0].equals(username)) {
                    deleted = true;
                    continue; // Skip this line
                }
                lines.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        // Write remaining lines back to the file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (String line : lines) {
                writer.write(line);
                writer.newLine();
            }
            return deleted;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<Map<String, String>> getAllUsers() {
        List<Map<String, String>> users = new ArrayList<>();
        
        // Read users from users.txt
        try (BufferedReader reader = new BufferedReader(new FileReader(USERS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 2) {
                    Map<String, String> user = new java.util.HashMap<>();
                    user.put("username", parts[0]);
                    user.put("role", "user");
                    users.add(user);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Read users from admins.txt
        try (BufferedReader reader = new BufferedReader(new FileReader(ADMINS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 2) {
                    Map<String, String> user = new java.util.HashMap<>();
                    user.put("username", parts[0]);
                    user.put("role", "admin");
                    users.add(user);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return users;
    }

    // Method to save cart to file
    public static boolean saveCart(int userId, Cart cart) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(CART_FILE, true))) {
            // Format: userId,toyId,name,price,quantity
            for (Toy toy : cart.getItems()) {
                writer.write(String.format("%d,%d,%s,%.2f,%d%n",
                    userId,
                    toy.getId(),
                    toy.getName(),
                    toy.getPrice(),
                    toy.getQuantity()
                ));
            }
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to load cart from file
    public static Cart loadCart(int userId) {
        Cart cart = new Cart(userId);
        try (BufferedReader reader = new BufferedReader(new FileReader(CART_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 5 && Integer.parseInt(parts[0]) == userId) {
                    Toy toy = new Toy(
                        Integer.parseInt(parts[1]),  // toyId
                        parts[2],                    // name
                        Double.parseDouble(parts[3]), // price
                        Integer.parseInt(parts[4])    // quantity
                    );
                    cart.addItem(toy);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return cart;
    }

    // Method to clear cart from file
    public static boolean clearCart(int userId) {
        List<String> lines = new ArrayList<>();
        boolean cleared = false;

        // Read all lines except the ones for this user
        try (BufferedReader reader = new BufferedReader(new FileReader(CART_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length > 0 && Integer.parseInt(parts[0]) != userId) {
                    lines.add(line);
                } else {
                    cleared = true;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        // Write remaining lines back to the file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(CART_FILE))) {
            for (String line : lines) {
                writer.write(line);
                writer.newLine();
            }
            return cleared;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to remove a specific toy from user's cart
    public static boolean removeToyFromCart(int userId, int toyId) {
        List<String> lines = new ArrayList<>();
        boolean removed = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(CART_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 5 && 
                    Integer.parseInt(parts[0]) == userId && 
                    Integer.parseInt(parts[1]) == toyId) {
                    removed = true;
                    continue; // Skip this line
                }
                lines.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(CART_FILE))) {
            for (String line : lines) {
                writer.write(line);
                writer.newLine();
            }
            return removed;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to update toy quantity
    public static boolean updateToyQuantity(int toyId, int quantityChange) {
        List<String> lines = new ArrayList<>();
        boolean updated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(TOYS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 4 && Integer.parseInt(parts[0].trim()) == toyId) {
                    // Update the quantity
                    int currentQuantity = Integer.parseInt(parts[3].trim());
                    int newQuantity = currentQuantity + quantityChange;
                    if (newQuantity >= 0) {  // Ensure quantity doesn't go below 0
                        parts[3] = String.valueOf(newQuantity);
                        updated = true;
                    }
                }
                lines.add(String.join(",", parts));
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        if (updated) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(TOYS_FILE))) {
                for (String line : lines) {
                    writer.write(line);
                    writer.newLine();
                }
                return true;
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }
        }
        return false;
    }

    // Method to get current toy quantity
    public static int getToyQuantity(int toyId) {
        try (BufferedReader reader = new BufferedReader(new FileReader(TOYS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 4 && Integer.parseInt(parts[0].trim()) == toyId) {
                    return Integer.parseInt(parts[3].trim());
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return 0;
    }
}

