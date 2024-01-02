<%@page import="dto.ProductOptionDto"%>
<%@page import="dao.ProductOptionDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    	
    
    
    	int optionId = Integer.parseInt(request.getParameter("optionId"));
    	int amount = Integer.parseInt(request.getParameter("amount"));
    	
    	
    		ProductOptionDao.getInstance().amountUpdate(optionId, amount);
    	
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
	
		location.href="${pageContext.request.contextPath}/product/productDetail.jsp";

	</script>
</body>
</html>