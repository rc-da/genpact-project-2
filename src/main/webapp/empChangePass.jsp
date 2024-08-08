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
    <title>Change Password</title>
    <link href="empChangePass.css" rel="stylesheet"/>
    <script>
        function insertErrorMsg(msg) {
            let p = document.createElement("p");
            p.textContent = msg;
            p.id = "errormsg";
            p.style.color = "red";
            
            let form = document.getElementById("changePass");
            let submitButton = form.querySelector("input[type='submit']");
            form.insertBefore(p, submitButton);
        }
        
        function clearErrorMsg() {
            let existingMessage = document.getElementById("errormsg");
            if (existingMessage) {
                existingMessage.remove();
            }
        }
        
        function validate() {
            const oldPass = document.forms["changePass"]["oldPass"].value;
            const newPass = document.forms["changePass"]["newPass"].value;
            const confirmPass = document.forms["changePass"]["confirmPass"].value;
            
            clearErrorMsg();
            
            if (newPass !== confirmPass) {
                if (!document.getElementById("errormsg")) { 
                    insertErrorMsg("New password and confirmation do not match.");
                    setTimeout(clearErrorMsg, 3000);
                }
                return false;
            }
            
            let msg = "<%= (session.getAttribute("errorMsg") != null) ? session.getAttribute("errorMsg") : "" %>";
            if (msg) {
                if (!document.getElementById("errormsg")) {
                    insertErrorMsg(msg);
                    setTimeout(clearErrorMsg, 3000);
                }
                return false;
            }
            return true;
        }
        
        window.onload = function() {
            <% 
                String errorMsg = (String) session.getAttribute("errorMsg");
                if (errorMsg != null) {
                    session.removeAttribute("errorMsg");
                }
            %>
        }
    </script>
</head>
<body>
    <div class="form-cont">
      <div class="form">
        <form name="changePass" id="changePass" action="changepass" method="POST" onsubmit="return validate()">
            <h1>CHANGE PASSWORD</h1>
            <label for="oldPass">Old Password</label><br>
            <input type="text" id="oldPass" name="oldPass" required><br>
            
            <label for="newPass">New Password</label><br>
            <input type="password" id="newPass" name="newPass" required><br>
            
            <label for="confirmPass">Confirm Password</label><br>
            <input type="password" id="confirmPass" name="confirmPass" required><br>  
            
            <input type="submit" value="Change Password">
            <a href="employeedash.jsp">Go to Dashboard</a>
        </form>
      </div>
    </div>
</body>
</html>
