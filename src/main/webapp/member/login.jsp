<%@page import="util.Crypto"%>
<%@page import="util.SessionManager"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String memberId = request.getParameter("memberId");
    String password = request.getParameter("password");	
    String isSave = request.getParameter("isSave");
     
	MemberDto dto = MemberDao.getInstance().getData(memberId);
	
	boolean isLoginSuccess = false;
	if (dto != null) {
		if (dto.getPassword().equals(Crypto.hash(password))) {
			SessionManager.setMember(request, dto);
			isLoginSuccess = true;
		}
	}
	String url = request.getParameter("url");
	String encodedUrl = URLEncoder.encode(url);
	
	if (isSave != null) {
		Cookie cook1 = new Cookie("savedMemberId", memberId);
		cook1.setMaxAge(60*60*24*7);
		response.addCookie(cook1);
	} else {
		Cookie cook1 = new Cookie("savedMemberId", "");
		cook1.setMaxAge(0);
		response.addCookie(cook1);
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login.jsp</title>
</head>
<body>
	<script>
		<%if (isLoginSuccess) { %>
			location.href = "${pageContext.request.contextPath}/index.jsp";
		<%} else { %>
			alert("실패");
			location.href = "${pageContext.request.contextPath}/member/login_form.jsp";
		<%} %>
	</script>
</body>
</html>