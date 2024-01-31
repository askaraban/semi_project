<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	//int totalNotice=NoticeDAO.getDAO().selectTotalNotice(search, keyword);
	
	/*
	//전체 페이지의 총갯수를 계산하여 저장
	int totalPage=(int)Math.ceil((double)totalNotice/pageSize);
	
	if(pageNum<=0 || pageNum>totalPage) {
		pageNum=1;
	}
	
	int startRow=(pageNum-1)*pageSize+1;
	
	int endRow=pageNum*pageSize;
	
	if(endRow>totalNotice) {
		endRow=totalNotice;
	}
	*/
	
	
	//페이징 처리 관련 정보
	//List<NoticeDTO> reviewList=ReviewDAO
	
	//session 객체에 저장된 권한 관련 속성값을 반환받아 저장
	ClientDTO loginMember=(ClientDTO)session.getAttribute("loginMember");
	
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	//int displayNum=totalNotice-(pageNum-1)*pageSize;
%>
<style type="text/css">
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

</style>

<h2>고객센터</h2>
<div id="notice_list">
	<br>
	<div id="notice_title"></div>
	
	
	<%-- 게시글 목록 출력 --%>
	<table>
		<div></div>
	</table>
	<table>
		<tr>
			<th></th>
			<th></th> 
			<th></th>
			<th></th>
			<th></th>
		</tr>
		<tr>
			<th width="100">번호</th>
			<th width="420">제목</th>
			<th width="150">작성자</th>
			<th width="150">작성일</th>
			<th width="80">조회</th>
		</tr>
		
		
		
	
			<%-- List 객체의 요소(ReviewDTO 객체)를 차례대로 제공받아 저장하여 처리하기 위한 반복문 --%>
			
			<tr>
				<%-- 게시글의 글번호가 아닌게시글의 일련번호 출력 --%>
				<td></td>
				<%-- 게시글 일련번호를 1씩 감소하여 저장 --%>
				
				<%-- 제목 - 없어도 될듯함 --%>
				
					<%-- 게시글 상태를 비교하여 제목과 링크를 구분해 응답 처리 --%>
					<%
						String url=request.getContextPath()+"/main_page/main.jsp?group=notice_page&worker=notice_detail";
						
					%>
							
					<%-- 작성자 출력 --%>
					<td></td>
								
					<%-- 조회수 출력 --%>
					<td></td>
								
					<%-- 작성일 출력 : 오늘 작성된 게시글인 경우 시간만 출력하고 오늘
					 작성된 게시글이 아닌 경우 날짜와 시간 출력 --%>
					 <td>
					 	<%-- 오늘 작성된 게시글인 경우 --%>
					 	
					 		
					 
					 </td>
		
					<td>&nbsp;</td>
				
			</tr>	
		
		
	</table>
	
	<%-- 페이지번호 출력 및 링크 제공 - 블럭화 처리(페이지 번호를 하나의 그룹화 시킨다고 생각하기) --%>
	<%
		
	%>
	
	<div style="text-align: right;" id="notice_write">
		<button type="button" id="writeBtn">글쓰기</button>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
	
	
	<div id="page_list">
		
	
		<%-- 이전 페이지블럭이 있는 경우에만 링크 제공 --%>
		
			
			<a><</a>
		
			
		
		
		
			<%-- 요청 페이지번호와 출력된 페이지번호가 같지 않은 경우에만 링크 제공 --%>
			
	
		<%-- 다음 페이지블럭이 있는 경우에만 링크 제공 --%>
		
			<a>></a>
		
		
		
	
			
		
	</div>


		<%-- 사용자로부터 검색 관련 정보를 입력받기 위한 태그 출력 --%>
	<form action="<%=request.getContextPath() %>/main.jsp?group=notice&worker=notice_main" method="post">
		<%-- select 태그를 사용하여 검색대상을 선택해 전달 - 전달값은 반드시 컬럼명으로 설정(DAO에서 사용하기 위해 컬럼명으로 설정) --%>
	</form>
</div>

<script type="text/javascript">
//전달값 없이 전달
$("#writeBtn").click(function() {
	location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=notice_page&worker=notice_write";
});
</script>