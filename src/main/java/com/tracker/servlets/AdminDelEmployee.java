package com.tracker.servlets;

import com.tracker.dao.*;
import com.tracker.beans.EmployeeDetailsBeans;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AdDeleteEmp")
public class AdminDelEmployee extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int empID = Integer.parseInt(request.getParameter("empID"));
        
        AdminDao ad = new AdminDao();
        EmployeeDao em = new EmployeeDao();
        EmployeeDetailsBeans emp = new EmployeeDetailsBeans(empID);
        try {
        	if(em.checkUser(emp) == 2) {
        		response.sendRedirect("deleteemp.jsp?msg=Employee%20doesn't%20exist%20!");
        		return;
        	}
        	if(ad.deleteEmployee(emp)) response.sendRedirect("admindash.jsp?msg=Employee%20Deleted%20!");
        	else {
            	response.sendRedirect("deleteemp.jsp?msg=Error%20Deleting%20!");
        	}
        }
        catch(Exception e) {
        	System.out.println("Error when serving update task");
        	response.sendRedirect("deleteemp.jsp?msg=Error%20Deleting%20!");
        }
        
    }
}

