package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;

import model.Location;

/**
 * Servlet implementation class Locations
 */
@WebServlet("/Locations")
public class Locations extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Locations() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
//		if(!validateSession(request, response))
//			return;
		
		if(request.getParameter("get") != null && request.getParameter("get").equals("all")) {
			response.setContentType("application/json");
			
			ObjectWriter objectWriter = new ObjectMapper().writer().withDefaultPrettyPrinter();
			
			response.getOutputStream().println(objectWriter.writeValueAsString(model.Locations.getAll()));
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
//		if(!validateSession(request, response))
//			return;
		
		response.setContentType("text/text");
		if(Boolean.parseBoolean(request.getParameter("add")) == true) {
			if(Location
					.save(request.getParameter("name"), 
							request.getParameter("address"), 
							Integer.parseInt(request.getParameter("zone")),
							Double.parseDouble(request.getParameter("latitude")),
							Double.parseDouble(request.getParameter("longitude")))){
				response.getOutputStream().println("success");
				return;
			}	
		}
		
	}
	
	private boolean validateSession(HttpServletRequest request, HttpServletResponse response) {
		if(request.getSession().getAttribute("session")== null || !(Boolean) request.getSession().getAttribute("session")) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			return false;
		}
		return true;
	}

}
