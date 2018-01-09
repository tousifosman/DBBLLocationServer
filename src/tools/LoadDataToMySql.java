package tools;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Scanner;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.util.JSONPObject;


public class LoadDataToMySql {

	public static void main(String[] args) {
		File jsonFile = new File("getBranchDetails.json");
		String jsonString = "";
		JSONPObject jsonpObject;
		ObjectMapper mapper = new ObjectMapper();
		JsonNode jsonNode;
		try {
			
//			Scanner fileScanner = new Scanner(jsonFile);
//			while(fileScanner.hasNext())
//				jsonString += fileScanner.nextLine();
//			fileScanner.close();
//			
//			System.out.println(jsonString);
			jsonNode = mapper.readTree(jsonFile);
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	public LoadDataToMySql() {
		// TODO Auto-generated constructor stub
		
	}

}
