<%@page import="dao.CartItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
	boolean isSuccess = CartItemDao.getInstance().delete(cartItemId);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cart/cartDelete.jsp</title>
</head>
<body>
	<script>
	<%if(isSuccess){ %>
		alert("장바구니에서 삭제되었습니다.");
		location.href="${pageContext.request.contextPath}/cart/cart.jsp";
	<%}%>
	</script>
</body>
</html>
