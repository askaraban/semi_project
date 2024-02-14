<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="xyz.itwill.DTO.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="xzy.itwill.DAO.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
	crossorigin="anonymous"></script>
<link href="<%=request.getContextPath()%>/style/my_page_order.css"
	type="text/css" rel="stylesheet">

<%@include file="/security/login_check.jspf" %> 

<%


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
List<ReviewDTO> productReview =ReviewDAO.getDAO().selectMyReviewList(loginClient.getClientNum());

//전체 페이지의 총갯수를 계산하여 저장
//int totalPage=totalReview/pageSize+totalReview%pageSize==0?0:1;
int totalPage=(int)Math.ceil((double)productReview.size()/pageSize);//페이지의 총갯수
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
if(endRow>productReview.size()) {
	endRow=productReview.size();
}

//페이징 처리 관련 정보(시작 행번호와 종료 행번호)와 게시글 검색 기능 관련 정보(검색대상과
//검색단어)를 전달받아 REVIEW 테이블에 저장된 행을 검색하여 게시글 목록을 반환하는 ReviewDAO 
//클래스의 메소드 호출
List<ReviewDTO> reviewList = ReviewDAO.getDAO().selectMyReviewList(loginClient.getClientNum());

//session 객체에 저장된 권한 관련 속성값을 반환받아 저장
// => 로그인 상태의 사용자에게만 글쓰기 권한 제공
// => 게시글이 비밀글인 경우 로그인 상태의 사용자가 게시글 작성자이거나 관리자인 경우에만 권한 제공

//서버 시스템의 현재 날짜를 제공받아 저장
// => 게시글 작성날짜와 비교하여 게시글 작성날짜를 다르게 출력되도록 응답 처리
String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());

//페이지에 출력될 게시글의 일련번호 시작값을 계산하여 저장
// => 검색된 게시글의 총갯수가 91개인 경우 >> 1Page : 91, 2Page : 81, 3Page, 71
int displayNum=productReview.size()-(pageNum-1)*pageSize;

%>

 
	
<div class="container text-center">
	<div class="row justify-content-md-center">
		<div class="col col-lg-2">
			<div id="navigation" style="padding-top: 60px;">
				<h1>
					<a class="side_menu"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=my_order">주문내역</a>
				</h1>
				<h2>
					<a class="side_menu"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review">리뷰</a>
				</h2>
				<h3>
					<a class="side_menu"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=qna">Q&A</a>
				</h3>
				<h4>
					<a class="side_menu"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=password_confirm&action=modify">회원정보</a>
				</h4>
			</div>
		</div>
		<div class="col col-lg-10">
			<h1 class="subTitle1">리뷰</h1>
			<div class="tabType">
				<ul class="item2" style="padding-left: unset;">
					<li class="active write_review" style="text-decoration: none;"><a style="text-decoration: none;"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review">
						<span>작성 가능한 리뷰</span></a></li>
					<li class="active1 write_review" ><a style="text-decoration: none;"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review_list">
						<span >내가 작성한 리뷰</span></a></li>
				</ul>
			</div>
			<div style="text-align: right;">
				<div class="mbOutTop" style="padding-top: 20px;">
				<%if(reviewList.size()==0){ %>
					<div class="nonList">
						구매하신 제품이 있을 경우에만<br> 리뷰 작성이 가능합니다.
					</div>
						
					<!-- 리뷰 없을때 -->
					
					<%} else{ %>
					<table style="text-align: center;">
							<colgroup>
								<col style="width: 100px;">
								<col style="width: 400px;">
								<col style="width: 150px;">
								<col style="width: 200px;">
							</colgroup>
							<thead style="padding-bottom: 10px;">
								<tr>
									<th scope="col">글번호</th>
									<th scope="col">제목</th>
									<th scope="col">작성자</th>
									<th scope="col">작성일</th>
								</tr>
							</thead>
							<tbody>
						<%for(ReviewDTO list : reviewList) {%>
								<tr>
									<%-- 게시글의 일련번호 출력 : 게시글의 글번호가 아닌 일련번호라는 점을 주의하자!!! --%>
									<td><%=displayNum %></td>
									<%displayNum--; // 게시글의 일련번호를 1씩 감소하여 저장%>
									
									<td class="left"><a href="javascript:void(0)"> <%=list.getReviewSubject() %></a></td>
									<td><%=loginClient.getClientName() %></td>
									<td><%=list.getReviewRegister() %></td>
									</tr>
							<%} %>
						<%} %>
							</tbody>
						</table>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$("#reviewArea").removeClass();
	$("#reviewArea").addClass('tableType tb_review');
</script>
