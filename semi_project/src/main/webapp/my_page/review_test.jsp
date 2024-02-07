<%@page import="xzy.itwill.DAO.ReviewDAO"%>
<%@page import="xyz.itwill.DTO.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- REVIEW 테이블에 게시글(새글)을 500개 삽입하는 JSP 문서 - 테스트 프로그램 --%>
<%
	ReviewDTO review=new ReviewDTO();
	for(int i=1;i<=2;i++) {
		int nextNum=ReviewDAO.getDAO().selectReivewNextNum();
		review.setReviewNum(nextNum);//글번호 변경
		review.setReviewMemberNum(1);//회원번호 변경
		review.setReviewSubject("테스트-"+i);//제목 변경
		review.setReviewContent("게시글 테스트 - "+i);//내용 변경
		
		ReviewDAO.getDAO().insertReview(review); 
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>2개의 테스트 게시글을 삽입 하였습니다.</h1>
</body>
</html>