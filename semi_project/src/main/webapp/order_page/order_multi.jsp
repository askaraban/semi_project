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
<%--fff --%>

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
	
 	for(String cart : cartNumList){
 		System.out.println("cart = " + cart);
		CartDTO cartOne = CartDAO.getDAO().selectOrder(Integer.parseInt(cart));
		System.out.println("cartOne = " + cartOne); 
	} 
 
%>

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
					<input type="text" name="orderNameTxt" id="orderNameTxt" maxlength="10" 
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
						<select name="mobile1" readonly="readonly">
							<option value="010" selected>&nbsp;010&nbsp;</option>
							<option value="011">&nbsp;011&nbsp;</option>
							<option value="016">&nbsp;016&nbsp;</option>
							<option value="017">&nbsp;017&nbsp;</option>
							<option value="018">&nbsp;018&nbsp;</option>
							<option value="019">&nbsp;019&nbsp;</option>
						</select>
						- <input type="text" name="mobile2" id="mobile2" size="4" maxlength="4" value="<%=loginClient.getClientMobile().substring(4,8)%>" readonly="readonly">
						- <input type="text" name="mobile3" id="mobile3" size="4" maxlength="4" value="<%=loginClient.getClientMobile().substring(9,13)%>" readonly="readonly">
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
			 			<input type="text" name="emailTxt" id="emailTxt" class="deliEmail" 
			 				title="이메일 입력" style="width:90 %;" value="<%=loginClient.getClientEmail()%>" readonly="readonly">
			 			<p class="inputAlt"></p>
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
	    <input type="hidden" id="clientNum" name="clientNum" value="<%=cartOne.getCartClientNum()%>">
	    <input type="hidden" id="productNum" name="productNum" value="<%=cart.getCartProductNum()%>">
	    <input type="hidden" id="orderSum" name="orderSum" value="<%=orderSum%>">
	    <input type="hidden" id="orderDisSum" name="orderDisSum" value="<%=orderDisSum%>">
		    
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
							- <input type="text" name="mobile5" id="mobile2" size="4" maxlength="4">
							- <input type="text" name="mobile6" id="mobile3" size="4" maxlength="4">
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
							<textarea rows="5" cols="80" name="order_content" placeholder="배송 요청사항을 입력해 주세요."></textarea>
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
		<% 
 			for(String cartTwo : cartOne) {  
				//System.out.println(cart);	 cartNum[i]	
				
				int cartNum=Integer.parseInt(cartList);
				/* CartDTO cart=CartDAO.getDAO().selectOrder(cartList); */
				
				int totalPrice= Integer.parseInt(cartOne.getProductPrice())*cartNum; //수량*가격 
				System.out.println("totalPrice = " + totalPrice);
				
				int discount = (int)Math.floor(((double)(cart.getProductPrice())*(100-cartOne.getProductDis())/100)/10)*10;
					
				int orderSum=cart.getProductPrice()*cart.getCartCount();
				int orderDisSum=discount*cart.getCartCount(); 
		%>
		<ul>
			<li>
				<div class="pdtRow">
					<div class="cell pdtImg">
						<a href="#"><img src="<%=request.getContextPath() %>/productImg/<%=cart.getProductMainImg() %>" alt="" width="90" height="90"></a>
					</div>	
			   </div>
				<div class="cell pdtInfo">
					<div class="pdtName"> <!-- 품명 -->
						<a href="/product_page/product" onclick="#"><%=cart.getProductName() %></a>
					</div>
					<div class="pdtOpt"> <!-- 수량 -->
						<span class="pdtCount"><%=cart.getCartCount() %> 개</span>
						<input type="hidden" name="productCount" value="<%=cart.getCartCount()%>">
					</div>
				</div>
				<div class="cell pdtPrice">
					<span class="price">
						<% if(cart.getProductDis()!=0) { 
							// 할인가를 나타내기 위한 변수
							int discount1 = (int)Math.floor(((double)(product.getProductPrice())*(100-product.getProductDis())/100)/10)*10;
						%>
							<span class="num"><%=format.format(orderDisSum) %> 원 </span>
						<% } else { %>
							<span class="num"><%=format.format(orderSum) %> 원</span>
						<% } %>
					</span>
				</div>
			</li>
		</ul>
	</div>	
<% } %>
</section>
  				
<section id="orderChk" style="display: block;">
<div id="orderProduct" class="totalPrice">
    <h5>총 결제금액</h5>  
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