<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="xyz.itwill.DTO.CartDTO"%>
<%@page import="xzy.itwill.DAO.CartDAO"%>
<%@page import="xzy.itwill.DAO.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="<%=request.getContextPath()%>/style/order_style.css" type="text/css" rel="stylesheet">
<%-- 장바구니 페이지에서 구매페이지로  --%>

<%@include file="/security/login_url.jspf" %>

<%
	DecimalFormat format = new DecimalFormat("###,###,##0");
	CartDTO sendCart = new CartDTO();
	List<CartDTO> cartList = CartDAO.getDAO().selectCartList(loginClient);
	/* List<CartDTO> cartList = CartDAO.getDAO().selectCartList(loginClient); 
	->
		127	17	21	2	킨더 초콜릿 T8 100g	2900	FERRERO oHG mbH	0	kinder_ch.jpg
		126	17	1	1	abc 초콜릿	1480	롯데	10	abc_ch.jpg
		125	17	2	3	오리온 비틀즈 57g	850	오리온	0	beatles_can.jpg
	*/
	
	String[] cartNumList = request.getParameterValues("cartNum");
	int totalPrice = 0;
 	
 
%>

<style>
.error {
	color: red;
	left: 160px;
	display: none;
	align-content: flex-start;
}
</style>


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
					<input type="text" name="clientName" id="clientName" maxlength="10" 
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
					<td>
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
			 		<td>
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
	
<form action="<%=request.getContextPath()%>/order_page/insert_order_multi.jsp" method="post" id="orderForm">
<section style="display=block;">							
 		<!-- 배송지 작성 -->    
 	<h5 class="deliveryForm">배송지 작성</h5>      
	   
		    
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
				 			<input type="text" name="emailTxt" id="emailTxt" style="width:90 %;" value="">				 			 
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

<!-- 주문 상품 정보 구역-->

