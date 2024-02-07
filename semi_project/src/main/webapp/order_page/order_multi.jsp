<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>    
<%-- 장바구니 페이지에서 구매페이지로  --%>
<style>
	tr {
		display: table-row;
		vertical-align: inherit;
		border-color: inherit;
	}
	
	table {
		border-collapse: collapse;
		text-indent: initial;
		border-spacing: 2px;
	}
	
	.tableTypeWrite {
		border-top: 2px solid #000;
	}
	
	body {
		overflow-x: hidden;
		height: 100%;
		color: #000000;
		font: 16px/1.5, '맑은 고딕', '돋움', sans-serif;
		letter-spacing: -0.01em;
		-webkit-text-size-adjust: none;
	}
	
	.tableTypeWrite.payTable.required {
		margin: 0;
	}
	
	.tableTypeWrite .required {
		font-size: 0;
	}
	
	* {
		padding: 0;
		margin: 0;
	}
	
	.tableTypeWrite th {
		padding: 24px 30px;
		border-bottom: 1px solid #F5F5F5;
		text-align: left;
		color: #333;
		vertical-align: top;
	}
	
	th {
		font-weight: normal;
		font-family: 'Pretendard','SDNeoM','notoM';
	}
	
	.tableTypeWrite .required:after {
		content: "*";
		display:inline-block;
		color: red;
		font-size: 16px;
		vertical-align: -3px;
	}
	
	.tableTypeWrite th {
		padding: 24px 30px;
		border-bottom: 1px solid #F5F5F5;
		text-align: left;
		vertical-align: top;
	}
	
	
	.btnSubmit {
		background: pink;
		border: 1px solid pink;
		font-weight: bold;
		color: white;
	}
	
	.prdBox {
		display: flex;
	
	}	
	
	td ul {
		list-style: none;
		padding: 0;
		-webkit-tap-highlight-color: rgba(0,0,0,0);
	    text-align: left;    
	}
	
	#postSearch {
		font-size: 12px;
		font-weight: bold;
		cursor: pointer;
		margin-left: 10px;
		padding: 2px 10px;
		border: 1px solid black;
	}

	#postSearch:hover {
		background: black;
		color: white;
	}
	
	li {
		list-style: none;
	}
	
	.cartList {
		border-top: 2px solid #000;
		border-bottom: 1px solid #eee;
	}
	
	div {
		display: block;
	}
	
	ul {
	    display: block;
	    list-style-type: disc;
	    margin-block-start: 1em;
	    margin-block-end: 1em;
	    margin-inline-start: 0px;
	    margin-inline-end: 0px;
	    padding-inline-start: 40px;
	}
	
	.pdtRow {
		display: flex;
		position: relative;
	}
	
	.pdtImg {
	 	position: relative;
	 	flex: none;
	 	width: 100px;
	 	height: 133px;
	}
	
	.cell {
		display: flex;
		flex-direction: column;
	}
	
	
	
	a {
		font-family: inherit;
		font-size: inherit;
		line-height: inherit;
		letter-spacing: -0.01em;
		color: inherit;
		text-decoration: none;
		outline: none;
	}	
	
	img {
		position: relative;
		width: 100%;
		height: 100%;
		vertical-align: top;
	}
	
	.pdtInfo {
		flex: 1;
		justify-content: start;
		padding: 0 50px 0 20px;
	}
	
	.pdtName {
	 	margin: 0 0 10px;
	 	font-size: 16px;
	 	line-height: 1.25;
	 	color: #000;
	}
	
	.pdtOpt {
	 	display: flex;
	 	font-size: 14px;
	 	line-height: 18px;
	 	color: #888;
	}
	
	.pdtPirce {
		justify-content: center;
		margin-left: 14px;
		width: 113px;
		text-align: right;
	}
	
	.price {
		display: block;
		font-weight: 500;
		font-size: 14px;
	}
	
	.num {
		font-weight: 700;
		font-size: 18px;
		line-height: 1.33;
	}
	
	#orderFixItem.ec-base-button.gFull [class*="btn"] {
		margin: 0;
		font-size: 18px;
		font-weight: 400;
		height: 50px;
		line-height: 50px;
		color: #fff;
		width: 100%;
	}
	
	button {
	 	overflow: visible;
	 	outline: 0;
	 	cursor: pointer;
	 	
	}
	
	
