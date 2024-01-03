<%@page import="dao.CartItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
	int optionId = Integer.parseInt(request.getParameter("optionId"));
	
	boolean isSuccess = CartItemDao.getInstance().optUpdate(cartItemId, optionId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
	<%if(isSuccess){ %>
		location.href="${pageContext.request.contextPath}/cart/cart.jsp";
	<%} %>
	</script>
</body>
</html>