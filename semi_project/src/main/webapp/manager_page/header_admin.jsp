<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="profile">
	<span style="font-weight: bold;">[관리자님, 환영합니다.]</span>&nbsp;&nbsp;	
	<a href="<%=request.getContextPath()%>/main_page/main.jsp?group=login_page&worker=client_logout_action">로그아웃</a>&nbsp;&nbsp;
	<a href="<%=request.getContextPath()%>/main_page/main.jsp">쿠키몰</a>&nbsp;&nbsp;
</div>

<div id="logo"><a href="<%=request.getContextPath()%>/manager_page/manager.jsp">관리자</a></div>

<div id="menu">
	<a href="<%=request.getContextPath() %>/manager_page/manager.jsp?group=manager_page&worker=manager_product">제품관리</a>
	<a href="<%=request.getContextPath() %>/manager_page/manager.jsp?group=manager_page&worker=manager_product_insert">제품추가</a>
	<a href="#">게시글관리</a>
	<a href="#">주문관리</a>
</div>  