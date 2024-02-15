<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@page import="xzy.itwill.DAO.ProductDAO"%>
<%@page import="xyz.itwill.DTO.ProductDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="oracle.security.o3logon.O3LoginClientHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/security/login_url.jspf" %>
<%
	
	DecimalFormat format = new DecimalFormat("###,###,##0");
	

	//제품번호가 전달되지 않은 경우에 대한 응답 처리 - 비정상적인 요청
	if (request.getParameter("productNum")==null) {
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp");
		return;
	}
	
	//전달값을 반환받아 저장
	int productNum=Integer.parseInt(request.getParameter("productNum"));         // 제품번호
	//System.out.println("productNum = "+productNum);
	
	
	//제품번호를 전달받아 Product 테이블의 단일행을 검색하여 상품(ProductDTO 객체)을반환하는
	//ProductDAO 클래스의 메소드 호출
	ProductDTO product=ProductDAO.getDAO().selectProductByNum(productNum);
	int productCount = Integer.parseInt(request.getParameter("totCount"));
	//System.out.println(productCount);
		
	// 할인가를 나타내기 위한 변수
	int discount = (int)Math.floor(((double)(product.getProductPrice())*(100-product.getProductDis())/100)/10)*10;
	
	int clientNum=loginClient.getClientNum();
	
	int orderSum=product.getProductPrice()*productCount;
	int orderDisSum=discount*productCount;
	
