<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@page import="xzy.itwill.DAO.NoticeDAO"%>
<%@page import="xyz.itwill.DTO.NoticeDTO"%>
<%@page import="xyz.itwill.DTO.QaDTO"%>
<%@page import="xzy.itwill.DAO.QaDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- REVIEW 테이블에 저장된 행을 검색하여 게시글 목록을 전달하여 응답하는 JSP 문서 --%>
<%-- => 게시글을 페이지 단위로 구분하여 검색해 출력 처리되도록 작성 - 페이징 처리 --%>
<%-- => [페이지번호] 태그를 클릭한 경우 [/review/review_list.jsp] 문서를 요청하여 페이지 이동 
- 페이지번호, 게시글갯수, 검색대상, 검색단어 전달(검색기능을 유지하기 위해 ) --%>
<%-- => [게시글갯수] 태그의 입력값을 변경한 경우 [/review/review_list.jsp] 문서를 요청하여 페이지 이동 
- 페이지번호, 게시글갯수, 검색대상, 검색단어 전달 --%>
<%-- => [검색] 태그를 클릭한 경우 [/review/review_list.jsp] 문서를 요청하여 페이지 이동 
- 검색대상, 검색단어 전달 --%>
<%-- => [글쓰기] 태그를 클릭한 경우 [/review/review_write.jsp] 문서를 요청하여 페이지 이동 
- 로그인 상태의 사용자에게만 태그를 출력하여 링크가 제공되도록 작성 --%>
<%-- => 게시글의 [제목] 태그를 클릭한 경우 [/review/review_detail.jsp] 문서를 요청하여 페이지 이동 
- 글번호, 페이지번호, 게시글갯수, 검색대상, 검색단어 전달 --%>
<%
	//게시글 검색 기능에 필요한 전달값(검색대상과 검색단어)을 반환받아 저장
	String search=request.getParameter("search");//검색대상
	if(search==null) {//전달값이 없는 경우 - 게시글 검색 기능을 사용하지 않은 경우
		search="";
	}
	
	String keyword=request.getParameter("keyword");//검색단어
	if(keyword==null) {//전달값이 없는 경우
		keyword="";
	}

	//페이징 처리에 필요한 전달값(페이지번호과 게시글갯수)을 반환받아 저장 - 중요
	int pageNum=1;//페이지번호- 전달값이 없는 경우 저장된 초기값 설정
	if(request.getParameter("pageNum")!=null) {//전달값이 있는 경우
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	int pageSize=10;//게시글갯수- 전달값이 없는 경우 저장된 초기값 설정
	if(request.getParameter("pageSize")!=null) {//전달값이 있는 경우
		pageSize=Integer.parseInt(request.getParameter("pageSize"));
	}

	//검색정보(검색대상과 검색단어)를 전달받아 REVIEW 테이블에 저장된 게시글 중 검색대상의 컬럼에
	//검색단어가 포함된 게시글의 갯수를 검색하여 반환하는 ReviewDAO 클래스의 메서드 호출
	// => 검색 기능을 사용하지 않을 경우 REVIEW 테이블에 저장된 모든 게시글의 갯수를 반환
	int totalNotice=NoticeDAO.getDAO().selectTotalNotice(search, keyword);
	int totalQa=QaDAO.getDAO().selectTotalQa(search, keyword);//검색된 게시글의 총갯수
	
	//전체 페이지의 총갯수를 계산하여 저장
	//int totalPage=totalReview/pageSize+totalReview%pageSize==0?0:1; - 삼항연산자
	int totalPage=(int)Math.ceil((double)totalQa/pageSize);//페이지의 총갯수 - 권장
 
	//전달받은 페이지번호가 비정상적인 경우
	if(pageNum<=0 || pageNum>totalPage) {
		pageNum=1;
	}
	
	//페이지번호에 대한 게시글의 시작 행번호를 계산하여 저장
	//ex) 1Page : 1, 2Page : 11, 3Page : 21, 4Page : 31, ...
	int startRow=(pageNum-1)*pageSize+1;
	
	//페이지번호에 대한 게시글의 종료 행번호를 계산하여 저장
	//ex) 1Page : 10, 2Page : 20, 3Page : 30, 4Page : 40, ...
	int endRow=pageNum*pageSize;
	
	//마지막 페이지의 게시글의 종료 행번호가 게시글의 총갯수보다 많은 경우 종료 행번호 변경
	if(endRow>totalQa) {
		endRow=totalQa;
	}
	
	//페이징 처리 관련 정보(시작 행번호와 종료 행번호)와 게시글 검색 기능 관련 정보(검색대상과
	//검색단어)를 전달받아 REVIEW 테이블에 저장된 행을 검색하여 게시글 목록을 반환하는 ReviewDAO 
	//클래스의 메소드 호출
	List<NoticeDTO> noticeList=NoticeDAO.getDAO().selectNoticeList(startRow, endRow, search, keyword);
	List<QaDTO> qaList=QaDAO.getDAO().selectQaList(startRow, endRow, search, keyword);
	
	//session 객체에 저장된 권한 관련 속성값을 반환받아 저장
	// => 로그인 상태의 사용자에게만 글쓰기 권한 제공
	// => 게시글이 비밀글인 경우 로그인 상태의 사용자가 게시글 작성자이거나 관리자인 경우에만 권한 제공
	ClientDTO loginClient=(ClientDTO)session.getAttribute("loginClient");
	
	//서버 시스템의 현재 날짜를 제공받아 저장
	// => 게시글 작성날짜와 비교하여 게시글 작성날짜를 다르게 출력되도록 응답 처리
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	//페이지에 출력될 게시글의 일련번호 시작값을 계산하여 저장
	// => 검색된 게시글의 총갯수가 91개인 경우 >> 1Page : 91, 2Page : 81, 3Page, 71
	int noticeDisplayNum=totalNotice-(pageNum-1)*pageSize;
	int qaDisplayNum=totalQa-(pageNum-1)*pageSize;
	
%>
<style type="text/css">
h1 {
	text-align: center;
}

#notice_list {
	width: 1000px;
	margin: 0 auto;
	text-align: center;
}

