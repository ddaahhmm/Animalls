<%@page import="dto.MemberDto"%>
<%@page import="util.SessionManager"%>
<%@page import="util.URLConverter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

MemberDto dto = SessionManager.getMember(request);
String sellerId = dto.getMemberId();
String sellerName = dto.getName();

int nowSellCount = 12;
int unProcessedOrder = 67; 
int unCheckedOrder = 23;
int completedOrder = 100;
int beforeDelivery = 35;
int afterDelivery = 60;
int completedAnswer = 20;
int recentReview = 48;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 마이페이지</title>

<link rel="stylesheet" href="/Animalls/css/common.css" />
<link rel="stylesheet" href="/Animalls/css/bootstrap.css" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
	crossorigin="anonymous">
</script>

</head>
<body class="d-flex flex-column ">
	<jsp:include page="/include/navbar.jsp">
		<jsp:param value="index" name="current" />
	</jsp:include>

    <div class="container flex-grow-1 d-flex my-2 py-4">
    
        <!--  sidebar start -->
        <div id="side-bar" class="flex-shrink-0 p-3 bg-white" style="width: 200px;">
            <a href="#" class="d-flex align-items-center pb-3 mb-3 link-dark text-decoration-none border-bottom">
                <span class="fs-5 fw-semibold">상세메뉴</span>
            </a>
            <ul class="list-unstyled ps-0">
                <li class="mb-1">
                    <div class="align-items-center fw-bold" >
                        상품 관리
                    </div>
                    <div>
                        <ul class="list-unstyled fw-normal pb-1 small">
                            <li><a href="/Animalls/seller/productList.jsp" class="text-decoration-none link-dark rounded">상품 DB</a></li>
                        </ul>
                    </div>
                </li>
                <li class="mb-1">
                    <div class="align-items-center fw-bold" >
                        주문 배송
                    </div>
                    <div>
                        <ul class="list-unstyled fw-normal pb-1 small">
                            <li><a href="/Animalls/seller/productOrderList.jsp" class="text-decoration-none link-dark rounded">주문 관리</a></li>
                            <li><a href="/Animalls/seller/productDeliveryList.jsp" class="text-decoration-none link-dark rounded">배송 확인</a></li>
                        </ul>
                    </div>
                </li>
                <li class="mb-1">
                    <div class="align-items-center fw-bold" >
                        고객 관리
                    </div>
                    <div>
                        <ul class="list-unstyled fw-normal pb-1 small">
                            <li><a href="/Animalls/review/customerReview.jsp" class="text-decoration-none link-dark rounded">리뷰 관리</a></li>
                        </ul>
                    </div>
                </li>
            </ul>
        </div>
        <!--  end of sidebar -->
        
        <div class="vr my-2"></div>
        
        <div class="ms-4  flex-grow-1">
            <h1>판매자 마이페이지</h1>
            <hr />
            
            <!-- top card  -->
            <div class="border d-flex">
                <div class="border-right border-secondary m-2 p-2" style="float: left; text-indent: 85px;">
                    <img width="64"
                        src="${pageContext.request.contextPath}/assets/shop-blocks/2.png"
                        alt="seller-image" />     
                    <img width="18"
                        src="${pageContext.request.contextPath}/assets/bronze-medal.png"
                        alt="seller-image" />
                    <div>
                        <a class="text-decoration-none text-reset" href="">
                            <strong class="text-success"><%=sellerName%></strong>판매자님 안녕하세요.
                        </a>
                    </div>
                </div>
                
                <div class="row row-cols-2" style="margin: auto; text-align: center;">
                    <div class="col">
                        판매중인 상품 <a href="productList.jsp">보기</a>
                    </div>
                    <div class="col">
                        미처리된 주문 <a href="../view_order.jsp">보기</a>
                    </div>
                </div>
            </div>


            <!--  main menu cards  -->
            <div id="main-menu-cards" class="row">
                <div class="d-flex flex-wrap justify-content-between">
                    <div class="border w-full">
    
                        <div class="bg-light p-2" style="text-indent: 6px">
                            <strong class="text-dark">메인 메뉴</strong>
                        </div>
    
                        <div class="d-flex w-full">
                        
                            <div class="flex-grow-1 text-center my-auto">
                                <jsp:include page="/include/components/shopblock.jsp">                            
                                    <jsp:param name="src" value="/Animalls/assets/shop-blocks/9.png" />
                                    <jsp:param name="href" value="#" />
                                    <jsp:param name="title"
                                        value="<%=URLConverter.encode(\"상품 현황\")%>" />
                                    <jsp:param name="subTitle"
                                        value="<%=URLConverter.encode(\"판매자의 상품현황을 조회 할 수 있습니다.\")%>" />
                                    <jsp:param name="description"
                                        value="<%=URLConverter.encode(\"<br> 할인 중인 상품 <a href='productList.jsp'>보기</a> <br>카테고리 별 상품 <a href='productList.jsp'>보기</a>\")%>" />
                                </jsp:include>
                            </div>
                        
    
                            <div class="flex-grow-1 text-center my-auto">
                                <jsp:include page="/include/components/shopblock.jsp">
                                    <jsp:param name="src" value="/Animalls/assets/shop-blocks/9.png" />
                                    <jsp:param name="href" value="#" />
                                    <jsp:param name="title"
                                        value="<%=URLConverter.encode(\"주문 현황\")%>" />
                                    <jsp:param name="subTitle"
                                        value="<%=URLConverter.encode(\"주문목록을 검색 및 조회 할 수 있습니다.\")%>" />
                                    <jsp:param name="description"
                                        value="<%=URLConverter.encode(\"<br>처리완료한 주문 <a href='productOrderList.jsp'>보기</a><br>ㅤ\")%>" />
                                </jsp:include>
                            </div>
    
                            <div class="flex-grow-1 text-center my-auto">
                                <jsp:include page="/include/components/shopblock.jsp">
                                    <jsp:param name="src"
                                        value="/Animalls/assets/shop-blocks/10.png" />
                                    <jsp:param name="href" value="#" />
                                    <jsp:param name="title"
                                        value="<%=URLConverter.encode(\"배송 현황\")%>" />
                                    <jsp:param name="subTitle"
                                        value="<%=URLConverter.encode(\"배송현황을 검색 및 조회 할 수 있습니다.\")%>" />
                                    <jsp:param name="description"
                                        value="<%=URLConverter.encode(\"<br> 배송전,배송지연 주문 <a href='productDeliveryList.jsp'>보기</a> <br>배송완료 주문 <a href='productDeliveryList.jsp'>보기</a> \")%>" />
                                </jsp:include>
                                <a href="#" class="text-decoration-none font-weight-bolder"></a>
                            </div>
    
                            <div class="flex-grow-1 text-center my-auto">
                                <jsp:include page="/include/components/shopblock.jsp">
                                    <jsp:param name="src" value="/Animalls/assets/shop-blocks/7.png" />
                                    <jsp:param name="href" value="#" />
                                    <jsp:param name="title"
                                        value="<%=URLConverter.encode(\"고객 관리\")%>" />
                                    <jsp:param name="subTitle"
                                        value="<%=URLConverter.encode(\"고객님의 최근 리뷰를 볼 수 있습니다.\")%>" />
                                    <jsp:param name="description"
                                        value="<%=URLConverter.encode(\" <br>최근 리뷰 <a href='../customerReview.jsp#scrollspyHeading1'>보기</a><br>ㅤ\")%>" />
                                </jsp:include>
                                <a ="#" class="text-decoration-none font-weight-bolder"></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </div>   
    </div> 
    <!--  container end -->


	
	<jsp:include page="/include/footer.jsp">
		<jsp:param value="index" name="current" />
	</jsp:include>
</body>
</html>