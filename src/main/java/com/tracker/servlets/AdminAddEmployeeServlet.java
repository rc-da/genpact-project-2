package com.tracker.servlets;

import com.tracker.dao.*;

import com.tracker.beans.EmployeeDetailsBeans;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AdAddEmp")
public class AdminAddEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String empName = request.getParameter("empName");
        String empDept = request.getParameter("empDept");
        String empPrivStr = request.getParameter("empPriv");

        int empPriv = Integer.parseInt(empPrivStr); 

        AdminDao ad = new AdminDao();
        EmployeeDetailsBeans emp = new EmployeeDetailsBeans(empName, empDept, empPriv);
        EmployeeDao em = new EmployeeDao();
        

        try {
        	
        	if(em.checkUser(emp) != 2 ) {
        		response.sendRedirect("createemp.jsp?msg=Employee%20already%20exists!");
        		return;
        	}
            if(ad.createEmployee(emp)) response.sendRedirect("admindash.jsp?msg=Employee%20Created%20!");
            else {
                response.sendRedirect("createemp.jsp?msg=Error%20creating%20employee%20!");
            }
        } catch (Exception e) {
            System.out.println("Error when adding employee " + e.getMessage());
            response.sendRedirect("createemp.jsp?msg=Error%20creating%20employee%20!");
        }
    }
}
