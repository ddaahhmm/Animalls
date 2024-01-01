<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@page import="java.util.List"%>
<%@page import="dao.NoticeItemDao"%>
<%@page import="dto.NoticeItemDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	final int PAGE_GROUP_SIZE = 5; 
	final int PAGINATION_COUNT = NoticeItemDao.getPaginationCount();


	
	String strPage = request.getParameter("page"); 
	int numPage = 1;
	
	int totalPost = NoticeItemDao.getInstance().getTotalPostCount();
	int lastPostPage = (totalPost + PAGINATION_COUNT - 1) / PAGINATION_COUNT;
	int lastPostPageGroup = (lastPostPage + PAGE_GROUP_SIZE - 1) / PAGE_GROUP_SIZE;
	
	try {
		int tmpNumPage= Integer.parseInt(strPage);
		if (tmpNumPage <= 0 || tmpNumPage > lastPostPage) {
			throw new AssertionError("invalid page number");
		}
		numPage = tmpNumPage;
	}catch(Exception e) {
	}
	
	List<NoticeItemDto> noticeItems = NoticeItemDao.getInstance().getList(numPage);
	int currentPageGroup = (numPage + PAGE_GROUP_SIZE - 1) / PAGE_GROUP_SIZE; 
	
	int pageGroupStart = (currentPageGroup - 1) * PAGE_GROUP_SIZE + 1;
	int pageGroupEnd = Math.min(pageGroupStart + PAGE_GROUP_SIZE - 1, lastPostPage);
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
		<h1>공지사항</h1>
		<div class="my-4">
			<table class="table">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
				<%for (NoticeItemDto item : noticeItems) {%>
					<tr>
						<td><%= item.getNoticeItemId() %></td>
						<td>
							<a class="text-reset text-decoration-none" href="noticeDetail.jsp?id=<%= item.getNoticeItemId() %>">
								<%= item.getNoticeTitle() %>
							</a>
						</td>
						<td><%= item.getCreatedAt() %></td>
					</tr>
				<%} %>
				</tbody>
			</table>
		</div>
		
		<nav aria-label="page navigator">
		  <ul class="pagination justify-content-center">
		    <li class="page-item <%= currentPageGroup == 1 ? "disabled" : "" %>">
		      <a class="page-link" href="noticeList.jsp?page=<%= pageGroupStart - 1 %>"  tabindex="-1">Previous</a>
		    </li>
		    
		    <% for (int i = pageGroupStart; i <= pageGroupEnd; i++) { %>
		    	<li class="page-item <%= numPage == i ? "active" : ""%>">
		    		<a class="page-link" href="noticeList.jsp?page=<%= i %>"><%= i %></a>
		    	</li>
		    <% } %>

		    <li class="page-item <%= currentPageGroup == lastPostPageGroup ? "disabled" : "" %>">
		      <a class="page-link" href="noticeList.jsp?page=<%= pageGroupEnd + 1 %>">Next</a>
		    </li>
		  </ul>
		</nav>
	</div>
	<jsp:include page="/include/footer.jsp">
		<jsp:param value="notice" name="current"/>
	</jsp:include>
</body>
</html>