<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그아웃 처리 => session 객체에 저장된 권한 관련 속성값 삭제
	session.removeAttribute("loginMember");
	//session.invalidate();
	
	request.setAttribute("returnURl", request.getContextPath()+"/main_page/main.jsp?group=main&worker=main");
%>