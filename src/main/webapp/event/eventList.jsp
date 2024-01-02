<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	int totalEventCount = 8; 
	String sampleName = "샘플 이벤트 제목";
    String category = request.getParameter("category");
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
<body class="d-flex flex-column"> 
	<jsp:include page="/include/navbar.jsp">
		<jsp:param value="event" name="current"/>
	</jsp:include>

	<div class="container py-4 flex-grow-1">
		<h1 class="my-4 fw-bold">이벤트</h1>
		
    	<div class="category"> 
			<ul class="menuCategory nav nav-tabs" >
                <li class="nav-item"><a class="nav-link <%= !"end".equals(category) ? "active" : " " %>" href="${pageContext.request.contextPath}/event/eventList.jsp">진행중인 이벤트</a></li>
				<li class="nav-item"><a class="nav-link <%= "end".equals(category) ? "active" : " " %>" href="${pageContext.request.contextPath}/event/eventList.jsp?category=end">종료된 이벤트</a></li>
				
			</ul>
    	</div>

		<div class="row my-4 g-0">		
			<% for (int i = 1 ; i <= totalEventCount; i++) { %>
				<div class="col pr-4 pb-3" style="max-width: 440px;">
					<a href="eventDetail.jsp" class="text-decoration-none">
						<img src="/Animalls/assets/event/<%=i %>.png" alt="" />	
					</a>
					
					<div>
						<div class="fs-5 fw-bold"><a href="eventDetail.jsp" class="text-reset text-decoration-none"><%= sampleName %></a></div>
						<div class="text-secondary">2022-01-01</div>
					</div>	
				</div>
			
			<%} %>
		</div>
	</div>

	
	<jsp:include page="/include/footer.jsp">
		<jsp:param value="event" name="current"/>
	</jsp:include>
	
</body>
</html>