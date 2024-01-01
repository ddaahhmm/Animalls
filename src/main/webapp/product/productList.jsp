<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.List"%>
<%@page import="dao.ProductDao"%>
<%@page import="dto.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<ProductDto> list = ProductDao.getInstance().getList();
	
	
	String category = request.getParameter("category");
	if(category!=null){
		list = list.stream().filter(c->category.equals(c.getCategory())).collect(Collectors.toList());
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>product/productList.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<style>
  .prdList {
    list-style: none;
    padding: 0;
    margin: 0;
    display: flex;
    flex-wrap: wrap;
  }

  .prdList li {
    width: 25%; /* Each item takes up 25% of the container width */
    box-sizing: border-box;
    padding: 10px;
  }

</style>
</head>
<body>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
<%--카테고리 구분, 카테고리페이지 *3 --%>
<%--(++)총 개수 표시, 정렬 --%>
<div class="container">
	<div class="category">
		<h3>Category</h3>
			<ul class="menuCategory">
				<li><a href="${pageContext.request.contextPath}/product/productList.jsp?category=food">food</a></li>
				<li><a href="${pageContext.request.contextPath}/product/productList.jsp?category=clothes">clothes</a></li>
				<li><a href="${pageContext.request.contextPath}/product/productList.jsp?category=bath">bath</a></li>
			</ul>
	</div>
	<div class="product">
		<h3>Product</h3>
			<ul class="prdList">
				<%for(ProductDto tmp:list){%>
							<li>
								<div class=thumbnail>
									<div class="icon_area">
									<span><a href="">장바구니</a></span>
									</div>
									<div class="prdImg">
									<a href="${pageContext.request.contextPath}/product/productDetail.jsp?productId=<%=tmp.getProductId()%>">
										<img src="<%=tmp.getThumbnail() %>" width="100px" height="150px"/>
									</a>
									</div>
								</div>
								<div class="description">
								 	<strong class="name">
								 		<a href="${pageContext.request.contextPath}/product/productDetail.jsp?productId=<%=tmp.getProductId()%>"><%=tmp.getTitle() %></a>
								 	</strong>
								 	<ul class="price">
								 		<%if(tmp.getSalesState().equals("on_sale")) {%>
									 		<li><%=tmp.getSalePrice() %></li>
									 		<li><%=tmp.getOrgPrice() %></li>
								 		<%}else{ %>
								 			<li><%=tmp.getOrgPrice() %></li>
								 		<%} %>
								 	</ul>
								</div>	
							</li>
				<%} %>
			</ul>
	</div>
</div>
<jsp:include page="/include/footer.jsp"></jsp:include>
</body>
</html>