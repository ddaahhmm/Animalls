<%@page import="javax.mail.Session"%>
<%@page import="util.SessionManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String url = request.getParameter("url");
	if (url == null) {
		String cPath = request.getContextPath();
		url = cPath + "/index.jsp";
	}
	
	String savedId="";
	String savedPwd="";
	Cookie[] cooks=request.getCookies();
	if(cooks != null){
		for(Cookie tmp: cooks){
			String key=tmp.getName();
			if(key.equals("savedMemberId")){
				savedId=tmp.getValue();
			}
			if(key.equals("savedPassword")){
				savedPwd=tmp.getValue();
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body class="d-flex align-items-center py-4 bg-body-tertiary">
	<main class="form-signin w-100 m-auto">
      <form action="login.jsp" method="post">
      	<input type="hidden" name="url" value="<%=url %>" />
        <h1 class="h3 mb-3 fw-normal">로그인</h1>

        <div class="form-floating">
          <input type="text" class="form-control" id="memberId" name="memberId" placeholder="아이디" value="<%=savedId %>" />
          <label for="memberId">아이디</label>
        </div>
        <div class="form-floating">
          <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호" value="<%=savedPwd %>" />
          <label for="password">비밀번호</label>
        </div>

        <div class="form-check text-start my-3">
          <input class="form-check-input" type="checkbox" value="remember-me" id="flexCheckDefault" name="isSave" <%=savedId.equals("") ? "" : "checked" %> />
          <label class="form-check-label" for="flexCheckDefault">
            아이디 저장
          </label>
        </div>
        <button class="btn btn-primary w-100 py-2" type="submit">
          로그인
        </button>
        <p class="mt-5 mb-3 text-body-secondary">&copy; 2023–2024</p>
      </form>
    </main>
</body>
</html>