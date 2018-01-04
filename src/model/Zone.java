package model;

import java.sql.PreparedStatement;
import java.sql.SQLException;


public class Zone {

	private int id;
	private String name;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Zone() {
		// TODO Auto-generated constructor stub
	}
	
	public Zone(int id, String name) {
		super();
		this.id = id;
		this.name = name;
	}

	public static boolean save(String name) {
		try {
			System.out.println("INSERT INTO zones (name) VALUES ('"+ name +"');");
			
			PreparedStatement preparedStatement = DB.getInstance()
					.getConnection()
					.prepareStatement("INSERT INTO zones (name) VALUES (?)");
			
			preparedStatement.setString(1, name);
			preparedStatement.execute();
			
			//DB.getInstance().query("INSERT INTO zones (name) VALUES ('"+ name +"');");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.err.println("model.Zone: Zone cannot be saved");
			return false;
		}
		
		System.out.println("model.Zone: Zone saved");
		
		return true;
	}

}
