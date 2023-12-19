<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	//어느 페이지에 포함되었는지 정보를 얻어오기
	String currentPage=request.getParameter("current"); // "index" or "member" or "guest"

	// id 가져옴
	String id = (String)session.getAttribute("id");
%>

<!-- 
	어두운색 계열의 navbar 배경색이면 data-bs-theme="dark" 속성을 추가한다 
	navbar-expand-md 는 md 영역 이상에서 navbar-collapse 가 펼쳐 지도록 한다.
-->
<nav class="navbar bg-success navbar-expand-md" data-bs-theme="dark">
  <div class="container">
    <a class="navbar-brand" href="">
      <img src="" alt="Logo" class="d-inline-block align-text-top">
      Animalls
    </a>
    <div class="collapse navbar-collapse" id="navbarText">
	   	<ul class="navbar-nav me-auto">
        	<li class="nav-item">
          		<a class="nav-link" href="">메뉴1</a>
        	</li>
        	<li class="nav-item">
          		<a class="nav-link" href="">메뉴2</a>
        	</li>
        	<li class="nav-item">
          		<a class="nav-link" href="">메뉴3</a>
        	</li>
        	<li class="nav-item">
          		<a class="nav-link" href="">메뉴4</a>
        	</li>
        	<li class="nav-item">
          		<a class="nav-link" href="">메뉴5</a>
        	</li>
      	</ul>
	      	<div class="navbar-nav">
	      		<%if(id != null) {%>
	      		<a class="nav-link" href=""><strong><%=id %></strong>님 ㅎㅇ</a>
	      		<a class="nav-link" href="">로그아웃</a>
	      		<%}else{ %>
	      		<a class="nav-link" href="" class="nav-link">로그인</a>
	      		<a class="nav-link" href="" class="nav-link">회원가입</a>
	      		<%} %>
	      	</div>
    </div>
  </div>
</nav>