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
  <head><link rel="stylesheet" href="deletetask.css">
    <meta charset="UTF-8" />
    <title>Deletion</title>
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

    	function validate(){
    		const empId = document.forms["deletetask"]["empID"].value;
    		const taskTitle = document.forms["deletetask"]["taskTitle"].value;
    		const namePattern = /^[A-Za-z\s0-9]+$/;
    		let errorMsg = "";
    		
    		if(empId < 1 || empId > 1000) errorMsg += "Employee ID exceed the limit !";
    		if(!namePattern.test(taskTitle)) errorMsg += "Task Title must contain only alphabets and numbers.";
    	    if(errorMsg !== ""){
    	    	openPopUp(errorMsg);
                setTimeout(closePopUp, 3000);
    	        return false;
    	    }
    	    return true;
    	}
    </script>
  </head>
  <body>
    <div class="form-cont">
      <div class="form">
        <form name = "deletetask" action="AdDeleteTask" id="deletetask" method="POST" onsubmit="return validate()">
        <h1>TASK DELETION</h1>
        <label for="empID">Employee ID</label><br>
        <input type="number" id="empID" name="empID" required><br>
        <label for="taskTitle">Task Title</label><br>
        <input type="text" id="taskTitle" name="taskTitle" required><br>
        
        
        <input type="submit" value="Delete Account">
        <a href="admindash.jsp">Go to Dashboard</a>
    </form>

      </div>
    </div>
  </body>
</html>
