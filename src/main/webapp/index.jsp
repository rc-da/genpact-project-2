<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>
    <link rel="stylesheet" href="index.css"/>
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
    </style>
    <script>
    function openPopUp(msg) {
        const body = document.body;
        const div = document.createElement("div");
        const p = document.createElement("p");

        div.id = "popup";
        p.textContent = "✅" + msg;

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
<body >
    <div class="container">
        <div class="welcome-message">WELCOME TO EMPLOYEE TIME TRACKER</div>
        <div class="login-link"><a href="loginpage.jsp">LOGIN</a></div>
    </div>
</body>
</html>
