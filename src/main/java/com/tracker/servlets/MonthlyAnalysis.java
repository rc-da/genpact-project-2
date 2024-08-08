package com.tracker.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tracker.utils.Database;

@WebServlet("/Month")
public class MonthlyAnalysis extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String empId = request.getParameter("empId");
        int id = Integer.parseInt(empId);

        Database db = new Database();
        Connection con = db.getConnection();
        String query = "SELECT MONTH(taskDate) AS month, SUM(taskDur) AS duration FROM task WHERE empID = ? GROUP BY MONTH(taskDate)";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, id); 
            rs = ps.executeQuery();

            List<List<Object>> taskList = new ArrayList<>();

            while (rs.next()) {
                int month = rs.getInt("month");
                int duration = rs.getInt("duration");

                List<Object> taskData = new ArrayList<>();
                taskData.add(month);
                taskData.add(duration);

                taskList.add(taskData);
            }

            request.setAttribute("tasklist", taskList);
            request.getRequestDispatcher("monthlychart.jsp").forward(request, response);
        } catch( SQLException e) {
            e.printStackTrace();
            System.out.println("Error during month analysis"+e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}