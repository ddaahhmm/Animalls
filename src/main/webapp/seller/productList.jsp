<%@page import="dao.ProductDao"%>
<%@page import="dto.ProductDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.UserDao"%>
<%@page import="dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<ProductDto> list = ProductDao.getInstance().getList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/seller/productList.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

</head>
<body>
	<jsp:include page="/include/navbar.jsp">
		<jsp:param value="seller" name="current"/>
	</jsp:include>
	<div class="container">
		<h1>판매자 상품 리스트</h1>
		<a href="productUpload_form.jsp">상품 추가</a>
		<table class="table">
			<thead>
				<tr>
					<th>상품번호</th>
					<th>이미지</th>
					<th>상품명</th>
					<th>카테고리</th>
					<th>판매가</th>
					<th>할인가격</th>
					<th>상품상태</th>
					<th>비고</th>
				</tr>
			</thead>
			<tbody>
			<%for(ProductDto tmp:list){ %>
				<tr>
					<td><%=tmp.getProductId() %></td>
					<td><%=tmp.getThumbnail() %></td>
					<td><%=tmp.getTitle() %></td>
					<td><%=tmp.getCategory() %></td>
					<td><%=tmp.getOrgPrice() %></td>
					<td><%=tmp.getSalePrice() %></td>
					<td><%=tmp.getSalesState() %></td>
					<td><%=tmp.getDescription() %></td>
					<td><a class="text-decoration-none" href="updateform.jsp?productId=<%=tmp.getProductId()%>">수정</a></td>
					<td>
						<form action="productDelete.jsp" method="post">
							<input type="hidden" name="productId" value="<%=tmp.getProductId()%>"/>
						</form>
					</td>
				</tr>
			<%} %>
			</tbody>
		</table>
		<button type="submit">수정</button>
		<button type="submit">삭제</button>
	</div>
	<jsp:include page="/include/footer.jsp">
		<jsp:param value="seller" name="current"/>
	</jsp:include>
</body>
</html>