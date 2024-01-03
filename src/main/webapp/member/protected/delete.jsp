<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@page import="util.SessionManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDto member = SessionManager.getMember(request);
	MemberDao.getInstance().delete(member.getMemberId());
	session.invalidate();
	response.sendRedirect(request.getContextPath() + "/");
%>