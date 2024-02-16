<%@page import="xzy.itwill.DAO.QaDAO"%>
<%@page import="xyz.itwill.DTO.QaDTO"%>
<%@page import="xzy.itwill.DAO.OrderDAO"%>
<%@page import="xyz.itwill.DTO.ReviewDTO"%>
<%@page import="xzy.itwill.DAO.ReviewDAO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- 게시글(새글 또는 답글)을 전달받아 REVIEW 테이블의 행으로 삽입하고 [/review/review_list.jsp]
문서를 요청하기 위한 URL 주소를 전달하여 응답하기 위한 JSP 문서 - 페이징 처리 관련 값 전달 --%>
<%-- => 로그인 상태의 사용자만 요청 가능한 JSP 문서 --%>
<%-- => 게시글이 [multipart/form-data] 타입으로 전달되므로 COS 라이브러리의 MultipartRequest 객체를 사용하여 처리 --%>
<%-- => 전달받은 파일은 [/review_images] 서버 디렉터리에 저장되도록 업로드 처리 --%>

<%@include file="/security/login_check.jspf"%>

<%
	//JSP 문서를 GET 방식으로 요청한 경우에 대한 응답 처리 - 비정상적인 요청
	if (request.getMethod().equals("GET")) {
		request.setAttribute("returnURL", request.getContextPath() + "/main_page/main.jsp?group=error&worker=error_400");
		return;
	}
	 
	//전달값을 반환받아 저장
	String pageNum=request.getParameter("pageNum");
	String pageSize=request.getParameter("pageSize");
	int qaNum = Integer.parseInt(request.getParameter("qaNum"));
	int productNum = Integer.parseInt(request.getParameter("productNum"));
	String replay=request.getParameter("replay");
	
	// reviewDTO 객체를 생성하여 변수값(전달값)을 필드값으로 저장
	QaDTO qa = new QaDTO();
	qa.setQaReplay(replay);
	qa.setQaProductNum(productNum);
	qa.setQaNum(qaNum);
	
	// 관리자가 답변 달 때 review_replay 행 update 하는 메소드
	QaDAO.getDAO().updateQaReplay(qa);
	
	request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=qa_page&worker=qa_detail"
			+"&qaNum="+qa.getQaNum()+"&productNum="+qa.getQaProductNum()+"&pageNum="+pageNum+"&pageSize="+pageSize);
%>
