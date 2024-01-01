<%@page import="util.URLConverter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String sellerId = "gildong1234";
String sellerName = "홍길동";
/* int recentlySell = 2000000; */
/* String unCalculated = "3,000,000"; */
/* int unProcessedClaimCount = 15; */
/* int ongoingEvent = 2; */
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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="/Animalls/css/footer.css" />

<style>
.seller-block {
	height: 200px;
}

.pics { /* 전체 케러셀 */
	width: 600px;
	float: left;
	position: relative;
	left: 50%;
	object-fit: cover;
}

.carousel-inner {
	width: auto;
	height: 250px; /* 이미지 높이 변경 */
}

.carousel-item {
	width: auto;
	height: 100%;
}

.d-block {
	height: 100%;
	border: solid 1px;
	padding: 10px;
	margin-left: 110px;
}

.subUl {
	list-style: none;
}

.upBorder {
	border-top: solid 1px;
	border-right: 0;
	border-bottom: 0;
	border-left: 0;
	vertical-align: middle;
	padding-top: 10px;
}

.cButton {
	height: 100%;
	padding: 10px;
	margin-left: 100px;
}

@media ( max-width : 767px) {
	.carousel-inner .carousel-item>div {
		display: none;
	}
	.carousel-inner .carousel-item>div:first-child {
		display: block;
	}
}

.carousel-inner .carousel-item.active, .carousel-inner .carousel-item-next,
	.carousel-inner .carousel-item-prev {
	display: flex;
}

/* medium and up screens */
@media ( min-width : 768px) {
	.carousel-inner .carousel-item-end.active, .carousel-inner .carousel-item-next
		{
		transform: translateX(25%);
	}
	.carousel-inner .carousel-item-start.active, .carousel-inner .carousel-item-prev
		{
		transform: translateX(-25%);
	}
}

.carousel-inner .carousel-item-end, .carousel-inner .carousel-item-start
	{
	transform: translateX(0);
}

.card-img {
	width: 240px;
	height: 160px;
}

.card-img img {
	width: 150px;
	opacity: 0.8;
}

.card-img-overlay {
	font-weight: 800;
	color: black;
	text-shadow: 10px 10px 10px white;
}

.carousel-control-next,
.carousel-control-prev /*, .carousel-indicators */ {
    filter: invert(100%);
}

