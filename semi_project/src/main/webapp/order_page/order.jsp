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
</style>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>과자몰</title>

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
		<h1>주문/결제</h1>	
	</div>
	<form id="frm_order_act" name="frm_order_act" method="post" target="_self" enctype="multipart-form-data">
	<input id="move_order_after" name="move_order_after" value="/order/order_result.html" type="hidden"  />
	        
<div class="billingNshipping">
    <!-- 주문자정보 -->
    <div id="ec-jigsaw-area-billingInfo" class="ec-base-fold eToggle selected ">
        <div id="ec-jigsaw-title-billingInfo" class="title">
            <h2>주문 정보</h2>
            <span id="ec-jigsaw-heading-billingInfo" class="txtEm gRight"></span>
        </div>
        <div class="contents ec-shop-ordererForm">
            <div class="ec-base-table typeWrite">
                <table border="1">
<caption>주문자 정보 입력</caption>
                    <colgroup>
<col style="width:102px">
<col style="width:auto">
</colgroup>
<!-- 국내/해외 주문자 정보 -->
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
</div>

<div class="ec-shippingInfo-shippingMessage segment unique  ">
	<select id="omessage_select" name="omessage_select" fw-filter="" fw-label="배송 메세지" fw-msg=""  >
		<option value="oMessage-0" selected="selected">-- 메시지 선택 (선택사항) --</option>
		<option value="oMessage-1">배송 전에 미리 연락바랍니다.</option>
		<option value="oMessage-2">부재 시 경비실에 맡겨주세요.</option>
		<option value="oMessage-3">부재 시 문 앞에 놓아주세요.</option>
		<option value="oMessage-4">빠른 배송 부탁드립니다.</option>
		<option value="oMessage-5">택배함에 보관해 주세요.</option>
		<option value="oMessage-input">직접 입력</option>
	</select>                <div class="ec-shippingInfo-omessageInput gBlank10" style="display:none;">
	                    <textarea id="omessage" name="omessage" fw-filter="" fw-label="배송 메세지" fw-msg="" maxlength="255" cols="70" ></textarea>                    
	<div class="gBlank10 displaynone">
	   <label><input id="omessage_autosave0" name="omessage_autosave[]" fw-filter="" fw-label="배송 메세지 저장" fw-msg="" value="T" type="checkbox"  /><label for="omessage_autosave0" ></label>[]에 자동 저장</label>
	                        
	</div>
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
            <strong class="txtStrong">
                <span id="payment_total_order_sale_price_view">64,400</span>원     <span class="refer displaynone">(<span id="payment_total_order_sale_price_ref_view"></span>)</span>
            </strong>
            

        <!-- app tag -->
        <div id="ec-orderform-payment-tail"></div>
    </div>
</div>         
	</form>
	<div class="ec-base-button gFull" id="orderFixItem">
            <button type="button" class="btnSubmit" id="btn_payment">
                <span id="total_order_sale_price_view">64,400</span>원 <span class="">결제하기</span>
            </button>
    </div>
    <div class="helpArea">
            <ul class="ec-base-help typeDash">
				<li class="displaynone"><span class="txtEm">상기 금액은 결제 시점의 금액과 다를 수 있습니다.</span></li>
                <li>무이자할부가 적용되지 않은 상품과 무이자할부가 가능한 상품을 동시에 구매할 경우 전체 주문 상품 금액에 대해 무이자할부가 적용되지 않습니다. 
                무이자할부를 원하시는 경우 장바구니에서 무이자할부 상품만 선택하여 주문하여 주시기 바랍니다.</li>
                <li>최소 결제 가능 금액은 결제금액에서 배송비를 제외한 금액입니다.</li>
            </ul>
	</div>


	<!-- 부트스트랩 -->
 	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js">
	</script>
</body>
</html>