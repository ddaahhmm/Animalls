<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 주문 목록 페이지</title>
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
</head>
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
	 		
			
			<table id="" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
			<thead>
				<tr>
					<th width="7%">주문번호<button>↑</button><button>↓</button></th>
					<th width="6%">우편번호</th>
					<th>주소</th>
					<th>상세주소</th>
					<th width="6%">결제수단</th>
					<th>요청사항</th>
					<th width="8%">주문일자<button>↑</button><button>↓</button></th>
					<th width="9%">상품주문번호</th>
					<th width="6%">옵션번호</th>
					<th width="5%">수량<button>↑</button><button>↓</button></th>
				</tr>
			 </thead>
			 <tbody>
			 	<tr>
					<td>1</td>
					<td>31918</td>
					<td>충청남도 서산시 지곡면 관장골길 57-19</td>
					<td>-</td>
					<td>-</td>
					<td>직접 수령하겠습니다.</td>
					<td>2023-12-20</td>
					<td>4075304892</td>
					<td>1</td>
					<td>2</td>
				</tr>
				<tr>
					<td>2</td>
					<td>34395</td>
					<td>대전광역시 대덕구 한밭대로 1175(중리동)</td>
					<td>-</td>
					<td>-</td>
					<td>배송 전 연락바랍니다.</td>
					<td>2023-12-21</td>
					<td>9567674456</td>
					<td>3</td>
					<td>10</td>
				</tr>
				<tr>
					<td>3</td>
					<td>35271</td>
					<td>대전광역시 서구 계룡로 410-8(갈마동)</td>
					<td>-</td>
					<td>-</td>
					<td>부재시 경비실에 맡겨주세요.</td>
					<td>2023-12-21</td>
					<td>2608325032</td>
					<td>7</td>
					<td>10</td>
				</tr>
				<tr>
					<td>4</td>
					<td>55306</td>
					<td>전라북도 완주군 삼례읍 원신금2길 4</td>
					<td>-</td>
					<td>-</td>
					<td>부재시 문 앞에 놓아주세요.</td>
					<td>2023-12-22</td>
					<td>2109818590</td>
					<td>15</td>
					<td>20</td>
				</tr>
				<tr>
					<td>5</td>
					<td>03121</td>
					<td>서울특별시 종로구 종로54길 9-21(창신동)</td>
					<td>-</td>
					<td>-</td>
					<td>부재 시 택배함에 넣어주세요.</td>
					<td>2023-12-22</td>
					<td>6241241113</td>
					<td>10</td>
					<td>15</td>
				</tr>
				<tr>
					<td>6</td>
					<td>46050</td>
					<td>부산광역시 기장군 철마면 석길길 16-12</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>2023-12-22</td>
					<td>6724890523</td>
					<td>5</td>
					<td>8</td>
				</tr>		
			 </tbody>
			</table>
		</div>
		
		<jsp:include page="/include/footer.jsp">
			<jsp:param value="index" name="current" />
		</jsp:include>
		
		<script>
		
		</script>
</body>
</html>