<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@page import="dto.MemberDtoBuilder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String memberId = request.getParameter("memberId");
	String password =  request.getParameter("password");
	String name = request.getParameter("name");
	int deliveryId = 1; 
	String phoneNumber = request.getParameter("phoneNumber");
	String email = request.getParameter("email");
	
	MemberDto dto = new MemberDtoBuilder()
				.memberId(memberId)
				.deliveryId(deliveryId)
				.password(password)
				.name(name)
				.nickname(name)
				.phoneNumber(phoneNumber)
				.email(email)
				.emailVerified(true)
				.build();
	
	boolean isSuccess = MemberDao.getInstance().insert(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
</head>
<body>
	<script>
		let isSuccess = <%=isSuccess %>;
		
		if (isSuccess) {
			alert("회원 가입 완료");
			location.href = "${pageContext.request.contextPath}/";
		} else {
			alert("실패");
			location.href = "${pageContext.request.contextPath}/member/signup_form.jsp"	
		}
	</script>
</body>
</html>