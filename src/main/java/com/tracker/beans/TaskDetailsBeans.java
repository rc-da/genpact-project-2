package com.tracker.beans;

public class TaskDetailsBeans {
	int taskId;
	String taskTitle;
	String taskDes;
	String taskDate;
	int taskDuration;
	
	public TaskDetailsBeans() {
    }
	
	public TaskDetailsBeans(String title, String des, String date, int dur) {
		this.taskTitle = title;
		this.taskDes = des;
		this.taskDate = date;
		this.taskDuration = dur;
	}
	
	public void setTaskId(int id) {
		taskId = id;
	}
	
	public int getTaskId() {
		return taskId;
	}
	
	public void setTaskTitle(String title) {
		taskTitle = title;
	}
	
	public String getTaskTitle() {
		return taskTitle;
	}
	
	public void setTaskDes(String des) {
		taskDes = des;
	}
	
	public String getTaskDes() {
		return taskDes;
	}
	
	public void setTaskDate(String date) {
		taskDate = date;
	}
	
	public String getTaskDate() {
		return taskDate;
	}
	
	public void setTaskDuration(int duration) {
		taskDuration = duration;
	}
	
	public int getTaskDuration() {
		return taskDuration;
	}
}
