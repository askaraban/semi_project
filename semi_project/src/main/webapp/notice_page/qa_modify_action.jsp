<%@page import="xyz.itwill.DTO.QaDTO"%>
<%@page import="xzy.itwill.DAO.QaDAO"%>
<%@page import="java.io.File"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 게시글을 전달받아 REVIEW 테이블에 저장된 행을 변경하고 [/review/review_detail.jsp] 문서를
요청하기 위한 URL 주소를 전달하여 응답하는 JSP 문서 --%>
<%-- => [/review/review_detail.jsp] 문서에게 글번호, 페이지번호, 게시글갯수, 검색대상, 검색단어 전달 --%>
<%-- => 로그인 상태의 사용자 중 게시글 작성자이거나 관리자인 경우에만 요청 가능한 JSP 문서 --%>    

<%@include file="/security/login_check.jspf" %>
<%
	//JSP 문서를 GET 방식으로 요청한 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getMethod().equals("GET")) {
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
		return;
	}

	//전달파일을 저장할 서버 디렉토리의 파일 시스템 경로를 반환받아 저장
	String saveDirectory=request.getServletContext().getRealPath("/images");
	
	//MultipartRequest 객체 생성 - 모든 전달파일을 서버 디렉터리에 저장되도록 자동 업로드 처리
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
			, 20*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	//전달값을 반환받아 저장
	int qaNum=Integer.parseInt(multipartRequest.getParameter("qaNum"));
	String pageNum=multipartRequest.getParameter("pageNum");
	String pageSize=multipartRequest.getParameter("pageSize");
	String search=multipartRequest.getParameter("search");
	String keyword=multipartRequest.getParameter("keyword");
	String qaSubject=Utility.escapeTag(multipartRequest.getParameter("qaSubject"));
	
	
	/* 일반글, 비밀글, 삭제글 따로 구분 없음
	int reviewStatus=1;//전달값이 없는 경우 - 일반글
	if(multipartRequest.getParameter("reviewSecret")!=null) {//전달값이 있는 경우 - 비밀글
		reviewStatus=Integer.parseInt(multipartRequest.getParameter("reviewSecret"));
	}
	*/
	
	String qaContent=Utility.escapeTag(multipartRequest.getParameter("qaContent"));
	
	//서버 디렉토리에 업로드되어 저장된 파일명을 반환받아 컨텍스트 경로를 저장
	String qaImage=multipartRequest.getFilesystemName("qaImage");
	if(qaImage!=null) {//업로드 파일이 있는 경우
		qaImage="/images/"+qaImage;
	
		//REVIEW 테이블에 저장된 행(게시글)의 이미지 파일의 경로(REVIEW_IMAGE 컬럼값)을 반환받아 저장
		String removeQaImage=QaDAO.getDAO().selectQaByNum(qaNum).getQaImage();
		if(removeQaImage!=null) {//서버 디렉터리에 이미지 파일이 있는 경우
			//서버 디렉토리에 저장된 기존 리뷰 이미지 파일을 삭제 처리
			new File(saveDirectory, removeQaImage.substring("/images/".length())).delete();
		}
	}
	
	//REVIEW_SEQ 시퀀스의 다음값을 검색하여 반환하는 ReviewDAO 클래스의 메소드 호출
	int nextNum=QaDAO.getDAO().selectQaNextNum();

	//ReviewDTO 객체를 생성하여 변수값(전달값)으로 필드값 변경
	QaDTO qa=new QaDTO();
	qa.setQaNum(qaNum);
	qa.setQaSubject(qaSubject);
	qa.setQaContent(qaContent);
	qa.setQaImage(qaImage);
	
	//게시글을 전달받아 REVIEW 테이블의 저장된 행의 컬럼값을 변경하고 변경행의 갯수를 반환하는
	//ReviewDAO 클래스의 메소드 호출
	QaDAO.getDAO().updateQa(qa);	
	//페이지 이동
	request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=notice_page&worker=qa_detail"
		+"&qaNum="+qaNum+"&pageNum="+pageNum+"&pageSize="+pageSize+"&search="+search+"&keyword="+keyword);
%>