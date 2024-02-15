<%@page import="java.util.UUID"%>
<%@page import="xzy.itwill.DAO.ClientDAO"%>
<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 이름과 아이디를 전달받아 MEMBER 테이블에 저장된 행의 비밀번호를 검색하여 검색 결과를 전달하여 응답하는 JSP 문서 --%>    
<%
	//JSP 문서를 GET 방식으로 요청한 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getMethod().equals("GET")) {
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main?group=error&worker=error_400");
		return;
	}
	

	//새로운 비밀번호를 생성하여 반환하는 메소드 - UUID 클래스 이용 
	//public static String newPasswordOne() {
		//UUID 클래스 : 범용적으로 사용되는 식별자(고유값)를 생성하기 위한 기능을 메소드로 제공하는 클래스
		//UUID.randomUUID() : 식별자를 생성하여 식별자가 저장된 UUID 객체를 반환하는 정적메소드 
		// => UUID 객체에 저장된 식별자는 숫자와 영문자(소문자), 4개의 - 문자를 조합하여 36개의 
		//문자로 구성된 문자열
		//UUID.toString() : UUID 객체에 저장된 식벼자를 문자열(String 객체)로 반환하는 메소드
		
		//return UUID.randomUUID().toString().replace("-", "").substring(0, 10).toUpperCase();
	//}
	
		//System.out.println("새로운 비밀번호-2 = "+newPasswordOne());
	

	//전달값을 반환받아 저장
	String name=request.getParameter("name");
	String id=request.getParameter("id");
	
	//MemberDTO 객체를 생성하여 전달값으로 필드값 변경
	ClientDTO client=new ClientDTO();
	client.setClientName((name));
	client.setClientID((id));
	
	//회원정보를 전달받아 client 테이블에 비밀번호 변경  
	//ClientDAO 클래스의 메소드 호출
	ClientDAO.getDAO().updateClientPassword(client);
	
	
%>
