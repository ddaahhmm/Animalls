<%@page import="dao.ProductDao"%>
<%@page import="dto.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String sellerId=request.getParameter("sellerId");
	int productId=Integer.parseInt(request.getParameter("productId"));
	String title=request.getParameter("title");
	String category=request.getParameter("category");
	int orgPrice=Integer.parseInt(request.getParameter("orgPrice"));
	int salePrice=Integer.parseInt(request.getParameter("salePrice"));
	String salesState=request.getParameter("salesState");
	String description=request.getParameter("description");
	
	ProductDto dto=new ProductDto();
	dto.setSellerId(sellerId);
	dto.setProductId(productId);
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
<title>/seller/productUpdate.jsp</title>
</head>
<body>
	<h1>알림</h1>
	<%if(isSuccess){%>
		<p>
			<strong><%=sellerId %></strong> 님이 작성한 글이 수정되었습니다.
			<a href="ProductList.jsp">판매 목록보기</a>
		</p>
		<%}else{%>
			<p>
				수정에 실패하였습니다. 다시 수정해주세요.
				<a href="productUpdate_form.jsp?productId=<%=productId%>">다시 작성하기</a>
			</p>
		<%}%>
<!-- 상품을 올리는 페이지입니다 -->
</body>
</html>