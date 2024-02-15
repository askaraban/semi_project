<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@page import="xzy.itwill.DAO.ReviewDAO"%>
<%@page import="xyz.itwill.DTO.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/style/review_list_style.css" type="text/css" rel="stylesheet">
<%
	// 제품번호 가져옴
	int productNum = Integer.parseInt(request.getParameter("productNum"));

	//페이징 처리에 필요한 전달값(페이지번호과 게시글갯수)을 반환받아 저장
	int pageNum=1;//페이지번호- 전달값이 없는 경우 저장된 초기값 설정
	if(request.getParameter("pageNum")!=null) {//전달값이 있는 경우
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	int pageSize=5;//게시글갯수- 전달값이 없는 경우 저장된 초기값 설정
	if(request.getParameter("pageSize")!=null) {//전달값이 있는 경우
		pageSize=Integer.parseInt(request.getParameter("pageSize"));
	}
	
	// REVIEW_TABLE에 저장된 제품별 리뷰의 count(갯수)를 반환하는 메소드 호출
	int productReview=ReviewDAO.getDAO().selectReviewCountByProductNum(productNum);
	
	//전체 페이지의 총갯수를 계산하여 저장
	//int totalPage=totalReview/pageSize+totalReview%pageSize==0?0:1;
	int totalPage=(int)Math.ceil((double)productReview/pageSize);//페이지의 총갯수
	if(totalPage == 0) {
		totalPage=1;
	}
	
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
	if(endRow>productReview) {
		endRow=productReview;
	}
	
	//페이징 처리 관련 정보(시작 행번호와 종료 행번호)와 게시글 검색 기능 관련 정보(검색대상과
	//검색단어)를 전달받아 REVIEW 테이블에 저장된 행을 검색하여 게시글 목록을 반환하는 ReviewDAO 
	//클래스의 메소드 호출
	List<ReviewDTO> reviewList = ReviewDAO.getDAO().selectReviewListByReviewProductNum(startRow, endRow, productNum);
	
	//session 객체에 저장된 권한 관련 속성값을 반환받아 저장
	// => 로그인 상태의 사용자에게만 글쓰기 권한 제공
	// => 게시글이 비밀글인 경우 로그인 상태의 사용자가 게시글 작성자이거나 관리자인 경우에만 권한 제공
	ClientDTO loginClient = (ClientDTO)session.getAttribute("loginClient");
	
	//서버 시스템의 현재 날짜를 제공받아 저장
	// => 게시글 작성날짜와 비교하여 게시글 작성날짜를 다르게 출력되도록 응답 처리
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	//페이지에 출력될 게시글의 일련번호 시작값을 계산하여 저장
	// => 검색된 게시글의 총갯수가 91개인 경우 >> 1Page : 91, 2Page : 81, 3Page, 71
	int displayNum=productReview-(pageNum-1)*pageSize;
	
%>
<div class="listArea">
	<ul class="menu">
		<li>
			<a href="#productDetailImg">상세정보</a>
		</li>
		<li class="selected">
			<a href="#review_list">리뷰 (<%=productReview %>)</a>
		</li>
		<li>
			<a href="#qa_list">Q&A</a>
		</li>
	</ul>
</div>
	
<div id="review_list">
	<%-- 검색된 게시글 총갯수 출력 --%>
	<div id="review_title" style="margin-bottom:65px; margin-top:40px; font-size: 25px;">제품후기목록(<%=productReview %>)</div>
	
	<%-- 게시글 목록 출력 --%>
	<table>
		<tr>
			<th width="100">글번호</th>
			<th width="100">답변</th>
			<th width="400">제목</th>
			<th width="100">작성자</th>
			<th width="100">조회수</th>
			<th width="200">작성일</th>
		</tr>
		<% if(productReview==0) {//검색된 게시글이 없는 경우 %>
			<tr id="nolist">
				<td colspan="5">검색된 게시글이 없습니다.</td>
			</tr>
		<% } else {//검색된 게시글이 있는 경우 %>
			<%-- List 객체의 요소(ReviewDTO 객체)를 차례대로 제공받아 저장하여 처리하기 위한 반복문 --%>
			<% for(ReviewDTO review : reviewList) { %>
			<tr>
				<%-- 게시글의 글번호가 아닌 게시글의 일련번호 출력 --%>
				<td><%=displayNum %></td>
				<% displayNum--; %><%-- 게시글 일련번호를 1씩 감소하여 저장 --%>
				
				<% if(review.getReviewReplay()==null) { %>
					<td>미완료</td>
				<% } else { %>
					<td>완료</td>
				<% } %>
				
				<%-- 제목 출력 --%>
				<td class="subject">
<%-- 					게시글이 답글인 경우에 대한 응답 처리
					<% if(review.getReviewReplay() != null) {//답글인 경우 
						int reviewReplayLen = 1; %>
						게시글(답글)의 깊이를 제공받아 왼쪽 여백 설정
						<span style="margin-left: <%=reviewReplayLen*20%>px;">┗[답글]</span>
					<% } %> --%>
				
					<%-- 게시글 상태를 비교하여 제목과 링크를 구분해 응답 처리 --%>
					<%
						String url=request.getContextPath()+"/main_page/main.jsp?group=review_page&worker=review_detail"
							+"&reviewNum="+review.getReviewNum()+"&productNum="+review.getReviewProductNum()+"&pageNum="+pageNum+"&pageSize="+pageSize
							+"&reviewSubject="+review.getReviewSubject()+"&replay="+review.getReviewReplay();
					%>
					<a href="<%=url%>"><%=review.getReviewSubject() %></a>
				</td>
				
				<%-- 작성자(회원이름) 출력 --%>
				<td><%= review.getReviewName() %></td>
							
				<%-- 조회수 출력 --%>
				<td><%=review.getReviewReadcount() %></td>
							
				<%-- 작성일 출력 : 오늘 작성된 게시글인 경우 시간만 출력하고 오늘 작성된
				게시글이 아닌 경우 날짜와 시간 출력 --%>	
				<td>
					<%-- 오늘 작성된 게시글인 경우 --%>
					<% if(currentDate.equals(review.getReviewRegister().substring(0, 10))) { %>
						<%=review.getReviewRegister().substring(0, 10) %>
					<% } else { %>
						<%=review.getReviewRegister().substring(0, 10) %>
					<% } %>
				</td>		
			</tr>	
			<% } %>
		<% } %>
	</table>
	
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
		
		//종료 페이지번호가 페이지 총갯수보다 큰 경우 종료 페이지번호 변경 
		if(endPage>totalPage) {
			endPage=totalPage;
		}
	%>
	
	<div id="page_list">
		<%
			String responseUrl=request.getContextPath()+"/main_page/main.jsp?group=product_page&worker=product"
					+"&productNum="+productNum+"&review_list"+"&pageSize="+pageSize;
		%>
		
		<%-- 이전 페이지블럭이 있는 경우에만 링크 제공 --%>
		<% if(startPage>blockSize) { %>
			<a href="<%=responseUrl%>&pageNum=<%=startPage-blockSize%>#review_list">[이전]</a>
		<% } else { %>	
			[이전]
		<% } %>
		
		<% for(int i=startPage;i<=endPage;i++) { %>
			
			<%-- 요청 페이지번호와 출력된 페이지번호가 같지 않은 경우에만 링크 제공 --%>
			<% if(pageNum != i) { %>
				<a href="<%=responseUrl%>&pageNum=<%=i%>#review_list">[<%=i %>]</a>
			<% } else { %>
				[<%=i %>]
			<% } %>
		<% } %>
		
		<%-- 다음 페이지블럭이 있는 경우에만 링크 제공 --%>
		<% if(endPage!=totalPage) { %>
			<a href="<%=responseUrl%>&pageNum=<%=startPage+blockSize%>#review_list">[다음]</a>
		<% } else { %>	
			[다음]
		<% } %>
	</div>
</div>