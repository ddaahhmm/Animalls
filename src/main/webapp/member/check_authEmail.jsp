<%@page import="util.SendMail"%>
<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String email = request.getParameter("email");
	String emailAuthCode = request.getParameter("emailAuthCode");
	new SendMail().send(email, "Anialls 이메일 인증", "인증번호: " + emailAuthCode);
%>