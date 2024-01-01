<%@page import="dao.MemberDao"%>
<%@page import="util.SessionManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String memberId = SessionManager.getInstance().getMemberId(request);
	MemberDao.getInstance().delete(memberId);
	session.invalidate();
	response.sendRedirect(request.getContextPath() + "/");
%>