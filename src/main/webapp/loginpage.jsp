<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Login</title>
    <link rel="stylesheet" href="login.css">
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
            width: auto;
            z-index: 2;
            display: flex;
        }
        #popup p {
            margin: 0;
            color: green;
        }
        input[type="number"] :focus{
        	border-color: black;
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

        function validate() {
            const empid = parseInt(document.forms['loginform']['empID'].value);
            const pass = document.forms['loginform']['pass'].value;

            if (empid < 1 || empid > 1000) {
                openPopUp("Enter a valid Employee ID!");
                setTimeout(closePopUp, 3000);
                return false;
            }

            return true;
        }

        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const msg = urlParams.get('error');
            const id = urlParams.get('empId');
            const form = document.getElementById('loginform');
            const inp = form.querySelector("input[type='number']");

            if (id) {
                inp.value = id;
            }

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
    <div class="login-container">
        <h2>Login</h2>
        <form name="loginform" action="LoginServlet" method="post" onsubmit="return validate()" id="loginform">
            <label for="empID">Employee ID</label>
            <input type="number" id="empID" name="empID" required>
            
            <label for="password">Password</label>
            <input type="password" id="pass" name="pass" required>
            
            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>
