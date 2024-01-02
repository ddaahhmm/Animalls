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
		list = list.stream().filter(c->c.getCategory().equals(category)).collect(Collectors.toList());
	}
	
	int count = list.size();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>product/productList.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<style>
	
  .nonSpace{
  text-align:center;
  	margin-bottom: 100px;
  }
  
 .menuCategory {
    font-size: 0;
    line-height: 0;
}

.menuCategory > li {
    display: inline-block;
    font-size: 12px;
    line-height: 14px;
    vertical-align: top;
    margin-right: 10px;
    margin-bottom: 10px;
}

.menuCategory > li:last-child {
    margin-right: 0;
}

.menuCategory > li > a {
    display: inline-block;
    height: 50px;
    line-height: 50px;
    padding: 0 40px;
    font-family: 'AppleGothic-R';
    font-size: 18px;
    letter-spacing: -0.025em;
    border-radius: 25px;
    background: #f4f4f1;
}


.menuCategory > li.selected > a {
    font-family: 'AppleGothic-B';
    color: #fff;
    background: #ff753f;
}


	.prdCount{
		display:block;
		margin-block-start:1em;
		margin-block-end:1em;
		margin-inline-start:0px;
		margin-inline-end:0px;
		font-size:16px;
		font-family:'AppleGothic-R';
		color:#aaaba6;
	}
	
	.option-list{
	height:24px;
	border: none;
	}
	
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
  

  .description{
  margin: auto;
  padding:0;
  font-size:12px;
  line-height:18px;
  text-align:left;
  }
  
  .price {
  	list-style:none;
  	padding:0;
  	margin:0;
  

  }
  
  #salePrice{
  	font-size:20px;
  	color:#353132;
  	margin-right:20px;
  	display:inline-block;
  }
  
  #orgPrice{
  font-size:16px;
  color:#aaaba6;
  margin-right:10px;
  	display:inline-block;
  }
  
  #nonSalePrice{
  	font-size:20px;
  	color:#353132;
  	margin-right:10px;
  	display:inline-block;
  }
  
	.name{
		font-size:16px;
		color:#353132;
		
	}
	
	a{
	color:#000;
	text-decoration:none;
	}
</style>
</head>
<body>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
<%--카테고리 구분, 카테고리페이지 *3 --%>
<%--(++)총 개수 표시, 정렬 --%>
<div class="container">
	<div class="category">
			<div class="nonSpace">
				<span></span>
			</div>
			<ul class="menuCategory">
				<li><a href="${pageContext.request.contextPath}/product/productList.jsp?category=food">사료</a></li>
				<li><a href="${pageContext.request.contextPath}/product/productList.jsp?category=clothes">의류</a></li>
				<li><a href="${pageContext.request.contextPath}/product/productList.jsp?category=bath">목욕</a></li>
			</ul>
	</div>
	<div class="d-flex justify-content-between">
				<p class="prdCount">총 <strong><%= count %></strong>개 상품</p>
				
				<select name="option-list" id="option-list">
					<option value="new">신상품</option>
					<option value="title">상품명</option>
					<option value="low-price">낮은가격순</option>
					<option value="high-price">높은가격순</option>
					<option value="rating">별점높은순</option>
				</select>
			</div>
	
	<div class="product">
		
			<ul class="prdList">
				<%for(ProductDto tmp:list){%>
							<li>
								<div class=thumbnail style="max-width: 320px;">
									
									<div class="prdImg">
									<a href="${pageContext.request.contextPath}/product/productDetail.jsp?productId=<%=tmp.getProductId()%>">
										<img src="<%=tmp.getThumbnail() %>" width="300px" height="300px"/>
									</a>
									</div>
								</div>
								<div class="description">
								
								 	<span class="name">
								 		<a href="${pageContext.request.contextPath}/product/productDetail.jsp?productId=<%=tmp.getProductId()%>"><%=tmp.getTitle() %></a>
								 	</span>
								 	<ul class="price d-flex align-items-end">
								 		<%if(tmp.getSalesState().equals("on_sale")) {%>
									 		<li class=" fs-3 fw-bold my-0" id="salePrice" ><%=tmp.getSalePrice()%></li>
									 		<li class="fs-6 text-secondary text-decoration-line-through my-0 px-2" id="orgPrice"><del><%=tmp.getOrgPrice() %></del></li>
								 		<%}else{ %>
								 			<li class="fs-3 fw-bold my-0" id="nonSalePrice"><%=tmp.getOrgPrice() %></li>
								 		<%} %>
								 	</ul>
								</div>	
							</li>
				<%} %>
			</ul>
	</div>
</div>
	<script>
	const numberWithCommas  = (x) => {
		   return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}

	</script>

<jsp:include page="/include/footer.jsp"></jsp:include>
</body>
</html>