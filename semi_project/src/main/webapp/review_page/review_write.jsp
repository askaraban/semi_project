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

String reviewNum = request.getParameter("reviewNum");
String pageNum =  request.getParameter("pageNum");
String pageSize = request.getParameter("pageSize");
String productNum = request.getParameter("productNum");

%>
<style type="text/css">
#review_detail {
	width: 500px;
	margin: 0 auto;
}

table {
	border: 1px solid black;
	border-collapse: collapse;
}

th, td {
	border: 1px solid black;
	padding: 5px;	
}

th {
	width: 100px;
	color: black;
}

td {
	width: 400px;
}

.subject, .content {
	text-align: left;
}

.content {
	height: 300px;
	vertical-align: middle;
}

#review_menu {
	text-align: right;
	margin: 5px;
}
</style>
 
	
<div class="container text-center">
	<div class="row justify-content-md-center">
		<div class="col col-lg-2">
			<div id="navigation" style="padding-top: 60px;">
				<h1>
					<a class="side_menu"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=my_order">주문내역</a>
				</h1>
				<h2>
					<a class="side_menu"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review">리뷰</a>
				</h2>
				<h3>
					<a class="side_menu"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=qna">Q&A</a>
				</h3>
				<h4>
					<a class="side_menu"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=password_confirm&action=modify">회원정보</a>
				</h4>
			</div>
		</div>
		<div class="col col-lg-10">
			<h1 class="subTitle1">리뷰</h1>
			<div class="tabType">
				<ul class="item2" style="padding-left: unset;">
					<li class="active write_review" style="text-decoration: none;"><a style="text-decoration: none;"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review">
						<span>작성 가능한 리뷰</span></a></li>
					<li class="active1 write_review" ><a style="text-decoration: none;"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review_list">
						<span >내가 작성한 리뷰</span></a></li>
				</ul>
			</div>
			<div>
				<div class="mbOutTop" style="padding-top: 20px;">
					<form action="<%=request.getContextPath()%>/main_page/main.jsp?group=review_page&worker=review_write_action" 
					 	method="post" id="reviewForm" enctype="multipart/form-data">
					 	<input type="hidden" name="pageNum" value="<%=pageNum %>">
					 	<input type="hidden" name="pageSize" value="<%=pageSize %>">
					 	<input type="hidden" name="productNum" value="<%=productNum %>">
					 	<table>
					 		<tr>
					 			<th>제목</th>
					 			<td>
					 				<input type="text" name="reviewSubject" id="reviewSubject" size="40">
					 			</td>
					 		</tr>
					 		<tr>
					 			<th>내용</th>
					 			<td>
					 				<textarea rows="7" cols="60" name="reviewContent" id="reviewContent"></textarea>
					 			</td>
					 		</tr>
					 		<tr>
					 			<th>이미지파일</th>
					 			<td>
					 				<input type="file" name="reviewImage">
					 			</td>
					 		</tr>
					 		<tr>
					 			<th colspan="2">
					 				<button type="submit">글저장</button>
					 				<button type="reset" id="resetBtn">다시쓰기</button>
					 			</th>
					 		</tr>
					 	</table>
					 </form>
					</div>
				</div>
			</div>
		</div>
	</div>
