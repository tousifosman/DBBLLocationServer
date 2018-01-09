package model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;

public class Locations {

	public Locations() {
		// TODO Auto-generated constructor stub
	}
	
	public static Location[] getAll() {
		
		try {
			return getLocationDBQuery("SELECT locations.*, zones.name AS zone_name FROM locations, zones WHERE locations.zone = zones.id;");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	public static Location[] getByZone(int zoneID){
		
		try {
			return getLocationDBQuery("SELECT locations.*, zones.name AS zone_name"
					+ " FROM locations, zones"
					+ " WHERE locations.zone = zones.id"
					+ " AND zones.id = "+ zoneID +";");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	private static Location[] getLocationDBQuery(String query) throws SQLException{
		
		ResultSet resultSet = DB.getInstance().query(query);
		
		LinkedList<Location> locations = new LinkedList<Location>();
		
		while (resultSet.next())
			locations.add(new Location(
					resultSet.getInt("id"),
					resultSet.getString("name"),
					resultSet.getString("address"),
					resultSet.getDouble("latitude"),
					resultSet.getDouble("longitude"),
					resultSet.getInt("zone"),
					resultSet.getString("zone_name")));
		return locations.toArray(new Location[0]);
		
	}

}
