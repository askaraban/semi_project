<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String main_header = "/main_page/main_header.jsp";
String main_body = "/login_page/login.jsp";
String main_footer = "/main_page/main_footer.jsp";
request.setCharacterEncoding("utf-8");
%>
<!doctype html>
<html lang="kr">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Main Page</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
	<!--  integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">-->
<link href="<%=request.getContextPath()%>/style/style.css" type="text/css" rel="stylesheet">
</head>

<body>
	<%-- 헤더 --%>
	<jsp:include page="<%=main_header %>"></jsp:include>
	<%-- 바디 --%>
	<jsp:include page="<%=main_body %>"></jsp:include>
	<%-- 풋터 --%>
	<jsp:include page="<%=main_footer %>"></jsp:include>
	
	
	<!-- 부트스트랩 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
		<!--  integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
		crossorigin="anonymous"-->
</body>
</html>