</style>
<!doctype html>
<html lang="kr">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<title>과자몰</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body id="userStyle">
	<!-- 사용자 영역 -->
	<div id="titleArea" class="titleArea">
		<h2>결제하기</h2>	
	</div>
	<br>
	<br>    	          
    <!-- 주문자정보 -->
    <section style="display=block;">
    <div id="ec-jigsaw-title-billingInfo" class="title">
       <h5>주문자 정보</h5>
    </div>
    
    <form id="orderInfoForm" name="orderInfoForm" method="POST">
	    <input type="hidden" id="recentlyAddrNoDefaultListCnt" value="0">
	    <div class="tableTypeWrite payTable">
    	<table>
			    <colgroup>
			    	<col style="width: 214px;">
			    	<col>
			    </colgroup>
			 <tbody>
			 	<tr>
			 		<th scope="row"> 
			 		<span class="required" aria-required="true">
			 		필수입력
			 		::after
			 		</span>
			 		주문자
					</th>
					<td>
						<input type="text" name="ordNmTxt" id="ordNmTxt" maxlength="10" 
						class="inputTxt altPosition" title="이름입력" style="width: 40%;" value="<%=loginClient.getClientName()%>">
						<p class="inputAlt"></p>
					</td>
				</tr>
				<tr class="">
			 		<th scope="row"> 
			 		<span class="required" aria-required="true">
			 		필수입력
			 		::after
			 		</span>
			 		연락처
			 		</th>
					<td>
						<select name="mobile1">
							<option value="010" selected>&nbsp;010&nbsp;</option>
							<option value="011">&nbsp;011&nbsp;</option>
							<option value="016">&nbsp;016&nbsp;</option>
							<option value="017">&nbsp;017&nbsp;</option>
							<option value="018">&nbsp;018&nbsp;</option>
							<option value="019">&nbsp;019&nbsp;</option>
						</select>
						- <input type="text" name="mobile2" id="mobile2" size="4" maxlength="4" value="<%=loginClient.getClientMobile().substring(4,8)%>">
						- <input type="text" name="mobile3" id="mobile3" size="4" maxlength="4" value="<%=loginClient.getClientMobile().substring(9,13)%>">
					<p class="inputAlt"></p>
					</td>
				</tr>
				<tr class="deliveryEmailWrap">
			 		<th scope="row"> 
			 		<span class="required" aria-required="true">
			 		필수입력
			 		::after
			 		</span>
			 		이메일
			 		</th>
			 		<td>
			 			<input type="text" name="emailTxt" id="emailTxt" class="inputTxt alt Position" 
			 			title="이메일 입력" style="width:90 %;" value="value="<%=loginClient.getClientEmail()%>">
			 			<p class="inputAlt"></p>
			 		</td>
				   </tr>
			  </tbody>
			</table>
		</div>
	</form>
</section>
	<br>
	<br>
	
<section style="display=block;">							
 <!-- 배송지 작성 -->    
 <h5 class="subtitle3">배송지 작성</h5>  
   	    <div class="segment ec-shippingInfo-sameaddr ">
	      <input id="sameaddr0" name="sameaddr"  value="T" type="radio" ><label for="sameaddr0" >주문자 정보와 동일</label>
	      <input id="sameaddr1" name="sameaddr" value="F" type="radio" ><label for="sameaddr1" >새로운 배송지</label>                    
	    </div>	    
	    	<form id="orderInfoForm" name="orderInfoForm" method="POST">
	    <input type="hidden" id="recentlyAddrNoDefaultListCnt" value="0">
	    <div class="tableTypeWrite payTable">
    	<table>
			    <colgroup>
			    	<col style="width: 214px;">
			    	<col>
			    </colgroup>
			 <tbody>
			 	<tr>
			 		<th scope="row"> 
			 		<span class="required" aria-required="true">
			 		필수입력
			 		::after
			 		</span>
			 		받는 사람 
					</th>
					<td>
						<input type="text" name="ordNmTxt" id="ordNmTxt" maxlength="10" 
						class="inputTxt altPosition" title="이름입력" style="width: 14%;" value="">
						<p class="inputAlt"></p>
					</td>
				</tr>
				<tr class="">
			 		<th scope="row"> 
			 		<span class="required" aria-required="true">
			 		필수입력
			 		::after
			 		</span>
			 		연락처
			 		</th>
					<td>
						<select name="mobile1">
							<option value="010" selected>&nbsp;010&nbsp;</option>
							<option value="011">&nbsp;011&nbsp;</option>
							<option value="016">&nbsp;016&nbsp;</option>
							<option value="017">&nbsp;017&nbsp;</option>
							<option value="018">&nbsp;018&nbsp;</option>
							<option value="019">&nbsp;019&nbsp;</option>
						</select>
						- <input type="text" name="mobile2" id="mobile2" size="4" maxlength="4">
						- <input type="text" name="mobile3" id="mobile3" size="4" maxlength="4">
					<p class="inputAlt"></p>
					</td>
				</tr>
				<tr class="deliveryEmailWrap">
			 		<th scope="row"> 
			 		<span class="required" aria-required="true">
			 		필수입력
			 		::after
			 		</span>
			 		이메일
			 		</th>
			 		<td>
			 			<input type="text" name="emailTxt" id="emailTxt" class="inputTxt alt Position" 
			 			title="이메일 입력" style="width:90 %;" value="">
			 			<p class="inputAlt"></p>
			 		</td>
				   </tr>
				   <tr class="address">
				   		<th scope="row"> 
			 			<span class="required" aria-required="true">
			 			필수입력
			 			::after
			 			</span>
			 			배송지
			 			</th>
			 			<td>
			 				<ul>
			 				<li>
							<input type="text" name="zipcode" id="zipcode" size="7" readonly="readonly" placeholder="우편번호">
							<span id="postSearch">우편번호 검색</span>
							</li>
							<li>
							<input type="text" name="address1" id="address1" size="50" readonly="readonly" placeholder="기본주소">
							</li>
							<li>
							<input type="text" name="address2" id="address2" size="50" placeholder="상세주소">
							</li>
							</ul>
			 			<p class="inputAlt"></p>
			 			</td>
				   </tr>
				   <tr class="shippingMsg">
			 		<th scope="row"> 
			 		<span class="required" aria-required="true">
			 		필수입력
			 		::after
			 		</span>
			 		배송 요청사항
			 		</th>
			 		<td>
						<textarea rows="5" cols="80" name="shippingMsg" placeholder="배송 요청사항을 입력해 주세요."></textarea>
			 			<p class="inputAlt"></p>
			 		</td>
				   </tr>
			  </tbody>
			</table>
		</div>
	</form>
	<br>
