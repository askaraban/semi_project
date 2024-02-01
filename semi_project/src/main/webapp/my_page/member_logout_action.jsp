<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그아웃 처리 => session 객체에 저장된 권한 관련 속성값 삭제
	session.removeAttribute("loginClient");
	//session.invalidate();
	
	request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp");
	//request.setAttribute("returnURl", request.getContextPath()+"/main_page/main.jsp?group=login_page&worker=client_login");
	
%>