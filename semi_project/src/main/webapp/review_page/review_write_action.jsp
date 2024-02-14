<%@page import="xzy.itwill.DAO.OrderDAO"%>
<%@page import="xyz.itwill.DTO.ReviewDTO"%>
<%@page import="xzy.itwill.DAO.ReviewDAO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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

//전달파일을 저장할 서버 디렉토리의 파일 시스템 경로를 반환받아 저장
//String saveDirectory=application.getRealPath("/review_images");
String saveDirectory = request.getServletContext().getRealPath("/review_images");

//MultipartRequest 객체 생성 - 모든 전달파일을 서버 디렉터리에 저장되도록 자동 업로드 처리
// => cos.jar 라이브러리 파일을 프로젝트에 빌드 처리해야만 MultipartRequest 클래스 사용 가능
MultipartRequest mr = new MultipartRequest(request, saveDirectory, 20 * 1024 * 1024, "utf-8",
		new DefaultFileRenamePolicy());
 
//전달값을 반환받아 저장
String pageNum = mr.getParameter("pageNum");
String pageSize = mr.getParameter("pageSize");
String productNum = mr.getParameter("productNum");
int orderNum = Integer.parseInt(mr.getParameter("orderNum"));


String reviewSubject = Utility.escapeTag(mr.getParameter("reviewSubject"));
String reviewContent = Utility.escapeTag(mr.getParameter("reviewContent"));
//서버 디렉토리에 업로드되어 저장된 파일명을 반환받아 컨텍스트 경로를 저장
String reviewImage=null;
if (mr.getFilesystemName("reviewImage") != null) {
	reviewImage = "/review_images/" + mr.getFilesystemName("reviewImage");
}

// reviewDTO 객체를 생성하여 변수값(전달값)을 필드값으로 저장
ReviewDTO review = new ReviewDTO();
review.setReviewNum(loginClient.getClientNum()); // 로그인된 회원정보의 회원번호를 필드값으로 변경
review.setReviewSubject(reviewSubject);
review.setReviewContent(reviewContent);
review.setReviewImage(reviewImage);
review.setReviewProductNum(Integer.parseInt(productNum));
review.setOrderReviewStatus(orderNum);

/* System.out.println("orderNum=" + orderNum);
System.out.println("reviewSubject=" + reviewSubject);
System.out.println("loginClient.getClientNum()=" + loginClient.getClientNum());
System.out.println("reviewImage=" + reviewImage);
System.out.println("orderNum=" + orderNum);
System.out.println("productNum=" + productNum);
 */
// review 테이블의 행으로 삽입하고 삽입행의 갯수를 반환하는 reviewDAo 클래스
ReviewDAO.getDAO().insertReview(review, orderNum);
int rows = OrderDAO.getDAO().updateReviewStatus(orderNum);

request.setAttribute("returnURL", request.getContextPath() + "/main_page/main.jsp?group=my_page&worker=review" + "&pageNum="
		+ pageNum + "&pageSize=" + pageSize);
%>
