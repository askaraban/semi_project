<%@page import="xzy.itwill.DAO.WishDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="xzy.itwill.DAO.ProductDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.DTO.WishDTO"%>
<%@page import="xyz.itwill.DTO.ProductDTO"%>
<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	
	ClientDTO loginClient = (ClientDTO)session.getAttribute("loginClient");
	int category = Integer.parseInt(request.getParameter("category"));
	
	List<ProductDTO> productList = new ArrayList<>();
	productList = ProductDAO.getDAO().searchCateProductList(category);
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
	<div class="subTitle" style="text-align: center;">
	<% if(category==10) {%>
	<h2 style="font-weight: bold; text-align: center;"><img src="<%=request.getContextPath()%>/images/icon/icons-pretzel.png" style="padding-bottom: 5px; width: 40px;">&nbsp;스낵</h2>
	<%} else if (category==20) {%>
	<h2 style="font-weight: bold; text-align: center;"><img src="<%=request.getContextPath()%>/images/icon/icons-cookie.png" style="padding-bottom: 5px; width: 40px;">&nbsp;파이&amp;쿠키</h2>
	<%} else if (category==30) {%>
	<h2 style="font-weight: bold; text-align: center;"><img src="<%=request.getContextPath()%>/images/icon/icons-candy.png" style="padding-bottom: 5px; width: 40px;">&nbsp;캔디&amp;젤리</h2>
	<%} else if (category==40) {%>
	<h2 style="font-weight: bold; text-align: center;"><img src="<%=request.getContextPath()%>/images/icon/icons-chocolate.png" style="padding-bottom: 5px; width: 40px;">&nbsp;초콜릿</h2>
	<%} else if (category==50) {%>
	<h2 style="font-weight: bold; text-align: center;"><img src="<%=request.getContextPath()%>/images/icon/icons-chewing-gum.png" style="padding-bottom: 5px; width: 40px;">&nbsp;껌</h2>
	<%} %>
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
							   +"&productNum="+pro.getProductNum();
					%>
					<a href="<%=url%>" class="product-a-line">
					<img src="<%=request.getContextPath() %>/productImg/<%=pro.getProductMainImg() %>" class="card-img-top" >
					</a>
					</div>
					<div class="card-body item-box" >
						<h5 class="card-title" ><%=pro.getProductName() %></h5>
						<p class="card-text" ><%=pro.getProductCom() %></p>
						<p class="card-text" ><%=format.format(pro.getProductPrice()) %>원</p>
						<p>
							<%-- 로그인이 안되어 있다면, 모두 빈 하트 --%>
							<%if(loginClient==null) {%>
								<img src="<%=request.getContextPath()%>/images/icon/heart-black.png" 
								class="wishHeart" alt="좋아요" title="off"  id="productNum<%=pro.getProductNum()%>"  >
							<%-- 로그인이 되어 있다면, 회원번호와 제품번호를 매개변수로 전달받아 제품번호를 전달받는 dao 메소드 호출 --%>	
							<% } else if(loginClient!=null){%>
								<%
									wishProductNum=WishDAO.getDAO().selectWish(pro.getProductNum(),loginClientNum);
								%>
								<%if(wishProductNum==pro.getProductNum()){%> 
									<img src="<%=request.getContextPath()%>/images/icon/heart-red.png" 
									class="wishHeart" alt="좋아요" title="on"  id="productNum<%=pro.getProductNum()%>">
								<%} else {%>
									<img src="<%=request.getContextPath()%>/images/icon/heart-black.png" 
									class="wishHeart" alt="좋아요" title="off"  id="productNum<%=pro.getProductNum()%>">
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