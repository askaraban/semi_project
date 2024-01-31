<%@page import="javax.tools.DocumentationTool.Location"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<%@include file="/security/login_check.jspf" %>  
<%
	//전달값을 반환받아 저장
	if(request.getParameter("passwd")!=null) {
		String passwd=Utility.encrypt(request.getParameter("passwd"));
		
		
		//로그인 상태의 사용자 비밀번호와 전달받은 비밀번호를 비교하여 같지 않은 경우에 대한 응답 처리
		if(!loginClient.getPasswd().equals(passwd)) {
			session.setAttribute("message", "입력하신 비밀번호가 맞지 않습니다.");	
			request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=my_page&worker=password_confirm&action=modify");
			return;
		}
	}
%>
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

<%--네비게이션 바 --%>
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

.fieldset {
	text-align: left;
	margin: 10px auto;
	width: 95%;
}

.legend {
	font-size: 50px;
	text-align: left;
	font-weight: 600;
	margin: 20px auto;
	border: 20px;
	padding: 20px;
}

.tableHeadTxt {
    margin: -19px 0 20px;
    text-align: left;
    font-size: 13px;
    line-height: 1.54em;
    color: #888;
}

<%-- 회원정보 수정 칸 --%>
.pwdInputField {
    position: relative;
    margin-top: 20px;
    padding: 20px 20px;
    border-top: 2px solid #000;
    border-bottom: 1px solid #eee;
    text-align: left;
    
}

#join label {
	width: 150px;
	text-align: center;
	float: left;
	margin-right: 10px;
}

#join ul li {
	list-style-type: none;
	margin: 15px 0;
}

#fs {
	text-align: center;
}

.error {
	color: red;
	position: relative;
	left: 160px;
	display: none;
}

.memberLeave {
    margin: 80px 0 0;
    padding: 40px 0;
    text-align: center;
    font-size: 14px;
    color: #333;
    border: 1px solid #EEE;
    background: #FCFCFD;
}

#idCheck, #postSearch {
    font-size: 12px;
    font-weight: bold;
    cursor: pointer;
    margin-left: 10px;
    padding: 2px 10px;
    border: 1px solid black;
}
</style>

