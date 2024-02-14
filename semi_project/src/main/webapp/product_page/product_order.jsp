<%@page import="xyz.itwill.DTO.WishDTO"%>
<%@page import="xzy.itwill.DAO.WishDAO"%>
<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="xyz.itwill.DTO.CartDTO"%>
<%@page import="xyz.itwill.DTO.ProductDTO"%>
<%@page import="xzy.itwill.DAO.ProductDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--     <%@include file="/security/login_url.jspf" %> --%>
<%

	ClientDTO loginClient = (ClientDTO)session.getAttribute("loginClient");
	DecimalFormat format = new DecimalFormat("###,###,##0");
	WishDTO redHeart = new WishDTO();
	Integer wishProductNum = 0;
	
	// 좋아요를 누른 것인지 확인하기 위한 Boolean 변수
	int login = 0;
	int loginClientNum=0;
	if(loginClient!=null){
		loginClientNum = loginClient.getClientNum();
		login = 1;
	}  else{
		login=0;
	}

	//제품번호가 전달되지 않은 경우에 대한 응답 처리 - 비정상적인 요청
	if (request.getParameter("productNum")==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
	//전달값을 반환받아 저장
	int productNum=Integer.parseInt(request.getParameter("productNum"));// 제품번호
	
	//제품번호를 전달받아 Product 테이블의 단일행을 검색하여 상품(ProductDTO 객체)을반환하는
	//ProductDAO 클래스의 메소드 호출
	ProductDTO product=ProductDAO.getDAO().selectProductByNum(productNum);
	
	
	//상품이 없는 경우에 대한 응답 처리 - 비정상적인 요청
	if(product==null) {
	request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
%>

<%
	List<ProductDTO> productList = new ArrayList<>();
	productList = ProductDAO.getDAO().selectProductList();
%>   

<link href="<%=request.getContextPath()%>/style/product_style.css" type="text/css" rel="stylesheet">
<form
	action="<%=request.getContextPath()%>/main_page/main.jsp?group=product_page&worker=product_action"
	method="post" id="uploadForm">
<input type="hidden" id="productNum" name="productNum" style="width: 50px;" value="<%=product.getProductNum() %>" type="number" min="1">
<!-- 상품명 ~ 주문하기/위시리스트/장바구니 버튼까지 -->
<div id="imgArea" class="row">
	<img src="<%=request.getContextPath() %>/productImg/<%=product.getProductMainImg() %>">
</div>
<div id="infoArea" class="row">
	<div class="row">
		<div class="col-sm-3" style="font-size:20px;">상품명</div>
		<div class="col-sm-9" style="text-align:left; padding-left:100px; font-size:20px;"><b><%=product.getProductName()%></b></div>
      
        <div class="col-sm-3">제조사</div>
        <div class="col-sm-9" style="text-align:left; padding-left:100px;"><%=product.getProductCom()%></div>
      
        <div class="col-sm-3">원산지</div>   
        <div class="col-sm-9" style="text-align:left; padding-left:100px;">상세설명참조</div>
            
        <div class="col-sm-3">판매가</div>
        <% if(product.getProductDis()!=0){ %>
    	<%
			// 할인가를 나타내기 위한 변수
			int discount =  (int)Math.floor(((double)(product.getProductPrice())*(100-product.getProductDis())/100)/10)*10;
		%>
		<div class="col-sm-9" style="text-align:left; padding-left:100px; font-weight: bold;" id="price"><%=format.format(discount) %> 원
			<span class=col-sm-3 style="text-align:left; font-size: 10px; text-decoration:line-through;"><%=format.format(product.getProductPrice()) %> 원</span>
        </div>
        <% } else { %>
       		<span class="col-sm-9" style="text-align:left; padding-left:100px; font-weight: bold;" id="price"><%=format.format(product.getProductPrice()) %> 원</span>
		<%} %>
        <div class="col-sm-3">배송비</div>
        <div class="col-sm-9" style="text-align:left; padding-left:100px;">무료배송</div>
      
        <div class="row">
		<div class="col-sm-3">수량</div>
			<div class="col" style="text-align:right;">
			<input id="countBtn" type="button" onclick="count('minus')" value="-"/>
				<span id="result">1</span>
				<input type="hidden" name="totCount" id="totCount" value="1">
			<input id="countBtn" type="button" onclick="count('plus')" value="+"/>
		</div>
		</div>
      
		<div class="row">
		<table>
			<tr id="totalPrice">
				<td width=80%;>총 상품금액 : </td> 
				<%
					// 할인가를 나타내기 위한 변수
					int discount =  (int)Math.floor(((double)(product.getProductPrice())*(100-product.getProductDis())/100)/10)*10;
				%>
				<td id="totalResult" style="text-align:right; padding-right:10px; font-weight: bold;"><%=format.format(discount) %> 원</td>
			</tr>
		</table>
		</div>
	</div>
</div>

<div id="infoBtnArea" class="row productInfo">
	<p>
	<%-- 로그인이 안되어 있다면, 빈 하트 --%>
	<%if(loginClient==null) {%>
		<img src="<%=request.getContextPath()%>/images/icon/heart-black.png" 
		class="ProductWish" alt="좋아요" title="off11"  id="productNum<%=product.getProductNum()%>">
	<%-- 로그인이 되어 있다면, 회원번호와 제품번호를 매개변수로 전달받아 제품번호를 전달받는 dao 메소드 호출 --%>	
	<% } else if(loginClient!=null){%>
		<%
			wishProductNum=WishDAO.getDAO().selectWish(product.getProductNum(),loginClientNum);
		%>
		<%if(wishProductNum==product.getProductNum()){%> 
			<img src="<%=request.getContextPath()%>/images/icon/heart-red.png" 
			class="ProductWish" alt="좋아요" title="on"  id="productNum<%=product.getProductNum()%>">
		<%} else {%>
			<img src="<%=request.getContextPath()%>/images/icon/heart-black.png" 
			class="ProductWish" alt="좋아요" title="off22"  id="productNum<%=product.getProductNum()%>">
		<%} %>
	<%} %>								
	</p>
	<p class="moveBtn">
		<button class="orderBtn" id="cartInsertBtn" type="submit">장바구니 담기</button>
		<%-- 바로 구매하기 버튼 클릭시 결제하기 창으로 이동할 때 넘길 값 --%>
		<%
			String url=request.getContextPath()+"/main_page/main.jsp?group=order_page&worker=order_single"
					   +"&productNum="+product.getProductNum();
		%>
		<button onclick="location.href='<%=url%>'" class="nowOrderBtn" type="button" id="directOrderBtn">바로 구매하기</button >
	</p>
</div>
</form>
</html>

<script type="text/javascript">
function count(type){
      // 결과를 표시할 element
      const resultElement = document.getElementById('result');
      const totalResultElement = document.getElementById('totalResult');
      const productPrice = document.getElementById('price');
    
      // 현재 화면에 표시된 값
      let number = resultElement.innerText;
      let totalNumber = totalResultElement.innerText;
      let price = productPrice.innerText;

      if(type === 'plus') {   // 더하기
         number = parseInt(number) + 1;
         totalNumber = number * parseInt(price.replace(",","").replace("원",""));
         totalNumber = totalNumber.toLocaleString() + " 원";
      } else if(type === 'minus' && number > 1)  {   // 빼기
         number = parseInt(number) - 1;
         totalNumber = parseInt(totalNumber.replace(",","").replace("원","")) - parseInt(price.replace(",","").replace("원",""));
         totalNumber = totalNumber.toLocaleString() + " 원";
      }
   
      // 결과 출력
      resultElement.innerText = number;
      totalResultElement.innerText = totalNumber;
      $("#totCount").val(number);
}

<%-- 하트 이미지 클릭 시 발생되는 이벤트 함수 --%>
$("img").filter(".ProductWish").click(function() {
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
// 단일제품 구매하기 버튼
$("#directOrderBtn").click(function() {
	var result = $("#totCount").val();
	$("#uploadForm").attr("action",  "<%=request.getContextPath()%>/main_page/main.jsp?group=order_page&worker=order_single");
	$("#uploadForm").submit();
	
});
</script>