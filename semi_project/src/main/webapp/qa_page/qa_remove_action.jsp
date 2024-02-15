<%@page import="java.io.File"%>
<%@page import="xyz.itwill.DTO.QaDTO"%>
<%@page import="xzy.itwill.DAO.QaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 글번호를 전달받아 REVIEW 테이블에 저장된 행(게시글)의 상태를 [0]으로 변경하여 삭제 
처리하고 [/review/review_list.jsp] 문서를 요청할 수 있는 URL 주소를 전달하여 응답하는 JSP 문서 --%>    
<%-- => [/review/review_list.jsp] 문서에게 페이지번호, 게시글갯수, 검색대상, 검색단어 전달 --%>
<%-- => 로그인 상태의 사용자 중 게시글 작성자이거나 관리자인 경우에만 요청 가능한 JSP 문서 --%>    

<%@include file="/security/login_check.jspf" %>    
<%
	System.out.println("qaNum = " + request.getParameter("qaNum"));
	//전달값을 반환받아 저장
	int qaNum=Integer.parseInt(request.getParameter("qaNum"));
	int pageNum=Integer.parseInt(request.getParameter("pageNum"));
	int pageSize=Integer.parseInt(request.getParameter("pageSize"));
	int productNum = Integer.parseInt(request.getParameter("productNum"));
	
	//글번호가 전달되지 않은 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getParameter("qaNum")==null) {
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
		return;
	}
	
	//글번호를 전달받아 REVIEW 테이블의 단일행을 검색하여 게시글(QaDTO 객체)을 반환하는 
	//QaDAO 클래스의 메소드 호출
	QaDTO qa = QaDAO.getDAO().selectQaByNum(qaNum);
	qa.setQaNum(qaNum);
	qa.setQaProductNum(productNum);
	
/* 	//검색된 게시글이 없는 경우에 대한 응답 처리 - 비정상적인 요청
	if(review==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
		return;
	} */	
	
	//로그인 상태의 사용자가 게시글 작성자 및 관리자가 아닌 경우에 대한 응답 처리 - 비정상적인 요청
	if(loginClient.getClientNum()!=qa.getQaMember() && loginClient.getClientStatus()!=9) {
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
		return;
	}
	
	//게시글을 전달받아 REVIEW 테이블의 저장된 행의 컬럼값을 변경하고 변경행의 갯수를 반환하는
	//QaDAO 클래스의 메소드 호출
	QaDAO.getDAO().deleteQa(qaNum);
	//System.out.println("delete 탔어용");
	
	//System.out.println("review.getQaProductNum() = " + review.getQaProductNum());
	
	
	//페이지 이동
 	request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=product_page&worker=product"
		+"&productNum="+qa.getQaProductNum()+"&pageNum="+pageNum+"&pageSize="+pageSize+"#qa_list");
%>