<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="xyz.itwill.DTO.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="xzy.itwill.DAO.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
   crossorigin="anonymous">
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
   integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
   crossorigin="anonymous"></script>
<link href="<%=request.getContextPath()%>/style/my_page_order.css"
   type="text/css" rel="stylesheet">

<%@include file="/security/login_check.jspf" %> 

<%
	//전달값을 반환받아 저장
	String replay=request.getParameter("replay"), pageNum="1", pageSize="5"
		, orderNum=request.getParameter("orderNum"), reviewSubject=request.getParameter("reviewSubject");
	int productNum=Integer.parseInt(request.getParameter("productNum"));
	int reviewNum=Integer.parseInt(request.getParameter("reviewNum"));
	System.out.println("reviewNum = " + reviewNum);
   	
	//글번호를 전달받아 REVIEW 테이블의 단일행을 검색하여 게시글(ReviewDTO 객체)을 반환하는 
	//ReviewDAO 클래스의 메소드 호출
	ReviewDTO review=ReviewDAO.getDAO().selectReviewTableByNum(reviewNum);
	
	System.out.println("review.getReviewNum() = " + review.getReviewNum());
	System.out.println("review.getReviewReplay() = " + review.getReviewReplay());
	System.out.println("============");
	
   /* if(!request.getParameter("replay").equals("null")) {//전달값이 있는 경우 - 답글 */
/* 	if(reviewNum!=0 && replay.equals("null") ) {//답글인 경우 
		//부모글 관련 정보를 반환받아 저장
		replay=request.getParameter("replay");
		pageNum=request.getParameter("pageNum");
		pageSize=request.getParameter("pageSize");
		productNum=Integer.parseInt(request.getParameter("productNum"));
	} */
%> 

<style type="text/css">
#review_write {
   width: 500px;
   margin: 0 auto;
}

table {
   border: 1px solid black;
   border-collapse: collapse;
}

th {
   width: 100px;
   background: pink;
   color: gray;
   border: 1px solid gray;
}

td {
   text-align: left;
   border: 1px solid gray;
   width: 400px;
}

#reviewContent{
   width: 400px;
}

#replay {
   width: 400px;
}

#review_menu {
   text-align: right;
   margin: 5px;
}
</style>

<div id="review_write">
	<h1>답글쓰기</h1>
	
	<form action="<%=request.getContextPath()%>/main_page/main.jsp?group=review_page&worker=review_replay_write_action" 
		method="post" id="reviewForm">
	<input type="hidden" name="reviewNum" value="<%=reviewNum %>">
	<input type="hidden" name="replay" value="<%=replay %>">
 	<input type="hidden" name="pageNum" value="<%=pageNum %>">
	<input type="hidden" name="pageSize" value="<%=pageSize %>">
<%--	<input type="hidden" name="productNum" value="<%=productNum %>">
	<input type="hidden" name="orderNum" value="<%=orderNum %>"> --%>
		
		<table>
			<tr>
				<th>작성자</th>
				<td>관리자</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="7" cols="60" name="replay" id="replay"></textarea>
				</td>
			</tr>
		</table>
		
		<div id="review_menu">
			<button type="submit">글저장</button>
			<button type="reset" id="resetBtn">다시쓰기</button>
		</div>
	</form>
</div>
<div id="message" style="color: red;"></div>

<script type="text/javascript">
$("#resetBtn").click(function() {
	$("#reviewSubject").focus();
	$("#message").text("");
});
</script>