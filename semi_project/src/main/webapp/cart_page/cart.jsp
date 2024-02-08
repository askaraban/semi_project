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
	int totalPrice = 0;
	int cnt=0;
%>
<style>
/* Chrome, Safari, Edge, Opera */
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

/* Firefox  */
input[type='number'] {
  -moz-appearance: textfield;
}
</style>
<form id="cart" method="post" action="">
<div class="main-body">
	<h2 class="titleArea"
		style="text-align: left; padding-left: 10px; padding-bottom: 5px;">장바구니</h2>
</div>
<div class="cart-body">
	<div class="form-check cart-store">
		<div class="check-box-all">
			<div class="check-box-all-inner">
				<input class="form-check-input" type="checkbox" value="" id="allCheck" checked="checked" style="background-color: pink; border-color: pink;">
				<label class="form-check-label" for="flexCheckDefault"> 전체 선택 </label>
			</div>
			<div class="checkBtn">
			<%-- 선택 삭제하는 버튼 --%>
				<button id="cartDelete" type="submit" class="btn btn-light">
					<img id="checkDel" alt="x" src="<%=request.getContextPath()%>/images/icon/icons8-x.png">선택 삭제
				</button>
			</div>
		</div>
		<div class="form-check cart-inner-check"></div>
		<div class="cart-logo">
			<span>쿠키킹</span>
		</div>
<%-- --------------여기부터 제품에 대한 div ------------------------%>
		<%for(CartDTO cart : cartList) {%>
		<%
		int discount =  (int)Math.floor(((double)(cart.getProductPrice())*(100-cart.getProductDis())/100)/10)*10;
		if(cart.getProductDis()==0){
			totalPrice += cart.getCartCount() * cart.getProductPrice();
		} else {
			totalPrice += cart.getCartCount() * discount;
		}
		
		System.out.println(totalPrice);
		// 할인가를 나타내기 위한 변수
		%>
		
		<div class="product-info">
			<div>
				<div class="check-box-select">
					<%-- 제품 각각에 대한 체크박스 --%>
					<input class="form-check-input selectCheck" type="checkbox" value="<%=cart.getCartNum() %>" 
						 aria-label="product-check" 
						 checked="checked" 
						 name="cartNum"
						 <%if(cart.getProductDis()==0){ %>
						 id="<%=cart.getCartNum() %>_<%=cart.getProductPrice() %>_<%=cart.getCartCount() %>" 
						 <%} else { %>
						 id="<%=cart.getCartNum() %>_<%=discount%>_<%=cart.getCartCount() %>" 
						 <%} %> 
						 style="background-color: pink; border-color: pink;">
				</div>
				
			</div>
			<div class="product-inner">
				<div>
					<%-- 장바구니에 있는 모든 제품을 가져오는 DAO 메소드를 호출하여 for문으로 사진과 가격 수량 할인가를 넣기--%>
					
					<img class="cart-product-img" alt="thumb" src="<%=request.getContextPath()%>/productImg/<%=cart.getProductMainImg()%>">
				</div>
				<div class="cart-product-infoArea"
					style="width: 250px; margin-left: 15px;">
					<div class="cart-product-title" style="font-weight: bold;"><%=cart.getProductName() %></div>
					<%if(cart.getProductDis()!=0) {%>
					<div class="cart-product-price" id="select_price_<%=cart.getProductPrice() %>" style="padding-top: 10px;">가격 : <%=format.format(discount) %>원
					<span class="discount" style="font-size: 10px;"><%=format.format(cart.getProductPrice()) %>원</span>
					</div>
					<%} else {%>
					<div class="cart-product-price" id="select_price_<%=cart.getProductPrice() %>" style="padding-top: 10px;">가격 : <%=format.format(cart.getProductPrice()) %>원</div>
					<%} %>
				</div>
			</div>
			
			<div class="cart-product-infoArea second-inner" style="width: 270px; text-align: left;">
				<span>상품 주문 수량   </span>
					<%-- 주문 수량을 조절하는 input 태그 --%>
					<br><br>
				<input class="contentCountBtn" id="minusBtn<%=cnt %>" type="button" value="-" />&nbsp;
				
				<input id="cartCount<%=cnt %>" class="cartCount" name="cartCount<%=cnt %>" value="<%=cart.getCartCount() %>" 
					type="number" min="1" style="width: 70px; text-align: center; padding-right: 10px;">&nbsp;
					
				<input class="contentCountBtn" id="plusBtn<%=cnt %>" type="button" value="+" style="margin-right: 10px;"/>
				
				<button type="submit" id="countChangeBtn<%=cnt %>" style="border: 1px solid pink; background-color: pink; border-radius: 5px; 
					font-weight: bold; color: white; height: 30px;">변경</button>
			</div>
			
			<input type="hidden" value="" id="plzCheck" name="plzCheck" >
			<div class="cart-product-infoArea third-inner" style="width: 250px;">
				<span style="font-weight: bold; font-size: 13px;">상품 금액</span> <br>
				<span><strong style="font-weight: bold; font-size: 20px;">
				
					<%if(cart.getProductDis()!=0) {%>
					<em><%=format.format(discount) %>원</em>
					<%} else {%>
					<em><%=format.format(cart.getCartCount()*cart.getProductPrice()) %>원</em>
					<%} %>
				</strong>&nbsp;(<%=cart.getCartCount() %>개)</span>
			</div>
			<br>
		</div>
		<% } %>

