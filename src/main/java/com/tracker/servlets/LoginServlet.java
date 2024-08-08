package com.tracker.servlets;

import com.tracker.beans.EmployeeDetailsBeans;
import com.tracker.dao.EmployeeDao;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String empIdStr = request.getParameter("empID");
        String pass = request.getParameter("pass");

        HttpSession session = request.getSession();
        try {
            int empId = Integer.parseInt(empIdStr);
            
            EmployeeDao empDao = new EmployeeDao();
            EmployeeDetailsBeans empDetails = new EmployeeDetailsBeans();
            empDetails.setEmpId(empId);
            empDetails.setPass(pass);
            int validationResult = empDao.validate(empDetails);
            System.out.println(validationResult);

            if (validationResult == 1) {
                session.setAttribute("empId", empId);
                response.sendRedirect("admindash.jsp?msg=Login%20Successful%20!");
            } 
            else if (validationResult == 0) {
                session.setAttribute("empId", empId);
                response.sendRedirect("employeedash.jsp?msg=Login%20Successful%20!");
            } 
            else if(validationResult == 2) {
                System.out.println("no such user");
                response.sendRedirect("loginpage.jsp?error=User%20doesn't%20exist%20!");            
                }
            else if(validationResult == -1){
                response.sendRedirect("loginpage.jsp?error=Incorrect%20Password%20!&empId="+empId); 
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            System.out.println("Error logging in "+ e);
            response.sendRedirect("loginpage.jsp?error=Error%20try%20again%20!");
        }
        
    }
}
