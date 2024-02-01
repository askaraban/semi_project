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
	color: blue;
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
					<li class="active"><a href="/kr/ko/MypageCounselWrite.do"><span>작성 가능한 리뷰</span></a></li>
					<li class="active1"><a href="/kr/ko/MypageCounselList.do"><span>내가 작성한 리뷰</span></a></li>
				</ul>
			</div>
		</div>
	</div>
</div>  
