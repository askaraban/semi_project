<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
	crossorigin="anonymous"></script>
<link href="<%=request.getContextPath()%>/style/my_page_order.css"
	type="text/css" rel="stylesheet">

<%@include file="/security/login_check.jspf" %> 

<%



%>
 
	
<div class="container text-center">
	<div class="row justify-content-md-center">
		<div class="col col-lg-2">
			<div id="navigation" style="padding-top: 60px;">
				<h1>
					<a class="side_menu"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=my_order">주문내역</a>
				</h1>
				<h2>
					<a class="side_menu"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review">리뷰</a>
				</h2>
				<h3>
					<a class="side_menu"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=qna">Q&A</a>
				</h3>
				<h4>
					<a class="side_menu"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=password_confirm&action=modify">회원정보</a>
				</h4>
			</div>
		</div>
		<div class="col col-lg-10">
			<h1 class="subTitle1">리뷰</h1>
			<div class="tabType">
				<ul class="item2" style="padding-left: unset;">
					<li class="active write_review" ><a
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review">
						<span>작성 가능한 리뷰</span></a></li>
					<li class="active1 write_review"><a
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review_list">
						<span>내가 작성한 리뷰</span></a></li>
				</ul>
			</div>
			<div style="text-align: right;">

				<div class="mbOutTop">
					<div class="tableType tb_review" id="reviewArea">
						<div class="tableType tb_review">
							<!-- 리뷰 없을때 -->
							<div class="nonList">
								구매하신 제품이 있을 경우에만<br> 리뷰 작성이 가능합니다.
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$("#reviewArea").removeClass();
	$("#reviewArea").addClass('tableType tb_review');
</script>
