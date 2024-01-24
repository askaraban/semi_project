<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String keyword = request.getParameter("keyword");
	request.setAttribute("keyword", keyword);
	request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?keyword="+URLEncoder.encode(keyword, "utf-8"));
	
%>