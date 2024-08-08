<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.tracker.dao.EmployeeDao" %>
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

        if (!db.checkAdmin(emp)) {
            response.sendRedirect("index.jsp");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("index.jsp");
        return;
    }
%>

<html>
<head>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        
        body {
            background-color: #f0f8ff;
            color: #333;
            font-size: 16px;
            height: 100%;
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .container {
            height: 700px;
            width: 700px;
            margin: 50px auto;
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        
        #columnchart_material {
            height: 500px;
            width: 500px;
        }
        
        form {
            text-align: center;
        }
        
        input[type="number"] {
            width: 200px;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
        }
        
        .bt-container {
            display: flex;
            gap: 30px;
        }
        input[type="submit"],
        a#dash {
        	width: 100px;
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            margin:0;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            transition: background-color 0.3s ease;
        }
        
        input[type="submit"]:hover,
        a#dash:hover {
            background-color: #0056b3;
        }
        
    </style>
    <script type="text/javascript">
        google.charts.load('current', {'packages':['bar']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            var data = google.visualization.arrayToDataTable([
                ['Month', 'Duration (hours)'],
                <% 
                    List<List<Object>> taskList = (List<List<Object>>) request.getAttribute("tasklist");
                    if (taskList != null) {
                        for (List<Object> task : taskList) {
                            int month = (Integer) task.get(0);
                            int minute = (Integer) task.get(1);
                            String monthName = new java.text.DateFormatSymbols().getMonths()[month - 1];
                            out.print("['" + monthName + "', " + minute / 60 + "],");
                        }
                    }
                %>
            ]);

            var options = {
                chart: {
                    title: 'Employee Task Duration by Month',
                    subtitle: 'Task duration throughout the year',
                }
            };

            var chart = new google.charts.Bar(document.getElementById('columnchart_material'));
            chart.draw(data, google.charts.Bar.convertOptions(options));
        }
        
        function validate() {
            const empId = document.forms["chart"]["empId"].value;
            if (empId < 1 || empId > 1000) return false;
            else return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <div id="columnchart_material"></div>
        <div class="bt-container">
            <form name="chart" action="Month" method="post" onsubmit="return validate()">
                <input type="number" name="empId" required />
                <input type="submit" value="Update" />
            </form>
            <a href="admindash.jsp" id="dash">DASHBOARD</a>
        </div>
    </div>
</body>
</html>
