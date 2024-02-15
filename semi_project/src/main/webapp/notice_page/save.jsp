<%@page import="xyz.itwill.DTO.QaDTO"%>
<%@page import="xzy.itwill.DAO.QaDAO"%>
<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/style/review_list_style.css" type="text/css" rel="stylesheet">
<%
	
	String search=request.getParameter("search");
	if(search==null) {
		search="";
	}
	
	String keyword=request.getParameter("keyword");
	if(keyword==null) {
		keyword="";
	}
	
	int pageNum=1;
	if(request.getParameter("pageNum")!=null) {
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	int pageSize=10;
	if(request.getParameter("pageSize")!=null) {
		pageNum=Integer.parseInt(request.getParameter("pageSize"));
	}
	
	
	
	//검색정보(검색대상과 검색단어)를 전달받아 REVIEW 테이블에 저장된 게시글 중 검색대상의 컬럼에
	//검색단어가 포함된 게시글의 갯수를 검색하여 반환하는 ReviewDAO 클래스의 메서드 호출
	int totalQa=QaDAO.getDAO().selectTotalQa(search, keyword);
	
	
	//전체 페이지의 총갯수를 계산하여 저장
	int totalPage=(int)Math.ceil((double)totalQa/pageSize);
	
	if(pageNum<=0 || pageNum>totalPage) {
		pageNum=1;
	}
	
	int startRow=(pageNum-1)*pageSize+1;
	
	int endRow=pageNum*pageSize;
	
	if(endRow>totalQa) {
		endRow=totalQa;
	}
	
	
	
	//페이징 처리 관련 정보
	List<QaDTO> QaList=QaDAO.getDAO().selectQaList(startRow, endRow, search, keyword);
	
	//session 객체에 저장된 권한 관련 속성값을 반환받아 저장
	ClientDTO loginClient=(ClientDTO)session.getAttribute("loginClient");
	
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	int displayNum=totalQa-(pageNum-1)*pageSize;
%>

<style type="text/css">
<%-- 사용 안하지만 혹시 몰라서 제거 안했음
#notice_list {
	width: 1000px;
	margin: 0 auto;
	text-align: center;
}

#notice_title {
	font-size: 1.2em;
	font-weight: bold;
}

table {
	margin: 5px auto;
	border-top: 0;
	border-bottom: 1px solid #d7d5d5;
	border-collapse: collapse;
	color: #fff;
}

th {
	border-bottom: 1px solid #dfdfdf;
	background: white;
	color: black;
}

td {
	border: 1px solid black;
	text-align: center;	
}

.subject {
	text-align: left;
	padding: 5px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

#notice_list a:hover {
	text-decoration: none; 
	color: blue;
	font-weight: bold;
}

.subject_hidden {
	background: black;
	color: white;
	font-size: 14px;
	border: 1px solid black;
	border-radius: 4px;
}

#page_list {
	font-size: 1.1em;
	margin: 10px;
}

#page_list a:hover {
	font-size: 1.3em;
}
--%>

#noticeWriteBtn {
	border: 1px solid gray;
	background: pink;
	color: black;
}

#qaWriteBtn {
	border: 1px solid gray;
	background: pink;
	color: black;
}

</style>

