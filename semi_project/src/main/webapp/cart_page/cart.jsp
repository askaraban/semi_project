<%@page import="java.text.DecimalFormat"%>
<%@page import="xzy.itwill.DAO.CartDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="xyz.itwill.DTO.CartDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="/security/login_url.jspf" %>
<%	
	List<CartDTO> cartList = CartDAO.getDAO().selectCartList(loginClient);
	DecimalFormat format = new DecimalFormat("###,###,##0");
	int productPrice = 0;
	int totalPrice = 0;
	int changeCount = 0;
	int totalCount = 0;
%>

<form id="cart" action="<%=request.getContextPath()%>/main_page/main.jsp/group=cart_page&worker=cart_action" method="post">
<div class="main-body">
	<h2 class="titleArea"
		style="text-align: left; padding-left: 10px; padding-bottom: 5px;">장바구니</h2>
</div>
<div class="cart-body">
	<div class="form-check cart-store">
		<div class="check-box-all">
			<div class="check-box-all-inner">
				<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault" checked="checked">
				<label class="form-check-label" for="flexCheckDefault"> 전체 선택 </label>
			</div>
			<div class="checkBtn">
			<%-- 선택 삭제하는 버튼 --%>
				<button id="cartDelete" type="button" class="btn btn-light">
					<img id="checkDel" alt="x" src="<%=request.getContextPath()%>/images/icon/icons8-x.png">선택 삭제
				</button>
			</div>
		</div>
		<div class="form-check cart-inner-check"></div>
		<div class="cart-logo">
			<span>과자몰</span>
		</div>
<%-- --------------여기부터 제품에 대한 div ------------------------%>
		<%for(CartDTO cart : cartList) {%>
		<div class="product-info">
			<div>
				<div class="check-box-select">
					<%-- 제품 각각에 대한 체크박스 --%>
					<input class="form-check-input" type="checkbox" id="checkboxNoLabel" value="<%=cart.getCartProductNum() %>" 
						aria-label="product-check" checked="checked">
				</div>
			</div>
			<div class="product-inner">
				<div>
					<img class="cart-product-img" alt="thumb" 
						<%-- 장바구니에 있는 모든 제품을 가져오는 DAO 메소드를 호출하여 for문으로 사진과 가격 수량 할인가를 넣기--%>
						src="<%=request.getContextPath()%>/productImg/<%=cart.getProductMainImg()%>">
				</div>
				<div class="cart-product-infoArea"
					style="width: 250px; margin-left: 15px;">
					<div class="cart-product-title" style="font-weight: bold;"><%=cart.getProductName() %></div>
					<div class="cart-product-price" style="padding-top: 10px;">가격 : <%=format.format(cart.getProductPrice()) %>원</div>
				</div>
			</div>
			<div class="cart-product-infoArea second-inner" style="width: 250px; text-align: left;">
				<span>상품 주문 수량 : </span>
					<%-- 주문 수량을 조절하는 input 태그 --%>
				<input id="cartCount" name="cartCount" style="width: 50px;" value="<%=cart.getCartCount() %>" type="number" min="1">&nbsp;&nbsp;
				<button type="button" id="changeBtn" style="border: 1px solid pink; background-color: pink; border-radius: 5px; 
					font-weight: bold; color: white; height: 30px;">변경</button>
			</div>
			<input type="hidden" value="<%=changeCount%>" name="changeCount" id="changeCount">
			<input type="hidden" value="<%=productPrice=cart.getProductPrice()*cart.getCartCount()%>" name="productPrice">
			<input type="hidden" value="<%=totalPrice+=productPrice%>" name="totalPrice">
			<input type="hidden" value="<%=totalCount+=cart.getCartCount()%>" name="totalCount">
			<div class="cart-product-infoArea third-inner" style="width: 270px;">
				<span style="font-weight: bold; font-size: 13px;">상품 금액</span> <br>
				<span><strong style="font-weight: bold; font-size: 20px;">
					<em><%=format.format(productPrice) %>원</em>
				</strong>&nbsp;(<%=cart.getCartCount() %>개)</span>
			</div>
			<br>
		</div>
		<%} %>
<%----------------------------- 여기까지가 제품에 대한 div -------------------%>

<%-- *******************결제창으로 가기 위한 최종 결제금액div *********************************** --%>
		<div style="display: flex;">
			<div class="cart-select-product-content">
				<span class="result-word">선택상품금액</span>
				<br>
				<span class="result-count"><%=format.format(productPrice) %>원</span>
			</div>
			<div class="cart-minus-content">-</div>
			<div style="width: 200px; height: 100px; padding-top: 20px;">
				<span class="result-word">즉시할인예상금액</span>
				<br>
				<span class="result-count">0원</span>
			</div>
			<div class="cart-result-content">=</div>
			<div style="width: 300px; height: 100px; padding-top: 20px;">
				<span class="result-word">주문금액</span>
				<br>
				<span class="result-count"><%=format.format(totalPrice) %>원</span>
			</div>
			<div style="width: 300px; height: 100px; padding-top: 20px;">
				<button type="button" class="cart-order-btn"><%=totalCount %>건 주문하기</button>
			</div>
		</div>

	</div>
</div>
</form>

<script type="text/javascript">

<%-- 전체 선택 시 모든 체크박스 선택되는 메소드 --%>
$("#flexCheckDefault").click(function() {
	let isChecked = $("#flexCheckDefault").is(':checked');
	
	if(isChecked){
		$('input:checkbox').prop('checked',true);
	} else{
		$('input:checkbox').prop('checked',false);
	}
});
<%-- 개별선택 시 전체 체크박스 해제되는 메소드 --%>
$("#checkboxNoLabel").click(function() {
	let isChecked = $("#checkboxNoLabel").is(':checked');
	
	if(!isChecked){
		$("#flexCheckDefault").prop('checked',false);
	}
})
<%-- 선택 삭제 버튼 클릭 시 [cart_remove_action]으로 이동하여 선택삭제하는 메소드 --%>
$("#cartDelete").click(()=>{
	location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=cart_page&worker=cart_remove_action";
});

$("#changeBtn").click(function() {
	location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=product_page&worker=product_action";
	$("#changeBtn").submit();
})

</script>
