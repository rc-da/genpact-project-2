package com.tracker.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.tracker.beans.EmployeeDetailsBeans;
import com.tracker.utils.Database;

public class EmployeeDao {
    Database db = new Database();
    Connection con = db.getConnection();

    public int validate(EmployeeDetailsBeans emp){
        String query = "SELECT empPriv FROM employee WHERE empID = ? AND password = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, emp.getEmpId());
            ps.setString(2, emp.getPass());
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("empPriv");
            } 
            else if(checkUser(emp) != 2) {
            	System.out.println("Wrong Password!");
            	return -1;
            }
            else {
            	
            	System.out.println("user doesnt exist"+ emp.getEmpId() + emp.getPass());
                return 2;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error during validating employee in EmployeeDao: " + e.getMessage());
            return 2;
        }
    }
    
    public int checkUser(EmployeeDetailsBeans emp){
        String query = "SELECT empPriv FROM employee WHERE empID = ? ";
        
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, emp.getEmpId());
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("empPriv");
            } 
            else {
            	
            	System.out.println("user doesnt exist"+ emp.getEmpId() + emp.getPass());
                return 2;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error during validating employee in EmployeeDao: " + e.getMessage());
            return 2;
        }
    }

    public boolean changePass(EmployeeDetailsBeans emp) {
        String query = "UPDATE employee SET password = ? WHERE empID = ?";
        
        try { 
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, emp.getNewPass());
            ps.setInt(2, emp.getEmpId());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error updating password in EmployeeDao: " + e.getMessage());
            return false;
        }
    }

    public boolean validatePass(EmployeeDetailsBeans emp) {
        String query = "SELECT password FROM employee WHERE empID = ?";
        String oldPass = emp.getOldPass();
        
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, emp.getEmpId());
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return oldPass.equals(rs.getString("password"));
            } 
            else {
                return false;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error validating password in EmployeeDao: " + e.getMessage());
            return false;
        }
    }

    public boolean checkAdmin(EmployeeDetailsBeans emp) {
        String query = "SELECT empPriv FROM employee WHERE empID = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, emp.getEmpId());
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next() && rs.getInt("empPriv") == 1) return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error checking admin in EmployeeDao: " + e.getMessage());
        }
        return false;
    }

    public boolean checkEmployee(EmployeeDetailsBeans emp) {
        String query = "SELECT empPriv FROM employee WHERE empID = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, emp.getEmpId());
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next() && rs.getInt("empPriv") == 0) return true;
            
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error checking employee in EmployeeDao: " + e.getMessage());
        }
        return false;
    }

}
