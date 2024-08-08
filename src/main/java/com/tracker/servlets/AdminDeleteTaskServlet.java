package com.tracker.servlets;

import com.tracker.beans.*;
import com.tracker.dao.*;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
@WebServlet("/AdDeleteTask")
public class AdminDeleteTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int empID = Integer.parseInt(request.getParameter("empID"));
    	String taskTitle = request.getParameter("taskTitle");
    	
    	AdminDao ad = new AdminDao();
    	EmployeeDetailsBeans emp = new EmployeeDetailsBeans(empID);
    	TaskDetailsBeans t = new TaskDetailsBeans();
    	EmployeeDao em = new EmployeeDao();
    	
        try {
        	t.setTaskTitle(taskTitle);
        	
        	if(em.checkUser(emp) == 2) {
        		System.out.println("Employee doesn't exist!");
                response.sendRedirect("deletetask.jsp?msg=Employee%20doesn't%20exist%20!");
                return;
            }
            if(ad.deleteTask(t, emp)) response.sendRedirect("admindash.jsp?msg=Successfully%20Deleted%20task%20!");
            
            else {
            	System.out.println("Error deleting task");
                response.sendRedirect("deletetask.jsp?msg=Error%20Deleting%20Task%20!");
            }
        } catch (Exception e) {
            System.out.println("Error when deleting task: " + e.getMessage());
            response.sendRedirect("deletetask.jsp?msg=Error%20Deleting%20Task%20!");
        }
    }
}
