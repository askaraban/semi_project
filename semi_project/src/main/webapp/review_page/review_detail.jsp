<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@page import="xzy.itwill.DAO.ReviewDAO"%>
<%@page import="xyz.itwill.DTO.ReviewDTO"%>
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
	//글번호가 전달되지 않은 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getParameter("reviewNum")==null) {
		request.setAttribute("returnURL", request.getContextPath()+"/main.jsp?group=error&worker=error_400");
		return;
	}

	//전달값을 반환받아 저장
	int reviewNum=Integer.parseInt(request.getParameter("reviewNum"));
	String pageNum=request.getParameter("pageNum");
	String pageSize=request.getParameter("pageSize");
	
	//글번호를 전달받아 REVIEW 테이블의 단일행을 검색하여 게시글(ReviewDTO 객체)을 반환하는 
	//ReviewDAO 클래스의 메소드 호출
	ReviewDTO review=ReviewDAO.getDAO().selectReviewTableByNum(reviewNum);
	
	//검색된 게시글이 없는 경우에 대한 응답 처리 - 비정상적인 요청
	if(review==null) {
		request.setAttribute("returnURL", request.getContextPath()+"/main.jsp?group=error&worker=error_400");
		return;
	}
	
	//session 객체에 저장된 권한 관련 속성값을 반환받아 저장
	// => 검색된 게시글이 비밀글인 경우 권한을 확인하기 위해 필요
	// => 권한에 따른 태그 출력을 위해 필요
	ClientDTO loginClient = (ClientDTO)session.getAttribute("loginClient");
	
	//글번호를 전달받아 REVIEW 테이블의 저장된 행의 게시글 조회수가 1 증가되도록 변경하고 
	//변경행의 갯수를 반환하는 ReviewDAO 클래스의 메소드 호출
	ReviewDAO.getDAO().updateReviewReadCount(reviewNum);
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
	height: 300px;
	vertical-align: middle;
}

#review_menu {
	text-align: right;
	margin: 5px;
}
</style>

<div id="review_detail">
	<h1>제품후기</h1>
	
	<%-- 검색된 게시글 출력 --%>
	<table>
		<tr>
			<th>작성자</th>
			<td>
				<%=review.getReviewName() %>
			</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td><%=review.getReviewRegister() %></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%=review.getReviewReadcount()+1 %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td class="subject">
				<%=review.getReviewSubject() %>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td class="content">
				<%=review.getReviewContent().replace("\n", "<br>")%>
				<br>
				<% if(review.getReviewImage()!=null) { %>
					<img src="<%=request.getContextPath()%>/<%=review.getReviewImage()%>" width="200">
					<%-- <% System.out.println("request.getContextPath() = " + request.getContextPath()); %> --%>
					<!-- request.getContextPath() = /semi_project_1 -->
				<% } %>
			</td>
		</tr>
	</table>
	
	<%-- 태그를 출력하여 링크 제공 --%>
	<div id="review_menu">
		<%-- 로그인 상태의 사용자 중 게시글 작성자이거나 관리자인 경우에만 태그를 출력하여 링크 제공 --%>
		<% if(loginClient!=null && (loginClient.getClientNum()==review.getReviewMemberNum()
			|| loginClient.getClientStatus()==9)) { %>
			<button type="button" id="modifyBtn">글변경</button>
			<button type="button" id="removeBtn">글삭제</button>
		<% } %>
		
		<%-- 로그인 상태의 사용자인 경우에만 태그를 출력하여 링크 제공 --%>
		<% if(loginClient!=null) { %>
			<button type="button" id="replyBtn">답글쓰기</button>
		<% } %>
		
		<button type="button" id="listBtn">글목록</button>
	</div>
</div>

<script type="text/javascript">
$("#modifyBtn").click(function() {
	location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=review_page&worker=review_modify"
		+"&reviewNum=<%=review.getReviewNum()%>&pageNum=<%=pageNum%>"
		+"&pageSize=<%=pageSize%>";	
});

$("#removeBtn").click(function() {
	if(confirm("게시글을 정말로 삭제 하시겠습니까?")) {
		location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=review_page&worker=review_remove_action"
			+"&reviewNum=<%=review.getReviewNum()%>&pageNum=<%=pageNum%>"
			+"&pageSize=<%=pageSize%>";	
	}
});

$("#replyBtn").click(function() {
	location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=review_page&worker=review_write"
		+"&replay=<%=review.getReviewReplay()%>&pageNum=<%=pageNum%>&pageSize=<%=pageSize%>";
});

/* request.getHeader("referer") : 이전페이지로 이동 */
$("#listBtn").click(function() {
	location.href="<%=request.getHeader("referer")%>#review_list";	 
});
</script>