<h2>고객센터</h2>
<div id="notice_list">
	<div id="review_title">공지사항/Q&A</div>
	<br>
	<div id="notice_title"></div>
	
	
	<%-- 게시글 목록 출력 --%>
	<table>
		<div></div>
	</table>
	<table>

		<tr>
			<th width="100">글번호</th>
			<th width="500">제목</th>
			<th width="100">작성자</th>
			<th width="100">조회수</th>
			<th width="200">작성일</th>
		</tr>
		
		
		
	
			<%-- List 객체의 요소(ReviewDTO 객체)를 차례대로 제공받아 저장하여 처리하기 위한 반복문 --%>
			<% for(ReviewDTO review : reviewList) { %>
			<tr>
				<%-- 게시글의 글번호가 아닌게시글의 일련번호 출력 --%>
				<td></td>
				<%-- 게시글 일련번호를 1씩 감소하여 저장 --%>
				
				<%-- 제목 - 없어도 될듯함 --%>
				
					<%-- 게시글 상태를 비교하여 제목과 링크를 구분해 응답 처리 --%>
					<%
						String URL=request.getContextPath()+"/main_page/main.jsp?group=notice_page&worker=notice_detail";	
					%>
							
					<%-- 작성자 출력 --%>
					<td>과자몰</td>
								
					<%-- 조회수 출력 --%>
					<td><%=notice.getNoticeCount() %></td>
								
					<%-- 작성일 출력 : 오늘 작성된 게시글인 경우 시간만 출력하고 오늘
					 작성된 게시글이 아닌 경우 날짜와 시간 출력 --%>
					 <td>
					 	<%-- 오늘 작성된 게시글인 경우 --%>
					 	
					 		
					 
					 </td>
		
					<td>&nbsp;</td>
				
			</tr>	
		
		
	</table>
	<table>
		<tr>
			<th width="100"></th>
			<th width="500"></th>
			<th width="100"></th>
			<th width="100"></th>
			<th width="200"></th>
		</tr>
		<tr id="nolist">
			<td colspan="5">검색된 게시글이 없습니다.</td>
		</tr>
	</table>
	
	<%-- 페이지번호 출력 및 링크 제공 - 블럭화 처리(페이지 번호를 하나의 그룹화 시킨다고 생각하기) --%>
	<%
		//하나의 페이지블럭에 출력될 페이지번호의 갯수 설정
		int blockSize=5;
	
		//페이지블럭에 출력될 시작 페이지번호를 계산하여 저장
		//ex)1Block : 1, 2Block : 6, 3Block : 11, 4Block : 16,...
		int startPage=(pageNum-1)/blockSize*blockSize+1;
		        
		//페이지블럭에 출력될 종료 페이지번호를 계산하여 저장
		//ex)1Block : 5, 2Block : 10, 3Block : 15, 4Block : 20,...
		int endPage=startPage+blockSize-1;
		
		//종료 페이지번호가 페이지 총갯수보다 큰 경우 종료 페이지번호 변경 
		if(endPage>totalPage) {
			endPage=totalPage;
		}
	%>
	
	<div style="text-align: right;" id="notice_write">
		<% if(loginClient!=null ) { %>
			<button type="button" id="qaWriteBtn">QA쓰기</button>
		<% } %>
		
		<% if(loginClient!=null && loginClient.getClientStatus()==9) { %>
			<button type="button" id="noticeWriteBtn">공지쓰기</button>
		<% } %>
		
		
		&nbsp;&nbsp;&nbsp;
	</div>
	
	
	<div id="page_list">
		<%
			String responseURL=request.getContextPath()+"/main_page/main.jsp?group=notice_page&worker=notice_main"
					+"&pageSize="+pageSize+"&search="+search+"&keyword="+keyword;
		%>
		<%-- 이전 페이지블럭이 있는 경우에만 링크 제공 --%>
		<% if(startPage>blockSize) { %>
			
			<a href="<%=responseURL%>&pageNum=<%=startPage-blockSize%>">[이전]</a>
		<% } else { %>	
			[이전]
		<% } %>
		
		<% for(int i=startPage;i<=endPage;i++) { %>
			<%-- 요청 페이지번호와 출력된 페이지번호가 같지 않은 경우에만 링크 제공 --%>
		<% if(pageNum != i) { %>
				<a href="<%=responseURL%>&pageNum=<%=i%>">[<%=i %>]</a>
			<% } else { %>
				[<%=i %>]
			<% } %>
		<% } %>
		<%-- 다음 페이지블럭이 있는 경우에만 링크 제공 --%>
		<% if(endPage!=totalPage) { %>
			<a href="<%=responseURL%>&pageNum=<%=startPage+blockSize%>">[다음]</a>
		<% } else { %>	
			[다음]
		<% } %>
	</div>


		<%-- 사용자로부터 검색 관련 정보를 입력받기 위한 태그 출력 --%>
	<form action="<%=request.getContextPath() %>/notice_pate/main.jsp?group=notice_main&worker=notice_main" method="post">
		<%-- select 태그를 사용하여 검색대상을 선택해 전달 - 전달값은 반드시 컬럼명으로 설정(DAO에서 사용하기 위해 컬럼명으로 설정) --%>
	<select name="search">
			<option value="name" <% if(search.equals("name")) { %>  selected <% } %>>&nbsp;작성자&nbsp;</option>
			<option value="review_subject" <% if(search.equals("review_subject")) { %>  selected <% } %>>&nbsp;제목&nbsp;</option>
			<option value="review_content" <% if(search.equals("review_content")) { %>  selected <% } %>>&nbsp;내용&nbsp;</option>
		</select>
		<input type="text" name="keyword" value="<%=keyword%>">
		<button type="submit">검색</button>
	</form>
</div>

<script type="text/javascript">
//전달값 없이 전달
$("#noticeWriteBtn").click(function() {
	location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=notice_page&worker=notice_write";
});
$("#qaWriteBtn").click(function() {
	location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=notice_page&worker=qa_write";
});
</script>




<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@page import="xzy.itwill.DAO.QaDAO"%>
<%@page import="xyz.itwill.DTO.QaDTO"%>
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
	if(request.getParameter("qaNum")==null) {
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
		return;
	}

	//전달값을 반환받아 저장
	int qaNum=Integer.parseInt(request.getParameter("qaNum"));
	String pageNum=request.getParameter("pageNum");
	String pageSize=request.getParameter("pageSize");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
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
	ClientDTO loginClient=(ClientDTO)session.getAttribute("loginClient");
	
	/*
	if(review.getReviewStatus()==2) {//검색된 게시글이 비밀글인 경우
		//JSP 문서를 요청한 사용자가 비로그인 상태의 사용자이거나 로그인 상태의 사용자가
		//게시글 작성자 및 관리자가 아닌 경우에 대한 응답 처리 - 비정상적인 요청
		if(loginMember==null || loginMember.getMemberNum()!=review.getReviewMember()
				&& loginMember.getMemberStatus()!=9) {
			request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
			return;
		}
	}
	*/
	
	//글번호를 전달받아 REVIEW 테이블의 저장된 행의 게시글 조회수가 1 증가되도록 변경하고 
	//변경행의 갯수를 반환하는 ReviewDAO 클래스의 메소드 호출
	QaDAO.getDAO().updateQaReadCount(qaNum);
%>
<style type="text/css">
#qa_detail {
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

h1 {
	text-align: center;
}

th {
	width: 100px;
	background: pink;
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

#qa_menu {
	text-align: right;
	margin: 5px;
}
</style>

<div id="qa_detail">
	<h1>Q&A</h1>
	
	<%-- 검색된 게시글 출력 --%>
	<table>
		<tr>
			<th>작성자</th>
			<td>
				<%=qa.getQaName() %>
				<%-- 로그인 상태의 사용자가 관리자인 경우 클라이언트의 IP 주소 출력 - 없어도 될 듯
				<% if(loginMember!=null && loginMember.getMemberStatus()==9) { %>
					[<%=review.getReviewIp() %>]				
				<% } %>
				--%>
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
		<tr>
			<th>제목</th>
			<td class="subject">
				<%-- 비밀글 없음
				<% if(review.getReviewStatus()==2) {//검색된 게시글이 비밀글인 경우 %>
					[비밀글]
				<% } %>
				--%>
				<%=qa.getQaSubject() %>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td class="content">
				<%=qa.getQaContent().replace("\n", "<br>")%>
				<br>
				<% if(qa.getQaImage()!=null) { %>
					<img src="<%=request.getContextPath()%>/<%=qa.getQaImage()%>" width="200">
				<% } %>
			</td>
		</tr>
	</table>
	
	<%-- 태그를 출력하여 링크 제공 --%>
	<div id="qa_menu">
		<%-- 로그인 상태의 사용자 중 게시글 작성자이거나 관리자인 경우에만 태그를 출력하여 링크 제공 --%>
		<% if(loginClient!=null && (loginClient.getClientNum()==qa.getQaMember()
			|| loginClient.getClientStatus()==9)) { %>
			<button type="button" id="modifyBtn">글변경</button>
			<button type="button" id="removeBtn">글삭제</button>
			<button type="button" id="replyBtn">답글쓰기</button>
		<% } %>
		
		<%-- 로그인 상태의 사용자인 경우에만 태그를 출력하여 링크 제공 - 없앴음 --%>

		<button type="button" id="listBtn">글목록</button>
	</div>
</div>

<script type="text/javascript">
//pageNum,search,keyword 글 목록 위해 전해주는 값(목록에서 상세 페이지)
$("#modifyBtn").click(function() {
	location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=notice_page&worker=qa_modify"
		+"&qaNum=<%=qa.getQaNum()%>&pageNum=<%=pageNum%>"
		+"&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>";	
});

$("#removeBtn").click(function() {
	if(confirm("게시글을 정말로 삭제 하시겠습니까?")) {
		location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=notice_page&worker=qa_remove_action"
			+"&qaNum=<%=qa.getQaNum()%>&pageNum=<%=pageNum%>"
			+"&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>";	
	}
});

$("#replyBtn").click(function() {
	location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=notice_page&worker=qa_write"
		+"&qaNum=<%=qa.getQaNum()%>&pageNum=<%=pageNum%>"
		+"&pageNum=<%=pageNum%>&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>";	
});

$("#listBtn").click(function() {
	location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=notice_page&worker=notice_main"
		+"&pageNum=<%=pageNum%>&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>";	
});
</script>