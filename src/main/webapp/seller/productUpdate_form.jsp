<%@page import="dao.ProductDao"%>
<%@page import="dto.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int productId=Integer.parseInt(request.getParameter("productId"));
	ProductDto dto=ProductDao.getInstance().getData(productId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 상품 수정 페이지</title>
</head>
<body>
	<div class="container">
		<h3>판매자 상품 수정</h3>
		<form action="${pageContext.request.contextPath}/seller/productUpdate.jsp" method="post">
			<div>
				<label for="product_id">상품번호</label>
				<input type="text" id="productId" name="productId" value="<%=dto.getProductId()%>" readonly/>
				<br />
			</div>
			<div>
				<label for="thumbnail">이미지</label>
				<br />
			</div>
			<div>
				<label for="title">상품명 : </label> 
				<input type="text" id="title" name="title" value="<%=dto.getTitle()%>"/>
				<br />
			</div>
			<div>
				<label for="category">카테고리 : </label>  
					<select id="category" name="category" value="<%=dto.getCategory()%>">
						<option value="food">음식</option>
						<option value="clothes">옷</option>
						<option value="bath">목욕용품</option>
					</select>
				<br />
			</div>
			<div>
				<label for="org_price">판매가 : </label> 
				<input type="text" id="orgPrice" name="orgPrice" value="<%=dto.getOrgPrice()%>">
				<br />
			</div>
			<div>
				<label for="salePrice">할인가격 : </label> 
				<input type="text" id="salePrice" name="salePrice" value="<%=dto.getSalePrice()%>">
				<br />
			</div>
			<div>
				<label for="salesState">상품상태 : </label>
					<select id="salesState" name="salesState" value="<%=dto.getSalesState()%>">
						<option value="onSale">판매중</option>
						<option value="soldOut">품절</option>
						<option value="salesEnd">판매종료</option>
					</select>
				<br />
				<br />
			</div>
			<div>
				<label for="description">비고 : </label> 
				<textarea id="description" name="description" value="<%=dto.getDescription()%>" cols="20" rows="5" 
				 style="resize: none; vertical-align:middle;"/></textarea>
				<button type="submit" style="vertical-align:bottom">수정하기</button>
				<button type="reset" style="vertical-align:bottom">취소</button>
			</div>
		</form>
	</div>
</body>
</html>