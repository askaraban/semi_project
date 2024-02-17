<%@page import="xzy.itwill.DAO.QaDAO"%>
<%@page import="xyz.itwill.DTO.QaDTO"%>
<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@page import="xzy.itwill.DAO.ReviewDAO"%>
<%@page import="xyz.itwill.DTO.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 글번호를 전달받아 REVIEW 테이블에 저장된 행을 검색하여 응답하는 JSP 문서 --%>
<%-- => 검색 및 페이징 처리 관련 값을 전달받아 JSP 문서를 요청할 때 전달 --%>
<%-- => [글변경] 태그를 클릭한 경우 [/review/review_modify.jsp] 문서를 요청하여 페이지 이동 
- 글번호, 페이지번호, 게시글갯수, 검색대상, 검색단어 전달 --%>
<%-- => [글삭제] 태그를 클릭한 경우 [/review/review_remove_action.jsp] 문서를 요청하여 페이지 이동 
- 글번호, 페이지번호, 게시글갯수, 검색대상, 검색단어 전달 --%>
<%-- => [답글쓰기] 태그를 클릭한 경우 [/review/review_write.jsp] 문서를 요청하여 페이지 이동 
- 답글그룹, 답글순서, 답글깊이, 페이지번호, 게시글갯수, 검색대상, 검색단어 전달 --%>
<%-- => [글목록] 태그를 클릭한 경우 [/review/review_list.jsp] 문서를 요청하여 페이지 이동 
- 페이지번호, 게시글갯수, 검색대상, 검색단어 전달 --%>
<%-- => [글변경] 태그와 [글삭제] 태그는 게시글 작성자 또는 관리자에게만 출력되어 링크를 제공하고
[답글쓰기] 태그는 로그인 상태의 사용자에게만 출력되어 링크 제공 --%>
<%
	//전달값을 반환받아 저장
	int qaNum=Integer.parseInt(request.getParameter("qaNum"));
	String pageNum=request.getParameter("pageNum");
	String pageSize=request.getParameter("pageSize");
	String qaSubject=request.getParameter("qaSubject");
	//글번호가 전달되지 않은 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getParameter("qaNum")==null) {
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
		return;
	}
	
	// 제품번호 가져옴
	int productNum = Integer.parseInt(request.getParameter("productNum"));
	
	//글번호를 전달받아 REVIEW 테이블의 단일행을 검색하여 게시글(ReviewDTO 객체)을 반환하는 
	//ReviewDAO 클래스의 메소드 호출
	QaDTO qa=QaDAO.getDAO().selectQaByNum(qaNum);
	
	//검색된 게시글이 없는 경우에 대한 응답 처리 - 비정상적인 요청
	if(qa==null) {
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
		return;
	}
	
	//session 객체에 저장된 권한 관련 속성값을 반환받아 저장
	// => 검색된 게시글이 비밀글인 경우 권한을 확인하기 위해 필요
	// => 권한에 따른 태그 출력을 위해 필요
	ClientDTO loginClient = (ClientDTO)session.getAttribute("loginClient");
	
	//글번호를 전달받아 REVIEW 테이블의 저장된 행의 게시글 조회수가 1 증가되도록 변경하고 
	//변경행의 갯수를 반환하는 ReviewDAO 클래스의 메소드 호출
	QaDAO.getDAO().updateQaReadCount(qaNum);
	
	QaDTO qaProductName = QaDAO.getDAO().selectQaProductName(productNum, qaNum);
%>
<%-- 페이지번호 출력 및 링크 제공 - 블럭화 처리 - 잘 모르니 우선 빼기
<%
	//하나의 페이지블럭에 출력될 페이지번호의 갯수 설정
	int blockSize=5;

	//페이지블럭에 출력될 시작 페이지번호를 계산하여 저장
	//ex)1Block : 1, 2Block : 6, 3Block : 11, 4Block : 16,...
	int startPage=(pageNum-1)/blockSize*blockSize+1;
	        
	//페이지블럭에 출력될 종료 페이지번호를 계산하여 저장
	//ex)1Block : 5, 2Block : 10, 3Block : 15, 4Block : 20,...
	int endPage=startPage+blockSize-1;
%>
 --%>
<style type="text/css">
#qa_detail {
	width: 500px;
	margin: 0 auto;
}

#qa_replay {
	width: 500px;
	margin: 0 auto;
	margin-top: 50px;
}

table {
	border: 1px solid black;
	border-collapse: collapse;
}

th, td {
	border: 1px solid gray;
	padding: 5px;	
}

th {
	width: 100px;
	background: pink;
	color: gray;
}

td {
	width: 400px;
}

.subject, .content {
	text-align: left;
}

.content {
	height: 200px;
	vertical-align: middle;
}

/* #qa_menu {
	text-align: right;
	margin: 5px;
}  */

#qa_listBtn {
	text-align: right;
	margin-top: 50px;
}

#modifyBtn {
	height: 100%;
	margin-top: 10px;
	margin-bottom: 7px;
	background-color: rgb(239, 239, 239);
 	color: black;
 	font-weight: bold;
 	border-radius: 5px;
 	border: 1px solid gray;
}

#replyBtn {
	height: 100%;
	margin-top: 10px;
	margin-bottom: 7px;
	background-color: rgb(239, 239, 239);
 	color: black;
 	font-weight: bold;
 	border-radius: 5px;
 	border: 1px solid gray;
}
 
