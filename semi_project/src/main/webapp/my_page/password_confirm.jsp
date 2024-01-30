<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    
<%-- 회원정보변경 또는 회원탈퇴를 위해 사용자로부터 비밀번호를 입력받기 위한 JSP 문서 --%>
<%-- => 로그인 상태의 사용자만 요청 가능한 JSP 문서 --%>
<%@include file="/security/login_check.jspf" %>  

<style>
<style type="text/css">
* {margin:0;padding:0;}
html {height: 100%; background: #fff;}
html.mobile {width: 100%; overflow: hidden;}
body {
	width: 100%;
	max-width: 1020px;
	margin: 0 auto;
	/*
		font-family: var(--bs-body-font-family);
		font-size: var(--bs-body-font-size);
		font-weight: var(--bs-body-font-weight);
		line-height: var(--bs-body-line-height);
		color: var(--bs-body-color);
		text-align: var(--bs-body-text-align);
		background-color: var(--bs-body-bg);
		-webkit-text-size-adjust: 100%;
		-webkit-tap-highlight-color: transparent;
		*/
	box-sizing: border-box;
	display: block;
	text-align: center;
	font-family: 'Nanum Gothic', sans-serif;
}

<%-- 비밀번호 재확인 --%>
[class*="subTitle1"] {
    margin: 60px 0 24px;
    font-weight: 600;
    font-size: 24px;
    line-height: 32px;
    text-align: left;
}


<%-- 비밀번호 입력 칸 --%>
.pwdInputField {
    position: relative;
    margin-top: 20px;
    padding: 20px 20px;
    border-top: 2px solid #000;
    border-bottom: 1px solid #eee;
    text-align: left;
    
}

fieldset, img {
    border: 0;
}

fieldset {
    display: block;
    margin-inline-start: 2px;
    margin-inline-end: 2px;
    padding-block-start: 0.35em;
    padding-inline-start: 0.75em;
    padding-inline-end: 0.75em;
    padding-block-end: 0.625em;
    min-inline-size: min-content;
    <%-- border-width: 2px; --%>
    border-style: groove;
    border-color: rgb(192, 192, 192);
    border-image: initial;
}

<%-- 회원탈퇴 버튼 --%>
[class*="btnType3"] {
    height: 50px;
    line-height: 50px;
    padding: 0 30px;
    font-weight: 600;
    color: #fff;
    text-align: center;
    background: #bc6b00;
}

<%-- 확인 버튼 --%>
.pwdInputField [class*="btnType3"] {
    position: absolute;
    right: 55%;
    width: 200px;
    margin-left: -100px;
}
<%-- 취소 버튼 --%>
[class*="btnType6l"] {
    height: 50px;
    line-height: 50px;
    padding: 0 30px;
    font-weight: 600;
    color: #000000;
    text-align: center;
    background: #FFFFFF;
	border: 1px solid black;
}

.pwdInputField [class*="btnType6l"] {
    position: relative;
    left: 55%;
    width: 200px;
    margin-left: -100px;
}


 <%-- 네비게이션 바 --%>
#navigation a:hover {
    text-align: left;
	color: blue;
	font-size: 1.5em;
}

