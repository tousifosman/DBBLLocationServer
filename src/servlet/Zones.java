package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;

import model.Zone;

/**
 * Servlet implementation class Zones
 */
@WebServlet("/Zones")
public class Zones extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Zones() {
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
			
			response.getOutputStream().println(objectWriter.writeValueAsString(model.Zones.getALL()));
		}	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		if(!validateSession(request, response))
			return;
		
		response.setContentType("text/text");
		if(Boolean.parseBoolean(request.getParameter("add")) == true) {
			if(Zone.save(request.getParameter("name"))){
				response.getOutputStream().println("success");
				return;
			}	
		}
		
		if(request.getParameter("delete") != null) {
			System.out.println(request.getParameter("delete"));
			try {
				if (Zone.deleteZoneByID(Integer.parseInt(request.getParameter("delete")))){
					response.getOutputStream().println("success");
					System.out.println("success");
					return;
				};
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
	
		
		response.getOutputStream().println("failed");
	}
	
	private boolean validateSession(HttpServletRequest request, HttpServletResponse response) {
		if(request.getSession().getAttribute("session")== null || !(Boolean) request.getSession().getAttribute("session")) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			return false;
		}
		return true;
	}

}
