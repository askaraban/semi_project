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
	
	// 페이징 처리를 위한 변수- 시작페이지 1페이지
		int pageNum = 1;
		if(request.getParameter("pageNum")!=null){
			pageNum=Integer.parseInt(request.getParameter("pageNum")); 
		}
		// 넘길 수 있는 최대 페이지 수를 저장하기 위한 변수 - 보여지는 페이지 수 10페이지
		int pageSize = 8;
		if(request.getParameter("pageSize")!=null){
			pageSize = Integer.parseInt(request.getParameter("pageSize"));
		}
		
		// 검색 대상과 검색 단어를 전달받아 product_table에 검색 대상과 검색단어에 해당되는 제품의 개수를 반환하는 메소드 호출
		int totalProduct = ProductDAO.getDAO().searchTotalList(category);
		System.out.println(totalProduct);
		
		// 전체 페이지의 개수를 계산하기 위한 변수 ceil> 나머지 올림처리
		int totalPage = (int)Math.ceil((double)totalProduct/pageSize);
		
		// 전달받은 페이지 수가 비정상적인 경우 
		if(pageNum<=0 || pageNum>totalPage ){
			pageNum=1;
		}

		// 페이지 번호에 대한 페이지의 시작번호를 저장하기 위한 변수 - 10의 간격으로 시작하도록 하시오
		// ex) 1) 1~10 2) 11~20 3) 21~30 ...
		int startRow = (pageNum-1)*pageSize + 1;

		// 페이지 번호에 대한 페이지의 끝번호를 저장하기 위한 변수
		// ex) 1) 1~10 2) 11~20 3) 21~30 ...
		int endRow = pageNum * pageSize;
		
		if(endRow>totalProduct){
			endRow=totalProduct;
		}
		productList = ProductDAO.getDAO().searchProductList(category, startRow, endRow);
		// 페이지에 출력될 제품들의 일련번호 시작값을 계산하여 저장
		// => 검색된 제품의 총 개수 : 91 >> 1Page : 91 ~ 82 , 2Page: 81 ~ 3Page : 71 
		int displayNum = totalProduct - (pageNum-1) * pageSize;
	
