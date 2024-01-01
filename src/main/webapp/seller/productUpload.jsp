<%@page import="util.IntegerUtil"%>
<%@page import="dao.ProductDao"%>
<%@page import="dto.ProductDto"%>
<%@page import="dao.UserDao"%>
<%@page import="dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String sellerId=request.getParameter("sellerId");
	String title=request.getParameter("title");
	String category=request.getParameter("category");
	
	int orgPrice=IntegerUtil.parseIntWithDefaultValue(request.getParameter("org_price"), 0);
	
	int salePrice=IntegerUtil.parseIntWithDefaultValue(request.getParameter("sale_price"), 0);
	
	String salesState=request.getParameter("sales_state");
	String description=request.getParameter("description");
	
	ProductDto dto=new ProductDto();
	dto.setSellerId(sellerId);
	dto.setTitle(title);
	dto.setCategory(category);
	dto.setOrgPrice(orgPrice);
	dto.setSalePrice(salePrice);
	dto.setSalesState(salesState);
	dto.setDescription(description);
	
	boolean isSuccess=ProductDao.getInstance().insert(dto);
	
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/seller/productUpload.jsp</title>
</head>
<body>
	<jsp:include page="/include/navbar.jsp">
		<jsp:param value="seller" name="current"/>
	</jsp:include>
	<div class="container">
		<h1>알림</h1>
		<%if(isSuccess){%>
			<p>
				<strong><%=sellerId %></strong> 님의 판매 상품이 등록되었습니다.
				<a href="productList.jsp">판매 목록보기</a>
			</p>
		<%}else{%>
			<p>
				등록에 실패하였습니다. 다시 등록해주세요.
				<a href="productUpload_form.jsp">다시 작성하기</a>
			</p>
		<%}%>
		<!-- 상품을 올리는 페이지입니다 -->
	</div>
	<jsp:include page="/include/footer.jsp">
		<jsp:param value="seller" name="current"/>
	</jsp:include>
</body>
</html>