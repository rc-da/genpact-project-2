<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
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
    <style>
		*{
		    margin: 0;
		    padding: 0;
		    font-family: Arial, sans-serif;
		}
		
		body {
		    background-color: #f0f8ff;
		    color: #333;
		    font-size: 16px;
		    height:100%;
		    width:100%;
		    display:flex;
		    justify-content:center;
		    align-items:center;
		}
		
		.container {
			height:700px;
		    width: 700px;
		    margin: 50px auto;
		    padding: 20px;
		    display:flex;
		    flex-direction:column;
		    justify-content:center;
		    align-items:center;
		    background-color: #fff;
		    border: 1px solid #ddd;
		    border-radius: 8px;
		    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		}
		
		#piechart {
			height: 500px;
		    width: 500px;
		    margin: 20px 0;
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
		
		input[type="submit"] {
		    background-color: #007bff;
		    color: #fff;
		    border: none;
		    padding: 10px 20px;
		    font-size: 16px;
		    border-radius: 4px;
		    cursor: pointer;
		    transition: background-color 0.3s ease;
		}
		
		input[type="submit"]:hover {
		    background-color: #0056b3;
		}
		
		#dash {
			width: 100px;
		    padding: 10px 20px;
		    margin: 10px 0;
		    background-color: #007bff;
		    color: white;
		    font-size: 16px;
		    text-decoration: none;
		    border-radius: 4px;
		    border: none;
		    cursor: pointer;
		    transition: background-color 0.3s ease;
		    text-align: center;
		}
		
		#dash:hover {
		    background-color: #0056b3;
		}
		    	
    </style>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script>
        google.charts.load('current', {'packages': ['corechart']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            var data = google.visualization.arrayToDataTable([
                ['Task', 'Hours per Day'],
                <% 
                    List<List<Object>> taskList = (List<List<Object>>) request.getAttribute("tasklist");
                    if (taskList != null) {
                        for (List<Object> task : taskList) {
                            out.print("['" + task.get(0) + "', " + task.get(1) + "],");
                        }
                    }
                %>
            ]);

            var options = {
                title: 'Total duration based on task in minutes'
            };

            var chart = new google.visualization.PieChart(document.getElementById('piechart'));
            chart.draw(data, options);
        }

        function validate() {
            const empId = document.forms["analyze"]["empId"].value;
            if (empId < 1 || empId > 1000) return false;
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <div id="piechart" ></div>
        <form name="analyze" action="analyzeTask" method="post" onsubmit="return validate()">
            <input type="number" name="empId" required/>
            <input type="submit" value="Update"/>
        <a href="admindash.jsp" id="dash">Dashboard</a>
        </form>
    </div>
</body>
</html>
