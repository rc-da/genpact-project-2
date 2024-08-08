package com.tracker.servlets;

import com.tracker.dao.AdminDao;
import com.tracker.dao.EmployeeDao;
import com.tracker.beans.*;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AdUpdateTask")
public class AdminUpdateTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String empIDStr = request.getParameter("empID");
        String taskTitle = request.getParameter("taskTitle");
        String taskDes = request.getParameter("taskDes");
        String taskDate = request.getParameter("taskDate");
        String taskDur = request.getParameter("taskDur");

        int empID = Integer.parseInt(empIDStr); 
        String[] time = taskDur.split(":");
        int duration = Integer.parseInt(time[0]) * 60 + Integer.parseInt(time[1]);

        AdminDao ad = new AdminDao();
        EmployeeDetailsBeans emp = new EmployeeDetailsBeans(empID);
        TaskDetailsBeans t = new TaskDetailsBeans(taskTitle, taskDes, taskDate, duration);
        EmployeeDao em = new EmployeeDao();

        try {
        	if(em.checkUser(emp) == 2) {
        		 System.out.println("Employee doesn't exist!");
                 response.sendRedirect("updatetask.jsp?msg=Employee%20doesn't%20exist%20!");
                 return;
            }
        	
            if(ad.updateTask(t, emp))response.sendRedirect("admindash.jsp?msg=Successfully%20Updated%20task%20!");
            
            else {
            	System.out.println("Error Updating task due to duration limit exceeded!");
                response.sendRedirect("updatetask.jsp?msg=Duration%20Limit%20Exceeded%20!");
            }
        }catch (Exception e) {
            System.out.println("Error Updating task: " + e.getMessage());
            response.sendRedirect("updatetask.jsp?msg=Error%20Updating%20task%20try%20again%20!");
        }
    }
}
