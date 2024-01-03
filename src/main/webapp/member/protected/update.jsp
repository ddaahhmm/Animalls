<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDtoBuilder"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String memberId = request.getParameter("memberId");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String deliveryId = request.getParameter("deliveryId");
	String phoneNumber = request.getParameter("phoneNumber");
	String email = request.getParameter("email");
	String profileImage = request.getParameter("profileImage");
	
	MemberDto dto = new MemberDtoBuilder()
		.password(password)
		.name(name)
		.nickname(name)
		.phoneNumber(phoneNumber)
		.email(email)
		.profileImage(profileImage)
		.build();
	boolean isSuccess = MemberDao.getInstance().update(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
</head>
<body>
	<script>
		let isSuccess = <%=isSuccess %>;
		
		if (isSuccess) {
			alert("수정을 완료했습니다.");
			location.href = "update_form.jsp";
		} else {
			alert("수정에 실패했습니다.");
			location.href = "update_form.jsp";
		}
	</script>
</body>
</html>