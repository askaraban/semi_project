<%@page import="xzy.itwill.DAO.ClientDAO"%>
<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

	ClientDTO loginClient = (ClientDTO)session.getAttribute("loginClient");

%>

<body>
	<div id="header">
		<!-- 최상단 메뉴d-->
		<header class="main-header py-3">
			<div
				class="row flex-nowrap justify-content-between align-items-center">
				<div class="col-4 pt-1">
					<a class="link-secondary head-right-line"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=notice_page
					&worker=notice_main">공지사항</a>
					<%if(loginClient==null) {%>
					<a class="link-secondary head-right-line"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=client_page
					&worker=client_join">회원가입</a>
					<a class="link-secondary head-right-line"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=login_page
					&worker=client_login">로그인</a>
					<%} else {%>
					<a class="link-secondary head-right-line"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=login_page
					&worker=client_logout_action">로그아웃</a>
						<%if(loginClient.getClientStatus()==9){ %>
						<a class="link-secondary head-right-line"
						href="<%=request.getContextPath()%>/manager_page/manager.jsp">관리자</a>
						<%} %>
					
					<%} %>
					<a class="link-secondary head-right-line"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page
					&worker=order">마이페이지</a>
				</div>
				<div class="col-4 text-center">

					<a class="blog-header-logo text-dark" href="main.jsp"> <img
						alt="로고" src="<%=request.getContextPath()%>/images/(nookki)logo.png"
						width="200">
					</a>
				</div>
				<div class="col-4 d-flex justify-content-end align-items-center">
					<div class="search">
						<form id="searching"
							action="<%=request.getContextPath()%>/main_page/main.jsp?group=main_page&worker=main_search"
							method="post">
							<input class=search-input type="text" placeholder="검색어 입력"
								name="keyword" id="keyword"> <input type="image" id="image"
								class=search-img
								src="<%=request.getContextPath()%>/images/icon/icons8-search.png"
								width="25" height="25">
						</form>
					</div>
					<a class="link-secondary head-right-line"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=client_page
					&worker=#">
						<img
						src="<%=request.getContextPath()%>/images/icon/icons8-heart.png"
						width="25" height="25">
					</a> <a class="link-secondary head-right-line"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=cart_page
					&worker=cart">
						<img
						src="<%=request.getContextPath()%>/images/icon/icons8-cart.png"
						width="25" height="25">
					</a> <span
						class="top-0 start-100 translate-middle badge rounded-pill bg-danger">
						99+ <span class="visually-hidden">unread messages</span>
					</span>
				</div>
			</div>
		</header>
		<br>
		<hr>
		<div class="nav-scroller py-1 mb-2">
			<nav class="nav d-flex justify-content-between">
				<a class="navbar-brand"
					href="/main_page/main.jsp?group=product_page&worker=#"> <img
					src="<%=request.getContextPath()%>/images/icon/icons-pretzel.png"
					width="25">스낵
				</a> <a class="navbar-brand"
					href="<%=request.getContextPath()%>/main_page/main.jsp?group=product_page&worker=#">
					<img
					src="<%=request.getContextPath()%>/images/icon/icons-cookie.png"
					width="25">파이&쿠키
				</a> <a class="navbar-brand"
					href="<%=request.getContextPath()%>/main_page/main.jsp?group=product_page&worker=#">
					<img
					src="<%=request.getContextPath()%>/images/icon/icons-candy.png"
					width="25">캔디&젤리
				</a> <a class="navbar-brand"
					href="/main_page/main.jsp?group=product_page&worker=#"> <img
					src="<%=request.getContextPath()%>/images/icon/icons-chocolate.png"
					width="25">초콜릿
				</a> <a class="navbar-brand"
					href="/main_page/main.jsp?group=product_page&worker=#"> <img
					src="<%=request.getContextPath()%>/images/icon/icons-chewing-gum.png"
					width="25">껌
				</a>
			</nav>
			<hr>
		</div>
	</div>

	<script type="text/javascript">
		$("#image").click(function() {
			$("#searching").submit();
		})
	</script>
</body>