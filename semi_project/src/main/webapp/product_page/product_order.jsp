<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/style/product_style.css" type="text/css" rel="stylesheet">
<body>
	<!-- 상품명 ~ 주문하기/위시리스트/장바구니 버튼까지 -->
	<div id="imgArea" class="row"">
		<img src="../images/homerunball.png" style="width:70%;">
	</div>
	<div id="infoArea" class="row">
		<div class="row">
			<div class="col-sm-3" style="font-size:20px;">상품명</div>
			<%-- <div class="col-sm-9" style="text-align: left">${productInfo.productName}</div> --%>
			<div class="col-sm-9" style="text-align:left; padding-left:100px; font-size:20px;"><b>해태 홈런볼 초코 46g [홈런왕]</b></div>
			
			<div class="col-sm-3">제조사</div>
			<div class="col-sm-9" style="text-align:left; padding-left:100px;">해태제과</div>
			
			<div class="col-sm-3">원산지</div>
			<div class="col-sm-9" style="text-align:left; padding-left:100px;">상세설명참조</div>
					
			<div class="col-sm-3">판매가</div>
			<div class="col-sm-9" style="text-align:left; padding-left:100px;">1,700 원</div>
			
			<div class="col-sm-3">배송비</div>
			<div class="col-sm-9" style="text-align:left; padding-left:100px;">
		    	2,500원<br>
		    	도서산간지역 배송비 5,000원 <br>/ 8만원 이상 결제시 무료배송
			</div>
			
			<div class="row">
		    	<div class="col-sm-3">수량</div>
				<div class="col" style="text-align:right;">
					<input type="button" onclick="count('minus')" value="-"/>
						<span id="result">1</span>
					<input type="button" onclick="count('plus')" value="+"/>
				</div>
		    	<div class="col" style="text-align:right;">1,700원</div>
			</div>
<!-- 			<div class="row">
		    	<div class="col-sm-3">총 상품금액</div>
		    	<div class="col" id="totalResult" style="text-align:right; padding-right:10px;">1700원</div>
			</div> -->
			
			<div class="row">
				<table>
					<tr>
						<td style="text-align:right; height:50px; font-weight: bold;" width=80%;>총 상품금액 : </td>
						<td id="totalResult" style="text-align:right; padding-right:10px; font-weight: bold;">1,700원</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	
	<div id="infoBtnArea" class="row productInfo">
		<div class="d-grid gap-2">
			<button class="nowOrderBtn" type="button">바로 구매하기</button>
		</div>
		<div class="d-grid gap-2 d-md-block">
			<button class="orderBtn" type="button">장바구니 담기</button>
			<button class="JjimBtn" type="button">관심상품 등록</button>
		</div>
	</div>
</body>
</html>

<script type="text/javascript">
function count(type)  {
	  // 결과를 표시할 element
	  const resultElement = document.getElementById('result');
	  const totalResultElement = document.getElementById('totalResult');
	  
	  // 현재 화면에 표시된 값
	  let number = resultElement.innerText;
	  let totalNumber = totalResultElement.innerText;
	  
	  // 더하기/빼기
	  if(type === 'plus') {
	    number = parseInt(number) + 1;
	    totalNumber = number * 1700;
	    //alert("plus 자료형 = " + typeof(totalNumber));
	  } else if(type === 'minus' && number != 0)  {
	    number = parseInt(number) - 1;
	    totalNumber = parseInt(totalNumber) - 1700;
	    //alert("minus 자료형 = " + typeof(totalNumber));
	  }
	  totalNumber = totalNumber.toLocaleString() + "원";
	  
	  // 결과 출력
	  resultElement.innerText = number;
	  totalResultElement.innerText = totalNumber;
}

</script>