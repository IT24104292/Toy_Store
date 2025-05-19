package com.toystore.models;

import java.io.Serializable;

public abstract class People implements Serializable {
    protected int id;
    protected String name;
    protected String email;
    protected String password;

    public People(int id, String name, String email, String password) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    // Abstract method to be implemented by subclasses
    public abstract String getRole();

    @Override
    public String toString() {
        return id + "," + name + "," + email + "," + password;
    }
}
