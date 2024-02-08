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
	String saveDirectory=request.getServletContext().getRealPath("/images");
	//System.out.println("saveDirectory = "+saveDirectory);

	//MultipartRequest 객체 생성 - 모든 전달파일을 서버 디렉터리에 저장되도록 자동 업로드 처리
	// => cos.jar 라이브러리 파일을 프로젝트에 빌드 처리해야만 MultipartRequest 클래스 사용 가능
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
			, 20*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	//전달값을 반환받아 저장
	String pageNum=multipartRequest.getParameter("pageNum");
	String pageSize=multipartRequest.getParameter("pageSize");
	String search=multipartRequest.getParameter("search");
	String keyword=multipartRequest.getParameter("keyword");
	
	//사용자로부터 입력받아 전달된 값에 태그 관련 문자값이 존재할 경우 웹프로그램 실행시 문제 발생
	//=> XSS(Cross Site Scripting) 공격 : 사용자가 악의적인 스크립트를 입력하여 페이지가 깨지거나
	// 다른 사용자의 사용을 방해 또는 개인정보를 특정 사이트로 전송하는 공격
	//String reviewSubject=multipartRequest.getParameter("reviewSubject");
	//XXS 공격을 방어하기 위한 전달값을 변환하여 저장
	//=> 전달값에 포함된 태그 관련 문자열을 제거하여 반환
	//String reviewSubject=Utility.stripTag(multipartRequest.getParameter("reviewSutbject"));
	//=> 전달값에 포함된 태그 관련 문자를 회피문자로 변환하여 반환
	String qaSubject=Utility.stripTag(multipartRequest.getParameter("qaSubject"));
	String qaContent=Utility.stripTag(multipartRequest.getParameter("qaContent"));
	
	/*
	int reviewStatus=1; //전달값이 없는 경우 - 일반글
	if(multipartRequest.getParameter("reviewSecret")!=null) { //전달값이 있는 경우 - 비밀글
		reviewStatus=Integer.parseInt(multipartRequest.getParameter("noticeSecret"));
	}
	String noticeContent=multipartRequest.getParameter("noticeContent");
	*/
	
	//서버 디렉토리에 업로드되어 저장된 파일명을 반환받아 컨텍스트 경로 저장
	String qaImage=null;
	if(multipartRequest.getFilesystemName("qaImage")!=null) { //업로드 파일이 있는 경우
		qaImage="/images/"+multipartRequest.getFilesystemName("qaImage");
		//String reviewImage=request.getContextPath()+"/review_images/"+multipartRequest.getFilesystemName("reviewImage"); //URL 주소 저장 방법
	}
	
	//REVIEW_SEQ 시퀀스의 다음값을 검색하여 반환하는 ReviewDAO 클래스의 메소드 호출
	int nextNum=QaDAO.getDAO().selectQaNextNum();
	
	/*
	//게시글을 작성한 클라이언트의 IP 주소를 반환받아 저장
	//request.getRomoteAddr() : JSP 문서를 요청한 클라이언트의 IP 주소를 반환하는 메소드
	//=> 이클립스에 등록된 WAS 프로그램은 기본적으로 128Bit 형식(IPV6)의 IP 주소 제공
	//32Bit 형식(IPV4)의 IP 주소를 제공받을 수 있도록 이클립스에 등록된 WAS 프로그램의 환경 설정 변경
	//=> Run >> Run Configurations... >> Apache Tomcat >> 사용중인 Apache Tomcat 선택
	// >> Arguments >> VM Arguments >> [-Djava.net.preferIPv4Stack=true] 추가 >> Apply
	//System.out.println("reviewIp = "+reviewIp);
	String noticeIp=request.getRemoteAddr();
	*/
	
	//ReviewDTO 객체를 생성하여 변수값(전달값)으로 필드값을 저장
	QaDTO qa=new QaDTO();
	qa.setQaNum(nextNum); //시퀀스 객체의 다음값으로 필드값 변경
	qa.setQaSubject(qaSubject);
	qa.setQaContent(qaContent);
	qa.setQaImage(qaImage);
	
	//게시글을 전달받아 REVIEW 테이블의 행으로 삽입하고 삽입행의 갯수를 반환하는 ReviewDAO 클래스의 메소드
	QaDAO.getDAO().insertQa(qa);
	
	//페이지 이동 - 검색 및 페이징 처리 관련 값 전달
	request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=notice_page&worker=qa_detail"
		+"&pageNum="+pageNum+"&pageSize="+pageSize+"&search="+search+"&keyword="+keyword);
%>