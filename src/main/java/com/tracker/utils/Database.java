package com.tracker.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
    public Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/genpact", "root", "root");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL Error connecting to the database from EmployeeDao");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("Class not found exception in EmployeeDao");
        }
        return con;
    }
}
