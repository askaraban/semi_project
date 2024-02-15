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
   , orderNum=request.getParameter("orderNum"),reviewSubject=request.getParameter("reviewSubject"),reviewNum=request.getParameter("reviewNum");
   int productNum=Integer.parseInt(request.getParameter("productNum"));
   
//   System.out.println("replay = " + replay);
//   System.out.println("orderNum = " + orderNum);
//   System.out.println("productNum = " + productNum);
//   System.out.println("reviewSubject = " + reviewSubject);
//   System.out.println("reviewNum = " + reviewNum);
   
   if(request.getParameter("replay")!=null) {//전달값이 있는 경우 - 답글
      //부모글 관련 정보를 반환받아 저장
      replay=request.getParameter("replay");
      pageNum=request.getParameter("pageNum");
      pageSize=request.getParameter("pageSize");
      orderNum = request.getParameter("orderNum");
      reviewSubject = request.getParameter("reviewSubject");
      productNum=Integer.parseInt(request.getParameter("productNum"));
   }
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
	<% if(replay==null) {//새글인 경우 %>
		<h1>새글쓰기</h1>
	<% } else {//답글인 경우 %>
		<h1>답글쓰기</h1>
	<% } %>
	
	<form action="<%=request.getContextPath()%>/main_page/main.jsp?group=review_page&worker=review_write_action" 
		method="post" id="reviewForm" enctype="multipart/form-data">
		<input type="hidden" name="replay" value="<%=replay %>">
		<input type="hidden" name="pageNum" value="<%=pageNum %>">
		<input type="hidden" name="pageSize" value="<%=pageSize %>">
		<input type="hidden" name="productNum" value="<%=productNum %>">
		<input type="hidden" name="orderNum" value="<%=orderNum %>">
		
	<table>
		<tr>
			<th>제목</th>
			<td>
				<!--  <input type="text" name="reviewSubject" id="reviewSubject" size="40"> -->
				<% if(replay==null) {//새글인 경우 %>
					<input type="text" name="reviewSubject" id="reviewSubject" size="40">
				<% } else {//답글인 경우 %>
					<input type="hidden" name="reviewSubject" id="reviewSubject" size="40">
					[답글]<%=reviewSubject %>
				<% } %>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<% if(replay==null) {//새글인 경우 %>
					<textarea rows="7" cols="60" name="reviewContent" id="reviewContent"></textarea>
				<% } else { //답글인 경우 %>
					<textarea rows="7" cols="60" name="replay" id="replay"></textarea>
				<% } %>
			</td>
		</tr>
		<% if(replay==null) {//새글인 경우 %>
		<tr>
			<th>이미지파일</th>
 			<td>
 				<input type="file" name="reviewImage">
 			</td>
		</tr>
		<% } else { //답글인 경우 %>
		<tr style="display: none;"></tr>
		<% } %>
		</table>
		
		<div id="review_menu">
			<button type="submit">글저장</button>
			<button type="reset" id="resetBtn">다시쓰기</button>
		</div>
	</form>
</div>
<div id="message" style="color: red;"></div>

<script type="text/javascript">
$("#reviewSubject").focus();

	if(replay==null) {//새글인 경우만
		$("#reviewForm").submit(function() {
		 	if($("#reviewSubject").val()=="") {
				$("#message").text("제목을 입력해 주세요.");
			
			$("#reviewSubject").focus();
			return false;
			}
		   
			if($("#reviewContent").val()=="") {
				$("#message").text("내용을 입력해 주세요.");
				$("#reviewContent").focus();
				return false;
			}
		});
	}

$("#resetBtn").click(function() {
	$("#reviewSubject").focus();
	$("#message").text("");
});
</script>