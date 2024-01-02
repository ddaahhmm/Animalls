<%@page import="util.SessionManager"%>
<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	//어느 페이지에 포함되었는지 정보를 얻어오기
	String currentPage = request.getParameter("current");

	//아이디 값
	MemberDto dto = SessionManager.getMember(request);
   
	String profile = "b0.png";
%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>

<header class="p-3 border-bottom sticky-top bg-white shadow-sm">
    <div class="container">
      <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
        <a href="/Animalls" class="d-flex align-items-center mb-2 mb-lg-0 link-body-emphasis text-decoration-none">
	        <i class="fas fa-dog" style="color: #ffa500; font-size:36px;"></i>
        </a>

        <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
          <li><a href="/Animalls/brandstory.jsp" class="nav-link px-2 link-body-emphasis">브랜드</a></li>
          <li><a href="/Animalls/product/productList.jsp" class="nav-link px-2 link-body-emphasis">제품</a></li>
          <li><a href="/Animalls/event/eventList.jsp" class="nav-link px-2 link-body-emphasis">커뮤니티</a></li>
          <li><a href="/Animalls/notice/noticeList.jsp" class="nav-link px-2 link-body-emphasis">고객지원</a></li>
          <li><a href="/Animalls/review/customerReview.jsp" class="nav-link px-2 link-body-emphasis">고객리뷰</a></li>
        </ul>

        <form action="" class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search">
          <input type="search" class="form-control" placeholder="검색어를 입력해주세요" name="">
        </form>
        
		<%if(dto != null && dto.getMemberId() != null) {%>
			<div class="dropdown text-end">
	          <a href="#" class="d-block link-body-emphasis text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
				<img id="profileImage" width="32px" src="${pageContext.request.contextPath}/upload/<%=profile %>" alt="프로필 이미지" />
	          </a>
	          <ul class="dropdown-menu text-small">
                
	            <li><a class="dropdown-item" href="/Animalls/member/protected/myPage.jsp">My Page</a></li>
	            <li><a class="dropdown-item" href="/Animalls/cart.jsp">Cart</a></li>    
                <li><hr class="dropdown-divider"></li>
            
                <% if (dto.isSeller()) { %>
                <li><a class="dropdown-item" href="/Animalls/seller/seller.jsp">Seller</a></li>
                <li><hr class="dropdown-divider"></li>
                <%} %>
                
            
	            <li><a class="dropdown-item" href="/Animalls/member/logout.jsp">Sign out</a></li>
	          </ul>
	        </div>
		<%} else {%>
			<div class="dropdown text-end">
	          <a href="#" class="d-block link-body-emphasis text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
				<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
				  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
				  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
				</svg>
	          </a>
	          <ul class="dropdown-menu text-small">
	            <li><a class="dropdown-item" href="/Animalls/member/loginForm.jsp">Login</a></li>
	            <li><a class="dropdown-item" href="/Animalls/member/signupForm.jsp">Sign Up</a></li>
	          </ul>
	        </div>
		<%} %>
        
      </div>
    </div>
  </header>