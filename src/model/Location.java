package model;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Location {
	
	private int id;
	private String name;
	private String address;
	private double latitude;
	private double longitude;
	private int zone;
	private String zone_name;

	public Location() {
		// TODO Auto-generated constructor stub
	}
	
	public Location(int id, String name, String address, double latitude,
			double longitude, int zone, String zone_name) {
		super();
		this.id = id;
		this.name = name;
		this.address = address;
		this.latitude = latitude;
		this.longitude = longitude;
		this.zone = zone;
		this.zone_name = zone_name;
	}
	
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public int getZone() {
		return zone;
	}

	public void setZone(int zone) {
		this.zone = zone;
	}

	public String getZone_name() {
		return zone_name;
	}

	public void setZone_name(String zone_name) {
		this.zone_name = zone_name;
	}

	public static boolean save(String name, String address, int zone, double latitude, double longitude) {
		
		try {
			PreparedStatement preparedStatement = DB.getInstance()
					.getConnection().prepareStatement("INSERT INTO locations (name, address, latitude, longitude, zone) VALUES (?, ?, ?, ?, ?)");
			preparedStatement.setString(1, name);
			preparedStatement.setString(2, address);
			preparedStatement.setDouble(3, latitude);
			preparedStatement.setDouble(4, longitude);
			preparedStatement.setInt(5, zone);
			
			preparedStatement.execute();
			preparedStatement.close();
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return false;
	}
	
}
