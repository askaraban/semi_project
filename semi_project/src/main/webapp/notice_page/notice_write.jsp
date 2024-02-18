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
	if(request.getParameter("qa_replay")!=null) {
		pageNum=request.getParameter("pageNum");
		pageSize=request.getParameter("pageSize");
		search=request.getParameter("search");
		keyword=request.getParameter("keyword");
	}
	
%>

<style type="text/css">
#notice_main_title {
   width: 500px;
   margin: 0 auto;
   text-align: left;
}

.table_review {
   border: 1px solid black;
   border-collapse: collapse;
}

.th_review {
   width: 100px;
   background: pink;
   color: gray;
   border: 1px solid gray;
}

.td_review {
   text-align: left;
   border: 1px solid gray;
   width: 400px;
}

#noticeContent{
   width: 400px;
}

#notice_menu {
   text-align: right;
   margin: 5px;
}

#resetBtn {
	height: 100%;
	margin-top: 10px;
	margin-bottom: 7px;
	background-color: rgb(239, 239, 239);
 	color: black;
 	font-weight: bold;
 	border-radius: 5px;
 	border: 1px solid gray;
}

#saveBtn {
	height: 100%;
	margin-top: 10px;
	margin-bottom: 7px;
	background-color: rgb(239, 239, 239);
 	color: black;
 	font-weight: bold;
 	border-radius: 5px;
 	border: 1px solid gray;
}
</style>

<div id="notice_main_title">
	<h1>공지사항 작성</h1>

	<%-- 파일(리뷰 이미지)을 입력받아 전달하기 위해 form 태그의 enctype 속성값을 반드시 [multipart/form-date]로 설정 --%>
	<form action="<%=request.getContextPath()%>/main_page/main.jsp?group=notice_page&worker=notice_writer_action"
	method="post" id="noticeForm" enctype="multipart/form-data">
		<input type="hidden" name="pageNum" value="<%=pageNum %>">
		<input type="hidden" name="pageSize" value="<%=pageSize %>">
		<input type="hidden" name="search" value="<%=search %>">
		<input type="hidden" name="keyword" value="<%=keyword %>">
		
		<table class="table_review">
			<tr>
				<th class="th_review">제목</th>
				<td class="td_review">
					<input type="text" name="noticeTitle" id="noticeTitle" size="40">
				</td>					
			</tr>	
			<tr>
				<th class="th_review">내용</th>
				<td class="td_review">
					<textarea rows="7" cols="60" name="noticeContent" id="noticeContent"></textarea>
				</td>
			</tr>			
			<tr>
				<th class="th_review">이미지파일</th>
				<td class="td_review">
					<input type="file" name="noticeImage">
				</td>
			</tr>
		</table>
		
		<div id="notice_menu">
			<button type="reset" id="resetBtn">다시쓰기</button>
			<button type="submit" id="saveBtn">글저장</button>
		</div>
	</form>
</div>
<div id="message" style="color: red;"></div>

<script type="text/javascript">
$("#noticeSubject").focus();

$("#noticeForm").submit(function() {
	if($("#noticeTitle").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#noticeTitle").focus();
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