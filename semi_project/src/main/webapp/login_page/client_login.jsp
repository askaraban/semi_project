<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%-- 사용자로부터 인증정보(아이디와 비밀번호)를 입력받기 위한 JSP 문서 --%>
<%-- => [로그인] 태그를 클릭한 경우 [/member/member_login_action.jsp] 문서를 요청하여 페이지 이동 - 입력값 전달 --%>
<%
	//전달값(URL 주소)를 반환받아 저장
	String url=request.getParameter("url");
	if(url==null) {
		url="";
	}	

	//인증 실패시 session 객체에 저장된 속성값을 반환받아 저장 
	// => session 객체에 저장된 속성값을 반환 받은 후 반드시 속성값 제거
	String message=(String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
	
	String id=(String)session.getAttribute("id");
	if(id==null) {
		id="";
	} else {
		session.removeAttribute("id");
	}
%>
<style type="text/css">
#space {
	height: 50px;
}

.login_tag {
	
	
	margin: 5px auto;
	width: 425px;
}

#loginForm label {
	text-align: right;
	width: 100px;
	float: left;
}

#loginForm ul li {
	width: 350px;
	list-style-type: none;
	margin-bottom: 10px;
}

#loginForm input:focus {
	border: 2px solid aqua;
}

#login_btn {
	text-align: center;
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

#search {
	margin-top: 10px;
	margin-bottom: 20px;
	text-align: center;
}

#message {
	color: red;
	font-weight: bold;
}

a:hover {
	color: blue;
	text-decoration: underline;
}

.titlearea {
	max-width: 1020px;
	width: 100%
	margin:0 auto;
	color : orange;
	text-align: center;
}


</style>
<div class="titlearea">
<h1>로그인</h1>
</div>
<div id="space"></div>
<form action="<%=request.getContextPath() %>/main_page/main.jsp?group=login_page&worker=client_login_action" 
	method="post" id="loginForm" name="loginForm">
	<%-- url을 전달하기 위한 hidden input --%>
	<input type="hidden" value="<%=url%>" name="url"> 
	<ul class="login_tag">
		<li>
			<label for="id" >아이디</label>
			<input type="text" name="id" id="id" value="<%=id%>" style="width:210px;" >	
		</li>
		<li>
			<label for="passwd">비밀번호</label>
			<input type="password" name="passwd" id="passwd" style="width:210px;" >	
		</li>
	</ul>	
	<div id="login_btn">로그인</div>
</form>
<div id="search">
	<a href="<%=request.getContextPath()%>/main_page/main.jsp?group=login_page&worker=search_id">아이디 찾기</a> |
	<a href="<%=request.getContextPath()%>/main_page/main.jsp?group=login_page&worker=search_passwd">비밀번호 찾기</a> |
	<a href="<%=request.getContextPath()%>/main_page/main.jsp?group=client_page&worker=client_join">회원가입</a>
</div>
<div id="message"><%=message %></div>

<script type="text/javascript">
$("#id").focus();

$("#login_btn").click(function() {
	if($("#id").val()=="") {
		$("#message").text("아이디를 입력해 주세요.");
		$("#id").focus();
		return;
	}	
	
	if($("#passwd").val()=="") {
		$("#message").text("비밀번호를 입력해 주세요.");
		$("#passwd").focus();
		return;
	}	
	
	$("#loginForm").submit();
});

	document.addEventListener("keydown", function(event) {
    // 엔터 누르면 클릭 기능 
    if (event.key === "Enter") {
        var loginButton = document.getElementById("login_btn"); 
        if (loginButton) {
            loginButton.click();
        }
    }
});
</script>