<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	String eventTitle = "두근 두근 젤리츄 2 + 1 EVENT";
	String eventDate = "2022-01-01";
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 페이지</title>
<link href="/Animalls/css/common.css" rel="stylesheet" />
<link href="/Animalls/css/bootstrap.css" rel="stylesheet" >
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</head>
<body>
	<jsp:include page="/include/navbar.jsp">
		<jsp:param value="event" name="current"/>
	</jsp:include>

	<div class="container p-4">
		<h1 class="my-4 fw-bold">이벤트</h1>
		
		<div>
			<div class="d-flex justify-content-between align-items-end">
				<div class="fs-3 fw-bold"><%= eventTitle %></div>
				<div class="text-secondary"><%= eventDate %></div>
			</div>
			
			<hr/>
						
			<div id="event-detail-content" class="d-flex justify-content-center">
				<img src="/Animalls/assets/event/content1.jpg" alt="content-img" />
			</div>
			
			<hr  class="my-5"/>
			
			<div class="d-flex justify-content-center">
				<a href="eventList.jsp" class="btn border px-4 py-3 my-4">
					전체 목록 보기
				</a>	
			</div>
			
		</div>
		.
	</div>
	
	<jsp:include page="/include/footer.jsp">
		<jsp:param value="event" name="current"/>
	</jsp:include>
</body>
</html>