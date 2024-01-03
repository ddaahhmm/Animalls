<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 배송 목록 페이지</title>
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
	th, td {
  		 text-align: center;
  		 vertical-align: middle;
	}
	#sort1{
		 padding: 10px;
	}
	.bar{
		color:#e2e2e2;
	}
	
	button:not(.btnSearch){
		border:none;
		padding: 1px;
		background:none;
		width:5px;
	}
	
	.btnSearch{
		border:none;
		margin-left:5px;
	}
	.btn{
		font-size:13px;
	}
	.date{
		vertical-align: middle;
	}
	
</style>
</head>
<body>

	<jsp:include page="/include/navbar.jsp">
		<jsp:param value="index" name="current" />
	</jsp:include>
	
	<div class="container my-3 head p-3 border">
		<h3>배송현황</h3>
		<hr />

		<div id="sort1" class="topMenu flex justify-content-start border">
			<input class="date" type="date" />
				<span>~</span>
			<input class="date" type="date" />
			
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio1">1일</label>
			
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio2">3일</label>
			
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio3" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio3">1주일</label>
			  
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio4" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio4">1개월</label>
					
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio5" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio5">3개월</label>
					
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio6" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio6">6개월</label>
			  
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio7" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio7">1년</label>
			  
			  	<div style="position: absolute; right: -600px;">
					<input type="search" /><button class="btnSearch" type="submit">검색</button>
				</div>
			</div>
		 </div>	
		 <br />
		 <table id="" class="table table-striped table-bordered table-sm" style="table-layout:fixed" cellspacing="0" width="100%">
			<thead>
				<tr>
					<th width="7%">배송번호<button>↑</button><button>↓</button></th>
					<th width="15%">상품이름</th>
					<th width="6%">보내는분</th>
					<th width="5%">받는분</th>
					<th width="5%">이미지</th>
					<th>상품정보</th>
					<th width="5%">수량<button>↑</button><button>↓</button></th>
					<th width="10%">상품구매금액<button>↑</button><button>↓</button></th>
					<th width="8%">
						<select>
							<option value="" selected disabled hidden>배송상태</option>
							<option value="">준비중</option>
							<option value="">배송완료</option>
							<option value="">배송지연</option>
							<option value="">반품</option>
							<option value="">교환</option> 
						</select>
					</th>
					<th width="10%">배송시작일자<button>↑</button><button>↓</button></th>
					<th width="10%">배송완료일자<button>↑</button><button>↓</button></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>1</td>
					<td>버블 샴푸 독스</td>
					<td>홍길동1</td>
					<td>길동1</td>
					<td>-</td>
					<td>EWG 그린 등급으로 이루어진 저자극 천연 샴푸 버블 샴푸</td>
					<td>30</td>
					<td>50,000 원</td>
					<td>상품준비중</td>
					<td>-</td>
					<td>-</td>
				</tr>	
				<tr>
					<td>2</td>
					<td>닥터독 그레인프리 참치 사료 1.6kg</td>
					<td>홍길동2</td>
					<td>길동2</td>
					<td>-</td>
					<td>알레르기 도움을 위한 최적 레시피</td>
					<td>25</td>
					<td>40,000 원</td>
					<td>배송완료</td>
					<td>23/12/03</td>
					<td>23/12/05</td>
				</tr>
				<tr>
					<td>3</td>
					<td>멍바오 방한 점퍼 2color</td>
					<td>홍길동3</td>
					<td>길동3</td>
					<td>-</td>
					<td>양면 보아 원단으로 가볍고 보온성이 뛰어난 방한 점퍼</td>
					<td>37</td>
					<td>80,000 원</td>
					<td>배송지연</td>
					<td>23/12/06</td>
					<td>23/12/08</td>
				</tr>
				<tr>
					<td>4</td>
					<td>버블 샴푸 독스</td>
					<td>홍길동4</td>
					<td>길동4</td>
					<td>-</td>
					<td>EWG 그린 등급으로 이루어진 저자극 천연 샴푸 버블 샴푸</td>
					<td>10</td>
					<td>200,000 원</td>
					<td>반품</td>
					<td>23/12/07</td>
					<td>23/12/09</td>
				</tr>
				<tr>
					<td>5</td>
					<td>닥터독 그레인프리 참치 사료 1.6kg</td>
					<td>홍길동5</td>
					<td>길동5</td>
					<td>-</td>
					<td>알레르기 도움을 위한 최적 레시피</td>
					<td>5</td>
					<td>500,000 원</td>
					<td>교환</td>
					<td>23/12/08</td>
					<td>23/12/10</td>
				</tr>
			</tbody>
		</table>
 		</div> 
 		<br />
 		
		
	
	<jsp:include page="/include/footer.jsp">
		<jsp:param value="index" name="current" />
	</jsp:include>
	
	<script>
	
	</script>	
	
</body>
</html>