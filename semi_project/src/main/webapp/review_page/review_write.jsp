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

String orderNum = request.getParameter("orderNum");
String pageNum =  request.getParameter("pageNum");
String pageSize = request.getParameter("pageSize");
String productNum = request.getParameter("productNum");

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

#review_menu {
	text-align: right;
	margin: 5px;
}
</style>

<div id="review_write">
	<h1>답글쓰기</h1>
	<form action="<%=request.getContextPath()%>/main_page/main.jsp?group=review_page&worker=review_write_action" 
	 	method="post" id="reviewForm" enctype="multipart/form-data">
	 	<input type="hidden" name="pageNum" value="<%=pageNum %>">
	 	<input type="hidden" name="pageSize" value="<%=pageSize %>">
	 	<input type="hidden" name="productNum" value="<%=productNum %>">
	 	<input type="hidden" name="orderNum" value="<%=orderNum %>">
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
	 	</table>
		<div id="review_menu">
			<button type="submit">글저장</button>
			<button type="reset" id="resetBtn">다시쓰기</button>
		</div>
	</form>
</div>