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
	//전달값을 반환받아 저장
	int qaNum=Integer.parseInt(request.getParameter("qaNum"));
	String pageNum=request.getParameter("pageNum");
	String pageSize=request.getParameter("pageSize");
	int productNum = Integer.parseInt(request.getParameter("productNum"));
	
	//글번호가 전달되지 않은 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getParameter("qaNum")==null) {
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
		return;
	}
	
	//글번호를 전달받아 Qa 테이블의 단일행을 검색하여 게시글(QaDTO 객체)을 반환하는 
	//QaDAO 클래스의 메소드 호출
	QaDTO qa=QaDAO.getDAO().selectQaByNum(qaNum);
	
	//검색된 게시글이 없는 경우에 대한 응답 처리 - 비정상적인 요청
	if(qa==null) {
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
		return;
	}	
	
	//로그인 상태의 사용자가 게시글 작성자 및 관리자가 아닌 경우에 대한 응답 처리 - 비정상적인 요청
	if(loginClient.getClientNum()!=qa.getQaMember() && loginClient.getClientStatus()!=9) {
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
		return;
	}
%>
<style type="text/css">
#qa_modify {
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

#qaContent{
	width: 400px;
}

#qa_menu {
	text-align: right;
	margin-top: 7px;
}

#modifyBtn {
	height: 100%;
	margin-top: 5px;
	margin-bottom: 7px;
	background-color: rgb(239, 239, 239);
 	color: black;
 	font-weight: bold;
 	border-radius: 5px;
 	border: 1px solid gray;
}

#resetBtn {
	height: 100%;
	margin-top: 5px;
	margin-bottom: 7px;
	background-color: rgb(239, 239, 239);
 	color: black;
 	font-weight: bold;
 	border-radius: 5px;
 	border: 1px solid gray;
}
</style>
<div id="qa_modify">
	<h1>Q&A 수정</h1>
	
	<%-- 파일(리뷰 이미지)을 입력받아 전달하기 위해 form 태그의 enctype 속성값을 반드시 [multipart/form-date]로 설정 --%>
	<form action="<%=request.getContextPath()%>/main_page/main.jsp?group=qa_page&worker=qa_modify_action"
		method="post" enctype="multipart/form-data" id="qaForm">
		<input type="hidden" name="qaNum" value="<%=qaNum %>">
		<input type="hidden" name="productNum" value="<%=productNum %>">
		<input type="hidden" name="pageNum" value="<%=pageNum %>">
		<input type="hidden" name="pageSize" value="<%=pageSize %>">
		<table>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="qaSubject" id="qaSubject" size="40" value="<%=qa.getQaSubject()%>">
				</td>					
			</tr>	
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="7" cols="60" name="qaContent" id="qaContent"><%=qa.getQaContent()%></textarea>
				</td>
			</tr>			
			<tr>
				<th>이미지파일</th>
				<td>
					<input type="file" name="qaImage"><br><br>
					<% if(qa.getQaImage()!=null) { %>
						<div style="color: red;">이미지를 변경할 경우에만 파일을 입력해 주세요.</div>
						<img src="<%=request.getContextPath()%>/<%=qa.getQaImage()%>" width="200">
					<% } %>
				</td>
			</tr>
		</table>
		<div id="qa_menu" style="text-align: right;">
			<button type="submit" id="modifyBtn">수정</button>
			<button type="reset" id="resetBtn">다시쓰기</button>
		</div>
	</form>
	<div id="message" style="color: red;"></div>
</div>
<script type="text/javascript">
$("#qaSubject").focus();

$("#qaForm").submit(function() {
	if($("#qaSubject").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#qaSubject").focus();
		return false;
	}
	
	if($("#qaContent").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#qaContent").focus();
		return false;
	}
});

$("#resetBtn").click(function() {
	$("#qaSubject").focus();
	$("#message").text("");
});
</script>