<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/style/product_style.css" type="text/css" rel="stylesheet">
<body>
<!-- 상품명 ~ 주문하기/위시리스트/장바구니 버튼까지 -->
<div class="container" style="width: 70%">
	<div class="row" style="float: left; width:50%;">
		<!--<img alt="productPhoto" src="/resources/upload${productInfo.filename}" width="150%"">-->
		<img src="../images/homerunball.png" width="50">
	</div>

	<dl class="row">
		<dd class="col-sm-3">상품명</dd>
		<%-- <dt class="col-sm-9" style="text-align: left">${productInfo.productName}</dt> --%>
		<dt class="col-sm-9" style="text-align: left">&emsp;&emsp;&emsp;홈런볼</dt>
		
		<dd class="col-sm-3">제조사</dd>
		<dd class="col-sm-9" style="text-align: left">&emsp;&emsp;&emsp;해태제과</dd>
		
		<dd class="col-sm-3">원산지</dd>
		<dd class="col-sm-9" style="text-align: left">&emsp;&emsp;&emsp;상세설명참조</dd>
				
		<dd class="col-sm-3">판매가</dd>
		<dd class="col-sm-9" style="text-align: left">&emsp;&emsp;&emsp;1,500 원</dd>
		
		<dd class="col-sm-3">배송비</dd>
		<dd class="col-sm-9" style="text-align: left">
	    	&emsp;&emsp;&emsp;2,500원<br>
	    	&emsp;&emsp;&emsp;도서산간지역 배송비 5,000원 <br>&emsp;&emsp;&emsp;/ 8만원 이상 결제시 무료배송
		</dd>
	</dl>
	<div class="row productInfo" style="width: 50%; float: right;">
		<!-- <div class="d-grid gap-2"> -->
		<div id="content">
			<!-- <button class="btn btn-primary" type="button">바로 구매하기</button> -->
			<button  class="btn btn-primary" type="button">바로 구매하기</button>
		</div>
		<div class="d-grid gap-2 d-md-flex justify-content-md-end">
			<button class="btn btn-primary me-md-2" type="button">장바구니 담기</button>
			<button class="btn btn-primary" type="button">관심상품 등록</button>
		</div>
	</div>
		<br>
		<br>
		<br>
	
</div>
</body>
</html>