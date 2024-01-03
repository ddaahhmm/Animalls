<%@page import="util.URLConverter"%>
<%@page import="java.io.UnsupportedEncodingException"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<% 
	String src = URLConverter.decode(request.getParameter("src"));
	String href = URLConverter.decode(request.getParameter("href"));
	String title = URLConverter.decode(request.getParameter("title"));
	String subTitle = URLConverter.decode(request.getParameter("subTitle"));
	String description = URLConverter.decode(request.getParameter("description"));
%>

<div class="mq-100">
	<div class="border">
		<div class="text-center">
			<div>
				<img class="object-fit-contain" src="<%= src %>" />
			</div>
			<a href="<%=href %>" style="text-decoration: none; color:#000">
				<div class="h5"><%= title %></div>
				<div class="h6"><%= subTitle %></div>
				<small><%= description %></small>
			</a>
		</div>
	</div>
</div>