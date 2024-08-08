<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tracker.dao.EmployeeDao" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
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
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="assigntask.css">
    <title>Assign Task</title>
    <style>
	    #popup {
		    position: absolute;
		    top: 10px;
		    right: 10px;
		    background-color: rgba(255, 255, 255, 0.9);
		    padding: 10px;
		    border: 1px solid #ccc;
		    box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
		    border-radius: 10px;
		    text-align: center;
		    width: 200px;
		    z-index: 2;
		    display:flex;
		}
		
		#popup p {
		    margin: 0;
		    color: green;
		}
	</style>
    <script>
	    function openPopUp(msg) {
	        const body = document.body;
	        const div = document.createElement("div");
	        const p = document.createElement("p");
	
	        div.id = "popup";
	        p.textContent = "❌ " + msg;
	
	        div.appendChild(p);
	        body.appendChild(div);
	    }

        function closePopUp() {
            const div = document.getElementById("popup");
            if (div) {
                div.remove();
            }
        }

        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const msg = urlParams.get('msg');
            
            if (msg) {
                openPopUp(msg);
                setTimeout(closePopUp, 3000);
            }
            const url = new URL(window.location);
            url.search = '';
            window.history.replaceState({}, document.title, url);
        }
        
    	function validate() {
	        let errorMsg = "";
	        const empId = document.forms["assigntask"]["empID"].value;
	        const taskTitle = document.forms["assigntask"]["taskTitle"].value;
	        const taskDes = document.forms["assigntask"]["taskDes"].value;
	        const taskDate = document.forms["assigntask"]["taskDate"].value;
	        const taskDur = document.forms["assigntask"]["taskDur"].value;
	
	        const namePattern = /^[A-Za-z\s0-9]+$/;
	        const duration = taskDur.split(":");
	        const date = taskDate.split("-");
	        const maxYear = 2024;
	        const maxDur = 8;
	        const year = parseInt(date[0]);
	        const hour = parseInt(duration[0]);
	
	        if (hour > maxDur) errorMsg += "Task Duration must not exceed 8 hours.\n";
	        if (year > maxYear) errorMsg += "Year should be 2024 or earlier.\n";
	        if (empId < 1 || empId > 1000) errorMsg += "Employee ID exceeds the limit.\n";
	        if (!namePattern.test(taskTitle)) errorMsg += "Task Title must contain only alphabets and numbers.\n";
	        if (!namePattern.test(taskDes)) errorMsg += "Task Description must contain only alphabets and numbers.\n";
			if(Number(date[0]) < 2024 ) errorMsg += "Incorrect Year";
	        if (errorMsg !== "") {
	            openPopUp(errorMsg);
                setTimeout(closePopUp, 3000);
	            return false;
	        }
	        
	        return true;
	    }

    </script>
</head>
<body>
    <div class="container">
        <h1>Assigning Task</h1>
        
        <form id="assigntask" name="assigntask" action="AdAssignTask" method="post" onsubmit="return validate()">
            <div class="form-group">
                <label for="empID">Employee ID:</label>
                <input type="number" id="empID" name="empID" placeholder="Id" required>
            </div>
            
            <div class="form-group">
                <label for="taskTitle">Task Title:</label>
                <input type="text" id="taskTitle" name="taskTitle" placeholder="Title" required>
            </div>
            
            <div class="form-group">
                <label for="taskDes">Task Description:</label>
                <input type="text" id="taskDes" name="taskDes" placeholder="Description" required>
            </div>
            
            <div class="form-group">
                <label for="taskDate">Task Date:</label>
                <input type="date" id="taskDate" name="taskDate" required>
            </div>
            
            <div class="form-group">
                <label for="taskDur">Task Duration:</label>
                <input type="text" name="taskDur" id="taskDur" pattern="([01]?[0-9]|2[0-3]):[0-5][0-9]" placeholder="hh:mm" required>
                
            </div>
            
            <div class="form-group" id="bt-group" >
                <input type="submit" value="Assign Task">
                <a href="admindash.jsp">Go to Dashboard</a>
            </div>
        </form>
    </div>
</body>
</html>
