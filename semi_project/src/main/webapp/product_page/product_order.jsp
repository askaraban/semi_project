<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/style/product_style.css" type="text/css" rel="stylesheet">
<body>
<!-- 상품명 ~ 주문하기/위시리스트/장바구니 버튼까지 -->
<div id="detailArea" style="float:center;">
	<div id="imgArea" class="row" style="float:left; text-align: center; width:50%;">
		<img src="../images/homerunball.png" style="width:70%;">
	</div>
	<div style="float: right; width:50%;">
		<div id="infoArea" class="row">
			<div>
				<dl class="row">
					<dd class="col-sm-3">상품명</dd>
					<%-- <dt class="col-sm-9" style="text-align: left">${productInfo.productName}</dt> --%>
					<dd class="col-sm-9" style="text-align: left; padding-left:100px;"><b>홈런볼</b></dd>
					
					<dd class="col-sm-3">제조사</dd>
					<dd class="col-sm-9" style="text-align: left; padding-left:100px;">해태제과</dd>
					
					<dd class="col-sm-3">원산지</dd>
					<dd class="col-sm-9" style="text-align: left; padding-left:100px;">상세설명참조</dd>
							
					<dd class="col-sm-3">판매가</dd>
					<dd class="col-sm-9" style="text-align: left; padding-left:100px;">1,500 원</dd>
					
					<dd class="col-sm-3">배송비</dd>
					<dd class="col-sm-9" style="text-align: left; padding-left:100px;">
				    	2,500원<br>
				    	도서산간지역 배송비 5,000원 <br>/ 8만원 이상 결제시 무료배송
					</dd>
					
					<dd class="col-sm-3">수량</dd>
					<dd class="col-sm-9" style="text-align: left; padding-left:100px;">
						<a href="#" class="minus">-</a>
						<span id="result">1</span>
						<a href="#" class="plus">+</a>
					</dd>
				</dl>
			</div>
		</div>
		
		<div class="row productInfo">
			<div class="d-grid gap-2">
			<!-- <div class="content"> -->
				<!-- <button class="btn btn-primary" type="button">바로 구매하기</button> -->
				<button class="nowOrderBtn" type="button">바로 구매하기</button>
			</div>
			<div class="d-grid gap-2 d-md-block">
				<button class="orderBtn" type="button">장바구니 담기</button>
				<button class="JjimBtn" type="button">관심상품 등록</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>