</section>		
<br>		                                               	
<br>

<!-- 주문 상품 정보 -->
    
    <form id="orderForm" name="orderForm" action="#" onsubmit="return false;">
    <section id="orderChk" style="display: block;">
    	<input type="hidden" id="#" name="#" value="#">
    <div id="orderProduct" class="title">
        <h5>주문 상품 정보</h5>  
    </div>	
    <div class="cartList">
    	<ul>
    		<script>
    		</script>
    		<li>
			    <div class="pdtRow">
			    	<div class="cell pdtImg">
			    	<a href="/product/detail.html?product_no=2527&cate_no=1">
			    		<img src="//cookieall.com/web/product/tiny/202311/bbe72d6afbfb3eb1f5d2c9daa2bec301.jpg" alt="그린티 씨드 세럼" onerror="''" width="90" height="90">
			   		</a>
			    </div>
			    <div class="cell pdtInfo">
			    	<div class="pdtName"> <!-- 품명 -->
			    		<a href="/product/detail.html?product_no=2527&cate_no=1" onclick="#">촉촉한 초코칩</a>
			    	</div>
			    	<div class="pdtOpt"> <!-- 수량 -->
			    		<span class="pdtCount">1개</span>
			    	</div>
			    </div>
			   	<div class="cell pdtPrice">
			   		<span class="price">
			   			<span class="num">54,000</span>
			   			원 
			   		</span>
			   	  </div>
			   	</div>
	   	    </li>
	   	  </ul>
	   	<ul>
    		<script>
    		</script>
    		<li>
			    <div class="pdtRow">
			    	<div class="cell pdtImg">
			    	<a href="/product/detail.html?product_no=2527&cate_no=1">
			    		<img src="//cookieall.com/web/product/tiny/202311/bbe72d6afbfb3eb1f5d2c9daa2bec301.jpg" alt="그린티 씨드 세럼" onerror="''" width="90" height="90">
			   		</a>
			    </div>
			    <div class="cell pdtInfo">
			    	<div class="pdtName"> <!-- 품명 -->
			    		<a href="/product/detail.html?product_no=2527&cate_no=1" onclick="#">촉촉한 초코칩</a>
			    	</div>
			    	<div class="pdtOpt"> <!-- 수량 -->
			    		<span class="pdtCount">1개</span>
			    	</div>
			    </div>
			   	<div class="cell pdtPrice">
			   		<span class="price">
			   			<span class="num">54,000</span>
			   			원 
			   		</span>
			   	  </div>
			   	</div>
			  </li>
   		  </ul>
     </div>	
  </section>	
 </form>
  				
	<form id="orderForm" name="orderForm" action="#" onsubmit="return false;">
    <section id="orderChk" style="display: block;">
    	<input type="hidden" id="#" name="#" value="#">
    <div id="orderProduct" class="title">
        <h5>총 결제금액</h5>  
    </div>
    	<div class="ec-base-button gFull" id="orderFixItem">
    	<button type="button" class="btnSubmit" id="btn_payment">
    	<span id="total_order_sale_price_view">54,000</span>
    	원 
    	<span class>결제하기</span>
    	</button>
    	</div>
    	</section>
    	</form>
    				      
                           
                  					
     
							
		

    
    
	<!-- 부트스트랩 -->
 	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js">
	</script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	$("#postSearch").click(function() {
		new daum.Postcode({
			oncomplete: function(data) {
				$("#zipcode").val(data.zonecode);
				$("#address1").val(data.address);
			} 
		}).open();
	});
	</script>
</body>
</html>