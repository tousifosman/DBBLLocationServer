package model;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DB {

	private static String username = "dbbl_location_server";
	private static String password = "";
	private static String database = "DBBLLocationServer";
	
	private Connection connection = null;
	
	private static DB db;

	private DB() {
		// TODO Auto-generated constructor stub
		
		 try {

	            Class.forName("com.mysql.jdbc.Driver");

	        } catch (ClassNotFoundException e) {

	            System.out.println("JDBC Driver not found.");
	            e.printStackTrace();
	            return;

	        }
		
		try {

			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+database,
					username,password);

		} catch (SQLException e) {

			System.out.println("Connection Failed! Check output console");
			//e.printStackTrace();
			return;

		}

		if (connection != null) {
			System.out.println("You made it, take control your database now!");
		} else {
			System.out.println("Failed to make connection!");
		}
	}
	
	public ResultSet query(String query) throws SQLException{
		
			Statement statement = connection.createStatement();
			ResultSet resultSet = statement.executeQuery(query);
			//statement.close();
			return resultSet;
		
	}
	
	public static DB getInstance() {
		if(db == null)
			db = new DB();
		return db;
	}
	
	public Connection getConnection() {
		return connection;
	}
	
}
