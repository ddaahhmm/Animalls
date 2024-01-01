<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String email = request.getParameter("email");
	MemberDto dto = MemberDao.getInstance().getEmailData(email);
	boolean canUse = dto == null;
%>
{"canUse": <%=canUse %>}