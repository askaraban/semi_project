<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">

#class {
  display: block;
  min-height: 80vh;  
  text-align: center;
  margin: 0 auto; 
  padding-top: 100px;
}
#successImg{
  display: flex;
  justify-content: center;
}

h2{
	margin-bottom: 35px;
}

.btn{
	border: 1px solid lightgray;
	color: white;
    font-size: large;
    border-radius: 10px;
    font-weight: bold;
}
.btn :hover {
	font-weight: bold;
}
 </style>   
  
    
<div id='class'>
	<br>
	<h2>회원가입을 축하합니다!</h2>
	<button type="button" class="btn" id="btn" onclick="location.href='<%=request.getContextPath()%>/main_page/main.jsp?group=login_page&worker=client_login'"
	 style="width: 400px; height: 70px; font-size: 20px; background-color: #ffb0d9;">시작하기</button>
</div>
	