%>	


	<div class="subTitle" style="text-align: center;">
	<% if(category==10) {%>
	<h2 style="font-weight: bold; text-align: center;">
	<img src="<%=request.getContextPath()%>/images/icon/icons-pretzel.png" style="padding-bottom: 5px; width: 40px;">
	&nbsp;스낵</h2>
	<%} else if (category==20) {%>
	<h2 style="font-weight: bold; text-align: center;">
	<img src="<%=request.getContextPath()%>/images/icon/icons-cookie.png" style="padding-bottom: 5px; width: 40px;">
	&nbsp;파이&amp;쿠키</h2>
	<%} else if (category==30) {%>
	<h2 style="font-weight: bold; text-align: center;">
	<img src="<%=request.getContextPath()%>/images/icon/icons-candy.png" style="padding-bottom: 5px; width: 40px;">
	&nbsp;캔디&amp;젤리</h2>
	<%} else if (category==40) {%>
	<h2 style="font-weight: bold; text-align: center;">
	<img src="<%=request.getContextPath()%>/images/icon/icons-chocolate.png" style="padding-bottom: 5px; width: 40px;">
	&nbsp;초콜릿</h2>
	<%} else if (category==50) {%>
	<h2 style="font-weight: bold; text-align: center;">
	<img src="<%=request.getContextPath()%>/images/icon/icons-chewing-gum.png" style="padding-bottom: 5px; width: 40px;">
	&nbsp;껌</h2>
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
					displayNum++;
					String url=request.getContextPath()+"/main_page/main.jsp?group=product_page&worker=product"
							   +"&productNum="+pro.getProductNum();
					%>
					<a href="<%=url%>" class="product-a-line">
					<img src="<%=request.getContextPath() %>/productImg/<%=pro.getProductMainImg() %>" class="card-img-top" >
					</a>
					</div>
					<div class="card-body item-box">
						<h5 class="card-title">
						<a href="<%=url%>" style=" text-decoration-line: none; color: black; font-size: 13px;" ><%=pro.getProductName() %></a>
						</h5>
						<p class="card-text" style="font-size: 12px;"><%=pro.getProductCom() %></p>
						<%if(pro.getProductDis()!=0){ %>
						<%
						// 할인가를 나타내기 위한 변수
						int discount =  (int)Math.floor(((double)(pro.getProductPrice())*(100-pro.getProductDis())/100)/10)*10;
						%>
						<p class="card-text" ><%=format.format(discount) %>원
						<span class="discount" style="font-size: 10px;"><%=format.format(pro.getProductPrice()) %>원</span>
						<%} else{%>
						<p class="card-text" ><%=format.format(pro.getProductPrice()) %>원
						<%} %>
						</p>
						
						<p>
							<%-- 로그인이 안되어 있다면, 모두 빈 하트 --%>
							<%if(loginClient==null) {%>
								<img src="<%=request.getContextPath()%>/images/icon/heart-black.png" 
								class="wishHeart" alt="좋아요" title="off"  id="productNum<%=pro.getProductNum()%>">
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

	
	<%-- 페이지 번호 출력 및 링크 제공 - 블럭화 처리 --%>
	<%
		// 하나의 페이지블럭에 출력될 페이지번호의 개수 설정
		int blockSize=5;
	
		// 페이지 블럭에 출력될 시작 페이지번호를 계산하여 저장
		// ex) 1 블럭 : 1, 2블럭 6, 3블럭 : 11
		int startPage=(pageNum-1)/blockSize*blockSize+1;
		
		// 페이지블럭에 출력될 종료페이지번호를 계산하여 저장
		// ex) 1블럭 : 5, 2블럭 : 10
		int endPage=startPage+blockSize-1;
		
		// 토탈페이지보다 종료페이지보다 크다면
		if(totalPage<endPage){
			endPage=totalPage;
		}
	%>
	<nav aria-label="Page navigation" >
	  <ul class="pagination justify-content-center" >
	    <li class="page-item" >
	    <%if(startPage>blockSize){%>
	      <a class="page-link" href="<%=request.getContextPath()%>/main_page/main.jsp?group=product_page&worker=product_cate&pageNum=<%=startPage-blockSize%>&pageSize=<%=pageSize%>&category=<%=category %>" aria-label="Previous">
	        <span aria-hidden="true">&laquo;</span>
	      </a>
	      <%} else {%>
	      <a class="page-link" href="#" aria-label="Previous">
	        <span aria-hidden="true">&laquo;</span>
	      </a>
	    </li>
	      <%} %>
	      <% for(int i=startPage;i<=endPage;i++){ %>
				<%if(pageNum !=i) {%>
	   	 			<li class="page-item">
	   	 			<a class="page-link" href="<%=request.getContextPath()%>/main_page/main.jsp?group=product_page&worker=product_cate&pageNum=<%=i%>&pageSize=<%=pageSize%>&category=<%=category %>"><%=i %></a>
	   	 			</li>
	   	 		<%}else{  %>
	   	 			<li class="page-item">
					<a class="page-link" href="#"><%=i %></a>
					</li>
				<%} %>
			<%} %>
				<%if(endPage!=totalPage){ %>
			    <li class="page-item">
			      <a class="page-link" href="<%=request.getContextPath()%>/main_page/main.jsp?group=product_page&worker=product_cate&pageNum=<%=startPage+blockSize%>&pageSize=<%=pageSize%>&category=<%=category %>" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			    </li>
			    <%}else{  %>
					<li class="page-item">
			      <a class="page-link" href="#" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			    </li>
				<%} %>
	  </ul>
</nav>
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
