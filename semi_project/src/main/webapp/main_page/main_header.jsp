<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="xzy.itwill.DAO.CartDAO"%>
<%@page import="xyz.itwill.DTO.CartDTO"%>
<%@page import="xzy.itwill.DAO.ClientDAO"%>
<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	ClientDTO loginClient = (ClientDTO)session.getAttribute("loginClient");
	// 카트 목록을 담기 위한 리스트
	List<CartDTO> cartList = new ArrayList<>();
	int count=0; // 카트에 담긴 숫자를 나타내기 위한 변수
	
	if(loginClient==null){ // 비회원이라면 카트에 담긴 수는 0
		count=0;
	} else { // 회원일 경우 카트에 있는 목록을 모두 구하는 DAO 메소드를 호출해 count로 증감하여 계산
		cartList = CartDAO.getDAO().selectCartList(loginClient);
		for(CartDTO cart : cartList){
			if(cart.getCartNum()!=0){
				count++;
			}
		}
	}
%>

<body>
	<div id="header">
		<!-- 최상단 메뉴-->
		<header class="main-header py-3">
			<div
				class="row flex-nowrap justify-content-between align-items-center">
				<div class="col-4 pt-1" style="font-size: 15px">
					<a class="link-secondary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=notice_page
					&worker=notice_main">공지사항</a>
					<%if(loginClient==null) {%>
					<a class="link-secondary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=client_page
					&worker=client_join">&nbsp;회원가입</a>
					<a class="link-secondary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=login_page
					&worker=client_login">&nbsp;로그인</a>
					<%} else {%>
					<a class="link-secondary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=login_page
					&worker=client_logout_action">&nbsp;로그아웃</a>
						<%if(loginClient.getClientStatus()==9){ %>
						<a class="link-secondary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"
						href="<%=request.getContextPath()%>/manager_page/manager.jsp">&nbsp;관리자</a>
						<%} %>
					
					<%} %>
					<a class="link-secondary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page
					&worker=my_order">&nbsp;마이페이지</a>
				</div>
				<div class="col-4 text-center">

					<a class="blog-header-logo text-dark" href="main.jsp"> <img
						alt="로고" src="<%=request.getContextPath()%>/images/King2.png"
						width="200" >
					</a>
				</div>
				<div class="col-4 d-flex justify-content-end align-items-center">
					<div class="search">
						<form id="searching"
							action="<%=request.getContextPath()%>/main_page/main.jsp?group=main_page&worker=main_search"
							method="post">
							<input class=search-input type="text" placeholder="검색어 입력"
								name="keyword" id="keyword"> <input type="image" id="image"
								class=search-img onkeyup="enterkey()"
								src="<%=request.getContextPath()%>/images/icon/icons8-search.png"
								width="25" height="25">
						</form>
					</div>
					<%if(loginClient==null){ %>
					<a class="link-secondary head-right-line"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=login_page&worker=client_login">
						<img src="<%=request.getContextPath()%>/images/icon/icons8-heart.png"
						 width="25" height="25"></a>
					<%}else { %>
					<a class="link-secondary head-right-line"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page
					&worker=my_wishList">
						<img src="<%=request.getContextPath()%>/images/icon/icons8-heart.png"
						 width="25" height="25"></a>
					<%} %>
						&nbsp;&nbsp;&nbsp;<a class="link-secondary head-right-line"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=cart_page
					&worker=cart">
						<img
						src="<%=request.getContextPath()%>/images/icon/icons8-cart.png"
						width="25" height="25">
					</a> &nbsp;<span
						class="top-0 start-100 translate-middle badge rounded-pill bg-danger">
						<%=count %> <span class="visually-hidden">unread messages</span>
					</span>
				</div>
			</div>
		</header>
		<br>
		<hr>
		<div class="nav-scroller py-1 mb-2">
			<nav class="nav d-flex justify-content-between">
				<a class="navbar-brand" 
					href="<%=request.getContextPath()%>/main_page/main.jsp?group=product_page&worker=product_cate&category=10">
					<img
					src="<%=request.getContextPath()%>/images/icon/icons-pretzel.png"
					width="25">&nbsp;스낵
				</a> <a class="navbar-brand"
					href="<%=request.getContextPath()%>/main_page/main.jsp?group=product_page&worker=product_cate&category=20">
					<img
					src="<%=request.getContextPath()%>/images/icon/icons-cookie.png"
					width="25">&nbsp;파이&amp;쿠키
				</a> <a class="navbar-brand" 
					href="<%=request.getContextPath()%>/main_page/main.jsp?group=product_page&worker=product_cate&category=30">
					<img
					src="<%=request.getContextPath()%>/images/icon/icons-candy.png"
					width="25">&nbsp;캔디&amp;젤리
				</a> <a class="navbar-brand" 
					href="<%=request.getContextPath()%>/main_page/main.jsp?group=product_page&worker=product_cate&category=40">
					<img
					src="<%=request.getContextPath()%>/images/icon/icons-chocolate.png"
					width="25">&nbsp;초콜릿
				</a> <a class="navbar-brand" 
					href="<%=request.getContextPath()%>/main_page/main.jsp?group=product_page&worker=product_cate&category=50">
					<img
					src="<%=request.getContextPath()%>/images/icon/icons-chewing-gum.png"
					width="25">&nbsp;껌
				</a>
			</nav>
			<hr>
		</div>
	</div>

	<script type="text/javascript">
		$("#image").click(function() {
			$("#searching").submit();
		})
		function enterkey() {
			if (window.event.keyCode == 13) {
		    	// 엔터키가 눌렸을 때 검색되도록 함수 등록
		    }
		}
	</script>
</body>