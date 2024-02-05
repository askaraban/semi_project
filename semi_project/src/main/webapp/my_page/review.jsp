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
	background:#000;
}

.myReview_new .inProgress .sel_area {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-bottom: 20px;
    margin-top: 30px;
}

<%-- 리뷰 목록 --%>
#review_title {
	font-size: 1.2em;
	font-weight: bold;
	margin: 60px;
}






<%-- 라인 --%>
.mbOutTop {
    padding: 70px 0 0;
    border-top: 3px solid #000;
}


.nonList:not(td) {
    justify-content: center;
    margin: 130px 0;
    text-align: center;
    font-weight: 600;
    font-size: 16px;
    line-height: 1.25em;
    color: #000000;
}



.nonList:not(td):before {
    display: block;
    content: '';
    flex: none;
    width: 60px;
    height: 60px;
    margin: 0 auto 20px;
    border-radius: 100px;
    background: url(../my_page/images/ico_nodate.png) no-repeat 50% 50%;
}


.btnWrap {
    display: flex;
    gap: 0 10px;
    text-align: center;
    justify-content: center;
    margin-top: 60px;
}

[class*="btnType3"] {
    height: 50px;
    line-height: 50px;
    padding: 0 30px;
    font-weight: 600;
    color: #fff;
    text-align: center;
    background: #F5A9D0;
}

.btnWrap a {
	color: white;
	
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
			<h1 class="subTitle1">리뷰</h1>
			<div class="tabType">
				<ul class="item2">
					<li class="active"><a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review"><span>작성 가능한 리뷰</span></a></li>
					<li class="active1"><a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review_list"><span>내가 작성한 리뷰</span></a></li>
				</ul>
			</div>
					
		
					<div id="review_title">리뷰 목록</div>

	<div style="text-align: right;">
		게시글갯수 : 
		<select id="reviewCount">
			<option value="10" <%  { %> selected <% } %>>&nbsp;10개&nbsp;</option>	
			<option value="20" <%  { %> selected <% } %>>&nbsp;20개&nbsp;</option>	
			<option value="50" <%  { %> selected <% } %>>&nbsp;50개&nbsp;</option>	
			<option value="100" <% { %> selected <% } %>>&nbsp;100개&nbsp;</option>	
		</select>
		&nbsp;&nbsp;&nbsp;
		
		
		
		
	<div class="mbOutTop">	
<div class="tableType tb_review" id="reviewArea">

  





<script>
$("#reviewArea").removeClass();
$("#reviewArea").addClass('tableType tb_review');
</script>


	<div class="tableType tb_review">
		<!-- 리뷰 없을때 -->
		<div class="nonList">
			구매하신 제품이 있을 경우에만<br>
			리뷰 작성이 가능합니다.
		</div>
	</div>
	<!-- 리뷰 없을때 -->						


				</div>
		</div>
		
		
		<div class="btnWrap">
		<div class="btnType3l">
						<a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=qna">리뷰 쓰기</a>
					</div>
					</div>
					
		</div>
	</div>
</div>  
