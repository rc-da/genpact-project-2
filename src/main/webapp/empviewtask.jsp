<%@ page import="com.tracker.dao.EmployeeDao" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="com.tracker.utils.Database" %>
<%@ page import="com.tracker.beans.EmployeeDetailsBeans" %>

<%
    try {
        
        if (session == null || session.getAttribute("empId") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        int empID = (Integer) session.getAttribute("empId");
        EmployeeDetailsBeans emp = new EmployeeDetailsBeans(empID);
        EmployeeDao db = new EmployeeDao();

        if (!db.checkEmployee(emp)) {
            response.sendRedirect("index.jsp");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Tasks</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background-color: #ffffff;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        h2 {
            color: #007bff;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: #ffffff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        a {
            display: inline-block;
            text-align: center;
            height: 30px;
            border-radius: 10px;
            background-color: #007bff;
            color: white;
            font-size: 14px;
            text-decoration: none;
            padding: 5px 10px;
            transition: background-color 0.3s ease;
        }
        a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <a href="employeedash.jsp">Dashboard</a>
    <div class="container">
        <h2>Tasks for Employee</h2>
        <% 
            int empID = (int) session.getAttribute("empId");
            
            if (empID > 0 ) {
                Database db = new Database();
                
                try (Connection con = db.getConnection();
                     PreparedStatement ps = con.prepareStatement("SELECT taskTitle, taskDes, taskDur, taskDate FROM task WHERE empID = ?")) {
                    
                    ps.setInt(1, empID);
                    
                    try (ResultSet rs = ps.executeQuery()) {
        %>
                        <table>
                            <tr>
                                <th>Task Title</th>
                                <th>Task Description</th>
                                <th>Task Date</th>
                                <th>Duration (minutes)</th>
                            </tr>
                            <% while (rs.next()) { %>
                                <tr>
                                    <td><%= rs.getString("taskTitle") %></td>
                                    <td><%= rs.getString("taskDes") %></td>
                                    <td><%= rs.getString("taskDate") %></td>
                                    <td><%= rs.getInt("taskDur") %></td>
                                </tr>
                            <% } %>
                        </table>
        <%          } 
                } catch (SQLException e) { %>
                    <p>Error retrieving tasks: <%= e.getMessage() %></p>
        <%      } 
            }  %>
    </div>
</body>
</html>
