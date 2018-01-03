package beans;

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

	public boolean isHasMessege() {
		return hasMessege;
	}

	public void setHasMessege(boolean hasMessege) {
		this.hasMessege = hasMessege;
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
	
	public boolean login() {
		System.out.println("In login");
		return true;
	}

}
