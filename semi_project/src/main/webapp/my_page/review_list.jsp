<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.DTO.ReviewDTO"%>
<%@page import="xzy.itwill.DAO.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

<%@include file="/security/login_check.jspf" %> 
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

	//페이징 처리에 필요한 전달값(페이지번호과 게시글갯수)을 반환받아 저장
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
	int totalReview=ReviewDAO.getDAO().selectTotalReview(search, keyword);//검색된 게시글의 총갯수
	
	//전체 페이지의 총갯수를 계산하여 저장
	//int totalPage=totalReview/pageSize+totalReview%pageSize==0?0:1;
	int totalPage=(int)Math.ceil((double)totalReview/pageSize);//페이지의 총갯수
 
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
	if(endRow>totalReview) {
		endRow=totalReview;
	}
	
	//페이징 처리 관련 정보(시작 행번호와 종료 행번호)와 게시글 검색 기능 관련 정보(검색대상과
	//검색단어)를 전달받아 REVIEW 테이블에 저장된 행을 검색하여 게시글 목록을 반환하는 ReviewDAO 
	//클래스의 메소드 호출
	List<ReviewDTO> reviewList=ReviewDAO.getDAO().selectReviewList(startRow, endRow, search, keyword);
	
	//session 객체에 저장된 권한 관련 속성값을 반환받아 저장
	// => 로그인 상태의 사용자에게만 글쓰기 권한 제공
	// => 게시글이 비밀글인 경우 로그인 상태의 사용자가 게시글 작성자이거나 관리자인 경우에만 권한 제공
	//MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	//서버 시스템의 현재 날짜를 제공받아 저장
	// => 게시글 작성날짜와 비교하여 게시글 작성날짜를 다르게 출력되도록 응답 처리
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	//페이지에 출력될 게시글의 일련번호 시작값을 계산하여 저장
	// => 검색된 게시글의 총갯수가 91개인 경우 >> 1Page : 91, 2Page : 81, 3Page, 71
	int displayNum=totalReview-(pageNum-1)*pageSize;
%>

<%-- 네비게이션 바 --%> 
<style type="text/css">
body {
	width: 100%;
	max-width: 1020px;
	margin: 0 auto;
	box-sizing: border-box;
	display: block;
	text-align: center;
	font-family: 'Nanum Gothic', sans-serif;
}

#navigation a:hover {
    text-align: left;
	color: #F5A9D0;
	font-size: 1.5em;
}

#navigation h1 {
	font-size: 1em;	
	margin: 5px;
	height: 50px;
	text-align: center;	
}

#navigation h2 {
	font-size: 1em;		
	margin: 5px;
	height: 50px;
	text-align: center;	
}

#navigation h3 {
	font-size: 1em;
	margin: 5px;
	height: 50px;
	text-align: center;			
}

#navigation h4 {
	font-size: 1em;
	margin: 5px;
	height: 50px;
	text-align: center;	
}

#navigation {
	position: absolute;
}


<%-- 리뷰 --%>
[class*="subTitle1"] {
    margin: 60px 0 24px;
    font-weight: 600;
    font-size: 24px;
    line-height: 32px;
    text-align: left;
}

<%-- 리뷰쓰기 --%>
[class*="tabType"] ul {
    display: flex;
}

<%-- 상자 --%>
.tabType li button,
.tabType li a {
	position: relative;
	display: block;
	width: 100%;
	height: 62px;
	text-align: center;
}

[class*="tabType"] li {
	flex:1;
	position:relative;
	font-size:16px;
	line-height:1.25;
	color:#666;
}

<%--글자 중앙--%>
.tabType li a:after {
	content: "";
	display: inline-block;
	height: 100%;
	vertical-align: middle;
}

<%--답글--%>
.tabType li.active1 a {
	font-weight:600;
	color:#000;
	background:#fff;
}

<%--점 없애기--%>
li {
    list-style: none;
}

a {
	text-decoration: none;
}

