package com.toystore.models;

import java.io.Serializable;
import java.util.List;

public class Order implements Serializable {
    private int orderId;
    private int userId;
    private List<Toy> toys;
    private double totalPrice;
    private String status; // "pending", "shipped", "delivered"

    public Order(int orderId, int userId, List<Toy> toys, double totalPrice, String status) {
        this.orderId = orderId;
        this.userId = userId;
        this.toys = toys;
        this.totalPrice = totalPrice;
        this.status = status;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public List<Toy> getToys() {
        return toys;
    }

    public void setToys(List<Toy> toys) {
        this.toys = toys;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(orderId).append(",")
          .append(userId).append(",")
          .append(totalPrice).append(",")
          .append(status).append(",");
        
        for (Toy toy : toys) {
            sb.append(toy.getId()).append(":")
              .append(toy.getName()).append(":")
              .append(toy.getPrice()).append(":")
              .append(toy.getQuantity()).append(";");
        }
        
        return sb.toString();
    }
}
