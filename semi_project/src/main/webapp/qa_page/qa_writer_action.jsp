<%@page import="xyz.itwill.DTO.QaDTO"%>
<%@page import="xzy.itwill.DAO.QaDAO"%>
<%@page import="xzy.itwill.DAO.NoticeDAO"%>
<%@page import="xyz.itwill.DTO.NoticeDTO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 게시글(새글 또는 답글)을 전달받아 REVIEW 테이블에 행으로 삽입하고 [/review/review_list.jsp]
 문서를 요청하기 위한 URL 주소를 전달하여 응답하기 위한 JSP 문서 - 페이징 처리 관련 값 전달 --%>
<%-- => 로그인 상태의 사용자만용청 가능한 JSP 문서 --%>
<%-- => 게시글이 [multipart/form-data] 타입으로 전달되므로 COS 라이브러리의 MultipartRequest 객체를 사용하여 처리 --%>
<%-- => 전달받은 파일은 [review_images] 서버 디렉토리에 저장되도록 업로드 처리 --%>
<%@include file="/security/login_check.jspf" %>
<%
	//JSP 문서를 GET 방식으로 요청한 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getMethod().equals("GET")) {
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
		return;
	}
	
	//전달파일을 저장할 서버 디렉토리의 파일 시스템 경로를 반환받아 저장
	//String saveDirectory=application.getRealPath("/review_images");
	String saveDirectory=request.getServletContext().getRealPath("/qa_images");

	//MultipartRequest 객체 생성 - 모든 전달파일을 서버 디렉터리에 저장되도록 자동 업로드 처리
	// => cos.jar 라이브러리 파일을 프로젝트에 빌드 처리해야만 MultipartRequest 클래스 사용 가능
	MultipartRequest mr=new MultipartRequest(request, saveDirectory
			, 20*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	//전달값을 반환받아 저장
	String pageNum=mr.getParameter("pageNum");
	String pageSize=mr.getParameter("pageSize");
	String productNum=mr.getParameter("productNum");
	String qaSubject=Utility.stripTag(mr.getParameter("qaSubject"));
	String qaContent=Utility.stripTag(mr.getParameter("qaContent"));
	
	//서버 디렉토리에 업로드되어 저장된 파일명을 반환받아 컨텍스트 경로 저장
	String qaImage=null;
	if(mr.getFilesystemName("qaImage")!=null) { //업로드 파일이 있는 경우
		qaImage="/qa_images/"+mr.getFilesystemName("qaImage");
		//String reviewImage=request.getContextPath()+"/review_images/"+multipartRequest.getFilesystemName("reviewImage"); //URL 주소 저장 방법
	}
	
	//QA_SEQ 시퀀스의 다음값을 검색하여 반환하는 QaDAO 클래스의 메소드 호출
	int nextNum=QaDAO.getDAO().selectQaNextNum();
	
	//QaDTO 객체를 생성하여 변수값(전달값)으로 필드값을 저장
	QaDTO qa=new QaDTO();
	qa.setQaNum(nextNum); //시퀀스 객체의 다음값으로 필드값 변경
	qa.setQaMember(loginClient.getClientNum());
	qa.setQaSubject(qaSubject);
	qa.setQaContent(qaContent);
	qa.setQaImage(qaImage);
	qa.setQaProductNum(Integer.parseInt(productNum));
	
	//게시글을 전달받아 QA 테이블의 행으로 삽입하고 삽입행의 갯수를 반환하는 ReviewDAO 클래스의 메소드
	QaDAO.getDAO().insertQaByProduct(qa);
	
	//페이지 이동
 	request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=product_page&worker=product"
		+"&productNum="+qa.getQaProductNum()+"&pageNum="+pageNum+"&pageSize="+pageSize+"#qa_list");
%>