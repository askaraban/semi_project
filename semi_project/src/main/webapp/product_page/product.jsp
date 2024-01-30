<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String main_header = "/main_page/main_header.jsp";
String product_order = "/product_page/product_order.jsp";
String product_detail = "/product_page/product_detail.jsp";
String review_list = "/review_page/review_list.jsp";
String main_footer = "/main_page/main_footer.jsp";

	request.setCharacterEncoding("utf-8");
	String group = request.getParameter("group");
	if(group==null){
		group="main_page";
	}
	
	// 페이지의 몸체부에 포함될 JSP 문서의 파일명을 반환받아 저장
	String worker=request.getParameter("worker");
	if(worker==null){
		worker="product_order";
	}
	
	// 전달값을 사용하여 페이지 몸체부에 포함될 JSP 문서의 컨텍스트 경로를 생성하여 저장
	String contentFilePath="/"+group+"/"+worker+".jsp";

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
<link href="<%=request.getContextPath()%>/style/style.css" type="text/css" rel="stylesheet">
</head>

<body>
	<%-- 헤더 --%>
	<jsp:include page="<%=main_header %>"></jsp:include>
	<%-- 바디 --%>
	<br>
	<br>
	<div class="productOrder">
		<jsp:include page="<%=product_order %>"></jsp:include>
		<% 
			String returnURL = (String)request.getAttribute("returnURL");
			if(returnURL!=null) {
				response.sendRedirect(returnURL);
				return;
			}
		%>
	</div>
	<div>
		<jsp:include page="<%=product_detail %>"></jsp:include>
	</div>
	<div>
		<jsp:include page="<%=review_list %>"></jsp:include>
	</div>
	<%-- 풋터 --%>
	<jsp:include page="<%=main_footer %>"></jsp:include>
	
	
	<!-- 부트스트랩 -->
 	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js">
	</script>
</body>
</html>