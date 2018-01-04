package beans;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Admin;

public class Login {
	
	private String messege;
	private boolean hasMessege;
	
	private String username;
	private String password;
	
	public Login() {
		// TODO Auto-generated constructor stub
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMessege() {
		return messege;
	}

	public void setMessege(String messege) {
		this.messege = messege;
	}
	
	public boolean hasMessege() {
		return hasMessege;
	}
	
	public boolean login(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		Admin admin = new Admin().initByUsernamePassword(username, password);
		hasMessege = true;
		if(admin != null) {
			try {
				session.setAttribute("session", true);
				session.setAttribute("admin", admin);
				response.sendRedirect("locations.jsp");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				messege = "Server error";
				e.printStackTrace();
			}
			return true;
		}
		messege = "Wrong username or password";
		return false;
	}

}
