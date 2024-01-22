<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<body>
	<div id="header">
		<!-- 최상단 메뉴d-->
		<header class="main-header py-3">
			<div
				class="row flex-nowrap justify-content-between align-items-center">
				<div class="col-4 pt-1">
					<a class="link-secondary" href="#">공지사항</a>
				</div>
				<div class="col-4 text-center">
					<a class="blog-header-logo text-dark" href="#">
					<img alt="로고" src="<%=request.getContextPath() %>/images/0.png" width="100">쿠키몰</a>
				</div>
				<div class="col-4 d-flex justify-content-end align-items-center">
					<a class="link-secondary" href="#" aria-label="Search"> 
					<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="none" stroke="currentColor" 
						stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="mx-3" role="img"
						viewBox="0 0 24 24">
							<title>Search</title>
							<circle cx="10.5" cy="10.5" r="7.5"></circle>
							<path d="M21 21l-5.2-5.2"></path>
						</svg>
					</a> <a class="link-secondary head-right-line" href="#">Sign up</a>
						<a class="link-secondary head-right-line" href="#">Login</a>
						<a class="link-secondary head-right-line" href="#">My page</a>
						<a class="link-secondary head-right-line" href="#">
						<img src="<%=request.getContextPath() %>/images/icons8-shopping-cart.png" width="25" height="25"></a>
				</div>
			</div>
		</header>
		<br>
		<hr>
		<div class="nav-scroller py-1 mb-2">
			<nav class="nav d-flex justify-content-between">
				<a class="navbar-brand" href="#"><img
					src="<%=request.getContextPath() %>/images/icons-pretzel.png"
					width="25">스낵</a> <a class="navbar-brand" href="#"><img
					src="<%=request.getContextPath() %>/images/icons-cookie.png" width="25">파이&쿠키</a> <a
					class="navbar-brand" href="#"><img src="<%=request.getContextPath() %>/images/icons-candy.png"
					width="25">캔디&젤리</a> <a class="navbar-brand" href="#"><img
					src="<%=request.getContextPath() %>/images/icons-chocolate.png" width="25">초콜릿</a> <a
					class="navbar-brand" href="#"><img
					src="<%=request.getContextPath() %>/images/icons-chewing-gum.png" width="25">껌</a>
			</nav>
			<hr>
		</div>
	</div>
</body>