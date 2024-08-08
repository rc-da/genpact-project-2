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

@WebServlet("/analyzeTask")
public class AnalyzeTask extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String empId = request.getParameter("empId");

       
        int id = Integer.parseInt(empId);
        

        Database db = new Database();
        try (Connection con = db.getConnection()) {
            String query = "SELECT taskTitle, SUM(taskDur) AS duration FROM task WHERE empID = ? GROUP BY taskTitle";
            try (PreparedStatement ps = con.prepareStatement(query)) {
                ps.setInt(1, id);
                try (ResultSet rs = ps.executeQuery()) {
                    List<List<Object>> taskList = new ArrayList<>();

                    while (rs.next()) {
                        String taskTitle = rs.getString("taskTitle");
                        double duration = rs.getInt("duration") / 60.0; 

                        List<Object> taskData = new ArrayList<>();
                        taskData.add(taskTitle);
                        taskData.add(duration);

                        taskList.add(taskData);
                    }

                    request.setAttribute("tasklist", taskList);
                    request.getRequestDispatcher("analyze.jsp").forward(request, response);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("errorpage.jsp");
        }
    }
}
