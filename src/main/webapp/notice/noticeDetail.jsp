<%@page import="dto.NoticeItemDto"%>
<%@page import="dao.NoticeItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	String strId = request.getParameter("id");
	int numId = -1; 
	
	try {
		numId = Integer.parseInt(strId); 	
	} catch(Exception e) {
		response.sendError(404);
		return;
	}
	NoticeItemDto dto = NoticeItemDao.getInstance().getOne(numId);
	
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</head>
<body>
	<jsp:include page="/include/navbar.jsp">
		<jsp:param value="notice" name="current"/>
	</jsp:include>
	
	<div class="container my-4">
		<h1>
			공지사항			
		</h1>
		<hr />
		<h3 class="my-4"><%= dto.getNoticeTitle() %></h3>
		<div class="d-flex justify-content-between">
			<div>
				<strong><%= dto.getWriterId() %></strong>
			</div>
			<div class="text-secondary"><em><%= dto.getCreatedAt() %></em></div>
		</div>
		<div class="text-break w-100 my-3 p-4 border rounded" style="min-height: 500px;">
			<%= dto.getNoticeContent() %>
		</div>
	</div>
	
	<div class="d-flex justify-content-center py-3">
		<a class="btn border text-decoration-none text-reset my-4" href="noticeList.jsp">
			목록 보기
		</a>
		
	</div>	
	
	<jsp:include page="/include/footer.jsp">
		<jsp:param value="notice" name="current"/>
	</jsp:include>
</body>
</html>