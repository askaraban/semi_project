<%@page import="java.util.Date"%>
<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@page import="xzy.itwill.DAO.WishDAO"%>
<%@page import="xyz.itwill.DTO.WishDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="xzy.itwill.DAO.ProductDAO"%>
<%@page import="xyz.itwill.DTO.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%	
	
	ClientDTO loginClient = (ClientDTO)session.getAttribute("loginClient");

	List<ProductDTO> productList = new ArrayList<>();
	productList = ProductDAO.getDAO().selectProductList();
	
	
	DecimalFormat format = new DecimalFormat("###,###,##0");
	
	
	// 좋아요를 누른 것인지 확인하기 위한 Boolean 변수
	boolean isLike = false;
	List<WishDTO> wishList = new ArrayList<>();
	
	if(loginClient!=null){
		wishList = WishDAO.getDAO().selectWishList(loginClient.getClientNum());
	}
	 
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
		<h2 ><img src="<%=request.getContextPath()%>/images/icon/icons8-crown.png" style="padding-bottom: 18px; width: 50px;">베스트 추천 상품</h2>
		</div>
	<div class="main-prd">
		<ul class="prdList grid3">
			<%for(ProductDTO pro : productList){ %>
			<li id="anchorBoxId_1" class="xans">
				<div class="card border-light" style="width: 14rem;">
					<div id="inner_img" class="">
					<%-- 제품이미지 클릭시 제품상세설명으로 이동할 때 넘길 값 --%>
					<%
					String url=request.getContextPath()+"/main_page/main.jsp?group=product_page&worker=product"
							   +"&productNum="+pro.getProductNum()+"&productName="+pro.getProductName()+"&productPrice="+pro.getProductPrice()
							   +"&productCom="+pro.getProductCom()+"&productCate="+pro.getProductCate()+"&productReg="+pro.getProductReg()
							   +"&productDis="+pro.getProductDis()+"&productDisContent="+pro.getProductDisContent()+"&productMainImg="+pro.getProductMainImg()
							   +"&productImg1="+pro.getProductImg1()+"&productImg2="+pro.getProductImg2()+"&productImg3="+pro.getProductImg3();
					%>
					<a href="<%=url%>" class="product-a-line">
					<img src="<%=request.getContextPath() %>/productImg/<%=pro.getProductMainImg() %>" class="card-img-top" >
					</a>
					</div>
					<div class="card-body item-box">
						<h5 class="card-title" ><%=pro.getProductName() %></h5>
						<p class="card-text" ><%=pro.getProductCom() %></p>
						<p class="card-text" ><%=format.format(pro.getProductPrice()) %>원 <a><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" id="like" name="like">
						<path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/></svg></a></p>
						<p>
						<%if(isLike) {%> 
						<img src="<%=request.getContextPath()%>/images/icon/heart-red.png" class="wishHeart" alt="좋아요" class="likee"  id="productNum<%=pro.getProductNum()%>">
						<%} else {%> <img src="<%=request.getContextPath()%>/images/icon/heart-black.png" class="wishHeart" alt="좋아요"  class="likee" id="productNum<%=pro.getProductNum()%>">
						<%} %>
						</p>

					</div>
				</div>
			</li>
					<%} %>
		</ul>
	</div>
	<hr>
	<script type="text/javascript">

var btn = document.getElementById("like")

btn.addEventListener('click',function(){
          btn.classList.toggle('active')
          
  })
  
 <%-- 좋아요// 하트를 누를 때 on <-> title off --%>

$("img").filter(".wishHeart").click(function() {
	var productNum = $(this).attr("id");
	var isHeart=document.querySelector("img[title=on]");
	if(isHeart){
		document.getElementById(productNum).setAttribute('src', "<%=request.getContextPath()%>/images/icon/heart-black.png");
		document.getElementById(productNum).setAttribute('title','off');
	} else {
		document.getElementById(productNum).setAttribute("src", "<%=request.getContextPath()%>/images/icon/heart-red.png");
		document.getElementById(productNum).setAttribute('title','on');
	}
	
	$.ajax({
		type: "get",
	    url : "<%=request.getContextPath()%>/main_page/main_like_action.jsp?productNum="+productNum,
	    dataType : "xml",
	    success:function(xmlDoc){
	    	var id = $("xmlDoc").find("id").text();
	    	alert(id);
	    },
	    error:function(xhr){
	    	alert("[에러] = "+xhr.status);
	    }
	});
})


<%--
$("#productNum1").click(function() {
	alert("시발!");
});


--%>

</script>
</body>
