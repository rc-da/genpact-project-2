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

@WebServlet("/changepass")
public class EmpChangePass extends HttpServlet{
	private static final long serialVersionUID = 1L;

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String oldPass = request.getParameter("oldPass");
    	String newPass = request.getParameter("newPass");
    	HttpSession session = request.getSession();
    	int empID = (int) session.getAttribute("empId");
    	
    	EmployeeDao emp = new EmployeeDao();
    	EmployeeDetailsBeans em = new EmployeeDetailsBeans();
    	em.setEmpId(empID);
    	em.setOldPass(oldPass);
    	em.setNewPass(newPass);
    	
    	
    	if (emp.validatePass(em)) {
	    	try {
	    		if(emp.changePass(em)) response.sendRedirect("employeedash.jsp");
	    		else {
	    			session.setAttribute("errorMsg", "Error changing password !");
		    		response.sendRedirect("empChangePass.jsp");
	    		}
	    	}catch(Exception e) {
	    		System.out.println("error during changing password"+ e.getMessage());
	    		session.setAttribute("errorMsg", "Error changing password !");
	    		response.sendRedirect("empChangePass.jsp");
	    	}
    	}
    	else {
    		session.setAttribute("errorMsg", "Old password is not correct !");
    		response.sendRedirect("empChangePass.jsp");
    	}
    }
	
}
