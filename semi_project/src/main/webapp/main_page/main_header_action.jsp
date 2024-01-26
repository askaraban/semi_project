<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(request.getMethod().equals("GET")){
	// 요청 JSP 문서에서 URL 주소를 전달하므로 아무런 효과가 없다.
	//response.sendRedirect(request.getContextPath()+"/error/error_400.jsp");
	//return;
	
	// request 내장객체의 속성값으로 URL 주소를 저장하여 주소를 저장
	System.out.println("에러입니다.");
	return;
	}
	
	String keyword = request.getParameter("keyword");
	session.setAttribute("keyword", keyword);

	request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=main_page&worker=main_search");
	
%>