<section id="orderChk" style="display: block;">
	<div id="orderProduct" class="orderProductInfo">
		<h5>주문 상품 정보</h5>  
	</div>

	<div class="cartList">
		<%-- <% 
 			for(String cartTwo : cartOne) {  
				//System.out.println(cart);	 cartNum[i]	
				
				int cartNum=Integer.parseInt(cartList);
				/* CartDTO cart=CartDAO.getDAO().selectOrder(cartList); */
				
				int totalPrice= Integer.parseInt(cartOne.getProductPrice())*cartNum; //수량*가격 
				System.out.println("totalPrice = " + totalPrice);
				
				int discount = (int)Math.floor(((double)(cartOne.getProductPrice())*(100-cartOne.getProductDis())/100)/10)*10;
					
				int orderSum=cartOne.getProductPrice()*cartOne.getCartCount();
				int orderDisSum=discount*cartOne.getCartCount(); 
		%> --%>
		<%
		for(String cart : cartNumList){
			CartDTO cartOne = CartDAO.getDAO().selectOrder(Integer.parseInt(cart));
			
			int discount =  (int)Math.floor(((double)(cartOne.getProductPrice())*(100-cartOne.getProductDis())/100)/10)*10;
			if(cartOne.getProductDis()==0){
				totalPrice += cartOne.getCartCount() * cartOne.getProductPrice();
			} else {
				totalPrice += cartOne.getCartCount() * discount;
			}
			
			int productNum = CartDAO.getDAO().selectProductCount(cartOne.getCartNum());
			
			
		%>
		
		<div class="product-info">
			<div class="product-inner">
				<div>
					<%String url=request.getContextPath()+"/main_page/main.jsp?group=product_page&worker=product"
							   +"&productNum="+cartOne.getCartProductNum(); %>
					<a href="<%=url%>">
					<img class="cart-product-img" alt="thumb" src="<%=request.getContextPath()%>/productImg/<%=cartOne.getProductMainImg()%>">
					</a>
				</div>
				<div class="cart-product-infoArea"
					style="width: 250px; margin-left: 15px;">
					<div class="cart-product-title" style="font-weight: bold;">
					<a href="<%=url%>" style="text-decoration-line: none; color: black;"><%=cartOne.getProductName() %></a>
					</div>
					<%if(cartOne.getProductDis()!=0) {%>
					<div class="cart-product-price" id="select_price_<%=cartOne.getProductPrice() %>" style="padding-top: 10px;">
					가격 : <%=format.format(discount) %>원
					<span class="discount" style="font-size: 10px;"><%=format.format(cartOne.getProductPrice()) %>원</span>
					</div>
					<%} else {%>
					<div class="cart-product-price" id="select_price_<%=cartOne.getProductPrice() %>" style="padding-top: 10px;">
					가격 : <%=format.format(cartOne.getProductPrice()) %>원
					</div>
					<%} %>
				</div>
			</div>
			
			<div class="cart-product-infoArea second-inner" style="width: 270px; text-align: left;">
				<span>상품 주문 수량 : <%=cartOne.getCartCount() %>개 </span>
			</div>
			<input type="hidden" value="" id="plzCheck" name="plzCheck" >
			<div class="cart-product-infoArea third-inner" style="width: 250px;">
				<span style="font-weight: bold; font-size: 13px;">상품 금액</span> <br><br>
				<span><strong style="font-weight: bold; font-size: 18px;">
				
					<%if(cartOne.getProductDis()!=0) {%>
					<em><%=format.format(cartOne.getCartCount()*discount) %>원</em>
					<%} else {%>
					<em><%=format.format(cartOne.getCartCount()*cartOne.getProductPrice()) %>원</em>
					<%} %>
				</strong>&nbsp;(<%=cartOne.getCartCount() %>개)</span>
			</div>
			<br>
		</div>
		<input type="hidden" value="<%=cartOne.getCartProductNum()%>" name="cartProductNum">
		<input type="hidden" value="<%=cartOne.getCartCount()%>" name="cartProductCount">
		<input type="hidden" value="<%=cartOne.getCartNum()%>" name="cartNum">
		<input type="hidden" value="<%=cartOne.getCartCount()*cartOne.getProductPrice()%>" name="orderSum">
		<input type="hidden" value="<%=cartOne.getProductDis()*cartOne.getCartCount()*cartOne.getProductPrice()%>" name="productDis">
		<% }%> 
	</div>	
</section>
		<% if(totalPrice < 50000) { %>
			<div style="display: flex;">
					<div class="cart-select-product-content">							
							<span class="result-word" >선택상품금액</span>
							<br>
							<span class="result-count" id="selectedPrice"><%=format.format(totalPrice) %>원</span>
						</div>
						<div class="cart-minus-content">+</div>
						<div style="width: 100px; height: 100px; padding-top: 20px;">
							<span class="result-word">배송비</span>
							<br>
							<span class="result-count" id="selectedPrice"><%=format.format(5000) %>원</span>
							<br>
						</div>
						<div class="cart-result-content">=</div>
						<div style="width: 250px; height: 100px; padding-top: 20px; padding-left: 20px;">
							<span class="result-word">주문금액</span>
							<br>
							<span class="result-count" id="selectedPrice2"><%=format.format(totalPrice+5000) %>원</span>
						</div>
				
					<div style="width: 200px; height: 100px; padding-top: 23px;">
						<button type="submit" id="cartOrderBtn" class="cart-order-btn"  >결제하기</button>
					</div>
			</div>
				
		<% } else { %>
				<div style="display: flex;">
					<div class="cart-select-product-content">						
								<span class="result-word" >선택상품금액</span>
								<br>
								<span class="result-count" id="selectedPrice"><%=format.format(totalPrice) %>원</span>
					</div>
					<div class="cart-minus-content">-</div>
							<div style="width: 100px; height: 100px; padding-top: 20px;">
								<span class="result-word">배송비</span>
								<br>
								<span class="result-discount" style="font-size: 20px; font-weight: bold;">0원</span>
							</div>
							<div class="cart-result-content">=</div>
							<div style="width: 250px; height: 100px; padding-top: 20px; padding-left: 20px;">
								<span class="result-word">주문금액</span>
								<br>
								<span class="result-count" id="selectedPrice2"><%=format.format(totalPrice) %>원</span>
							</div>
							<div style="width: 200px; height: 100px; padding-top: 23px;">
					<button type="submit" id="cartOrderBtn" class="cart-order-btn"  >결제하기</button>
				</div>
			</div>										
		<% } %>
</form>
				                                 				                         											
    
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

$("#order_receiver").focus();

$("#orderForm").submit(function() {
	var submitResult=true;
	
	$(".error").css("display","none");
	
	if($("#order_receiver").val()=="") {
		$("#nameMsg").css("display","block");
		submitResult=false;
	}
	
	var emailReg=/^[a-zA-Z]\w{5,19}$/g;
	//alert($("#emailTxt").val());
	
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

