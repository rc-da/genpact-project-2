<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
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
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet"href="updatetask.css" >
	<meta charset="UTF-8">
	<title>Update task</title>
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
	    clearErrorMsg(); 
	    const empId = document.forms["updatetask"]["empID"].value;
	    const taskTitle = document.forms["updatetask"]["taskTitle"].value;
	    const taskDes = document.forms["updatetask"]["taskDes"].value;
	    const taskDate = document.forms["updatetask"]["taskDate"].value;
	    const taskDur = document.forms["updatetask"]["taskDur"].value;
	
	    const namePattern = /^[A-Za-z\s0-9]+$/;
	    const duration = taskDur.split(":");
	    const date = taskDate.split("-");
	    const maxYear = 2024;
	    const maxDur = 8;
	    const year = parseInt(date[0]);
	    const hour = parseInt(duration[0]);
	    let errorMsg = "";
	
	    if (hour > maxDur) errorMsg += "Task Duration must not exceed 8 hours.\n";
	    if (year > maxYear) errorMsg += "Year should be 2024 or earlier.\n";
	    if (empId < 1 || empId > 1000) errorMsg += "Employee ID exceeds the limit.\n";
	    if (!namePattern.test(taskTitle)) errorMsg += "Task Title must contain only alphabets and numbers.\n";
	    if (!namePattern.test(taskDes)) errorMsg += "Task Description must contain only alphabets and numbers.\n";
	
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
	        <form id = "updatetask" name="updatetask" action="AdUpdateTask" method="post" onsubmit = "return validate()">
			<h1>Update Task</h1>
	       
	        
            <div class="form-group">
                <label for="empID">Employee ID:</label>
                <input type="number" id="empID" name="empID" required>
            </div>
            
            <div class="form-group">
                <label for="taskTitle">Task Title:</label>
                <input type="text" id="taskTitle" name="taskTitle" required>
            </div>
            
            <div class="form-group">
                <label for="taskDes">Task Description:</label>
                <input type="text" id="taskDes" name="taskDes" required>
            </div>
            
            <div class="form-group">
                <label for="taskDate">Task Date:</label>
                <input type="date" id="taskDate" name="taskDate" required>
            </div>
            
            <div class="form-group">
                <label for="taskDur">Task Duration:</label>
                <input type="text" name="taskDur" id="taskDur" pattern="([01]?[0-9]|2[0-3]):[0-5][0-9]" placeholder="Enter time in hh:mm format" required>
                
            </div>
            
             <input type="hidden" id="status" name="status" value="${request.getAttribute('status')}">
            <div class="form-group" id="bt-group">
                <input type="submit" value="Update Task">
                <a href="admindash.jsp">Go to Dashboard</a>
            </div>
        </form>
	</div>
</body>
</html>