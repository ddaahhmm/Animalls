package util;

import javax.servlet.http.HttpServletRequest;

public class SessionManager {
	private static SessionManager instance;
	
	private SessionManager() { }
	
	public static SessionManager getInstance() {
		if (instance == null) {
            synchronized (SessionManager.class) {
                if (instance == null) {
                    instance = new SessionManager();
                }
            }
        }
		
        return instance;
    }
	
	public void setMemberId(HttpServletRequest request, String memberId) {
		request.getSession().setAttribute("memberId", memberId);
    }
	
	public String getMemberId(HttpServletRequest request) {
		
        return (String)request.getSession().getAttribute("memberId");
    }
	
	public void setPassword(HttpServletRequest request, String password) {
		request.getSession().setAttribute("password", password);
    }
	
	public String getPassword(HttpServletRequest request) {
		
        return (String)request.getSession().getAttribute("password");
	}
}
