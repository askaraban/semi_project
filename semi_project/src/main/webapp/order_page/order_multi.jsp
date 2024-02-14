<%@page import="java.text.DecimalFormat"%>
<%@page import="xyz.itwill.DTO.CartDTO"%>
<%@page import="xzy.itwill.DAO.CartDAO"%>
<%@page import="xzy.itwill.DAO.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 장바구니 페이지에서 구매페이지로  --%>
<%--fff --%>

<%@include file="/security/login_url.jspf" %>
<%

	DecimalFormat format = new DecimalFormat("###,###,##0");
	 
	
	 	String[] cartNumList = request.getParameterValues("cartNum");
	System.out.println(cartNumList);
	for(String cart : cartNumList){
		System.out.println(cart);
		
	} 
	
	
 
%>
   
    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style type="text/css">
	
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
									<td >
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
								 		<td >
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
	    <input type="hidden" id="clientNum" name="clientNum" value="<%=cart.getCartClientNum()%>">
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
    <% for(String cartList : cartNumList){ 
		//System.out.println(cart);	 cartNum[i]	
	    
		int cartNum=Integer.parseInt(cartList);
		CartDTO cart=CartDAO.getDAO().selectOrder(cartList);
		
		int totalPrice= Integer.parseInt(cart.getProductPrice())*cartNum; //수량*가격 
		
		int discount = (int)Math.floor(((double)(cart.getProductPrice())*(100-cart.getProductDis())/100)/10)*10;
			
		int orderSum=cart.getProductPrice()*cart.getCartCount();
		int orderDisSum=discount*cart.getCartCount(); 
	%>
	    	<ul>
    			<li>
			    <div class="pdtRow">
			    	<div class="cell pdtImg">
			    	<a href="#">
			    		<img src="<%=request.getContextPath() %>/productImg/<%=cart.getProductMainImg() %>" alt="" width="90" height="90">
			   		</a>
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
			   		<% if(cart.getProductDis()!=0){ %>
			   		<%
			   			// 할인가를 나타내기 위한 변수
						int discount1 = (int)Math.floor(((double)(product.getProductPrice())*(100-product.getProductDis())/100)/10)*10;
			   		%>
			   			<span class="num"><%=format.format(orderDisSum) %> 원 </span>
			   		<% } else { %>
			   			<span class="num"><%=format.format(orderSum) %> 원</span>
			   		</span>
			   		<% } %>
			   	  </div>
			   	</div>
	   	    </li>
	   	  </ul>
     </div>	
 </section>	
 <% } %>
  				
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
</body>
</html>