%>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style type="text/css">
	
	
	.error {
		color: red;
		left: 160px;
		display: none;
		align-content: flex-start;
	}

	.tableTypeWrite {
		border-top: 2px solid #000;
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
	
	
	
	.cartList {
		border-top: 2px solid #000;
		border-bottom: 1px solid #eee;
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
	
	
	.titleArea     {
		text-align: left;
	}
	
	.orderInfotitle {
		text-align: left;
	}
	
	.deliveryForm   {
		text-align: left;
	}
	
	.orderProductInfo {
		text-align: left;
	}
	
	.totalPrice {
		text-align: left;
	}
	
	.nameInfo {
		text-align: left;
		
	}
	
	.receiver {
		text-align: left;
	}
	
	td ul {
		list-style: none;
		padding: 0;
		-webkit-tap-highlight-color: rgba(0,0,0,0);
		text-align: left;    
	}
	
	.deliEmail {
		text-align: left;
	}
	
	.deliPhone {
		text-align: left;
	}
	
	
</style>
<%-- 제품 상세에서 구매 페이지로 제품번호와 수량을 전달받아 반환
	 DB랑 연결해서 삽입할 데이터 처리 DAO 메소드 호출  
	 구매 정보 삽입하고 결제완료 표시하는 문서를 하나로 통합 --%>

	<!-- 사용자 영역 -->
	<div id="titleArea" class="titleArea">
		<h2>결제하기</h2>	
	</div>
	<br>
	<br>    	          
    <!-- 주문자정보 -->
    <section style="display=block;">
	    <div id="ec-jigsaw-title-billingInfo" class="orderInfotitle">
	       <h5>주문자 정보</h5> 
	    </div>
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
										<td class="nameInfo">
										<input type="text" name="orderNameTCxt" id="orderNameTxt" maxlength="10" 
										class="inputTxt name" title="이름입력" style="width: 40%;" value="<%=loginClient.getClientName()%>" readonly="readonly">
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
									<td >
										<select name="mobile11" readonly="readonly">
											<option value="010" selected>&nbsp;010&nbsp;</option>
											<option value="011">&nbsp;011&nbsp;</option>
											<option value="016">&nbsp;016&nbsp;</option>
											<option value="017">&nbsp;017&nbsp;</option>
											<option value="018">&nbsp;018&nbsp;</option>
											<option value="019">&nbsp;019&nbsp;</option>
										</select>
										- <input type="text" name="mobile12" id="mobile12" size="4" maxlength="4" value="<%=loginClient.getClientMobile().substring(4,8)%>" readonly="readonly">
										- <input type="text" name="mobile13" id="mobile13" size="4" maxlength="4" value="<%=loginClient.getClientMobile().substring(9,13)%>" readonly="readonly">
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
								 		<td >
								 			<input type="text" name="clientEmail" id="clientEmail" class="deliEmail" 
								 			title="이메일 입력" style="width:90 %;" value="<%=loginClient.getClientEmail()%>" readonly="readonly">
								 		</td>
									</tr>
								  </tbody>
							</table>
						</div>
			</section>
			<br>
			<br>				    													
	
<form action="<%=request.getContextPath()%>/order_page/insert_order_single.jsp" method="post" id="orderForm">
<section style="display=block;">							
 		<!-- 배송지 작성 -->    
 	<h5 class="deliveryForm">배송지 작성</h5>      
	    <input type="hidden" id="clientNum" name="clientNum" value="<%=clientNum%>">
	    <input type="hidden" id="productNum" name="productNum" value="<%=productNum%>">
	    <input type="hidden" id="orderSum" name="orderSum" value="<%=orderSum%>">
	    <input type="hidden" id="orderDisSum" name="orderDisSum" value="<%=orderDisSum%>">
	    <input type="hidden" id="productCount" name="productCount" value="<%=productCount%>">
		    
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
						<td class="receiver">
							<input type="text" name="order_receiver" id="order_receiver" maxlength="10" 
							class="inputTxt altPosition" title="이름입력" style="width: 14%;" value="">
							<div id="nameMsg" class="error">이름을 입력해 주세요.</div>
						</td>
					</tr>
					<tr class="deliPhone">
				 		<th scope="row"> 
					 		<span class="required" aria-required="true">
					 		필수입력
					 		::after
					 		</span>
					 		연락처
				 		</th>
						<td>
							<select name="mobile4">
								<option value="010" selected>&nbsp;010&nbsp;</option>
								<option value="011">&nbsp;011&nbsp;</option>
								<option value="016">&nbsp;016&nbsp;</option>
								<option value="017">&nbsp;017&nbsp;</option>
								<option value="018">&nbsp;018&nbsp;</option>
								<option value="019">&nbsp;019&nbsp;</option>
							</select>
							- <input type="text" name="mobile5" id="mobile5" size="4" maxlength="4">
							- <input type="text" name="mobile6" id="mobile6" size="4" maxlength="4">
							<div id="mobileMsg"  class="error">전화번호를 입력해 입력해 주세요.</div>
							<div id="mobileRegMsg" class="error">전화번호는 3~4 자리의 숫자로만 입력해 주세요.</div>
						</td>
					</tr>
					<tr class="deliEmail">
				 		<th scope="row"> 
					 		<span class="required" aria-required="true">
					 		필수입력
					 		::after
					 		</span>
					 		이메일
				 		</th>
				 		<td>
				 			<input type="text" name="emailTxt" id="emailTxt" class="inputTxt email" 
				 			title="이메일 입력" style="width:90 %;" value="">
				 			<div id="emailMsg" class="error">이메일을 입력해 주세요.</div>
							<div id="emailRegMsg" class="error">입력한 이메일이 형식에 맞지 않습니다.</div>
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
								<div id="zipcodeMsg" class="error">우편번호를 입력해 주세요.</div>
								</li>
								<li>
								<input type="text" name="address1" id="address1" size="50" readonly="readonly" placeholder="기본주소">
								<div id="address1Msg" class="error">기본주소를 입력해 주세요.</div>
								</li>
								<li>
								<input type="text" name="address2" id="address2" size="50" placeholder="상세주소">
								<div id="address2Msg" class="error">상세주소를 입력해 주세요.</div>
								</li>
							</ul>
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
							<textarea rows="5" cols="80" id="order_content"name="order_content" placeholder="배송 요청사항을 입력해 주세요."></textarea>
							<div id="orderContentMsg" class="error">배송 요청사항을 입력해 주세요.</div>
				 		</td>
				   </tr>
			  </tbody>
			</table>
		</div>
	<br>
</section>		
<br>		                                               	
<br>

<!-- 주문 상품 정보 -->
    <section id="orderChk" style="display: block;">
    <div id="orderProduct" class="orderProductInfo">
        <h5>주문 상품 정보</h5>  
    </div>
    <div class="product-info">
			<div class="product-inner">
				<div>
					<%String url=request.getContextPath()+"/main_page/main.jsp?group=product_page&worker=product"
							   +"&productNum="+product.getProductNum(); %>
					<a href="<%=url%>">
					<img class="cart-product-img" alt="thumb" src="<%=request.getContextPath() %>/productImg/<%=product.getProductMainImg() %>">
					</a>
				</div>
				<div class="cart-product-infoArea"
					style="width: 250px; margin-left: 15px;">
					<div class="cart-product-title" style="font-weight: bold;">
					<a href="<%=url%>" style="text-decoration-line: none; color: black;"><%=product.getProductName() %></a>
					</div>
					<%if(product.getProductDis()!=0) {%>
					<div class="cart-product-price" id="select_price_<%=product.getProductPrice() %>" style="padding-top: 10px;">
					가격 : <%=format.format(discount) %>원
					<span class="discount" style="font-size: 10px;"><%=format.format(product.getProductPrice()) %>원</span>
					</div>
					<%} else {%>
					<div class="cart-product-price" id="select_price_<%=product.getProductPrice() %>" style="padding-top: 10px;">
					가격 : <%=format.format(product.getProductPrice()) %>원
					</div>
					<%} %>
				</div>
			</div>
			
			<div class="cart-product-infoArea second-inner" style="width: 270px; text-align: left;">
				<span>상품 주문 수량 : <%=productCount %>개 </span>
			</div>
			<input type="hidden" value="" id="plzCheck" name="plzCheck" >
			<div class="cart-product-infoArea third-inner" style="width: 250px;">
				<span style="font-weight: bold; font-size: 13px;">상품 금액</span> <br><br>
				<span><strong style="font-weight: bold; font-size: 18px;">
				
					<%if(product.getProductDis()!=0) {%>
					<em><%=format.format(productCount*discount) %>원</em>
					<%} else {%>
					<em><%=format.format(productCount*product.getProductPrice()) %>원</em>
					<%} %>
				</strong>&nbsp;(<%=productCount %>개)</span>
			</div>
			<br>
		</div>
 </section>	
  				
    <section id="orderChk" style="display: block;">
    <div id="orderProduct" class="totalPrice">
    </div>
    	<div class="ec-base-button gFull" id="orderFixItem"> 
	    	<button type="submit" class="btnSubmit" id="btn_payment">	
		    	<%
				  int discount1 = (int)Math.floor(((double)(product.getProductPrice())*(100-product.getProductDis())/100)/10)*10;
				%>
	    	<span id="totalOrderDisPrice"><%=format.format(discount1*productCount) %> 원</span> 	
	    	<span class="payment">결제하기</span>
	    	</button>	
    	</div>
    </section>
 </form>
				                                 				  
    
<!-- 부트스트랩 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js">
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$("#order_receiver").focus();

$("#postSearch").click(function() {
	new daum.Postcode({
		oncomplete: function(data) {
			$("#zipcode").val(data.zonecode);
			$("#address1").val(data.address);
		}	 
	}).open();
});

$("#orderForm").submit(function() {
	var submitResult=true;
	
	$(".error").css("display","none");
	
	if($("#order_receiver").val()=="") {
		$("#nameMsg").css("display","block");
		submitResult=false;
	}
	
	var emailReg=/^[a-zA-Z]\w{5,19}$/g;
	if($("#emailTxt").val()=="") {
		$("#emailMsg").css("display","block");
		submitResult=false;
	} else if(!emailReg.test($("#email").val())) {
		$("#emailRegMsg").css("display","block");
		submitResult=false;
	}

	var mobile2Reg=/\d{3,4}/;
	var mobile3Reg=/\d{4}/;
	if($("#mobile5").val()=="" || $("#mobile6").val()=="") {
		$("#mobileMsg").css("display","block");
		submitResult=false;
	} else if(!mobile2Reg.test($("#mobile5").val()) || !mobile3Reg.test($("#mobile6").val())) {
		$("#mobileRegMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#zipcode").val()=="") {
		$("#zipcodeMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#address1").val()=="") {
		$("#address1Msg").css("display","block");
		submitResult=false;
	}
	
	if($("#address2").val()=="") {
		$("#address2Msg").css("display","block");
		submitResult=false;
	}
	
	if($("#order_content").val()=="") {
		$("#orderContentMsg").css("display","block");
		submitResult=false;
	}
	
	return submitResult;
});

</script>