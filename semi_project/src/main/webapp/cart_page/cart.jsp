<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<form id="cart" action="<%=request.getContextPath()%>/main_page/main.jsp/group=cart_page&worker=cart_action" method="post">
<div class="main-body">
	<h2 class="titleArea"
		style="text-align: left; padding-left: 10px; padding-bottom: 5px;">장바구니</h2>
</div>
<div class="cart-body">
	<div class="form-check cart-store">
		<div class="check-box-all">
			<div class="check-box-all-inner">
				<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
				<label class="form-check-label" for="flexCheckDefault"> 전체 선택 </label>
			</div>
			<div class="checkBtn">
				<button type="button" class="btn btn-light">
					<img id="checkDel" alt="x" src="<%=request.getContextPath()%>/images/icon/icons8-x.png">선택 삭제
				</button>
			</div>
		</div>
		<div class="form-check cart-inner-check"></div>
		<div class="cart-logo">
			<span>과자몰</span>
		</div>
<%-- --------------여기부터 제품에 대한 div ------------------------%>
		<div class="product-info">
			<div>
				<div class="check-box-select">
					<input class="form-check-input" type="checkbox" id="checkboxNoLabel" value="" aria-label="product-check">
				</div>
			</div>
			<div class="product-inner">
				<div>
					<img class="cart-product-img" alt="thumb"
						<%-- 장바구니에 있는 모든 제품을 가져오는 DAO 메소드를 호출하여 for문으로 사진과 가격 수량 할인가를 넣기--%>
						src="<%=request.getContextPath()%>/images/snack_ch/ABC.png">
				</div>
				<div class="cart-product-infoArea"
					style="width: 250px; margin-left: 15px;">
					<div class="cart-product-title" style="font-weight: bold;">ABC 초콜릿 500g</div>
					<div class="cart-product-price" style="padding-top: 10px;">가격 : 4,800원</div>
				</div>
			</div>
			<div class="cart-product-infoArea second-inner" style="width: 250px; text-align: left;">
				<span>상품 주문 수량</span>
				<div style="display: block;">
					<div class="quantity"
						style="display: inline-block; vertical-align: middle;">
						<input id="quantity" name="quantity_opt[]" style="width: 50px;" value="1" type="text">
					</div>
					<div style="display: inline-block; vertical-align: middle;">
						<div style="height: 17px;">
							<a href="javascript:;" class="up QuantityUp">
							<img src="//img.echosting.cafe24.com/skin/base_ko_KR/product/btn_count_up.gif" alt="수량증가">
							</a>
						</div>
						<div>
							<a href="javascript:;" class="down QuantityDown">
							<img src="//img.echosting.cafe24.com/skin/base_ko_KR/product/btn_count_down.gif" alt="수량감소">
							</a>
						</div>
					</div>
				</div>
			</div>
			<div class="cart-product-infoArea third-inner" style="width: 270px;">
				<span style="font-weight: bold; font-size: 13px;">상품 금액</span> <br>
				<span><strong style="font-weight: bold; font-size: 20px;"><em>19,600원</em></strong>&nbsp;(1개)</span>
			</div>
			<br>
		</div>
<%----------------------------- 여기까지가 제품에 대한 div -------------------%>

<%-- *******************결제창으로 가기 위한 최종 결제금액div *********************************** --%>
		<div style="display: flex;">
			<div class="cart-select-product-content">
				<span class="result-word">선택상품금액</span>
				<br>
				<span class="result-count">30,500원</span>
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
				<span class="result-count">0원</span>
			</div>
			<div style="width: 300px; height: 100px; padding-top: 20px;">
				<button type="button" class="cart-order-btn" style="">N건 주문하기</button>
			</div>
		</div>

	</div>
</div>
</form>
