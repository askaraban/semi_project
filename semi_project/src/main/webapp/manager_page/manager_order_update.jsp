<%@page import="xzy.itwill.DAO.ClientDAO"%>
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
	String timeStamp = request.getParameter("timeStemp").substring(0, 17);
	String clientNum = request.getParameter("orderClientNum");
	
	// 회원정보를 전달해 회원정보를 받아옴 
	ClientDTO client = ClientDAO.getDAO().selectClientByNum(Integer.parseInt(clientNum));
	
	List<OrderDTO> orderlist = OrderDAO.getDAO().selectManagerOrder(timeStamp);
	
	
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
					class="inputTxt name" title="이름입력" style="width: 40%;" value="<%=client.getClientName()%>" readonly="readonly">
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
						- <input type="text" name="mobile2" id="mobile2" size="4" maxlength="4" value="<%=client.getClientMobile().substring(4,8)%>" readonly="readonly">
						- <input type="text" name="mobile3" id="mobile3" size="4" maxlength="4" value="<%=client.getClientMobile().substring(9,13)%>" readonly="readonly">
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
			 				title="이메일 입력" style="width:90 %;" value="<%=client.getClientEmail()%>" readonly="readonly">
			 			<p class="inputAlt"></p>
			 		</td>
				</tr>
			</tbody>
		</table>
	</div>
</section>
<br>
<br>				    							
	
<form action="<%=request.getContextPath()%>/manager_page/manager.jsp?worker=manager_order_update_action" method="post" id="orderForm">
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

	<div id="orderProduct" class="orderProductInfo">
		<h5 style="font-size: 20px;">주문 상품 정보 <a style="font-size: 14px;" href="<%=request.getContextPath()%>/manager_page/manager.jsp?group=manager_page&worker=manager_order">[돌아가기]</a></h5>  	
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
		
		<div class="product-info" >
			<div class="product-inner">
				<div class="imgList" style="display: flex; position: relative;">
					<%String url=request.getContextPath()+"/main_page/main.jsp?group=product_page&worker=product"
							   +"&productNum="+order.getOrderProductNum(); %>
					<a href="<%=url%>">
					<img class="cart-product-img" alt="thumb" src="<%=request.getContextPath()%>/productImg/<%=order.getProductMainImg()%>" style="width: 100px;">
					</a>
					<div class="cart-product-title" style="font-weight: bold; padding-top: 10px; padding-left: 15px; width: 400px;">
					<a href="<%=url%>" style="text-decoration-line: none; color: black;"><%=order.getProductName() %></a>
					<%if(order.getProductDis()!=0) {%>
					<div class="cart-product-price" id="select_price_<%=order.getProductPrice() %>" style="padding-top: 10px;">
					가격 : <%=format.format(discount) %>원
					<span class="discount" style="font-size: 10px; text-decoration:line-through;"><%=format.format(order.getProductPrice()) %>원</span>
					</div>
					<%} else {%>
					<div class="cart-product-price" id="select_price_<%=order.getProductPrice() %>" style="padding-top: 10px; ">
					가격 : <%=format.format(order.getProductPrice()) %>원
					</div>
					</div>
					<div class="cart-product-infoArea second-inner" style="width: 270px; text-align: left; padding-top: 10px;">
						<span>상품 주문 수량 : <%=order.getOrderCount() %>개 </span>
					</div>
					<input type="hidden" value="" id="plzCheck" name="plzCheck" >
					<div class="cart-product-infoArea third-inner" style="width: 250px; padding-top: 10px;">
						<span style="font-weight: bold; font-size: 13px;">상품 금액</span> <br><br>
						<span><strong style="font-weight: bold; font-size: 18px;">
						
							<%if(order.getProductDis()!=0) {%>
							<em><%=format.format(order.getOrderCount()*discount) %>원</em>
							<%} else {%>
							<em><%=format.format(order.getOrderCount()*order.getProductPrice()) %>원</em>
							<%} %>
						</strong>&nbsp;(<%=order.getOrderCount() %>개)</span>
					</div>
				</div>
				<hr>
					<%} %>
			</div>
			
			<br>
		</div>
		<input type="hidden" value="<%=order.getOrderNum()%>" name="orderNum">
		<input type="hidden" value="<%=order.getOrderClientNum()%>" name="orderClientNum">
		<input type="hidden" value="<%=order.getOrderTime()%>" name="timeStamp">
		<% }%> 
	</div>	
	<div style="display: flex; padding-left: 50px; background-color: pink;" >
		<div style="width: 80px; height: 100px; padding-top: 20px; padding-left: 40px;" >
			<button type="submit" style="border-radius: 10px; width: 140px; height: 50px; background-color: pink; font-weight: bold; font-size: 20px;">
			배송완료하기</button>
		</div>
		<div style="width: 320px; height: 100px; padding-top: 20px; padding-left: 20px;">
			<span class="result-word" style="text-align: center; font-weight: bold; font-size: 20px;">선택 상품금액</span>
			<br>
			<br>
			<span class="result-count" id="selectedPrice2" style="font-weight: bold; font-size: 20px;">
			<%=format.format(totalPrice) %>원</span>
		</div>
		<div style="width: 20px; height: 100px; padding-top: 20px; padding-left: 20px;">
			<span class="result-word" style="text-align: center; font-weight: bold; font-size: 20px;">+</span>
			<br>
			<br>
		</div>
		<%if(totalPrice>=50000){ %>
		<div style="width: 320px; height: 100px; padding-top: 20px; padding-left: 20px;">
			<span class="result-word" style="text-align: center; font-weight: bold; font-size: 20px;">배송비</span>
			<br>
			<br>
			<span class="result-count" id="selectedPrice2" style="font-weight: bold; font-size: 20px;">
			0 원</span>
		</div>
		<div style="width: 20px; height: 100px; padding-top: 20px; padding-left: 20px;">
			<span class="result-word" style="text-align: center; font-weight: bold; font-size: 20px;">=</span>
			<br>
			<br>
		</div>
		<div style="width: 200px; height: 100px; padding-top: 20px; padding-left: 20px;">
			<span class="result-word" style="text-align: center; font-weight: bold; font-size: 20px;">총 주문금액</span>
			<br>
			<br>
			<span class="result-count" id="selectedPrice2" style="font-style: italic; font-weight: bold; font-size: 20px;">
			<%=format.format(totalPrice) %>원</span>
		</div>
		<%}else{%>
		<div style="width: 320px; height: 100px; padding-top: 20px; padding-left: 20px;">
			<span class="result-word" style="text-align: center; font-weight: bold; font-size: 20px;">배송비</span>
			<br>
			<br>
			<span class="result-count" id="selectedPrice2" style="font-weight: bold; font-size: 20px;">
			<%=format.format(5000) %>원</span>
		</div>
		<div style="width: 20px; height: 100px; padding-top: 20px; padding-left: 20px;">
			<span class="result-word" style="text-align: center; font-weight: bold; font-size: 20px;">=</span>
			<br>
			<br>
		</div>
		<div style="width: 200px; height: 100px; padding-top: 20px; padding-left: 20px;">
			<span class="result-word" style="text-align: center; font-weight: bold; font-size: 20px;">총 주문금액</span>
			<br>
			<br>
			<span class="result-count" id="selectedPrice2" style="font-style: italic; font-weight: bold; font-size: 20px;">
			<%=format.format(totalPrice+5000) %>원</span>
		</div>
		<%}%>
	</div>
</form>