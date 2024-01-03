<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/protected/view_order.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/Animalls/css/view_order.css" />
</head>
<body>
	<jsp:include page="/include/navbar.jsp">
		<jsp:param value="view_order" name="current"/>
	</jsp:include>
	
	<div class="container contain">
		<h4>주문조회</h4>
		<hr />
		<ul class="topMenu flex justify-content-start border">
			<li class="border-end me1 active"><a class="cset1">주문내역조회</a></li>
			<li class="border-end me2"><a class="cset2">취소/반품/교환 내역</a></li>
			<li class="border-end me3"><a class="cset3">과거주문내역</a></li>
		</ul>
		
		<div id="set1" class="mt-2">
			<div class="head p-3 border">
				<select name="" id="" class="float-start">
					<option value="입금전">입금전</option>
					<option value="입금후">입금후</option>
				</select>
				<span class="stick">|</span>
				<ul class="dateSelect flex list-unstyled p-0 justify-content-flex-start border border-light-subtle">
					<li class="border-end">오늘</li>
					<li class="border-end">1주일</li>
					<li class="border-end">1개월</li>
					<li class="border-end">3개월</li>
					<li>6개월</li>
				</ul>
				<span class="stick">|</span>
				<input type="date" />
				<span>~</span>
				<input type="date" />
			</div>
			
			<div class="content">
				<table class="table">
					<colgroup>
						<col width="10%"/>
						<col width="10%"/>
						<col width="30%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
					</colgroup>
					<thead class="thead-light">
						<tr>
							<th>주문일자</th>
							<th>이미지</th>
							<th>상품정보</th>
							<th>수량</th>
							<th>상품구매금액</th>
							<th>주문처리상태</th>
							<th>취소/교환/반품</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>1</td>
							<td>얍</td>
							<td>얍얍얍얍</td>
							<td>38개</td>
							<td>37,800원</td>
							<td>배송중</td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		<div id="set2" class="mt-2">
			<div class="head p-3 border">
				<select name="" id="" class="float-start">
					<option value="입금전">입금전</option>
					<option value="입금후">입금후</option>
				</select>
				<span class="stick">|</span>
				<ul class="dateSelect flex list-unstyled p-0 justify-content-flex-start border border-light-subtle">
					<li class="border-end">오늘</li>
					<li class="border-end">1주일</li>
					<li class="border-end">1개월</li>
					<li class="border-end">3개월</li>
					<li>6개월</li>
				</ul>
				<span class="stick">|</span>
				<input type="date" />
				<span>~</span>
				<input type="date" />
			</div>
			
			<div class="content">
				<table class="table">
					<colgroup>
						<col width="10%"/>
						<col width="10%"/>
						<col width="30%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
					</colgroup>
					<thead class="thead-light">
						<tr>
							<th>주문일자</th>
							<th>이미지</th>
							<th>상품정보</th>
							<th>수량</th>
							<th>상품구매금액</th>
							<th>주문처리상태</th>
							<th>취소/교환/반품</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>2</td>
							<td>얍dididid</td>
							<td>얍얍얍얍</td>
							<td>38개</td>
							<td>37,800원</td>
							<td>배송중</td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		<div id="set3" class="mt-2">
			<div class="head p-3 border">
				<select name="" id="" class="float-start">
					<option value="입금전">입금전</option>
					<option value="입금후">입금후</option>
				</select>
				<span class="stick">|</span>
				<ul class="dateSelect flex list-unstyled p-0 justify-content-flex-start border border-light-subtle">
					<li class="border-end">오늘</li>
					<li class="border-end">1주일</li>
					<li class="border-end">1개월</li>
					<li class="border-end">3개월</li>
					<li>6개월</li>
				</ul>
				<span class="stick">|</span>
				<input type="date" />
				<span>~</span>
				<input type="date" />
			</div>
			
			<div class="content">
				<table class="table">
					<colgroup>
						<col width="10%"/>
						<col width="10%"/>
						<col width="30%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
					</colgroup>
					<thead class="thead-light">
						<tr>
							<th>주문일자</th>
							<th>이미지</th>
							<th>상품정보</th>
							<th>수량</th>
							<th>상품구매금액</th>
							<th>주문처리상태</th>
							<th>취소/교환/반품</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>3</td>
							<td>얍</td>
							<td>얍wefewfwefewfew얍</td>
							<td>38개</td>
							<td>37,800원</td>
							<td>배송중</td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<script>
		document.querySelector(".cset1").addEventListener("click",()=>{
			document.querySelector(".me1").classList.add("active");
			document.querySelector(".me2").classList.remove("active");
			document.querySelector(".me3").classList.remove("active");
			document.querySelector("#set1").style.display="block";
			document.querySelector("#set2").style.display = "none";
			document.querySelector("#set3").style.display = "none";
		});
		
		document.querySelector(".cset2").addEventListener("click",()=>{
			document.querySelector(".me2").classList.add("active");
			document.querySelector(".me1").classList.remove("active");
			document.querySelector(".me3").classList.remove("active");
			document.querySelector("#set2").style.display="block";
			document.querySelector("#set1").style.display = "none";
			document.querySelector("#set3").style.display = "none";
		});
		
		document.querySelector(".cset3").addEventListener("click",()=>{
			document.querySelector(".me3").classList.add("active");
			document.querySelector(".me1").classList.remove("active");
			document.querySelector(".me2").classList.remove("active");
			document.querySelector("#set3").style.display="block";
			document.querySelector("#set1").style.display = "none";
			document.querySelector("#set2").style.display = "none";
		});
	</script>
	
	<jsp:include page="/include/footer.jsp">
		<jsp:param value="view_order" name="current"/>
	</jsp:include>
</body>
</html>