#qa_list {
	width: 1000px;
	margin: 0 auto;
	margin-top: 30px;
	text-align: center;
}

#notice_title {
	font-size: 1.2em;
	font-weight: bold;	
	text-align: left;
}

#qa_title {
	font-size: 1.2em;
	font-weight: bold;
	text-align: left;
}

.table_review {
	margin: 5px auto;
	border: 1px solid black;
	border-collapse: collapse;
}

.th_review {
	border: 1px solid gray;
	background: pink;
	color: black;
}

.td_review {
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
	color: pink;
	font-weight: bold;
}

#qa_list a:hover {
	text-decoration: none; 
	color: pink;
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

#noticeWriteBtn {
	height: 100%;
	margin-top: 10px;
	margin-bottom: 7px;
	background-color: rgb(239, 239, 239);
 	color: black;
 	font-weight: bold;
 	border-radius: 5px;
 	border: 1px solid gray;
}

#qaWriteBtn {
	height: 100%;
	margin-bottom: 7px;
	background-color: rgb(239, 239, 239);
 	color: black;
 	font-weight: bold;
 	border-radius: 5px;
 	border: 1px solid gray;
}
</style>

<h1 style="margin-top:30px; margin-bottom:30px;">고객센터</h1>
<div id="notice_list">
	<div id="notice_title">- 공지사항/Q&A</div>
		
	<div style="text-align: right;">
	<%if(loginClient!=null && loginClient.getClientStatus()==9) {//로그인 상태의 사용자가 JSP 문서를 요청한 경우 %>
		<button type="button" id="noticeWriteBtn">공지작성</button>
	<% } %>
	</div>
	
	<%-- 공지사항 --%>
	<%-- 게시글 목록 출력 --%>
	<table>
		<tr>
			<th width="100" class="th_review">글번호</th>
			<th width="500" class="th_review">제목</th>
			<th width="100" class="th_review">작성자</th>
			<th width="100" class="th_review">조회수</th>
			<th width="200" class="th_review">작성일</th>
		</tr>
		
		<% if(totalNotice==0) { %>
			<tr>
				<td colspan="5" class="td_review">검색된 게시글이 없습니다.</td>
			</tr>
		<% } else { %>
			<%-- List 객체의 요소(ReviewDTO 객체)를 차례대로 제공받아 저장하여 처리하기 위한 반복문 --%>
			<% for(NoticeDTO notice : noticeList) { %>
			<tr >
				<%-- 게시글의 글번호가 아닌게시글의 일련번호 출력 --%>
				<td class="td_review"><%=noticeDisplayNum %></td>
				<% noticeDisplayNum--; %><%-- 게시글 일련번호를 1씩 감소하여 저장 --%>
				
				<%-- 제목 --%>
				<td class="subject td_review">
					<%-- 답글 기능 지움 --%>
				
					<%-- 게시글 상태를 비교하여 제목과 링크를 구분해 응답 처리 --%>
					<%
						String url=request.getContextPath()+"/main_page/main.jsp?group=notice_page&worker=notice_detail"
						+"&noticeNum="+notice.getNoticeNum()+"&pageNum="+pageNum+"&pageSize="+pageSize
						+"&search="+search+"&keyword="+keyword;
					%>
						<a href="<%=url%>"><%=notice.getNoticeTitle() %></a>
				</td>			
					<%-- 작성자 출력 --%>
					<td class="td_review">과자몰</td>
								
					<%-- 조회수 출력 --%>
					<td class="td_review"><%=notice.getNoticeCount() %></td>
								
					<%-- 작성일 출력 : 오늘 작성된 게시글인 경우 시간만 출력하고 오늘
					 작성된 게시글이 아닌 경우 날짜와 시간 출력 --%>
					 <td class="td_review">
					 	<%-- 오늘 작성된 게시글인 경우 --%>

						 		<%=notice.getNoticeDate() %>
					 </td> 
				<%--
				<% } else {//삭제글인 경우 %>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				<% } %>
				--%>
			</tr>	
		<% } %>
	<% } %>
	</table>
	
	<div id="qa_list">
		<div id="qa_title">- Q&A(<%=totalQa%>)</div>
	</div>
	
	<div style="text-align: right;">
		<%if(loginClient!=null){ %>
			<% if(loginClient.getClientStatus()==1) { %>
				<button type="button" id="qaWriteBtn">QA작성</button>
			<%} %>
		<%} %>
	</div>
	
	<%-- Q&A --%>
	<%-- 게시글 목록 출력 --%>
	<table class="table_review">
		<tr>
			<th width="100" class="th_review">글번호</th>
			<th width="100" class="th_review">답변</th>
			<th width="500" class="th_review">제목</th>
			<th width="100" class="th_review">작성자</th>
			<th width="100" class="th_review">조회수</th>
			<th width="200" class="th_review">작성일</th>
		</tr>
		
		<% if(totalQa==0) { %>
			<tr>
				<td colspan="5" class="td_review">검색된 게시글이 없습니다.</td>
			</tr>
		<% } else { %>
			<%-- List 객체의 요소(ReviewDTO 객체)를 차례대로 제공받아 저장하여 처리하기 위한 반복문 --%>
			<% for(QaDTO qa : qaList) { %>
			<tr>
				<%-- 게시글의 글번호가 아닌게시글의 일련번호 출력 --%>
				<td class="td_review"><%=qaDisplayNum %></td>
				<% qaDisplayNum--; %><%-- 게시글 일련번호를 1씩 감소하여 저장 --%>
											
			<% if(qa.getQaReplay()==null) { %>
				<td class="td_review">미완료</td>
			<% } else { %>
				<td class="td_review">완료</td>
			<% } %>
				
				<%-- 제목 --%>
				<td class="subject td_review">
					<%-- 게시글이 답글인 경우에 대한 응답 처리 --%>
				
					<%-- 게시글 상태를 비교하여 제목과 링크를 구분해 응답 처리 --%>
					<%
						String url=request.getContextPath()+"/main_page/main.jsp?group=notice_page&worker=qa_detail"
						+"&qaNum="+qa.getQaNum()+"&pageNum="+pageNum+"&pageSize="+pageSize
						+"&search="+search+"&keyword="+keyword;
					%>
					<a href="<%=url%>"><%=qa.getQaSubject() %></a>
				</td>
				
				<%-- 작성자 출력 --%>
				<td class="td_review"><%=qa.getQaName() %></td>
							
				<%-- 조회수 출력 --%>
				<td class="td_review"><%=qa.getQaReadCount() %></td>
							
				<%-- 작성일 출력 : 오늘 작성된 게시글인 경우 시간만 출력하고 오늘
				 작성된 게시글이 아닌 경우 날짜와 시간 출력 --%>
				<td class="td_review">
				 	<%-- 오늘 작성된 게시글인 경우 --%>
				 	<%=qa.getQaRegister() %>
				</td>
			</tr>
		<% } %>
	<% } %>
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
	<form action="<%=request.getContextPath() %>/main_page/main.jsp?group=notice_page&worker=notice_main" method="post" >
		<%-- select 태그를 사용하여 검색대상을 선택해 전달 - 전달값은 반드시 컬럼명으로 설정(DAO에서 사용하기 위해 컬럼명으로 설정) --%>
		<select name="search">
			<option value="client_name" <% if(search.equals("client_name")) { %>  selected <% } %>>&nbsp;작성자&nbsp;</option>
			<option value="qa_subject" <% if(search.equals("qa_subject")) { %>  selected <% } %>>&nbsp;제목&nbsp;</option>
			<option value="qa_content" <% if(search.equals("qa_content")) { %>  selected <% } %>>&nbsp;내용&nbsp;</option>
		</select>
		<input type="text" name="keyword" value="<%=keyword%>">
		<button type="submit">검색</button>
	</form>
</div>

<script type="text/javascript">
$("#qaCount").change(function() {
	//alert($("#reviewCount").val());
	location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=notice_page&worker=notice_main"
		+"&pageNum=<%=pageNum%>&pageSize="+$("#qaCount").val()
		+"&search=<%=search%>&keyword=<%=keyword%>";
});

//전달값 없이 전달
$("#noticeWriteBtn").click(function() {
	location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=notice_page&worker=notice_write";
});

$("#qaWriteBtn").click(function() {
	location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=notice_page&worker=qa_write";
});
</script>