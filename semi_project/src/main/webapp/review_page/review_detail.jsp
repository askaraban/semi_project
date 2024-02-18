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
	//전달값을 반환받아 저장
	int reviewNum=Integer.parseInt(request.getParameter("reviewNum"));
	
	int pageNum=1;//페이지번호- 전달값이 없는 경우 저장된 초기값 설정
	if(request.getParameter("pageNum")!=null) {//전달값이 있는 경우
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	int pageSize=5;//게시글갯수- 전달값이 없는 경우 저장된 초기값 설정
	if(request.getParameter("pageSize")!=null) {//전달값이 있는 경우
		pageSize=Integer.parseInt(request.getParameter("pageSize"));
	}
	/* String reviewSubject=request.getParameter("reviewSubject"); */
	
	//글번호가 전달되지 않은 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getParameter("reviewNum")==null) {
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
		return;
	}

	// 제품번호 가져옴
	int productNum = Integer.parseInt(request.getParameter("productNum"));
	
	//글번호를 전달받아 REVIEW 테이블의 단일행을 검색하여 게시글(ReviewDTO 객체)을 반환하는 
	//ReviewDAO 클래스의 메소드 호출
	ReviewDTO review=ReviewDAO.getDAO().selectReviewTableByNum(reviewNum);
	
	//검색된 게시글이 없는 경우에 대한 응답 처리 - 비정상적인 요청
	if(review==null) {
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
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
<%-- 페이지번호 출력 및 링크 제공 - 블럭화 처리 --%>
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
<style type="text/css">
#review_detail {
	width: 500px;
	margin: 0 auto;
}

#review_replay {
	width: 500px;
	margin: 0 auto;
	margin-top: 50px;
}

.table_review {
	border: 1px solid black;
	border-collapse: collapse;
}

.th_review, .td_review {
	border: 1px solid gray;
	padding: 5px;	
}

.th_review {
	width: 100px;
	background: pink;
	color: gray;
}

.td_review {
	width: 400px;
}

.subject, .content {
	text-align: left;
}

.content {
	height: 200px;
	vertical-align: middle;
}
/* 
#review_menu {
	text-align: right;
	margin: 5px;
}
*/

#review_listBtn {
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

<div id="review_detail">
	<h1>제품리뷰</h1>
	
	<%-- 검색된 게시글 출력 --%>
	<table class="table_review">
		<tr>
			<th class="th_review">작성자</th>
			<td class="td_review">
				<%=review.getReviewName() %>
			</td>
		</tr>
		<tr>
			<th class="th_review">작성일</th>
			<td class="td_review"><%=review.getReviewRegister() %></td>
		</tr>
		<tr>
			<th class="th_review">조회수</th>
			<td class="td_review"><%=review.getReviewReadcount()+1 %></td>
		</tr>
		<tr>
			<th class="th_review">제목</th>
			<td class="subject">
				<%=review.getReviewSubject() %>
			</td>
		</tr>
		<tr>
			<th class="th_review">내용</th>
			<td class="content">
				<% if(review.getReviewContent()!=null) { %>
					<%= review.getReviewContent().replace("\n", "<br>") %>
				<% } else { %>
					<%=review.getReviewContent()%>
				<% } %>				
				<br>
				<% if(review.getReviewImage()!=null) { %>
					<img src="<%=request.getContextPath()%>/<%=review.getReviewImage()%>" width="200">
				<% } %>
			</td>
		</tr>
	</table>
	
 	<!-- 버튼 태그 div -->
	<div id="review_menu" style="text-align: right;">
		<!-- 로그인 상태의 사용자면서 게시글 작성자인 경우에만 태그를 출력하여 링크 제공 -->
		<% if(loginClient!=null && (loginClient.getClientNum()==review.getReviewMemberNum())) { %>
			<button type="button" id="modifyBtn">리뷰수정</button>
		<% } %>
	</div>
</div>

<div id="review_replay">
	<h1>답변</h1>
	
	<form action="<%=request.getContextPath()%>/main_page/main.jsp?group=review_page&worker=review_replay_write_action" 
		method="post" id="reviewForm" enctype="multipart/form-data">
		
		<table>
			<tr>
				<th class="th_review">작성자</th>
				<td class="td_review">관리자</td>
			</tr>
			<tr>
				<th class="th_review">내용</th>
				<% if(review.getReviewReplay()==null) { %>
					<td class="content td_review" >답변이 없습니다.</td>
				<% } else { %>
					<td class="content td_review"><%= review.getReviewReplay().replace("\n", "<br>") %></td>
				<% } %>
			</tr>
		</table>
		
		<% if(loginClient!=null && loginClient.getClientStatus()==9) { %>
		<div id="review_menu" style="text-align: right;">
			<%-- 관리자인 경우에만 태그를 출력하여 링크 제공 --%>
				<button type="button" id="replyBtn">답변수정</button>
		</div>
		<% } else {} %>
	</form>
</div>

<div id="review_listBtn" style="text-align: right;">

	<% if(loginClient!=null && (loginClient.getClientNum()==review.getReviewMemberNum()
			|| loginClient.getClientStatus()==9)) { %>
		<button type="button" id="removeBtn">삭제</button>
	<% } %>
	<button type="button" id="listBtn">글목록</button>
</div>

<script type="text/javascript">
$("#modifyBtn").click(function() {
<%-- 	location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=review_page&worker=review_modify"
		+"&reviewNum=<%=review.getReviewNum()%>&pageNum=<%=pageNum%>"
		+"&pageSize=<%=pageSize%>&productNum=<%=productNum%>";	 --%>
		var referrer = document.referrer;

		if(referrer.includes('review_written')) {// 마이페이지 화면에서 이동됬으면 글목록 버튼 클릭시 다시 마이페이지로 이동
			location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=review_page&worker=review_modify"
				+"&reviewNum=<%=review.getReviewNum()%>&pageNum=<%=pageNum%>"
				+"&pageSize=<%=pageSize%>&productNum=<%=productNum%>&review_written";
		} else {// 아니면 해당제품의 상품상세로 이동
			location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=review_page&worker=review_modify"
				+"&reviewNum=<%=review.getReviewNum()%>&pageNum=<%=pageNum%>"
				+"&pageSize=<%=pageSize%>&productNum=<%=productNum%>";	
		}
});

$("#removeBtn").click(function() {
	if(confirm("게시글을 정말로 삭제 하시겠습니까?")) {
		location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=review_page&worker=review_remove_action"
			+"&reviewNum=<%=review.getReviewNum()%>&pageNum=<%=pageNum%>"
			+"&pageSize=<%=pageSize%>&productNum=<%=productNum%>";	
	}
});

$("#replyBtn").click(function() {
	location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=review_page&worker=review_replay_write"
		+"&replay=<%=review.getReviewReplay()%>&pageNum=<%=pageNum%>&pageSize=<%=pageSize%>"
		+"&orderNum=<%=review.getReviewOrderNum()%>&productNum=<%=productNum%>&reviewNum=<%=reviewNum%>";
});


$("#listBtn").click(function() {
	var referrer = document.referrer;

	if(referrer.includes('review_written')) {// 마이페이지 화면에서 이동됬으면 글목록 버튼 클릭시 다시 마이페이지로 이동
		location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review_written";
	} else {// 아니면 해당제품의 상품상세로 이동
		location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=product_page&worker=product"
			+"&productNum=<%=productNum%>&review_list&pageSize=<%=pageSize%>&pageNum=<%=pageNum%>#review_list";  
	}
});
</script>