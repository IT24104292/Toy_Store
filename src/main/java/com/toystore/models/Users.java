package com.toystore.models;

public class User extends People {
    private String role; // Usually "user"

    public User(int id, String name, String email, String password, String role) {
        super(id, name, email, password);
        this.role = role;
    }

    @Override
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return super.toString() + "," + role;
    }
}
