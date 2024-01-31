<%@page import="xzy.itwill.DAO.ClientDAO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<%

	/*
	//JSP 문서를 GET 방식으로 요청한 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getMethod().equals("GET")) {
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
		return;
	}	
	
	//전달값을 반환받아 저장
	String passwd=Utility.encrypt(request.getParameter("passwd"));
	*/
	
	//전달값을 반환받아 저장
	if(request.getParameter("passwd")!=null) {
		String passwd=Utility.encrypt(request.getParameter("passwd"));
	
	//로그인 상태의 사용자 비밀번호와 전달받은 비밀번호를 비교하여 같지 않은 경우에 대한 응답 처리
	if(!loginClient.getPasswd().equals(passwd)) {
		session.setAttribute("message", "입력하신 비밀번호가 맞지 않습니다.");	
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=my_page&worker=password_confirm&action=remove");
		return;
	}	
	
	//ClientDTO 객체를 생성하여 필드값 변경
	ClientDTO client=new ClientDTO();
	client.setClientNum(loginClient.getClientNum());
	client.setClientStatus(0);//회원정보의 회원상태를 [0]으로 변경 - 탈퇴회원
	
	//회원정보를 전달받아 CLIENT 테이블에 저장된 회원정보의 회원상태를 변경하고 변경행의 갯수를
	//반환하는 ClientDAO 클래스의 메소드 호출
	ClientDAO.getDAO().updateClientStatus(client);
	
	//페이지 이동
	request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=my_page&worker=member_logout_action");	
	//request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=main&work=main");	
%>