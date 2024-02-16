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

	List<ProductDTO> pro = new ArrayList<>();
	pro = ProductDAO.getDAO().selectBestProudct();
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
      <a href="<%=request.getContextPath()%>/main_page/main.jsp?group=product_page&worker=product_recommand">
      <img src="<%=request.getContextPath()%>/images/banner5.png" class="img-fluid" class="d-block w-100" alt="saleProduct">
      </a>
    </div>
  </div>
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
			<%for(int i=0;i<8;i++){ %>
			<%-- <%for(ProductDTO pro : productList){ %> --%>
			<li id="anchorBoxId_1" class="xans">
				<div class="card border-light" style="width: 14rem;">
					<div id="inner_img" class="">
					<%-- 제품이미지 클릭시 제품상세설명으로 이동할 때 넘길 값 --%>
					<%
					String url=request.getContextPath()+"/main_page/main.jsp?group=product_page&worker=product"
							   +"&productNum="+pro.get(i).getProductNum();
					%>
					<a href="<%=url%>" class="product-a-line">
					<img src="<%=request.getContextPath() %>/productImg/<%=pro.get(i).getProductMainImg() %>" class="card-img-top" >
					</a>
					</div>
					<div class="card-body item-box">
						<h5 class="card-title">
						<a href="<%=url%>" style=" text-decoration-line: none; color: black; font-size: 13px;" ><%=pro.get(i).getProductName() %></a>
						</h5>
						<p class="card-text" style="font-size: 12px;"><%=pro.get(i).getProductCom() %></p>
						<%if(pro.get(i).getProductDis()!=0){ %>
						<%
						// 할인가를 나타내기 위한 변수
						int discount =  (int)Math.floor(((double)(pro.get(i).getProductPrice())*(100-pro.get(i).getProductDis())/100)/10)*10;
						%>
						<p class="card-text" ><%=format.format(discount) %>원
						<span class="discount" style="font-size: 10px;"><%=format.format(pro.get(i).getProductPrice()) %>원</span>
						<%} else{%>
						<p class="card-text" ><%=format.format(pro.get(i).getProductPrice()) %>원
						<%} %>
						</p>
						
						<p>
							<%-- 로그인이 안되어 있다면, 모두 빈 하트 --%>
							<%if(loginClient==null) {%>
								<img src="<%=request.getContextPath()%>/images/icon/heart-black.png" 
								class="wishHeart" alt="좋아요" title="off"  id="productNum<%=pro.get(i).getProductNum()%>">
							<%-- 로그인이 되어 있다면, 회원번호와 제품번호를 매개변수로 전달받아 제품번호를 전달받는 dao 메소드 호출 --%>	
							<% } else if(loginClient!=null){%>
								<%
									wishProductNum=WishDAO.getDAO().selectWish(pro.get(i).getProductNum(),loginClientNum);
								%>
								<%if(wishProductNum==pro.get(i).getProductNum()){%> 
									<img src="<%=request.getContextPath()%>/images/icon/heart-red.png" 
									class="wishHeart" alt="좋아요" title="on"  id="productNum<%=pro.get(i).getProductNum()%>">
								<%} else {%>
									<img src="<%=request.getContextPath()%>/images/icon/heart-black.png" 
									class="wishHeart" alt="좋아요" title="off"  id="productNum<%=pro.get(i).getProductNum()%>">
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


<%-- 하트 이미지 클릭 시 발생되는 이벤트 함수 --%>
$("img").filter(".wishHeart").click(function() {
	var productNum = $(this).attr("id");
	var title = $(this).attr("title");
	
	<%-- 로그인 하지 않았을 시 로그인 페이지로 이동--%>
	if(<%=login%>==0){
		location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=login_page&worker=client_login";
	} else {
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
	}
	
	
	
})

</script>
</body>
