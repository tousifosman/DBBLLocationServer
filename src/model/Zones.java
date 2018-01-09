package model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;

public class Zones {

	public Zones() {
		// TODO Auto-generated constructor stub
	}
	
	public static Zone[] getALL() {
		try {
			ResultSet resultSet = DB.getInstance().query("SELECT * FROM zones;");
			
			LinkedList<Zone> zones = new LinkedList<Zone>();
			zones.add(new Zone(0, "All"));
			while(resultSet.next()){
				zones.add(new Zone(
						resultSet.getInt("id"),
						resultSet.getString("name")
				));
			}
			return zones.toArray(new Zone[0]);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}