<%--1:1--%>
.tabType li.active a {
	font-weight:600;
	color:#fff;
	background:#F5A9D0;;
}

<%-- 라인 --%>
.mbOutTop {
    padding: 70px 0 0;
    border-top: 3px solid #000;
}

<%-- 리뷰 목록 --%>
#review_title {
	font-size: 1.2em;
	font-weight: bold;
	margin: 60px;
}

<%-- 수정 삭제 --%>
.userIntro .n2 {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 10px;
}

<%-- 아이디 작성자 날짜 --%>
.userIntro .n2 .left {
    display: flex;
    align-items: center;
    font-size: 14px;
    letter-spacing: -0.01em;
}






.myReview_new .endProgress .summary {
    display: flex;
    align-items: center;
    padding: 40px 0 30px;
}

.userIntro .n2 {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 10px;
}




</style>
<div class="container text-center">
	<div class="row justify-content-md-center">
		<div class="col col-lg-2">
			<div id="navigation">
				<h1>
					<a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=order">주문내역</a>
				</h1>
				<h2>
					<a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review">리뷰</a>
				</h2>
				<h3>
					<a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=qna">Q&A</a>
				</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=password_confirm&action=modify">회원정보</a>
				</h4>
			</div>
		</div>
		<div class="col col-lg-10">
			<h1 class="subTitle1">내가 작성한 리뷰</h1>
			
			<div class="tabType">
				<ul class="item2">
					<li class="active"><a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review"><span>작성 가능한 리뷰</span></a></li>
					<li class="active1"><a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review_list"><span>내가 작성한 리뷰</span></a></li>
				</ul>
			</div>
					
			<%-- 검색된 게시글 총갯수 출력 --%>		
			<div id="review_title">리뷰 목록(<%=totalReview %>)</div>
			<div style="text-align: right;">
				게시글갯수 : 
				<select id="reviewCount">
					<option value="10" <%  { %> selected <% } %>>&nbsp;10개&nbsp;</option>	
					<option value="20" <%  { %> selected <% } %>>&nbsp;20개&nbsp;</option>	
					<option value="50" <%  { %> selected <% } %>>&nbsp;50개&nbsp;</option>	
					<option value="100" <% { %> selected <% } %>>&nbsp;100개&nbsp;</option>	
				</select>
				&nbsp;&nbsp;&nbsp;
			</div>
				
			<div class="mbOutTop">	
				<div class="tableType tb_review" id="reviewArea"></div>
				
				
				<table>
					<tr>
						<th width="100">글번호</th>
						<th width="500">제목</th>
						<th width="100">작성자</th>
						<th width="100">조회수</th>
						<th width="200">작성일</th>
					</tr>
		
				<%-- 연습 --%>
				<% if(totalReview==0) {//검색된 게시글이 없는 경우 %>
					<tr>
						<td colspan="5">검색된 게시글이 없습니다.</td>
					</tr>
				<% } else {//검색된 게시글이 있는 경우 %>
					<% for(ReviewDTO reviewTable : reviewList) { %>	
						<tr>
						<%-- 게시글의 글번호가 아닌 게시글의 일련번호 출력 --%>
						<td><%=displayNum %></td>
						<% displayNum--; %><%-- 게시글 일련번호를 1씩 감소하여 저장 --%>
				
						<%-- 제목 출력 --%>
						<td class="subject">
							<%-- 게시글이 답글인 경우에 대한 응답 처리 --%>
							<% if(reviewTable.getReviewRestep() != 0) {//답글인 경우 %>
							<%-- 게시글(답글)의 깊이를 제공받아 왼쪽 여백 설정 --%>
							<span style="margin-left: <%=review.getReviewRelevel()*20%>px;">┗[답글]</span>
						<% } %>
					
					
					
					<%-- 게시글 상태를 비교하여 제목과 링크를 구분해 응답 처리 --%>
					<%
						String url=request.getContextPath()+"/index.jsp?group=review&worker=review_detail"
							+"&reviewNum="+reviewTable.getReviewNum()+"&pageNum="+pageNum+"&pageSize="+pageSize
							+"&search="+search+"&keyword="+keyword;
					%>
						<%-- 로그인 상태의 사용자가 게시글 작성자인 경우 또는 로그인 상태의 
						사용자가 관리자인 경우 제목과 링크 제공 --%>
						<%-- <% if(loginMember!=null && (loginMember.getMemberNum()==reviewTable.getReviewMemberNum() 
							|| loginMember.getMemberStatus()==9)) { %>
							<a href="<%=url%>"><%=reviewTable.getReviewSubject() %></a>
						<% } else { %>
							게시글 작성자 또는 관리자만 확인 가능합니다.						
						<% } %>	--%>
					<%--	
					<% } if(reviewTable.getReviewStatus()==0) {//삭제 게시글인 경우 %>
						<span class="subject_hidden">삭제글</span>
						게시글 작성자 또는 관리자에 의해 삭제된 게시글입니다.	
					<% } %>
				</td>
				
				<% if(reviewTable.getReviewStatus()!=0) {//삭제 게시글이 아닌 경우 %>
				--%>				
					<%-- 작성자(회원이름) 출력 --%>
					<td><%=reviewTable.getReviewName() %></td>
								
					<%-- 조회수 출력 --%>
					<td><%=reviewTable.getReviewReadcount() %></td>
								
					<%-- 작성일 출력 : 오늘 작성된 게시글인 경우 시간만 출력하고 오늘 작성된
					게시글이 아닌 경우 날짜와 시간 출력 --%>	
					<td>
						<%-- 오늘 작성된 게시글인 경우 --%>
						<% if(currentDate.equals(reviewTable.getReviewRegister().substring(0, 10))) { %>
							<%=reviewTable.getReviewRegister().substring(11) %>
						<% } else { %>
							<%=reviewTable.getReviewRegister() %>
						<% } %>
				
				<%--	</td>		
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
		
		
		
		
		
		
		
		
		
		
			<li>
					<!-- 상단 프로필과 제품 -->
					<div class="summary">
						<!-- 프로필 -->						
						<div class="userIntro">
							
								
								
									<div class="n2">
										<!-- 좌 -->
										<div class="left">
											<span class="name">kmi*******</span>
                                            <div class="age">홍길동</div>
                                            <div class="gomin">남성
	                                            
											</div>
                                            <!-- 날짜 FO 개선 : 위치변경 -->
                                            <span class="date">2023.05.03</span>
										</div>
										
										<!-- 우 -->
										<div class="right">
											<div class="btn_wrap">						
                                                <button type="button" class="mod" onclick="modifyProductReview('1946335')">수정</button>
                                                <button type="button" class="del" onclick="deleteProductReview('1946335', 'N')">삭제</button>
                                            </div>
										</div>
									</div>
								
								
						</div>
					</div>
					
					<!-- 포토 리스트 -->
					
						<div class="list_photo">							
							<ul>
								
									
										
																													
												
													<li>
														<div class="pImg">
															<a href="#" onclick="openProductReviewView('1946335','N')">
																<img src="https://images.innisfree.co.kr/upload/productReview/128665434382134310.jpeg" onerror="this.src='/kr/ko/resources/error/img/140x186.png'" alt="">
															</a>	
															
														</div>																			
													</li>
																						
											
										
										
									
														
							</ul>
						</div>
					
					
					<!-- 리뷰 텍스트 내용 -->					
					<div class="reviewCnt">
	                    <p class="rcTxt">
	                    	
								
								
									
									
									
								
							
							<!-- 20201027 미구매 리뷰 노출키워드 추가-->
							
							너무 좋아서 또 구입 했네요!! 여드름 직방
						</p>
                	</div>

					<!-- 제품-->
					<div class="vwProduct">
						<div class="reviewPro">
							
								
								
										
								
						</div>
					</div>
				</li>
                	
                	
	</div>
</div>  
