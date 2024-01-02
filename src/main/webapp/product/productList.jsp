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
<link rel="stylesheet" href="/Animalls/css/bootstrap.css"/>
<link rel="stylesheet" href="/Animalls/css/common.css" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

<style>
.nonSpace{
  	margin-bottom:100px;
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

.menuCategory > li > a:hover {
}

.menuCategory > li.selected > a {
    font-family: 'AppleGothic-B';
    color: #fff;
    background: #ff753f;
}

.menuCategory > li .count {
    font-weight: normal;
}

.menuCategory > li > ul {
    padding: 6px 0 0 0;
}

.menuCategory > li > ul > li {
    margin: 8px 0 0 0;
    line-height: 14px;
}

.menuCategory > li > ul > li > a {
    color: #575a63;
}



 .menuCategory > li > ul > li > .button {
    display: inline-block;
    position: relative;
    width: 9px;
    height: 14px;
    margin: 1px 0 0 3px;
    vertical-align: top;
}
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
        <div class="nonSpace"><span></span></div>
        
    	<div class="category"> 
			<ul class="menuCategory" >
                <li class="nav-item"><a class="nav-link <%= !"food".equals(category) && !"clothes".equals(category) && !"bath".equals(category) ? "active" : " " %>" href="${pageContext.request.contextPath}/product/productList.jsp">전체 보기</a></li>
				<li class="nav-item"><a class="nav-link <%= "food".equals(category) ? "active" : " " %>" href="${pageContext.request.contextPath}/product/productList.jsp?category=food">사료</a></li>
				<li class="nav-item"><a class="nav-link <%= "clothes".equals(category) ? "active" : " " %>" href="${pageContext.request.contextPath}/product/productList.jsp?category=clothes">의류</a></li>
				<li class="nav-item"><a class="nav-link <%= "bath".equals(category) ? "active" : " " %>" href="${pageContext.request.contextPath}/product/productList.jsp?category=bath">욕실용품</a></li>
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