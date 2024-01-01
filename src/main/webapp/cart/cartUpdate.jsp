<%@page import="dto.CartItemDto"%>
<%@page import="dao.CartItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
	int amount = Integer.parseInt(request.getParameter("amount"));
	if(amount>0){
	CartItemDao.getInstance().amountUpdate(cartItemId, amount);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		location.href="${pageContext.request.contextPath}/cart/cart.jsp";
	</script>
	
</body>
</html>