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
	WishDTO redHeart = new WishDTO();
	Integer wishProductNum = 0;
	
	DecimalFormat format = new DecimalFormat("###,###,##0");
	
	
	// 좋아요를 누른 것인지 확인하기 위한 Boolean 변수
	int login = 0;
	int loginClientNum=0;
	if(loginClient!=null){
		loginClientNum = loginClient.getClientNum();
		login = 1;
	}  else{
		login=0;
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
						<p class="card-text" ><%=format.format(pro.getProductPrice()) %>원</p>
						<p>
							<%if(loginClient==null) {%>
								<img src="<%=request.getContextPath()%>/images/icon/heart-black.png" class="wishHeart" alt="좋아요" title="off"  id="productNum<%=pro.getProductNum()%>">
							<% } else if(loginClient!=null){%>
								<%
									wishProductNum=WishDAO.getDAO().selectWish(pro.getProductNum(),loginClientNum);
								%>
								
								<%if(wishProductNum==pro.getProductNum()){%> <%-- 제품 번호가 같은 애들을 찾아 --%>
									<img src="<%=request.getContextPath()%>/images/icon/heart-red.png" class="wishHeart" alt="좋아요" title="on"  id="productNum<%=pro.getProductNum()%>">
								<%} else {%>
									<img src="<%=request.getContextPath()%>/images/icon/heart-black.png" class="wishHeart" alt="좋아요" title="off"  id="productNum<%=pro.getProductNum()%>">
								<%} %>
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

  
 <%-- 좋아요// 하트를 누를 때 on <-> title off --%>
<%--
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
--%>



$("img").filter(".wishHeart").click(function() {
	var productNum = $(this).attr("id");
	var title = $(this).attr("title");
	
	<%-- 로그인 하지 않았을 시 로그인 페이지로 이동--%>
	if(<%=login%>==0){
		location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=login_page&worker=client_login";
	}
	<%-- 로그인 시 좋아요 눌렀을 시 동작되는 ajax--%>
	$.ajax({
		type: "get",
	    url : "<%=request.getContextPath()%>/main_page/main_like_action.jsp?productNum="+productNum+"&title="+title,
	    dataType : "xml",
	    success:function(xmlDoc){
	    	var code = $(xmlDoc).find("code").text();
	    	if(code=="success"){
	    		var titleName = $(xmlDoc).find("title").text();
	    		$("#"+productNum).attr("src", "<%=request.getContextPath()%>/images/icon/heart-red.png")
	    		$("#"+productNum).attr("title", titleName);
	    	} else{
	    		var titleName = $(xmlDoc).find("title").text();
	    		$("#"+productNum).attr("src", "<%=request.getContextPath()%>/images/icon/heart-black.png")
	    		$("#"+productNum).attr("title", titleName);
	    	}
	    },
	    error:function(xhr){
	    	alert("[에러] = "+xhr.status);
	    }
	});
	
	
})

</script>
</body>