.navigation {
  width : 100px;
  height : 100px;
  background-color: red;
  position: absolute;
  top: 50%;
  left: 50%;
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
<%-- 회원탈퇴 --%>
[class*="subTitle4"] {
    margin: 60px 0 24px;
    font-weight: 600;
    font-size: 24px;
    line-height: 32px;
    text-align: left;
}

.mbOutTop {
    padding: 70px 0 0;
    border-top: 2px solid #000;
}

.mbOutTop .txt {
    margin: 0 0 50px;
    font-size: 14px;
    line-height: 19px;
    color: #666;
    text-align: center;
}

.mbOutTop .list {
    padding: 30px;
    font-weight: 500;
    font-size: 16px;
    line-height: 1.25em;
    border: 1px solid #EEEEEE;
    background: #FCFCFD;
}

.mbOutTop .list li {
    margin-top: 30px;
}

li {
    list-style: none;
    text-align: left;
}

.mbOutTop .list {
    padding: 30px;
    font-weight: 500;
    font-size: 16px;
    line-height: 1.25em;
    border: 1px solid #EEEEEE;
    background: #FCFCFD;
}

h3.subTitle2 {
    margin-top: 60px;
}

.subTitle2 {
    margin: 100px 0 20px;
    font-weight: 600;
    font-size: 22px;
    line-height: 1.55;
    text-align: left;
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
			<%	String action = request.getParameter("action");
			//전달값이 업거나 전달값이 잘못된 경우에 대한 응답 처리 - 비정상적인 요청
			if (action == null || !action.equals("modify") && !action.equals("remove")) {
				request.setAttribute("returnUrl", request.getContextPath() + "/main_page/main.jsp?group=error&worker=error_400");
				return;
			}

			String message = (String) session.getAttribute("message");
			if (message == null) {
				message = "";
			} else {
				session.removeAttribute("message");
			} %>
			<%
			if (action.equals("modify")) {
			%>
			<h2 class="subTitle1">비밀번호 재확인</h2>
			<p align="left">
				회원님의 개인정보 보호를 위해 비밀번호를 입력해주세요.<br> 과자몰은 회원님의 개인정보를 신중히 취급하며,
				회원님의 동의 없이는 회원정보가 공개되지 않습니다.<br> 보다 다양한 혜택/서비스를 받으시려면 회원 정보를
				최신으로 유지해주세요.
			</p>

			<% } else { %>
			<h2 class="subTitle4">회원탈퇴</h2>
			<div class="mbOutTop">
						<div id="logo">
			            	<img alt="로고" src="/semi_project_1/my_page/images/ico_nodate.png">
		                </div>
						<p class="tit">과자몰 공식 온라인몰을 이용하는데 불편한 사항이 있으셨나요?</p>
						<p class="txt">
							의견을 남겨주시면, 보다 나은 서비스 제공을 위해 참고하겠습니다.<br>
							회원 탈퇴 전 아래의 사항들을 확인해주세요.
						</p>
						<ul class="list">
							<li>1.과자몰 공식 온라인몰에서 탈퇴시 다음의 정보는 삭제될 수 있습니다.
								<span class="sub">
									- 과자몰 공식 온라인몰에서 발행한 쿠폰<br>
									- 리뷰 프로필, 리뷰 작성 내역, 리뷰관 활동 내역<br>
									- 1:1 문의 내역 등
								</span>
							</li>
							<li>2. 과자몰 공식 온라인몰에서 탈퇴하면, 즉시 재이용 하실 수 없습니다.
								<span class="sub">
									- 과자몰 아이디로 로그인 및 과자몰 서비스 이용약관 동의<br>
									- 과자몰 아이디로 공식 온라인몰을 이용하셨던 경우, 재가입 시점에 따라 1에서 언급한 정보가 유지될 수 있습니다.
								</span>
							</li>
						</ul>
					</div>
			<h3 class="subTitle2">과자몰 온라인 회원탈퇴</h3>
			<% } %>
			<div class="pwdInputField">
				<form method="post" id="passwordForm">
					<label for="passch" class="titLabel">비밀번호</label>&nbsp;&nbsp;&nbsp;&nbsp;
				<p id="message" style="color: red;"><%=message%></p>
			</div>
					<input type="password" name="passwd" id="passwd">
					<div class="btnWrap wL" id="btn">
						<button type="button" id="submitBtn" class="btnType3">확인</button>
						<a href="/semi_project_1/main_page/main.jsp" class="btnType6l">취소</a>
					</div>
					
				</form>

	</div>
</div>
</div>

<script type="text/javascript">
$("#passwd").focus();

$("#submitBtn").click(function() {
	if($("#passwd").val()=="") {
		$("#message").text("입력 비밀번호와 확인 비밀번호가 불일치 합니다.");
		return;
	}
	
	<%-- 전달값에 의해 form 태그의 action 속성값으로 요청 JSP 문서를 구분하여 저장 --%>
	<%if (action.equals("modify")) {%>
		$("#passwordForm").attr("action", "<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=member_modify");
	<%} else {%>
		$("#passwordForm").attr("action", "<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=member_remove_action");
	<%}%>
	
	$("#passwordForm").submit();
});
</script>

