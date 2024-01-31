<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="xzy.itwill.DAO.ProductDAO"%>
<%@page import="xyz.itwill.DTO.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
	List<ProductDTO> productList = new ArrayList<>();
	productList = ProductDAO.getDAO().selectProductList();
	
	
	DecimalFormat format = new DecimalFormat("###,###,##0");

%>	

<body>
	<br>
	<div id="carouselExample" class="carousel slide">
  <div class="carousel-inner main-img">
    <div class="carousel-item active">
      <img src="<%=request.getContextPath()%>/images/banner5.png" class="img-fluid" class="d-block w-100" alt="saleProduct">
    </div>
    <div class="carousel-item">
      <img src="<%=request.getContextPath()%>/images/banner5.png" class="img-fluid" class="d-block w-100" alt="bestSaleProduct">
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
	<%-- 
	<div class="main-body main-img" >
		<img src="<%=request.getContextPath()%>/images/main_img.png" class="img-fluid" alt="Koala"
			style="width: 100%; height: 400px;">
			<div class="main-text">여기를 모르ㅇㅇ</div>
			<%=session.getAttribute("keyword") %>
	</div>
	--%>
		<div class="subTitle">
		<h2 >베스트 추천 상품</h2>
		</div>
	<div class="main-prd">
		<ul class="prdList grid3">
			<%for(ProductDTO pro : productList){ %>
			<li id="anchorBoxId_1" class="xans">
				<div class="card border-light" style="width: 14rem;">
					<a href="#" class="product-a-line">
					<img src="<%=request.getContextPath() %><%=pro.getProductImgPath()%>" class="card-img-top" alt="...">
					<div class="card-body">
						<h5 class="card-title"><%=pro.getProductName() %></h5>
						<p class="card-text"><%=pro.getProductCom() %></p>
						<p class="card-text"><%=format.format(pro.getProductPrice()) %>원</p>
					</div>
						</a>
				</div>
				
			</li>
					<%} %>
		</ul>
	</div>
	<hr>
</body>
</html>