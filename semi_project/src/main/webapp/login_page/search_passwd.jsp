<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 비밀번호를 검색하기 위해 사용자로부터 이름과 아이디를 입력받기 위한 JSP 문서 --%>
<style type="text/css">
.search_tag {
	margin: 5px auto;
	width: 300px;
}

#searchForm label {
	text-align: right;
	width: 100px;
	float: left;
}

#searchForm ul li {
	list-style-type: none;
	margin-bottom: 10px;
}

#searchForm input:focus {
	border: 2px solid aqua;
}

#search_btn {
	margin: 0 auto;
	padding: 5px;
	width: 300px;
	background-color: black;
	color: white;
	font-size: 1.2em;
	cursor: pointer;
	letter-spacing: 20px;
	font-weight: bold;
}

#message {
	color: red;
	font-weight: bold;
}


</style>

<h1>비밀번호 찾기</h1>
<form action="<%=request.getContextPath()%>/main_page/main.jsp?group=login_page&worker=search_passwd_action"
	method="post" name="searchForm" id="searchForm">
	<ul class="search_tag">
		<li>
			<input type="text" name="name" id="name" placeholder="이름">	
		</li>
		<li>
			<input type="text" name="id" id="id" placeholder="아이디">	
		</li>
		<li>
			<input type="text" name="email" id="email" placeholder="이메일">	
		</li>
	</ul>	
	<div id="search_btn" class="repasswd">비밀번호 찾기</div>
</form>
<div id="message"></div>

<script type="text/javascript">
$("#name").focus();

$("#search_btn").click(function() {
	if($("#name").val()=="") {
		$("#message").text("이름을 입력해 주세요.");
		$("#name").focus();
		return;
	}	
	
	if($("#id").val()=="") {
		$("#message").text("아이디를 입력해 주세요.");
		$("#id").focus();
		return;
	}	
	if($("#email").val()=="") {
		$("#message").text("이메일를 입력해 주세요.");
		$("#email").focus();
		return;
	}
	$("#searchForm").submit();
});
</script>