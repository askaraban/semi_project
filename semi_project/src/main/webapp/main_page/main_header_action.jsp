<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String keyword = (String)session.getAttribute("keyword");
	if(keyword==null) {
		keyword="";
	} else {
		session.removeAttribute("keyword");
	}

	request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=main_page&worker=main_search&keyword"+keyword);
	
%>