<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<div class="main-body">
	<h2 class="titleArea">장바구니</h2>
</div>
<div class="cart-body">
	<div class="form-check cart-store">
		<div class="check-box-all">
			<div class="check-box-all-inner">
				<input class="form-check-input" type="checkbox" value=""
					id="flexCheckDefault"> <label class="form-check-label"
					for="flexCheckDefault"> 전체 선택 </label>
			</div>
			<div class="checkBtn">
				<button type="button" class="btn btn-light">
					<img id="checkDel" alt="x"
						src="<%=request.getContextPath()%>/images/icon/icons8-x.png">선택
					삭제
				</button>
			</div>
		</div>
		<div class="form-check cart-inner-check"></div>
		<div class="cart-logo">
			<span>과자몰</span>
		</div>
		<div class="product-info">
			<div>
				<div class="check-box-all-inner">
					<input class="form-check-input" type="checkbox"
						id="checkboxNoLabel" value="" aria-label="product-check">
				</div>
			</div>
			<div class="product-inner">
				<div >
					<img class="cart-product-img" alt="thumb" src="<%=request.getContextPath()%>/images/snack_ch/ABC.png">
				</div>
				<div class="cart-product-infoArea">
					<div class="cart-product-title">ABC 초콜릿 500g</div>
					<div class="cart-product-price">가격 : 4,800원</div>
					<div class="cart-product-countInner">주문 수량 : 1개</div>
				</div>
			</div>
			
			<br>
		</div>
		<div class="product-info">
			<div>
				<div class="check-box-all-inner">
					<input class="form-check-input" type="checkbox"
						id="checkboxNoLabel" value="" aria-label="product-check">
				</div>
			</div>
			<div class="product-inner">
				<div >
					<img class="cart-product-img" alt="thumb" src="<%=request.getContextPath()%>/images/snack_ch/ABC.png">
				</div>
				<div class="cart-product-infoArea">
					<div class="cart-product-title">ABC 초콜릿 500g</div>
					<div class="cart-product-price">가격 : 4,800원</div>
					<div class="cart-product-countInner">주문 수량 : 1개</div>
				</div>
			</div>
			
			<br>
		</div>
	</div>
</div>
