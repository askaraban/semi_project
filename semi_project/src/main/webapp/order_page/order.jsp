<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	#order_info {
	text-align: left;
	margin: 10px auto;
	width: 1100px;
	}	
	
	
	#join label {
		width: 150px;
		text-align: right;
		float: left;
		margin-right: 10px;
	}
	
	#join ul li {
		list-style-type: none;
		margin: 15px 0;
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
	
	.helpArea {
		margin: 0;
		background-color: white;
	}
	
	.btnSubmit {
		
		border: 1px solid #333;
    	background: #333;
	}
	.btnSubmit {
		background: pink;
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
	<!-- 상단 영역 -->
	<header id="header">
	<div id="ec-orderform-header-head"></div>
	<div class="header">
		<h1 class="logotop"><a href="/main_page/main.jsp">과자몰</a></h1>
		</div>
	<div class="headerMenu gLeft"><span class="backBtn"><a href="cart.jsp">::before"뒤로가기"</a></span>::after
		</div>
	<div class="headerMenu gRight"><span class="cartBtn"><a href="cart.jsp">"장바구니"<span class="count EC-Layout-Basket-count-display"><span class="EC-Layout-Basket-count">2</span></span></a></span>
	<a href="mypage.jsp" class="mypageBtn">마이페이지</a>
	::after
	</div>
	
	<!-- app tag -->
	<div id="ec-orderform-header-tail"></div>
	</header>
	<div id="titleArea" class="titleArea">
		<h1>결제하기</h1>	
	</div>
	<input id="move_order_after" name="move_order_after" value="/order/order_result.html" type="hidden"  />
	        
    <!-- 주문자정보 -->
        <div id="ec-jigsaw-title-billingInfo" class="title">
            <h2>주문/배송정보</h2>
            <span id="ec-jigsaw-heading-billingInfo" class="txtEm gRight"></span>
        </div>
        <div class="contents ec-shop-ordererForm">
            <div class="ec-base-table typeWrite">
                <table border="1">
<!-- 주문자 정보 -->
<tbody class="address_form ">
	    <tr>
		<th scope="row">주문자 <span class="icoRequired">필수</span>
		</th>
        <td><input id="oname" name="oname" fw-filter="isFill" fw-label="주문자 성명" fw-msg="" class="inputTypeText" placeholder="" size="15" value="" type="text"  />
        </td>
        </tr>
		<tr class="ec-orderform-emailRow ">
		<th scope="row">이메일 <span class="icoRequired icon_order_email">필수</span>
		</th>
        <td>
                            <div class="ec-base-mail">
            <input id="oemail1" name="oemail1" class="mailId" value="" type="text"  />
            <span class="mailAddress"> </span>
          	</div>
		</td>
		</tr>
       
		<tr class="">
		<th scope="row">전화번호<span class="displaynone"><span class="icoRequired">필수</span></span>
		</th>
		                        <td><div class="ec-base-mail"><select id="ophone2_1" name="ophone2_[]" fw-filter="isNumber" fw-label="주문자 핸드폰번호" fw-alone="N" fw-msg=""  >
		<option value="010">010</option>
		<option value="011">011</option>
		<option value="016">016</option>
		<option value="017">017</option>
		<option value="018">018</option>
		<option value="019">019</option>
		</select>-<input id="ophone2_2" name="ophone2_[]" maxlength="4" fw-filter="isNumber" fw-label="주문자 핸드폰번호" fw-alone="N" fw-msg="" placeholder="" size="4" value="" type="text"  />-<input id="ophone2_3" name="ophone2_[]" maxlength="4" fw-filter="isNumber" fw-label="주문자 핸드폰번호" fw-alone="N" fw-msg="" placeholder="" size="4" value="" type="text"  /></div></td>
		</tr>

		<tr id="ec-orderer-address">
		<th scope="row">주소 <span class=""><span class="icoRequired">필수</span></span>
		</th>
        	<td>
                <ul class="ec-address">
        			<li id="orderer_zipcode_wrap" class="ec-address-zipcode displaynone">
                	<input id="ozipcode1" name="ozipcode1" placeholder="우편번호" fw-filter="isLengthRange[1][14]" class="inputTypeText displaynone" type="text" maxlength="14"> 
                	<button id="btn_search_ozipcode" class="btnBasic displaynone" type="button" >우편번호</button>
            		</li>
                                                     
           <li id="orderer_baseAddr_wrap" class="displaynone">
                <input id="oaddr1" name="oaddr1" placeholder="기본주소" fw-filter="isFill" class="inputTypeText displaynone" type="text" size="60" maxlength="100" >
           </li>
        
           <li id="orderer_detailAddr_wrap" class="displaynone">
                <input id="oaddr2" name="oaddr2" placeholder="상세 주소" fw-filter="isFill" class="inputTypeText displaynone" type="text" size="60" maxlength="255" >
           </li>
        
                </ul>
          </td>
       </tr>
</tbody>
			</table>
		 </div>
     </div>
<h3>배송지 작성</h3>   
     
<div class="contents ec-shop-ordererForm">
            <div class="ec-base-table typeWrite">
                <table border="1">
<!-- 주문자 정보 -->
<tbody class="address_form ">
	    <tr>
		<th scope="row">주문자 <span class="icoRequired">필수</span>
		</th>
        <td><input id="oname" name="oname" fw-filter="isFill" fw-label="주문자 성명" fw-msg="" class="inputTypeText" placeholder="" size="15" value="" type="text"  />
        </td>
        </tr>
		<tr class="ec-orderform-emailRow ">
		<th scope="row">이메일 <span class="icoRequired icon_order_email">필수</span>
		</th>
        <td>
                            <div class="ec-base-mail">
            <input id="oemail1" name="oemail1" class="mailId" value="" type="text"  />
            <span class="mailAddress"> </span>
          	</div>
		</td>
		</tr>
       
		<tr class="">
		<th scope="row">전화번호<span class="displaynone"><span class="icoRequired">필수</span></span>
		</th>
		                        <td><div class="ec-base-mail"><select id="ophone2_1" name="ophone2_[]" fw-filter="isNumber" fw-label="주문자 핸드폰번호" fw-alone="N" fw-msg=""  >
		<option value="010">010</option>
		<option value="011">011</option>
		<option value="016">016</option>
		<option value="017">017</option>
		<option value="018">018</option>
		<option value="019">019</option>
		</select>-<input id="ophone2_2" name="ophone2_[]" maxlength="4" fw-filter="isNumber" fw-label="주문자 핸드폰번호" fw-alone="N" fw-msg="" placeholder="" size="4" value="" type="text"  />-<input id="ophone2_3" name="ophone2_[]" maxlength="4" fw-filter="isNumber" fw-label="주문자 핸드폰번호" fw-alone="N" fw-msg="" placeholder="" size="4" value="" type="text"  /></div></td>
		</tr>

		<tr id="ec-orderer-address">
		<th scope="row">주소 <span class=""><span class="icoRequired">필수</span></span>
		</th>
        	<td>
                <ul class="ec-address">
        			<li id="orderer_zipcode_wrap" class="ec-address-zipcode displaynone">
                	<input id="ozipcode1" name="ozipcode1" placeholder="우편번호" fw-filter="isLengthRange[1][14]" class="inputTypeText displaynone" type="text" maxlength="14"> 
                	<button id="btn_search_ozipcode" class="btnBasic displaynone" type="button" >우편번호</button>
            		</li>
                                                     
           <li id="orderer_baseAddr_wrap" class="displaynone">
                <input id="oaddr1" name="oaddr1" placeholder="기본주소" fw-filter="isFill" class="inputTypeText displaynone" type="text" size="60" maxlength="100" >
           </li>
        
           <li id="orderer_detailAddr_wrap" class="displaynone">
                <input id="oaddr2" name="oaddr2" placeholder="상세 주소" fw-filter="isFill" class="inputTypeText displaynone" type="text" size="60" maxlength="255" >
           </li>
        
                </ul>
          </td>
       </tr>
       
      <tr>
		<th scope="row">배송 요청사항</th>
			<td class="shippingMsg">
				<div class="selectArea" style="width: 75%;">
					<div class="shippingMsg">
							  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
							    메세지 직접 입력
							  </button>
							  <ul class="dropdown-menu">
							    <li><a class="dropdown-item" href="#">부재시 경비(관리)실에 맡겨주세요.</a></li>
							    <li><a class="dropdown-item" href="#">부재시 문앞에 놓아주세요.</a></li>
							    <li><a class="dropdown-item" href="#">파손의 위험이 있는 상품이 있으니, 배송에 주의해주세요.</a></li>
							    <li><a class="dropdown-item" href="#">배송전에 연락주세요.</a></li>
							    <li><a class="dropdown-item" href="#">메시지 직접 입력</a></li>
							  </ul>
					</div>
				</div>
				<div class="writeMsg noRequest">
					<input type="text" class="inputTxt" id="dlvReqCntTxt" maxlength="45" style="width: 75%;" placeholder="배송요청사항을 입력해주세요. (최대 45자 까지 입력 가능)">
				</div>
			</td>
		</tr> 
</tbody>
			</table>
		 </div>
     </div>

		<div class="ec-shippingInfo-newAddress-setMain segment ">
             <input id="set_main_address0" name="set_main_address[]" fw-filter="" fw-label="기본 배송지로 저장" fw-msg="" value="T" type="checkbox"  /><label for="set_main_address0" >기본 배송지로 저장</label>            
        </div>
                
<div id="ec-jigsaw-area-orderProduct" class="ec-base-fold eToggle">
    <div id="ec-jigsaw-title-orderProduct" class="title">
        <h2>주문상품</h2>
    </div>
    <div class="contents">
        <!-- app tag -->
        <div id="ec-orderform-orderProduct-head"></div>

        <!-- 국내배송상품 주문내역 -->
        <div class="orderArea ">
 <!-- 기본배송 -->
<div class="xans-element- xans-order xans-order-normallist">
 <div class="ec-base-prdInfo xans-record-">
           <div class="prdBox">
                        <div class="thumbnail"><a href="/product/detail.html?product_no=2527&cate_no=1"><img src="//cookieall.com/web/product/tiny/202311/bbe72d6afbfb3eb1f5d2c9daa2bec301.jpg" alt="" width="90" height="90"></a></div>
                        <div class="description">
                            <strong class="prdName" title="상품명"> <a href = "/product/오리온-촉촉한-초코칩-실속형-560g-빅싸이즈/2527/category/1/" class="ec-product-name" >오리온 촉촉한 초코칩 실속형 560g [빅싸이즈]</a></strong>
                            <ul class="info">
                                <li title="옵션">
                                    <p class="option ">[옵션: 촉촉한 초코칩 실속형 560g x 6ea(BOX) (+42,000)]</p>
                                    </li>
                                <li>수량: 1개</li>
                                <li id="" class="displaynone">
                                    가격: 50,500원</li>
                            </ul>
                        </div>						
                 <button type="button" class="btnRemove " id="btn_product_one_delete_id0" prd="2527:000B:F:61937" set_prd_type="">삭제</button>
           </div>
    </div>
</div>
            

<div id="ec-jigsaw-area-payment" class="ec-base-fold eToggle selected">
    <div id="ec-jigsaw-title-payment" class="title">
        <h2>결제정보</h2>
    </div>
    <div class="contents">
        <!-- app tag -->
        <div id="ec-orderform-payment-head"></div>

        <div class="segment">
            <div class="ec-base-table gCellNarrow">
                <table border="1">

            
    <h3 class="heading">최종 결제 금액</h3>
    <!-- app tag -->
    <div id="ec-orderform-payment-tail"></div>
	<div class="ec-base-button gFull" id="orderFixItem">
            <button type="button" class="btnSubmit" id="btn_payment">
                <span id="total_order_sale_price_view">50,500</span>원 <span class="">결제하기</span>
            </button>
    </div>
    
	<!-- 부트스트랩 -->
 	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js">
	</script>
</body>
</html>