package com.tracker.servlets;

import com.tracker.dao.AdminDao;
import com.tracker.dao.EmployeeDao;
import com.tracker.beans.EmployeeDetailsBeans;
import com.tracker.beans.TaskDetailsBeans;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AdAssignTask")
public class AdminAssignTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String empIDStr = request.getParameter("empID");
        String taskTitle = request.getParameter("taskTitle");
        String taskDes = request.getParameter("taskDes");
        String taskDate = request.getParameter("taskDate");
        String taskDur = request.getParameter("taskDur");
        AdminDao adminDao = new AdminDao();
        EmployeeDao employeeDao = new EmployeeDao();

        try {
            int empID = Integer.parseInt(empIDStr);
            String[] time = taskDur.split(":");
            int duration = Integer.parseInt(time[0]) * 60 + Integer.parseInt(time[1]);

            EmployeeDetailsBeans employee = new EmployeeDetailsBeans(empID);
            TaskDetailsBeans task = new TaskDetailsBeans(taskTitle, taskDes, taskDate, duration);

            if (employeeDao.checkUser(employee) == 2) {
                System.out.println("Employee doesn't exist!");
                response.sendRedirect("assigntask.jsp?msg=Employee%20doesn't%20exist%20!");
                return;
            }

            if (adminDao.addTask(task, employee)) {
                response.sendRedirect("admindash.jsp?msg=Successfully%20assigned%20task%20!");
            } else {
                System.out.println("Error assigning task due to duration limit exceeded!");
                response.sendRedirect("assigntask.jsp?msg=Duration%20Limit%20Exceeded%20!");
            }

        } catch (Exception e) {
            System.out.println("Error assigning task: " + e.getMessage());
            response.sendRedirect("assigntask.jsp?msg=Error%20assigning%20task%20try%20again%20!");
        }
    }
}
