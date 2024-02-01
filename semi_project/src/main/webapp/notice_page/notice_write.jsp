<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 사용자로부터 게시글(새글 또는 답글)을 입력받기 위한 JSP 문서 --%>
<%-- => 로그인 사용자만 요청 가능한 JSP 문서 --%>
<%-- => [글저장] 태그를 클릭한 경우 [/review/review_write_action.jsp] 문서를 요청하여 페이지 이동
 - 입력값(게시글) 전달 --%>

<%-- 새글 : [review/review_list.jsp] 문서에 의해 JPS 문서를 요청된 경우 - 전달값 X --%> 
<%-- 답글 : [review/review_detail.jsp] 문서에 의해 JSP 문서를 요청된 경우 - 전달값 O --%> 

<%-- 비로그인 상태의 사용자가 JSP 문서를 요청한 경우 에러페이지로 이동되도록 응답 처리 --%>
<%@include file="/security/login_check.jspf"%>

<%
	//전달값을 반환받아 저장 - 전달값이 없는 경우(새글) 변수에 초기값 저장
	String pageNum="1", pageSize="10", search="", keyword=""; //페이지 검색 정보 유지 위해
	if(request.getParameter("ref")!=null) {//전달값이 있는 경우 - 답글인 경우 부모글의 정보를 변수에 저장
		//부모글 관련 정보를 반환받아 저장
		//ref, restep, revlevel 제일 중요
		pageNum=request.getParameter("pageNum");
		pageSize=request.getParameter("pageSize");
		search=request.getParameter("search");
		keyword=request.getParameter("keyword");
	}
%>

<style type="text/css">
table {
	margin: 0 auto;
}

th {
	width: 100px;
	font-weight: bold;
}

td {
	text-align: left;
}
</style>
	<div id="notice_main_title">
	<h2>공지사항</h2>
	</div>
	<div>공지사항입니다.</div>
	<br>

<%-- 파일(리뷰 이미지)을 입력받아 전달하기 위해 form 태그의 enctype 속성값을 반드시 [multipart/form-date]로 설정 --%>
<form action="<%=request.getContextPath()%>/main_page/main.jsp?group=notice_page&worker=notice_writer_action"
	method="post" enctype="multipart/form-data" id="noticeForm">
	<input type="hidden" name="pageNum" value="<%=pageNum %>">
	<input type="hidden" name="pageSize" value="<%=pageSize %>">
	<input type="hidden" name="search" value="<%=search %>">
	<input type="hidden" name="keyword" value="<%=keyword %>">
	<table>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="noticeSubject" id="noticeSubject" size="40">
			</td>					
		</tr>	
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="7" cols="60" name="noticeContent" id="noticeContent"></textarea>
			</td>
		</tr>			
		<tr>
			<th>이미지파일</th>
			<td>
				<input type="file" name="noticeImage">
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
<div id="message" style="color: red;"></div>

<script type="text/javascript">
$("#noticeSubject").focus();

$("#noticeForm").submit(function() {
	if($("#noticeSubject").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#noticeSubject").focus();
		return false;
	}
	
	if($("#noticeContent").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#noticeContent").focus();
		return false;
	}
});

$("#resetBtn").click(function() {
	$("#noticeSubject").focus();
	$("#message").text("");
});
</script>