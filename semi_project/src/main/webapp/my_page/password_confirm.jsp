<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<link href="<%=request.getContextPath()%>/style/my_page_order.css" type="text/css" rel="stylesheet">
<style>
#navigation a:hover {
    text-align: center;
	color: #F5A9D0;
	font-size: 17px;
}
</style>
<%@include file="/security/login_check.jspf" %>  
<div class="container text-center">
	<div class="row justify-content-md-center">
		<div class="col col-lg-2">
			<%@include file="/my_page/my_side.jspf" %>
		</div>
		<div class="col col-lg-10">
			<%	String action = request.getParameter("action");
			//전달값이 업거나 전달값이 잘못된 경우에 대한 응답 처리 - 비정상적인 요청
			if (action == null || !action.equals("modify") && !action.equals("remove")) {
				request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
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
				회원님의 개인정보 보호를 위해 비밀번호를 입력해주세요.<br> 쿠키킹은 회원님의 개인정보를 신중히 취급하며,
				회원님의 동의 없이는 회원정보가 공개되지 않습니다.<br> 보다 다양한 혜택/서비스를 받으시려면 회원 정보를
				최신으로 유지해주세요.
			</p>

			<% } else { %>
			<h2 class="subTitle4">회원탈퇴</h2>
			<div class="mbOutTop">
				<div id="logo">
			    	<img alt="로고" src="/semi_project_1/my_page/images/ico_nodate.png">
		        </div>
				<p class="tit">쿠키킹 공식 온라인몰을 이용하는데 불편한 사항이 있으셨나요?</p>
				<p class="txt">
					의견을 남겨주시면, 보다 나은 서비스 제공을 위해 참고하겠습니다.<br>
					회원 탈퇴 전 아래의 사항들을 확인해주세요.
				</p>
				<ul class="list">
					<li class="list_sub">1.쿠키킹 공식 온라인몰에서 탈퇴시 다음의 정보는 삭제될 수 있습니다.
						<span class="sub">
							- 쿠키킹 공식 온라인몰에서 발행한 쿠폰<br>
							- 리뷰 프로필, 리뷰 작성 내역, 리뷰관 활동 내역<br>
							- 1:1 문의 내역 등
						</span>
					</li>
					<li class="list_sub">2. 쿠키킹 공식 온라인몰에서 탈퇴하면, 즉시 재이용 하실 수 없습니다.
						<span class="sub">
							- 쿠키킹 아이디로 로그인 및 쿠키킹 서비스 이용약관 동의<br>
							- 쿠키킹 아이디로 공식 온라인몰을 이용하셨던 경우, 재가입 시점에 따라 1에서 언급한 정보가 유지될 수 있습니다.
						</span>
					</li>
				</ul>
			</div>
			<h3 class="subTitle2">쿠키킹 온라인 회원탈퇴</h3>
			<% } %>
			<div class="pwdInputField">
				<form method="post" id="passwordForm">
				<label for="passch" class="titLabel">비밀번호</label>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="password" name="ClientPasswd" id="ClientPasswd">
				<p id="message" style="color: red;"><%=message%></p>
				</form>
			</div>
			<div class="btnWrap wL" id="btn">
				<button type="button" id="submitBtn" class="btnType3m">확인</button>
				<a href="/semi_project_1/main_page/main.jsp" class="btnType4m" style="color: black; border: 1px solid black; text-decoration: none;">취소</a>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$("#ClientPasswd").focus();

document.addEventListener("keydown", function(event) {
    // 엔터 누르면 클릭 기능 
    if (event.key === "Enter") {
        var passwdButton = document.getElementById("submitBtn"); 
        if (passwdButton) {
        	passwdButton.click();
        }
    }
});

$("#submitBtn").click(function() {
	if($("#ClientPasswd").val()=="") {
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