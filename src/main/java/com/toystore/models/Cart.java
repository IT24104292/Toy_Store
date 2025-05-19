package com.toystore.models;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Cart implements Serializable {
    private int userId;
    private List<Toy> items;

    public Cart(int userId) {
        this.userId = userId;
        this.items = new ArrayList<>();
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public List<Toy> getItems() {
        return items;
    }

    public void setItems(List<Toy> items) {
        this.items = items;
    }

    public void addItem(Toy toy) {
        // Check if item already exists in cart
        for (Toy item : items) {
            if (item.getId() == toy.getId()) {
                item.setQuantity(item.getQuantity() + toy.getQuantity());
                return;
            }
        }
        items.add(toy);
    }

    public void removeItem(int toyId) {
        items.removeIf(toy -> toy.getId() == toyId);
    }

    public void clearCart() {
        items.clear();
    }

    public double calculateTotal() {
        return items.stream()
                .mapToDouble(toy -> toy.getPrice() * toy.getQuantity())
                .sum();
    }

    @Override
    public String toString() {
        return "Cart for user " + userId + ": " + items.toString();
    }
}
