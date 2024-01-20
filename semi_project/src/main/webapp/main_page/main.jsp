<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String main_header = "/main_page/main_header.jspf";
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
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
</head>
<body>
	<%--<jsp:include page="<%=main_header %>"></jsp:include> --%>
	<%@include file="main_header.jspf"%>

	<%@include file="main_body.jspf"%>

	<%@include file="main_footer.jspf"%>

	<!-- 부트스트랩 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
		crossorigin="anonymous"></script>
</body>
</html>