<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="xzy.itwill.DAO.ProductDAO"%>
<%@page import="xyz.itwill.DTO.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
	List<ProductDTO> productList = new ArrayList<>();
	productList = ProductDAO.getDAO().fileList();


%>	

<style>
body {
	width: 100%;
	max-width: 1020px;
	margin: 0 auto;
	/*
		font-family: var(--bs-body-font-family);
		font-size: var(--bs-body-font-size);
		font-weight: var(--bs-body-font-weight);
		line-height: var(--bs-body-line-height);
		color: var(--bs-body-color);
		text-align: var(--bs-body-text-align);
		background-color: var(--bs-body-bg);
		-webkit-text-size-adjust: 100%;
		-webkit-tap-highlight-color: transparent;
		*/
	box-sizing: border-box;
	display: block;
	text-align: center;
}

div {
	display: block;
}

.main-image {
	padding-bottom: 0px;
	position: relative;
	padding: 0;
	display: block;
	max-width: 1020px;
	width: 100%;
	border: 5px solid black;
	margin: 0 auto;
}

.main-prd {
	border: 5px solid black;
	max-width: 1020px;
	width: 100%;
	margin: 0 auto;
	text-align: left;
}

.prdList {
	width: 100%;
	max-width: 1020px;
	margin: 0 auto;
}

.prdList>li {
	position: relative;
	display: inline-block;
	margin: 30px 0 10px;
	color: #757575;
	vertical-align: top;
}
.subTitle {
		text-align: left;
	}
</style>
<body>
	<br>
	<div class="main-image">
		<img src="../images/Koala.jpg" class="img-fluid" alt="Koala"
			style="width: 100%; height: 400px;">
	</div>
	<div class="main-prd">
		<div>
		<h2 class="subTitle">베스트 추천 상품</h2>
		</div>
		<ul class="prdList grid3">
			<%for(ProductDTO pro : productList){ %>
			<li id="anchorBoxId_1" class="xans">
				<div class="card" style="width: 15rem;">
					<img src="<%=request.getContextPath() %>/upload/<%=pro.getImagePath()%>" class="card-img-top" alt="...">
					<%System.out.println(pro.getImagePath()); %>
					<%System.out.println(request.getContextPath()); %>
					<div class="card-body">
						<h5 class="card-title">Card title</h5>
						<p class="card-text">Some quick example text to build on the
							card title and make up the bulk of the card's content.</p>
						<a href="#" class="btn btn-primary">구매하기</a> <a href="#"
							class="btn btn-primary">장바구니</a>
					</div>
				</div>
			</li>
					<%} %>
		</ul>
	</div>
	<hr>
</body>
</html>