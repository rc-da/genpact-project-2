package com.tracker.beans;

public class EmployeeDetailsBeans {
	int empPriv;
	int empId;
	String empName;
	String empDept;
	String oldPass;
	String newPass;
	String pass;
	
    public EmployeeDetailsBeans() {
    }
    
	
	public EmployeeDetailsBeans(String name, String dept, int priv) {
		this.empName = name;
		this.empDept = dept;
		this.empPriv = priv;
	}
	
	public EmployeeDetailsBeans(int id) {
		this.empId = id;
	}
	
	public void setEmpName(String name) {
		empName = name;
	}
	
	public String getEmpName() {
		return empName;
	}
	
	public void setEmpDept(String dept) {
		empDept = dept;
	}
	
	public String getEmpDept() {
		return empDept;
	}
	
	public void setEmpPriv(int priv) {
		empPriv = priv;
	}
	
	public int getEmpPriv() {
		return empPriv;
	}
	
	public void setEmpId(int id) {
		empId = id;
	}
	
	public int getEmpId() {
		return empId;
	}
	
	public void setOldPass(String oldP) {
		this.oldPass = oldP;
	}
	
	public String getOldPass() {
		return oldPass;
	}
	
	public void setNewPass(String newP) {
		this.newPass = newP;
	}
	
	public String getNewPass() {
		return newPass;
	}
	
	public void setPass(String passw) {
		this.pass = passw;
	}
	
	public String getPass() {
		return pass;
	}
}