<form id="join" action="<%=request.getContextPath() %>/main_page/main.jsp?group=my_page&worker=member_modify_action" method="post">
<input type="hidden" name="clientNum" value="<%=loginClient.getClientNum() %>">
<%-- 네이게이션 바 --%>
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
			<div class="tableHead">
				<legend>과자몰 회원정보 수정</legend>
				<p class="tableHeadTxt">* 이름 변경(개명)의 경우 과자몰 고객상담실(080-XXX-XXXX)로 문의 부탁드립니다.</p>
			</div>
			<fieldset class="pwdInputField">
				<ul>
					<li>
						<label for="id">아이디</label>
						<input type="text" name="id" id="id" value="<%=loginClient.getId() %>" readonly="readonly">
					</li>
					<li>
						<label for="passwd">비밀번호</label>
						<input type="password" name="passwd" id="passwd">
						<span style="color: red;">비밀번호를 변경하지 않을 경우 입력하지 마세요.</span>
						<div id="passwdRegMsg" class="error">비밀번호는 영문자,숫자,특수문자가 반드시 하나이상 포함된 6~20 범위의 문자로만 작성 가능합니다.</div>
					</li>
					<li>
						<label for="name">이름</label>
						<input type="text" name="name" id="name"  value="<%=loginClient.getName()%>">
						<div id="nameMsg" class="error">이름을 입력해 주세요.</div>
					</li>
					<li>
						<label for="email">이메일</label>
						<input type="text" name="email" id="email" value="<%=loginClient.getEmail()%>">
						<div id="emailMsg" class="error">이메일을 입력해 주세요.</div>
						<div id="emailRegMsg" class="error">입력한 이메일이 형식에 맞지 않습니다.</div>
					</li>
					<li>
						<% String[] mobile=loginClient.getMobile().split("-"); %>
						<label for="mobile2">전화번호</label>
						<select name="mobile1">
							<option value="010" <% if(mobile[0].equals("010")) { %> selected <% } %>>&nbsp;010&nbsp;</option>
							<option value="011" <% if(mobile[0].equals("011")) { %> selected <% } %>>&nbsp;011&nbsp;</option>
							<option value="016" <% if(mobile[0].equals("016")) { %> selected <% } %>>&nbsp;016&nbsp;</option>
							<option value="017" <% if(mobile[0].equals("017")) { %> selected <% } %>>&nbsp;017&nbsp;</option>
							<option value="018" <% if(mobile[0].equals("018")) { %> selected <% } %>>&nbsp;018&nbsp;</option>
							<option value="019" <% if(mobile[0].equals("019")) { %> selected <% } %>>&nbsp;019&nbsp;</option>
						</select>
						- <input type="text" name="mobile2" id="mobile2" value="<%=mobile[1]%>" size="4" maxlength="4">
						- <input type="text" name="mobile3" id="mobile3" value="<%=mobile[2]%>" size="4" maxlength="4">
						<div id="mobileMsg" class="error">전화번호를 입력해 입력해 주세요.</div>
						<div id="mobileRegMsg" class="error">전화번호는 3~4 자리의 숫자로만 입력해 주세요.</div>
					</li>
					<li>
						<label>우편번호</label>
						<input type="text" name="zipcode" id="zipcode" value="<%=loginClient.getZipcode()%>" size="7" readonly="readonly">
						<span id="postSearch">우편번호 검색</span>
						<div id="zipcodeMsg" class="error">우편번호를 입력해 주세요.</div>
					</li>
					<li>
						<label for="address1">기본주소</label>
						<input type="text" name="address1" id="address1" value="<%=loginClient.getAddress1()%>" size="50" readonly="readonly">
						<div id="address1Msg" class="error">기본주소를 입력해 주세요.</div>
					</li>
					<li>
						<label for="address2">상세주소</label>
						<input type="text" name="address2" id="address2"  value="<%=loginClient.getAddress2()%>" size="50">
						<div id="address2Msg" class="error">상세주소를 입력해 주세요.</div>
					</li>
				</ul>
			</fieldset>
			<div id="fs">
				<button type="submit" class="btn btn-secondary">회원변경</button>
				<button type="reset" class="btn btn-outline-secondary">다시입력</button>
			</div>
			<div id="link" class="memberLeave">
 				<p>과자몰 회원에서 탈퇴가 가능합니다.
				<a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=password_confirm&action=remove">[회원탈퇴]</a>
				</p>
			</div>
		</div>
	</div>
</div>   

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(".btn-secondary").click(function(){		  
	alert("회원정보가 변경되었습니다.");
});

$(".btn-outline-secondary").click(function(){		  
	alert("회원정보가 초기화되었습니다.");
});

$("#id").focus();

$("#join").submit(function() {
	var submitResult=true;
	
	$(".error").css("display","none");

	var passwdReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
	if($("#passwd").val()!="" && !passwdReg.test($("#passwd").val())) {
		$("#passwdRegMsg").css("display","block");
		submitResult=false;
	} 
	
	if($("#name").val()=="") {
		$("#nameMsg").css("display","block");
		submitResult=false;
	}
	
	var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
	if($("#email").val()=="") {
		$("#emailMsg").css("display","block");
		submitResult=false;
	} else if(!emailReg.test($("#email").val())) {
		$("#emailRegMsg").css("display","block");
		submitResult=false;
	}

	var mobile2Reg=/\d{3,4}/;
	var mobile3Reg=/\d{4}/;
	if($("#mobile2").val()=="" || $("#mobile3").val()=="") {
		$("#mobileMsg").css("display","block");
		submitResult=false;
	} else if(!mobile2Reg.test($("#mobile2").val()) || !mobile3Reg.test($("#mobile3").val())) {
		$("#mobileRegMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#zipcode").val()=="") {
		$("#zipcodeMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#address1").val()=="") {
		$("#address1Msg").css("display","block");
		submitResult=false;
	}
	
	if($("#address2").val()=="") {
		$("#address2Msg").css("display","block");
		submitResult=false;
	}
	
	return submitResult;
});

$("#postSearch").click(function() {
	new daum.Postcode({
		oncomplete: function(data) {
			$("#zipcode").val(data.zonecode);
			$("#address1").val(data.address);
		} 
	}).open();
});
</script>