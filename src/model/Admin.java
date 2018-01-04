package model;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Admin {
	
	private int id;
	private String username;
	private String name;
	private String password;

	public Admin() {
		// TODO Auto-generated constructor stub
	}
	
	public Admin initByUsernamePassword(String username, String password){
		
		try {
			
			ResultSet resultSet =  DB.getInstance().query("SELECT * FROM admins"
					+ " WHERE username = '" + username + "'"
					+ " AND password = '" + password + "';");
			
			if(resultSet.next()) {
				this.id = resultSet.getInt("id");
				this.username = username;
				this.name = resultSet.getString("name");
				this.password = password;
				System.out.println("model.Admin: User created");
				return this;
			}
		} catch (SQLException e) {
			//e.printStackTrace();
		}
		System.err.println("model.Admin: User cannot be Initialized");
		return null;
	}
	
	public boolean verifyPassword(String password){
		return false;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
}
