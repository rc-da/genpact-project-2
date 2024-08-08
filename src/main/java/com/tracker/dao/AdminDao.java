package com.tracker.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.tracker.beans.EmployeeDetailsBeans;
import com.tracker.beans.TaskDetailsBeans;
import com.tracker.utils.Database;

public class AdminDao {
    Database db = new Database();

    public void getTaskId(TaskDetailsBeans t, EmployeeDetailsBeans emp) {
        int id = emp.getEmpId();
        String title = t.getTaskTitle();
        int taskID = 0;
        String query = "SELECT taskID FROM task WHERE empID = ? AND taskTitle = ?";
        
        try (Connection con = db.getConnection();
             PreparedStatement pre = con.prepareStatement(query)) {
            pre.setInt(1, id);
            pre.setString(2, title);
            try (ResultSet re = pre.executeQuery()) {
                if (re.next()) {
                    taskID = re.getInt("taskID");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error getting TaskID: " + e.getMessage());
        }
        t.setTaskId(taskID);
    }

    public boolean addTask(TaskDetailsBeans t, EmployeeDetailsBeans emp) {
        String query = "INSERT INTO task (empID, taskTitle, taskDes, taskDate, taskDur) VALUES (?,?,?,?,?)";
        
        try (Connection con = db.getConnection();
             PreparedStatement pre = con.prepareStatement(query)) {
            pre.setInt(1, emp.getEmpId());
            pre.setString(2, t.getTaskTitle());
            pre.setString(3, t.getTaskDes());
            pre.setString(4, t.getTaskDate());
            pre.setInt(5, t.getTaskDuration());
            pre.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error Assigning Task: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteTask(TaskDetailsBeans t, EmployeeDetailsBeans emp) {
        String query = "DELETE FROM task WHERE empID = ? and taskTitle = ?";
        
        try (Connection con = db.getConnection();
             PreparedStatement pre = con.prepareStatement(query)) {
            pre.setInt(1, emp.getEmpId());
            pre.setString(2, t.getTaskTitle());
            pre.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error Deleting Task: " + e.getMessage());
            return false;
        }
    }

    public boolean updateTask(TaskDetailsBeans t, EmployeeDetailsBeans emp) {
        String query = "UPDATE task SET taskTitle = ?, taskDes = ?, taskDate = ?, taskDur = ? WHERE empID = ? AND taskID = ?";
        
        getTaskId(t, emp);
        
        try (Connection con = db.getConnection();
             PreparedStatement pre = con.prepareStatement(query)) {
            pre.setString(1, t.getTaskTitle());
            pre.setString(2, t.getTaskDes());
            pre.setString(3, t.getTaskDate());
            pre.setInt(4, t.getTaskDuration());
            pre.setInt(5, emp.getEmpId());
            pre.setInt(6, t.getTaskId());
            pre.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error Updating Task: " + e.getMessage());
            return false;
        }
    }

    public boolean createEmployee(EmployeeDetailsBeans emp) {
        String query = "INSERT INTO employee (empName, empDept, empPriv) VALUES (?,?,?)";
        
        try (Connection con = db.getConnection();
             PreparedStatement pre = con.prepareStatement(query)) {
            pre.setString(1, emp.getEmpName());
            pre.setString(2, emp.getEmpDept());
            pre.setInt(3, emp.getEmpPriv());
            pre.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error Creating Employee: " + e.getMessage());
            return true;
        }
    }

    public boolean deleteEmployee(EmployeeDetailsBeans emp) {
        String query = "DELETE FROM employee WHERE empID = ?";
        
        try (Connection con = db.getConnection();
             PreparedStatement pre = con.prepareStatement(query)) {
            pre.setInt(1, emp.getEmpId());
            pre.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error Deleting Employee: " + e.getMessage());
            return false;
        }
    }
}