#removeBtn {
	height: 100%;
	margin-top: 5px;
	margin-bottom: 7px;
	background-color: rgb(239, 239, 239);
 	color: black;
 	font-weight: bold;
 	border-radius: 5px;
 	border: 1px solid gray;
}

#listBtn {
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

<div id="qa_detail">
<%-- 	<% if(qaProductName.getProductName()!=null) { %>
		<h1>상품 Q&A</h1>
	<% } else { %>	 --%>
		<h1>Q&A</h1>
<%-- 	<% } %> --%>
	
	<%-- 검색된 게시글 출력 --%>
	<table>
		<tr>
			<th>작성자</th>
			<td>
				<%=qa.getQaName() %>
			</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td><%=qa.getQaRegister() %></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%=qa.getQaReadCount()+1 %></td>
		</tr>
		
<%-- 	<% if(qaProductName.getProductName()!=null) { %>
		<tr>
			<th>상품명</th>
			<td><%= qaProductName.getProductName() %></td>
		</tr>
	<% } %> --%>
	
		<tr>
			<th>제목</th>
			<td class="subject">
				<%=qa.getQaSubject() %>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td class="content">
				<%-- <%=review.getReviewContent().replace("\n", "<br>")%> --%>
				<%=qa.getQaContent()%>
				<br>
				<% if(qa.getQaImage()!=null) { %>
					<img src="<%=request.getContextPath()%>/<%=qa.getQaImage()%>" width="200">
				<% } %>
			</td>
		</tr>
	</table>
	
	<% System.out.println("loginClient.getClientNum() = " + loginClient.getClientNum()); %>
	<% System.out.println("qa.getQaMember() = " + qa.getQaMember()); %>
	<!-- 버튼 태그 div -->
	<div id="qa_menu" style="text-align: right;">
		<%-- 로그인 상태의 사용자면서 게시글 작성자인 경우에만 태그를 출력하여 링크 제공 --%>
		<% if(loginClient!=null && (loginClient.getClientNum()==qa.getQaMember())) { %>
			<button type="button" id="modifyBtn">Q&A수정</button>
		<% } %>
	</div>
</div>

<div id="qa_replay">
	<h1>답변</h1>
	
	<form action="<%=request.getContextPath()%>/main_page/main.jsp?group=notice_page&worker=qa_replay_writer_action" 
		method="post" id="reviewForm" enctype="multipart/form-data">
		
		<table>
			<tr>
				<th>작성자</th>
				<td>관리자</td>
			</tr>
			<tr>
				<th>내용</th>
				<% if(qa.getQaReplay()==null) { %>
					<td class="content">답변이 없습니다.</td>
				<% } else { %>
					<td class="content"><%= qa.getQaReplay().replace("\n", "<br>") %></td>
				<% } %>
			</tr>
		</table>

 		<div id="qa_menu" style="text-align: right;">
			<!-- 관리자인 경우에만 태그를 출력하여 링크 제공 -->
			<% if(loginClient!=null) { %>	
				<% if(loginClient.getClientStatus()==9) { %>
					<button type="button" id="replyBtn">답변수정</button>
				<% } %>
			<% } %>
		</div> 
		
		
<%-- 		<% if(loginClient!=null && loginClient.getClientStatus()==9) { %>
			<div id="qa_menu" style="text-align: right;">
				관리자인 경우에만 태그를 출력하여 링크 제공
				<button type="button" id="replyBtn">답변수정</button>
			</div>
		<% } else { %>
			<div id="qa_menu" style="text-align: right;"></div>
		<% } %> --%>
	</form>
</div>

<div id="qa_listBtn">
	<%-- 로그인 상태의 사용자면서 게시글 작성자인 경우에만 태그를 출력하여 링크 제공 --%>
	<% if(loginClient!=null && (loginClient.getClientNum()==qa.getQaMember()
			|| loginClient.getClientStatus()==9)) { %>
		<button type="button" id="removeBtn">삭제</button>
	<% } %>
	<button type="button" id="listBtn">글목록</button>
</div>

<script type="text/javascript">
$("#modifyBtn").click(function() {
	location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=qa_page&worker=qa_modify"
		+"&qaNum=<%=qaNum%>&pageNum=<%=pageNum%>"
		+"&pageSize=<%=pageSize%>&productNum=<%=productNum%>";	
});

$("#removeBtn").click(function() {
	if(confirm("게시글을 정말로 삭제 하시겠습니까?")) {
		location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=qa_page&worker=qa_remove_action"
			+"&qaNum=<%=qa.getQaNum()%>&pageNum=<%=pageNum%>"
			+"&pageSize=<%=pageSize%>&productNum=<%=productNum%>";	
	}
});

$("#replyBtn").click(function() {
	location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=qa_page&worker=qa_replay_write"
		+"&replay=<%=qa.getQaReplay()%>&pageNum=<%=pageNum%>&pageSize=<%=pageSize%>"
		+"&qaSubject=<%=qaSubject %>&productNum=<%=productNum%>&qaNum=<%=qaNum%>";	
});

$("#listBtn").click(function() {
	var referrer = document.referrer;
	
 	if(referrer.includes('qna')){// 마이페이지 화면에서 이동됬으면 글목록 버튼 클릭시 다시 마이페이지로 이동
		location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=qna";
 	} else {// 아니면 해당제품의 상품상세로 이동
		location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=product_page&worker=product"
			+"&productNum=<%=productNum%>#qa_list";
 	}
});
</script>