.carousel-control-container {
	width: 32px;
	height: 100%;
}
</style>
</head>
<body>
	<jsp:include page="/include/navbar.jsp">
		<jsp:param value="index" name="current" />
	</jsp:include>

	<div class="row d-flex"
		style="float: left; width: 290px; padding-left: 60px; word-break: break-all; display: block; text-align: left;">
		<div class="row my-2"
			style="float: left; width: 290px; word-break: break-all; display: block; text-align: left;">
			상세메뉴</div>
		<br />
		<!-- <div class="border row"
			style="float: left; width: 290px; word-break: break-all; display: inline-block; text-align: left;">
			회원정보
			<ul class="subUl upBorder">
				<li style=""><a href="">정보수정</a></li>
				<li><a href="">탈퇴하기</a></li>
			</ul>
		</div> -->
		<div class="border row"
			style="float: left; width: 290px; word-break: break-all; display: inline-block; text-align: left;">
			상품관리
			<ul class="subUl upBorder">
				<li><a class="text-decoration-none text-reset" href="productList.jsp">상품DB</a></li>
			</ul>
		</div>
		<!-- <div class="border row"
			style="float: left; width: 290px; word-break: break-all; display: inline-block; text-align: left;">
			상점관리
			<ul class="subUl upBorder">
				<li><a href="">상세페이지(예시)</a></li>
				<li><a href="">이벤트/프로모션(예시)</a></li>
			</ul>
		</div> -->
		<div class="border row"
			style="float: left; width: 290px; word-break: break-all; display: inline-block; text-align: left">
			주문배송
			<ul class="subUl upBorder">
				<li><a class="text-decoration-none text-reset" href="productOrderList.jsp">주문관리</a></li>
				<li><a class="text-decoration-none text-reset" href="productDeliveryList.jsp">배송확인</a></li>
			</ul>
		</div>
		<div class="border row"
			style="float: left; width: 290px; word-break: break-all; display: inline-block; text-align: left;">
			고객관리
			<ul class="subUl upBorder">
				<!-- <li><a href="">고객 클레임(예시)</a></li>
				<li><a href="">문의(예시)</a></li> -->
				<li><a class="text-decoration-none text-reset" href="../customerReview.jsp">리뷰</a></li>
				<!-- <li><a href="">단골고객(예시)</a></li>
				<li><a href="">블랙컨슈머(예시)</a></li> -->
			</ul>
		</div>
		<!-- <div class="border row"
			style="float: left; width: 290px; word-break: break-all; text-align: left;">
			판매정산
			<ul class="subUl upBorder">
				<li><a href="">판매정산DB(예시)</a></li>
			</ul>
		</div> -->
	</div>


	<div class="container my-2">
		<h1>판매자 마이페이지</h1>
		<hr />
		<div class="border my-3 d-flex">
			<div class="border-right border-secondary m-2 p-2"
				style="float: left; text-indent: 85px;">
				<img width="64"
					src="${pageContext.request.contextPath}/assets/shop-blocks/2.png"
					alt="seller-image" /> <img width="18"
					src="${pageContext.request.contextPath}/assets/bronze-medal.png"
					alt="seller-image" /><a class="text-decoration-none text-reset" href=""><strong class="text-success">
						<%=sellerName%></strong></a> 판매자님 안녕하세요.<br>
			</div>



			<div class="row row-cols-2" style="margin: auto; text-align: center;">
				<div class="col">
					판매중인 상품 <a href="productList.jsp">보기</a>
				</div>
				<div class="col">
					미처리된 주문 <a href="../view_order.jsp">보기</a>
				</div>
				<%-- <div class="col">
					미처리된 클레임(예시) <a href=""><%=unProcessedClaimCount%></a> 개
				</div>
				<div class="col">
					정산예정 금액(예시) <a href=""><%=unCalculated%></a> 원
				</div> --%>
			</div>
		</div>

		<div class="row">
			<div class="d-flex flex-wrap justify-content-between">
				<div class="border w-full">

					<div class="bg-light p-2" style="text-indent: 6px">
						<strong class="text-dark">메인 메뉴</strong>
					</div>

					<div class="d-flex w-full">
					
						<div class="flex-grow-1 text-center my-auto">
							<jsp:include page="/include/components/shopblock.jsp">
								<jsp:param name="src" value="/Animalls/assets/shop-blocks/9.png" />
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
								<jsp:param name="title"
									value="<%=URLConverter.encode(\"고객 관리\")%>" />
								<jsp:param name="subTitle"
									value="<%=URLConverter.encode(\"고객님의 최근 리뷰를 볼 수 있습니다.\")%>" />
								<jsp:param name="description"
									value="<%=URLConverter.encode(\" <br>최근 리뷰 <a href='../customerReview.jsp#scrollspyHeading1'>보기</a><br>ㅤ\")%>" />
							</jsp:include>
							<a ="#" class="text-decoration-none font-weight-bolder"></a>
						</div>

						<%-- <div class="flex-grow-1 text-center my-auto">
							<jsp:include page="/include/components/shopblock.jsp">
								<jsp:param name="src"
									value="/Animalls/assets/shop-blocks/12.png" />
								<jsp:param name="title"
									value="<%=URLConverter.encode(\"기타(예시)\")%>" />
								<jsp:param name="subTitle"
									value="<%=URLConverter.encode(\"기타 사항들을 관리 할 수 있습니다.\")%>" />
								<jsp:param name="description"
									value="<%=URLConverter.encode(\"<br>진행중인 이벤트/프로모션 2 건 <br><a href='#'>통계</a>\")%>" />
							</jsp:include>

						</div> --%>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container">
		<br /> <strong class="text-success" style="text-indent:-100px"><%=sellerName%></strong>님의 가장 잘팔린
		상품들 <small>(3개월 기준)</small>
	</div>
	<div class="row mx-auto my-auto">
		<div id="recipeCarousel" class="carousel slide d-flex justify-content-center align-items-center" data-bs-ride="carousel">
			
			<!-- 이전 -->
			<a class="position-relative carousel-control-prev bg-transparent w-aut"
				href="#recipeCarousel" role="button" data-bs-slide="prev"> 
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			</a> 
		
			
			<!--  본문 -->	
			<div class="carousel-inner d-flex align-items-center" role="listbox">
				<div class="carousel-item active rows align-items-center">
					<div class="col-md-3">
						<div class="card">
							<div class="card-img d-flex justify-content-center align-items-center">
								<img
									src="${pageContext.request.contextPath}/assets/seller-best/1.png"
									class="img-fluid object-fit-scaledown">
							</div>
							<div class="card-img-overlay">[두근두근 젤리CHU] 젤리츄 연어 2+1</div>
						</div>
					</div>
				</div>
				<div class="carousel-item rows align-items-center">
					<div class="col-md-3">
						<div class="card ">
							<div class="card-img d-flex justify-content-center align-items-center">
								<img
									src="${pageContext.request.contextPath}/assets/seller-best/2.png"
									class="img-fluid object-fit-scaledown">
							</div>
							<div class="card-img-overlay">피부모질 닥터독 사료 2kg</div>
						</div>
					</div>
				</div>
				<div class="carousel-item rows align-items-center">
					<div class="col-md-3">
						<div class="card">
							<div class="card-img d-flex justify-content-center align-items-center">
								<img
									src="${pageContext.request.contextPath}/assets/seller-best/3.png"
									class="img-fluid object-fit-scaledown">
							</div>
							<div class="card-img-overlay">포비타 오렌지(장건강)</div>
						</div>
					</div>
				</div>
				<div class="carousel-item rows align-items-center">
					<div class="col-md-3">
						<div class="card">
							<div class="card-img d-flex justify-content-center align-items-center">
								<img
									src="${pageContext.request.contextPath}/assets/seller-best/4.jpg"
									class="img-fluid object-fit-scaledown">
							</div>
							<div class="card-img-overlay">퐁퐁패딩(베이지)</div>
						</div>
					</div>
				</div>
				<div class="carousel-item rows align-items-center">
					<div class="col-md-3">
						<div class="card">
							<div class="card-img d-flex justify-content-center align-items-center">
								<img
									src="${pageContext.request.contextPath}/assets/seller-best/5.jpg"
									class="img-fluid object-fit-scaledown">
							</div>
							<div class="card-img-overlay">코쿤펫 아기곰 패딩</div>
						</div>
					</div>
				</div>
				<div class="carousel-item rows align-items-center">
					<div class="col-md-3">
						<div class="card">
							<div class="card-img d-flex justify-content-center align-items-center">
								<img
									src="${pageContext.request.contextPath}/assets/seller-best/6.jpg"
									class="img-fluid object-fit-scaledown">
							</div>
							<div class="card-img-overlay">코튼 스트라이프 올인원</div>
						</div>
					</div>
				</div>
				<div class="carousel-item rows align-items-center">
					<div class="col-md-3">
						<div class="card">
							<div class="card-img d-flex justify-content-center align-items-center">
								<img
									src="${pageContext.request.contextPath}/assets/seller-best/7.jpg"
									class="img-fluid object-fit-scaledown">
							</div>
							<div class="card-img-overlay">논슬립 샤워 매트</div>
						</div>
					</div>
				</div>
				<div class="carousel-item rows align-items-center">
					<div class="col-md-3">
						<div class="card">
							<div class="card-img d-flex justify-content-center align-items-center">
								<img
									src="${pageContext.request.contextPath}/assets/seller-best/8.jpg"
									class="img-fluid object-fit-scaledown">
							</div>
							<div class="card-img-overlay">버블 샴푸 독스</div>
						</div>
					</div>
				</div>
				<div class="carousel-item rows align-items-center">
					<div class="col-md-3">
						<div class="card">
							<div class="card-img d-flex justify-content-center align-items-center">
								<img
									src="${pageContext.request.contextPath}/assets/seller-best/9.jpg"
									class="img-fluid object-fit-scaledown">
							</div>
							<div class="card-img-overlay">스펀지 타월 S</div>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 다음 -->			
			<a class="position-relative carousel-control-next bg-transparent w-aut"
				href="#recipeCarousel" role="button" data-bs-slide="next"> 
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
			</a>
		
		</div>
	</div>
	<!--  end of container -->
	
	


	<jsp:include page="/include/footer.jsp">
		<jsp:param value="index" name="current" />
	</jsp:include>

	<script>
		let items = document.querySelectorAll('.carousel .carousel-item')
	
		items.forEach((el) => {
		    const minPerSlide = 4
		    let next = el.nextElementSibling
		    for (var i=1; i<minPerSlide; i++) {
		        if (!next) {
		            // wrap carousel by using first child
		        	next = items[0]
		      	}
		        let cloneChild = next.cloneNode(true)
		        el.appendChild(cloneChild.children[0])
		        next = next.nextElementSibling
		    }
		})
	</script>
</body>
</html>