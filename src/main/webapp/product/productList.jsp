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
<link rel="stylesheet" href="/Animalls/css/bootstrap.css"/>
<link rel="stylesheet" href="/Animalls/css/common.css" />
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
    width: 320px;
    box-sizing: border-box;
    padding: 10px;
  }

    .thumbnail {
        position: relative; 
    }
    
    .icon-area {
        position: absolute; 
  
        bottom: 0px;
        height: 60px;
        width: 100%;
        background-color: #ff9164;
    }
    .icon-area .shopping-bascket {
        background-image: url('/Animalls/assets/shopping-bascket.png');
        box-sizing: border-box;
        width: 48px;
        height: 48px;  
    }
    .icon-area .shopping-heart {
        background-image: url('/Animalls/assets/heart.png');
        box-sizing: border-box;
        width: 48px;
        height: 48px; 
    }
</style>
</head>
<body class="d-flex flex-column">
	<jsp:include page="/include/navbar.jsp"></jsp:include>
    
    <div class="container flex-grow-1 pb-5">
        <h1 class="my-4">상품 목록</h1>
        
    	<div class="category"> 
			<ul class="menuCategory nav nav-tabs" >
                <li class="nav-item"><a class="nav-link <%= !"food".equals(category) && !"clothes".equals(category) && !"bath".equals(category) ? "active" : " " %>" href="${pageContext.request.contextPath}/product/productList.jsp">전체 보기</a></li>
				<li class="nav-item"><a class="nav-link <%= "food".equals(category) ? "active" : " " %>" href="${pageContext.request.contextPath}/product/productList.jsp?category=food">애견 사료 및 간식</a></li>
				<li class="nav-item"><a class="nav-link <%= "clothes".equals(category) ? "active" : " " %>" href="${pageContext.request.contextPath}/product/productList.jsp?category=clothes">애견 패션 의류</a></li>
				<li class="nav-item"><a class="nav-link <%= "bath".equals(category) ? "active" : " " %>" href="${pageContext.request.contextPath}/product/productList.jsp?category=bath">애견 욕실 용품</a></li>
			</ul>
    	</div>
        
    	<div class="product">
    			<ul class="prdList">
    				<%for(ProductDto tmp:list){%>
    							<li>
    								<div class="thumbnail">
    									<div class="icon-area d-none">
    									   <i class="shopping-bascket"></i>
                                           <i class="shopping-heart" ></i>
    									</div>
                                        
    									<div class="prdImg">
    									<a href="${pageContext.request.contextPath}/product/productDetail.jsp?productId=<%=tmp.getProductId()%>">
    										<img src="<%=tmp.getThumbnail() %>" width="304px" height="353px"/>
    									</a>
    									</div>
    								</div>
    								<div class="description">
                                        <div>
                                            <a class="py-3 text-reset text-decoration-none" href="${pageContext.request.contextPath}/product/productDetail.jsp?productId=<%=tmp.getProductId()%>"><%=tmp.getTitle() %></a>    
                                        </div>
    								 	
    								 	<div class="price d-flex align-items-end">
    								 		<%if(tmp.getSalePrice() != 0) {%>
    									 		<div class="fw-bold" style="font-size: 27px;"><%= String.format("%,d", tmp.getSalePrice()) %></div>
    									 		<div class="px-2" style="font-size: 15px; color: #999999;"><del><%= String.format("%,d", tmp.getOrgPrice()) %></del></div>
    								 		<%}else{ %>
    								 			<div class="fw-bold" style="font-size: 27px;"><%= String.format("%,d", tmp.getOrgPrice()) %></div>
    								 		<%} %>
    								 	</div>
    								</div>	
    							</li>
    				<%} %>
    			</ul>
    	</div>
    </div>
    <jsp:include page="/include/footer.jsp"></jsp:include>
    
    <script>
    	document.querySelector('.thumbnail').forEach(elem => {
    		elem.addEventListener('mouseover', () => {
    			
    		});
    	});
    </script>
</body>
</html>