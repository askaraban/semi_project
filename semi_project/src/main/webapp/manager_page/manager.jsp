<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 	request.setCharacterEncoding("utf-8");
 	// 작업 폴더명을 반환받아 저장
 	String group = request.getParameter("group");
 	if(group==null){
 		group="manager_page";
 	}
 	
 	// 페이지의 몸체부에 포함될 JSP 문서의 파일명을 반환받아 저장
 	String worker=request.getParameter("worker");
 	if(worker==null){
 		worker="manager_main";
 	}
 	
 	// 전달값을 사용하여 페이지 몸체부에 포함될 JSP 문서의 컨텍스트 경로를 생성하여 저장
 	String contentFilePath="/"+group+"/"+worker+".jsp";
 %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<link href="<%=request.getContextPath()%>/style/manager_style.css" type="text/css" rel="stylesheet">
</head>
<body>
	<div id="header">
	<jsp:include page="/manager_page/header_admin.jsp"/>
	</div>
	<div id="content">
		<jsp:include page="<%=contentFilePath %>"/>
		<% String returnURL = (String)request.getAttribute("returnURL");
			if(returnURL!=null) {
				response.sendRedirect(returnURL);
				return;
			} %>
	</div>
	<div id="footer">
		<jsp:include page="/manager_page/manager_footer.jsp"/>
	</div>
</body>
</html>