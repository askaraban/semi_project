<%@page import="java.util.List"%>
<%@page import="xzy.itwill.DAO.OrderDAO"%>
<%@page import="xyz.itwill.DTO.OrderDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link href="<%=request.getContextPath()%>/style/order_style.css" type="text/css" rel="stylesheet">
<%@include file="/security/login_url.jspf" %>
<%
	DecimalFormat format = new DecimalFormat("###,###,##0");
	String timeStamp = request.getParameter("orderTime").substring(0, 17);
	List<OrderDTO> orderlist = OrderDAO.getDAO().selectOrder(timeStamp);
	
	String[] cartNumList = request.getParameterValues("cartNum");
	int totalPrice = 0;
 	
 
%>

<div id="titleArea" class="titleArea">
	<h2>결제내역</h2>	
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
	
<form action="<%=request.getContextPath()%>/order_page/insert_order_multi.jsp" method="post" id="orderForm">
<section style="display=block;">							
 		<!-- 배송지 작성 -->    
 	<h5 class="deliveryForm">배송지</h5>      
	   
		    
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
							class="inputTxt altPosition" title="이름입력" style="width: 14%;" value="<%=orderlist.get(0).getOrderReceiver()%>"
								readonly="readonly">
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
							<input type="text" name="mobile6" id="mobile3" value="<%=orderlist.get(0).getOrderMobile()%>" readonly="readonly">
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
				 			title="이메일 입력" style="width:90 %;" value="<%=orderlist.get(0).getOrder_email()%>">
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
								<input type="text" name="zipcode" id="zipcode" size="7" readonly="readonly" 
									value="<%=orderlist.get(0).getOrderZipcode()%>">
								</li>
								<li>
								<input type="text" name="address1" id="address1" size="50" readonly="readonly" 
									value="<%=orderlist.get(0).getOrderAddress1()%>">
								</li>
								<li>
								<input type="text" name="address2" id="address2" size="50" readonly="readonly" 
									value="<%=orderlist.get(0).getOrderAddress2()%>">
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
							<textarea rows="5" cols="80" name="order_content" readonly="readonly"><%=orderlist.get(0).getOrderContent()%></textarea>
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
		for(OrderDTO order : orderlist){
			
			int discount =  (int)Math.floor(((double)(order.getProductPrice())*(100-order.getProductDis())/100)/10)*10;
			if(order.getProductDis()==0){
				totalPrice += order.getOrderCount() * order.getProductPrice();
			} else {
				totalPrice += order.getOrderCount() * discount;
			}
		%>
		
		<div class="product-info">
			<div class="product-inner">
				<div>
					<%String url=request.getContextPath()+"/main_page/main.jsp?group=product_page&worker=product"
							   +"&productNum="+order.getOrderProductNum(); %>
					<a href="<%=url%>">
					<img class="cart-product-img" alt="thumb" src="<%=request.getContextPath()%>/productImg/<%=order.getProductMainImg()%>">
					</a>
				</div>
				<div class="cart-product-infoArea"
					style="width: 250px; margin-left: 15px;">
					<div class="cart-product-title" style="font-weight: bold;">
					<a href="<%=url%>" style="text-decoration-line: none; color: black;"><%=order.getProductName() %></a>
					</div>
					<%if(order.getProductDis()!=0) {%>
					<div class="cart-product-price" id="select_price_<%=order.getProductPrice() %>" style="padding-top: 10px;">
					가격 : <%=format.format(discount) %>원
					<span class="discount" style="font-size: 10px;"><%=format.format(order.getProductPrice()) %>원</span>
					</div>
					<%} else {%>
					<div class="cart-product-price" id="select_price_<%=order.getProductPrice() %>" style="padding-top: 10px;">
					가격 : <%=format.format(order.getProductPrice()) %>원
					</div>
					<%} %>
				</div>
			</div>
			
			<div class="cart-product-infoArea second-inner" style="width: 270px; text-align: left;">
				<span>상품 주문 수량 : <%=order.getOrderCount() %>개 </span>
			</div>
			<input type="hidden" value="" id="plzCheck" name="plzCheck" >
			<div class="cart-product-infoArea third-inner" style="width: 250px;">
				<span style="font-weight: bold; font-size: 13px;">상품 금액</span> <br><br>
				<span><strong style="font-weight: bold; font-size: 18px;">
				
					<%if(order.getProductDis()!=0) {%>
					<em><%=format.format(order.getOrderCount()*discount) %>원</em>
					<%} else {%>
					<em><%=format.format(order.getOrderCount()*order.getProductPrice()) %>원</em>
					<%} %>
				</strong>&nbsp;(<%=order.getOrderCount() %>개)</span>
			</div>
			<br>
		</div>
		<input type="hidden" value="<%=order.getOrderProductNum()%>" name="getOrderProductNum">
		<input type="hidden" value="<%=order.getOrderCount()%>" name="getOrderCount">
		<input type="hidden" value="<%=order.getOrderProductNum()%>" name="cartNum">
		<input type="hidden" value="<%=order.getOrderCount()*order.getProductPrice()%>" name="orderSum">
		<input type="hidden" value="<%=order.getProductDis()*order.getOrderCount()*order.getProductPrice()%>" name="productDis">
		<% }%> 
	</div>	
</section>
	<div style="display: flex; padding-left: 100px;">
		<div style="width: 280px; height: 100px; padding-top: 23px;">
		</div>
		<div style="width: 300px; height: 100px; padding-top: 20px; padding-left: 20px;">
			<span class="result-word"></span>
			<br>
			<span class="result-count" id="selectedPrice2"></span>
		</div>
		<div style="width: 300px; height: 100px; padding-top: 20px;" >
			<span class="result-word">총 주문금액</span>
			<br>
			<span class="result-count" id="selectedPrice2"><%=format.format(totalPrice) %>원</span>
			<span>돌아가기</span>
		</div>
	</div>
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