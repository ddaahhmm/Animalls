package util;

import javax.servlet.http.HttpServletRequest;

import dto.MemberDto;

public class SessionManager {
	private SessionManager() {}
	
	public static void setMember(HttpServletRequest request, MemberDto dto) {
		request.getSession().setAttribute("member", dto);
    }
	
	public static MemberDto getMember(HttpServletRequest request) {
		return (MemberDto)request.getSession().getAttribute("member");
	}
}
