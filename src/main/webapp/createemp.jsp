<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        session.setAttribute("errorMsg", "An error occurred while processing your request.");
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Creation</title>
    <link rel="stylesheet" href="createemp.css">
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
            const empName = document.forms["addempform"]["empName"].value;
            const empDept = document.forms["addempform"]["empDept"].value;
            const namePattern = /^[A-Za-z\s]+$/;
            let errorMsg = "";

            if (!namePattern.test(empName)) errorMsg += "Employee Name must contain only alphabets and spaces!\n";
            if (!namePattern.test(empDept)) errorMsg += "Employee Department must contain only alphabets and spaces!\n";

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
        <h2>Employee Creation</h2>
        <form id="addempform" name="addempform" action="AdAddEmp" method="post" onsubmit="return validate()">
            <div class="form-group">
                <label for="empName">Employee Name:</label>
                <input type="text" id="empName" name="empName" required>
            </div>
            <div class="form-group">
                <label for="empDept">Employee Department:</label>
                <input type="text" id="empDept" name="empDept" required>
            </div>
            <div class="form-group">
                <label for="empPriv">Employee Type:</label>
                <select id="empPriv" name="empPriv" required>
                    <option value="" disabled selected>-----Select type-----</option>
                    <option value="0">Employee</option>
                    <option value="1">Admin</option>
                </select>
            </div>
            <div class="form-group buttons" id="bt-group">
                <input type="submit" value="Create"/>
                <button type="reset">Reset</button>
                <a href="admindash.jsp">Go to Dashboard</a>
            </div>
        </form>
    </div>
</body>
</html>
