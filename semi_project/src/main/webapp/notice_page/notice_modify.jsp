<%@page import="xzy.itwill.DAO.NoticeDAO"%>
<%@page import="xyz.itwill.DTO.NoticeDTO"%>
<%@page import="xzy.itwill.DAO.QaDAO"%>
<%@page import="xyz.itwill.DTO.QaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 글번호를 전달받아 REVIEW 테이블의 저장된 행(게시글)을 검색하여 입력태그의 입력값으로
출력하고 변경값을 입력받기 위한 JSP 문서 --%>
<%-- => 로그인 상태의 사용자 중 게시글 작성자이거나 관리자인 경우에만 요청 가능한 JSP 문서 --%>    
<%-- => [글변경] 태그를 클릭한 경우 [/review/review_modify_action.jsp] 문서를 요청하여 페이지 이동 - 입력값(게시글) 전달 --%>

<%-- 비로그인 상태의 사용자가 JSP 문서를 요청한 경우 에러페이지로 이동되도록 응답 처리 --%>
<%@include file="/security/login_check.jspf" %>    
<%
	//글번호가 전달되지 않은 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getParameter("noticeNum")==null) {
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
		return;
	}

	//전달값을 반환받아 저장
	int noticeNum=Integer.parseInt(request.getParameter("noticeNum"));
	String pageNum=request.getParameter("pageNum");
	String pageSize=request.getParameter("pageSize");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	//글번호를 전달받아 REVIEW 테이블의 단일행을 검색하여 게시글(ReviewDTO 객체)을 반환하는 
	//ReviewDAO 클래스의 메소드 호출
	NoticeDTO notice=NoticeDAO.getDAO().selectNoticeByNum(noticeNum);
	
	//검색된 게시글이 없는 경우에 대한 응답 처리 - 비정상적인 요청
	if(notice==null) {
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
		return;
	}	
	
	//로그인 상태의 사용자가 게시글 작성자 및 관리자가 아닌 경우에 대한 응답 처리 - 비정상적인 요청
	if(loginClient.getClientStatus()!=9) {
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
		return;
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
<h1>게시글변경</h1>

<%-- 파일(리뷰 이미지)을 입력받아 전달하기 위해 form 태그의 enctype 속성값을 반드시 [multipart/form-date]로 설정 --%>
<form action="<%=request.getContextPath()%>/main_page/main.jsp?group=notice_page&worker=notice_modify_action"
	method="post" enctype="multipart/form-data" id="noticeForm">
	<input type="hidden" name="noticeNum" value="<%=noticeNum %>">
	<input type="hidden" name="pageNum" value="<%=pageNum %>">
	<input type="hidden" name="pageSize" value="<%=pageSize %>">
	<input type="hidden" name="search" value="<%=search %>">
	<input type="hidden" name="keyword" value="<%=keyword %>">
	<table>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="noticeTitle" id="noticeSubject" size="40" 
					value="<%=notice.getNoticeTitle()%>">
				<%-- 비밀글 없음
				<input type="checkbox" name="qaSecret" value="2"
					<% if(review.getReviewStatus()==2) { %> checked <% } %>>비밀글
				--%>
			</td>					
		</tr>	
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="7" cols="60" name="	noticeContent" id="noticeContent"><%=notice.getNoticeContent()%></textarea>
			</td>
		</tr>			
		<tr>
			<th>이미지파일</th>
			<td>
				<input type="file" name="noticeImage"><br><br>
				<% if(notice.getNoticeImage()!=null) { %>
					<div style="color: red;">이미지를 변경할 경우에만 파일을 입력해 주세요.</div>
					<img src="<%=request.getContextPath()%>/<%=notice.getNoticeImage()%>" width="200">
				<% } %>
			</td>
		</tr>
		<tr>
			<th colspan="2">
				<button type="submit">글변경</button>
				<button type="reset" id="resetBtn">다시쓰기</button>
			</th>
		</tr>
	</table>
</form>
<div id="message" style="color: red;"></div>

<script type="text/javascript">
$("#noticeTitle").focus();

$("#noticeForm").submit(function() {
	if($("#noticeTitle").val()=="") {
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
	$("#noticeTitle").focus();
	$("#message").text("");
});
</script>