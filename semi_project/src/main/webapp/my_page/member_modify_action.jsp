<%@page import="xzy.itwill.DAO.ClientDAO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>  
<%
	//JSP 문서를 GET 방식으로 요청한 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getMethod().equals("GET")) {
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
		return;
	}

	//전달값을 반환받아 저장
	int clientNum=Integer.parseInt(request.getParameter("clientNum"));
	String clientID=request.getParameter("clientID");
	String clientPasswd=request.getParameter("clientPasswd");
	if(clientPasswd==null || clientPasswd.equals("")) {//전달값(비밀번호)이 없는 경우
		//현재 로그인 사용자의 비밀번호를 변수에 저장 - 기존 비밀번호 유지
		clientPasswd=loginClient.getClientPasswd();
	} else {//전달값(비밀번호)이 있는 경우
		//전달값을 암호화 처리하여 변수에 저장 - 전달된 비밀번호로 변경
		clientPasswd=Utility.encrypt(clientPasswd);
	}
	String clientName=request.getParameter("clientName");
	String clientEmail=request.getParameter("clientEmail");
	String clientMobile=request.getParameter("clientMobile1")+"-"+request.getParameter("clientMobile2")
		+"-"+request.getParameter("clientMobile3");
	String clientZipcode=request.getParameter("clientZipcode");
	String clientAddress1=request.getParameter("clientAddress1");
	String clientAddress2=request.getParameter("clientAddress2");
	
	//ClientDTO 객체를 생성하여 전달값으로 필드값 변경
	ClientDTO clientTable=new ClientDTO();
	clientTable.setClientNum(clientNum);
	clientTable.setClientID(clientID);
	clientTable.setClientPasswd(clientPasswd);
	clientTable.setClientName(clientName);
	clientTable.setClientEmail(clientEmail);
	clientTable.setClientMobile(clientMobile);
	clientTable.setClientZipcode(clientZipcode);
	clientTable.setClientAddress1(clientAddress1);
	clientTable.setClientAddress2(clientAddress2);
	
	//회원정보를 전달받아 CLIENT 테이블에 저장된 행을 변경하고 변경행의 갯수를 반환하는 
	//ClientDAO 클래스의 메소드 호출
	ClientDAO.getDAO().updateClient(clientTable);
	
	//session 객체에 저장된 권한 관련 속성값(회원정보 - ClientDTO 객체) 변경
	session.setAttribute("loginClient", ClientDAO.getDAO().selectClientByNum(clientNum));
	
	//페이지 이동
	request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=my_page&worker=member_modify");
	
%> 