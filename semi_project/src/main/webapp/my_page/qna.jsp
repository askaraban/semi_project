<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%> 
<%@page import="xzy.itwill.DAO.QaDAO"%>
<%@page import="xyz.itwill.DTO.QaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
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
	int totalQa=QaDAO.getDAO().selectTotalQa(search, keyword);//검색된 게시글의 총갯수
	
	//전체 페이지의 총갯수를 계산하여 저장
	//int totalPage=totalReview/pageSize+totalReview%pageSize==0?0:1;
	int totalPage=(int)Math.ceil((double)totalQa/pageSize);//페이지의 총갯수
 
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
	List<QaDTO> QaList=QaDAO.getDAO().selectQaList(startRow, endRow, search, keyword);
	
	//session 객체에 저장된 권한 관련 속성값을 반환받아 저장
	// => 로그인 상태의 사용자에게만 글쓰기 권한 제공
	// => 게시글이 비밀글인 경우 로그인 상태의 사용자가 게시글 작성자이거나 관리자인 경우에만 권한 제공
	QaDTO client_login=(QaDTO)session.getAttribute("client_login");
	
	//서버 시스템의 현재 날짜를 제공받아 저장
	// => 게시글 작성날짜와 비교하여 게시글 작성날짜를 다르게 출력되도록 응답 처리
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	//페이지에 출력될 게시글의 일련번호 시작값을 계산하여 저장
	// => 검색된 게시글의 총갯수가 91개인 경우 >> 1Page : 91, 2Page : 81, 3Page, 71
	int displayNum=totalQa-(pageNum-1)*pageSize;
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

<%-- qna --%>
[class*="subTitle1"] {
    margin: 60px 0 24px;
    font-weight: 600;
    font-size: 24px;
    line-height: 32px;
    text-align: left;
}

<%-- Q&A 목록 --%>
#qa_title {
	font-size: 1.2em;
	font-weight: bold;
	margin: 30px;
}


<%-- 주문창 테이블 --%>
.tableType {
    position: relative;
    border-top: 2px solid #000;
}

.tableType thead th {
    border-left: 1px solid #eee;
    background: #F5F5F5;
}

<%-- 주문창 글자 --%>
.tableType th {
    padding: 15px 20px 15px;
    border-bottom: 1px solid #eee;
    border-left: 1px solid #eee;
    text-align: center;
    font-size: 14px;
    font-weight: 500;
    color: #000;
}

.helpWrap li {
    margin-top: 5px;
    font-size: 13px;
    line-height: 1.54;
    color: #888;
    text-align: left;
}

<%-- 1234 --%>
[class*="tableType"] + .paging, .helpWrap + .paging {
    margin-top: 30px;
    padding: 0px 0px 30px;
}

.selectArea .selTit {
    display: inline-flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
    height: 42px;
    padding: 0 15px;
    border: 1px solid #eee;
    text-align: left;
    font-size: 14px;
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
			<h1 class="subTitle1">Q&A</h1>	
		<div id="listArea">
		<div id="qa_title">Q&A목록(<%=totalQa %>)</div>
		<div id="qa_list">
			<div style="text-align: right;">
				게시글갯수 : 
				<select id="qaCount">
					<option value="10" <%  { %> selected <% } %>>&nbsp;10개&nbsp;</option>	
					<option value="20" <%  { %> selected <% } %>>&nbsp;20개&nbsp;</option>	
					<option value="50" <%  { %> selected <% } %>>&nbsp;50개&nbsp;</option>	
					<option value="100" <% { %> selected <% } %>>&nbsp;100개&nbsp;</option>	
				</select>
				&nbsp;&nbsp;&nbsp;
			</div>
			<div class="tableType">
				<table>
					<colgroup>
						<col style="width:150px;">
						<col style="width:350px;">
						<col style="width:150px;">
						<col style="width:200px;">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">글번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">작성일</th>
						</tr>
					</thead>
					<tbody>
						<tr>
						<td>2023.11.15</td>
						<td>
							<a href="javascript:void(0)" onclick="goOrderDetail('20691308', '000', 'N')">
								20691308
							</a>				
						</td>
						<td class="left">
							<a href="javascript:void(0)" onclick="goOrderDetail('20691308', '000', 'N')">
								비자 트러블 토너 외1건
							</a>				
						</td>
						<td>66,500원</td>
						</tr>
						
			
			
		</tbody>
	</table>
</div>

	<div class="paging"><span class="num on"><a href="javascript:void(0);">1</a></span></div>


</div>	
		</div>
	</div>
</div> 