<%----------------------------- 여기까지가 제품에 대한 div -------------------%>

<%-- *******************결제창으로 가기 위한 최종 결제금액div *********************************** --%>
		<div style="display: flex;">
			<div class="cart-select-product-content">
				<span class="result-word" >선택상품금액</span>
				<br>
				<span class="result-count" id="selectedPrice"><%=format.format(totalPrice) %>원</span>
			</div>
			<div class="cart-minus-content">-</div>
			<div style="width: 200px; height: 100px; padding-top: 20px;">
				<span class="result-word">즉시할인예상금액</span>
				<br>
				<span class="result-discount" style="font-size: 20px; font-weight: bold;">0원</span>
			</div>
			<div class="cart-result-content">=</div>
			<div style="width: 300px; height: 100px; padding-top: 20px;">
				<span class="result-word">주문금액</span>
				<br>
				<span class="result-count" id="selectedPrice2"><%=format.format(totalPrice) %>원</span>
			</div>
			<div style="width: 300px; height: 100px; padding-top: 20px;">
				<button type="submit" id="cartOrderBtn" class="cart-order-btn" value=""><%=cnt %>건 주문하기</button>
			</div>
		</div>
	</div>
</div>
</form>

<script type="text/javascript">


<%--전체선택과 부분선택에 대한 메소드--%>
<%-- 1. 전체선택 클릭하였 때 개별상품이 변동되도록 하는 이벤트 함수 --%>

var checkLength = $(".selectCheck").length; // 장바구니에 들어간 제품의 수
var checkedProduct = ""; // 선택된 제품의 수
var totalPrice = <%=totalPrice%>;

$("#allCheck").click(function() {
let cbArray = document.getElementsByClassName("selectCheck"); // 개별 체크박스의 배열을 획득
	if($("#allCheck").is(":checked")){ // 전체선택 체크박스 클릭 시 - 모든 제품 체크 및 해제
		for(let i=0;i<cbArray.length;i++){
			var checked = $(cbArray[i]).attr("id");
			var num_price = checked.split("_");
			
			if(cbArray[i].checked==false){
				totalPrice+=Number(num_price[1]*num_price[2]); // 가격 * 수량
				$(cbArray[i]).prop("checked", true);
			} 
		}
	} else {
		for(let i=0;i<cbArray.length;i++){
			var checked = $(cbArray[i]).attr("id");
			var num_price = checked.split("_");
			
			if(cbArray[i].checked==true){
				totalPrice-=Number(num_price[1]*num_price[2]); // 가격 * 수량
				$(cbArray[i]).prop("checked", false);
			} 
		}
	}
	$("#selectedPrice").html(totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+"원");
	console.log("전체 선택 총 금액 = " + totalPrice);
});

