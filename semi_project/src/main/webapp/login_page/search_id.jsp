<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 아이디를 검색하기 위해 사용자로부터 이름과 이메일을 입력받기 위한 JSP 문서 --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style type="text/css">


.search_tag {
	margin: 5px auto;
	width: 300px;
}

#searchForm ul li {
	list-style-type: none;
	margin-bottom: 10px;
	margin-right: 100px;
	
}

#name {
	width: 244px;
}

#email {
	width: 244px;
}

#searchForm input:focus {
	border: 2px solid aqua;
}

.search_btn {
	margin: 0 auto;
	padding: 5px;
	width: 252px;
	background-color:#ffb0d9;
	color: white;
	font-size: 1.2em;
	cursor: pointer;
	letter-spacing: 20px;
	font-weight: bold;
	text-align: center;
}

#message {
	color: red;
	font-weight: bold;
	text-align: center;
}

</style>
<div class="titlearea">
<h1>아이디 찾기</h1>
</div>
<form action="<%=request.getContextPath()%>/main_page/main.jsp?group=login_page&worker=search_id_action"
	method="post" name="searchForm" id="searchForm">
	<ul class="search_tag">
		<li>
			<input type="text" name="name" id="name" placeholder="이름">	
		</li>
		
		<li>
			<input type="text" name="email" id="email" placeholder="이메일">	
		</li>		
	</ul>	
	<div id="search_btn" class="search_btn">아이디 찾기</div>
</form>
<br>
<div id="message"></div>



<script type="text/javascript">
$("#name").focus();

$("#search_btn").click(function() {
	if($("#name").val()=="") {
		$("#message").text("이름을 입력해 주세요.");
		$("#name").focus();
		return;
	}	
	
	if($("#email").val()=="") {
		$("#message").text("이메일을 입력해 주세요.");
		$("#email").focus();
		return;
	}	
	
	$("#searchForm").submit();
});
</script>