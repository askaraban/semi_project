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
     
    <div id="order_info">
	<ul> 
		<li>
			<label for="name">주문자</label>
			<input type="text" name="name" id="name" readonly="readonly">
		</li>
		<li>
			<label for="email">이메일</label>
			<input type="text" name="email" id="email" readonly="readonly">
			
		</li>
		<li>
			<label for="mobile2">전화번호</label>
			
			- <input type="text" name="mobile2" id="mobile2" size="4" maxlength="4" readonly="readonly">
			- <input type="text" name="mobile3" id="mobile3" size="4" maxlength="4" readonly="readonly">
			
		</li>
		<li>
			<label>우편번호</label>
			<input type="text" name="zipcode" id="zipcode" size="7" readonly="readonly">
			
		</li>
		<li>
			<label for="address1">기본주소</label>
			<input type="text" name="address1" id="address1" size="50" readonly="readonly">
		
		</li>
		<li>
			<label for="address2">상세주소</label>
			<input type="text" name="address2" id="address2" size="50"  readonly="readonly">
		</li>
	</ul>
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
                    <textarea id="omessage" name="omessage" fw-filter="" fw-label="배송 메세지" fw-msg="" maxlength="255" cols="70" ></textarea>                    <div class="gBlank10 displaynone">
                        <label><input id="omessage_autosave0" name="omessage_autosave[]" fw-filter="" fw-label="배송 메세지 저장" fw-msg="" value="T" type="checkbox"  /><label for="omessage_autosave0" ></label>[]에 자동 저장</label>
                        <ul class="ec-base-help">
<li>게시글은 비밀글로 저장되며 비밀번호는 주문번호 뒷자리로 자동 지정됩니다.</li>
                        </ul>
</div>
                </div>
            </div>
	<div class="ec-shippingInfo-newAddress-setMain segment ">
                <input id="set_main_address0" name="set_main_address[]" fw-filter="" fw-label="기본 배송지로 저장" fw-msg="" value="T" type="checkbox"  /><label for="set_main_address0" >기본 배송지로 저장</label>            
                </div>
                
<div id="ec-jigsaw-area-orderProduct" class="ec-base-fold eToggle">
    <div id="ec-jigsaw-title-orderProduct" class="title">
        <h2>주문상품</h2>
        <span id="ec-jigsaw-heading-orderProduct" class="txtStrong gRight">2개</span>
    </div>
    <div class="contents">
        <!-- app tag -->
        <div id="ec-orderform-orderProduct-head"></div>

        <!-- 국내배송상품 주문내역 -->
        <div class="orderArea ">
            <!-- 기본배송 -->
            <div class="xans-element- xans-order xans-order-normallist">
            <!-- 참고: 상품반복 -->
<div class="ec-base-prdInfo xans-record-">
                    <div class="prdBox">
                        <div class="displaynone"><input id="chk_order_cancel_list0" name="chk_order_cancel_list_basic0" value="2527:000B:F:61937" type="checkbox"  /></div>
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
<div class="proPrice">
                                <span class="displaynone">50,500원</span>
                                <span class="displaynone"></span>
                                <span class="display">
                                    <span id="">50,500원 </span>
                                    <span class="displaynone">()</span>
                                </span>
                            </div>
                        </div>
                        <button type="button" class="btnRemove " id="btn_product_one_delete_id0" prd="2527:000B:F:61937" set_prd_type="">삭제</button>
                    </div>
                </div>
<!-- //참고 -->
<!-- 참고: 상품반복 -->
<div class="ec-base-prdInfo xans-record-">
                    <div class="prdBox">
                        <div class="displaynone"><input id="chk_order_cancel_list1" name="chk_order_cancel_list_basic1" value="2510:000A:F:61936" type="checkbox"  /></div>
                        <div class="thumbnail"><a href="/product/detail.html?product_no=2510&cate_no=1"><img src="//cookieall.com/web/product/tiny/202310/ca4f44b5542933dab27ae45db5fe18dd.jpg" alt="" width="90" height="90"></a></div>
                        <div class="description">
                            <strong class="prdName" title="상품명"> <a href = "/product/롯데-마가렛트-패키지-660g-대용량-30입/2510/category/1/" class="ec-product-name" >롯데 마가렛트 패키지 660g [대용량 30입]</a></strong>
                            <ul class="info">
                                <li title="옵션">
                                    <p class="option ">[옵션: 마가렛트 패키지 660g]</p>
                                    </li>
                                <li>수량: 1개</li>
                                <li id="" class="displaynone">
                                    가격: 원 </li>
                            </ul>
<div class="proPrice">
                                <span class="displaynone">10,900원</span>
                                <span class="displaynone"></span>
                                <span class="display">
                                    <span id="">10,900원 </span>
                                    <span class="displaynone">()</span>
                                </span>
                            </div>
                        </div>
                        <button type="button" class="btnRemove " id="btn_product_one_delete_id1" prd="2510:000A:F:61936" set_prd_type="">삭제</button>
                    </div>
                </div> 
                <!-- //참고 -->
</div>
            

           
       <!-- [결제정보] -->
<!--
        이 파일은 원터치 주문서의 읽기 전용 파일입니다.
        이 파일은 기능 업그레이드 시, 자동으로 개선된 소스가 적용되어 별도로 디자인 수정을 하지 않아도 됩니다 .
        원터치 주문서 조각 html 파일을 수정할 경우, 작성한 정보가 유실되거나 주문서 최신 기능이 자동 업그레이드되지 않을 수 있으니 유의해 주세요.
-->
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
            <span class="displaynone"><input id="total_price" name="total_price" fw-filter="isFill" fw-label="결제금액" fw-msg="" class="inputTypeText" placeholder="" style="text-align:right;ime-mode:disabled;clear:none;border:0px;float:none;" size="10" readonly="1" value="64400" type="text"  /></span>
        </div>

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


<script type="text/javascript">
</script>


</body>
</html>