<%-- 개별 체크박스 선택 시 변동되는 함수--%>
$("input[type=checkbox]").filter(".selectCheck").click(function() { // .selectCheck 체크박스 클래스 중 하나가 클릭 되었을 때,
	
	var checked = $(this).attr("id");
	var num_price = checked.split("_");
	if($("#"+checked).is(":checked")){
		console.log(num_price[0] + "번호 "+num_price[1] + " 가격 " + num_price[2] + " 수량");
		console.log("체크시 가격 = " + Number(num_price[1]*num_price[2]));
		totalPrice+=Number(num_price[1]*num_price[2]);
		$("#selectedPrice").html(totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+"원");
		
	} else{
		totalPrice-=Number(num_price[1]*num_price[2]);
		$("#selectedPrice").html(totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+"원");
		console.log("체크해제시 가격 = " + Number(num_price[1]*num_price[2]));
	}
	// 전체 체크박스 체크 선택/해제 되도록 조건 설정
	if(checkLength!=$("input[type=checkbox]").filter(".selectCheck:checked").length){
		$("#allCheck").prop("checked", false);
	} else {
		$("#allCheck").prop("checked", true);
	}
});


<%-- 선택 삭제 버튼 클릭 시 [cart_remove_action]으로 이동하여 선택삭제하는 메소드 --%>
$("#cartDelete").click(()=>{
	location.href="<%=request.getContextPath()%>/main_page/main.jsp?group=cart_page&worker=cart_remove_action";
});

<%-- 수량변경에 대한 메소드 --%>
for(let i=0;i<<%=cnt%>;i++){
	<%-- 음수값을 입력하지 못하도록 제약조건 설정 --%>
	let contentInput = document.getElementById("cartCount"+[i]+"");
	contentInput.onkeydown = function(e) {
        if(!((e.keyCode > 95 && e.keyCode < 106) || (e.keyCode > 47 && e.keyCode < 58) || e.keyCode == 8)) {
            return false;
        }
    }
	<%-- + 버튼 눌렀을 때 증가되도록 함 --%>
	if($("#plusBtn"+[i]+"").click){
		$("#plusBtn"+[i]+"").click(function() {
			let count = Number(document.getElementById("cartCount"+[i]+"").value);
			document.getElementById("cartCount"+[i]+"").value=count+1;
		});
	} 
	<%-- - 버튼 눌렀을 때 증가되도록 함 --%>
	if($("#minusBtn"+[i]+"").click){
		$("#minusBtn"+[i]+"").click(function() {
			let count = Number(document.getElementById("cartCount"+[i]+"").value);
			<%-- 0일 때 버튼 비활성화 --%>
			if(count==1 || count<=0){ 
				document.getElementById("cartCount"+[i]+"").value=1;
				document.getElementById("cartCount"+[i]+"").target.disabled=true;
			}
			document.getElementById("cartCount"+[i]+"").value=count-1;
		});
	}
	<%-- 수량 변경버튼을 눌렀을 때 동작되는 메소드 --%>
	if($("#countChangeBtn"+[i]+"").click){
		$("#countChangeBtn"+[i]+"").click(function() {
			$("#cart").attr("action",  "<%=request.getContextPath()%>/main_page/main.jsp?group=cart_page&worker=cart_update_action");
		});
	}
};

<%-- 주문페이지로 이동하는 메소드 --%>
$("#cartOrderBtn").click(function() {
	if($("#selectedPrice2").text()=="0원"){
		alert("주문할 제품을 선택해주세요.");
		return;
	}
	$("#cart").attr("action",  "<%=request.getContextPath()%>/main_page/main.jsp?group=order_page&worker=order_multi");
<%--	$("#cart").attr("action",  "<%=request.getContextPath()%>/main_page/main.jsp?group=order_page&worker=order"); --%>
});
<%-- 선택된 체크박스를 삭제하는 메소드 --%>
$("#cartDelete").click(function(){
	var checked = $("input").filter(".selectCheck").length;
	$("#plzCheck").attr("value", checked);
	$("#cart").attr("action",  "<%=request.getContextPath()%>/main_page/main.jsp?group=cart_page&worker=cart_remove_action");
});
	


</script>
