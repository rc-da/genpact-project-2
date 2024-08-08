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
    <title>Employee Dashboard</title>
    <link rel="stylesheet" href="employeedash.css">
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
        p.textContent = "✅ " + msg;

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
    </script>
    
</head>
<body>
    <div class="container">
        <h1>EMPLOYEE DASHBOARD</h1>

      
        <div class="dashboard-links">
            <a href="empviewtask.jsp">View Task</a>
            <a href = "empChangePass.jsp">Change password</a>
           
            <form action="LogoutServlet" method="post">
                <input type="submit" value="Logout">
            </form>
        </div>
        
    </div>
</body>
</html>
