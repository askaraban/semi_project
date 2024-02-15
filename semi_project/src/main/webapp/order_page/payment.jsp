<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<link href="<%=request.getContextPath()%>/style/payment_style.css" type="text/css" rel="stylesheet">

   
<div id='class1'><h2>"구매가 완료되었습니다."</h2></div>

<div class="moveBtn">
	<a href="<%=request.getContextPath()%>/main_page/main.jsp">	
	<button type="submit"  class="home">홈으로</button></a>
	
	<a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=my_order">	
	<button type="submit"  class="myorderBtn">나의주문내역</button></a>
</div>

	
