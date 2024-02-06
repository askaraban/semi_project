<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
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
#review_title {
	font-size: 1.2em;
	font-weight: bold;
	margin: 60px;
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
		<div id="review_title">Q&A목록()</div>
		<div id="review_list">
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

