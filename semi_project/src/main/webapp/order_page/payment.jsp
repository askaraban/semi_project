<%@page import="xzy.itwill.DAO.OrderDAO"%>
<%@page import="xyz.itwill.DTO.OrderDTO"%>
<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/login_url.jspf" %>
<%
	ClientDTO Client=(ClientDTO)session.getAttribute("loginClient");
	OrderDTO order= OrderDAO.getDAO().selectedOrderList(Client);
%>
<style type="text/css">

.class {
    margin_bottom: 60px;
    padding: 200px;
}

h2{
	margin-bottom: 35px;
}
    
</style>  
        
<div id='class'><h2>"구매가 완료되었습니다."</h2></div>

<span><%=loginClient.getClientName()%>님의 주문번호는<%=order.getOrderNum()%>입니다.</span>
<a href="<%=request.getContextPath()%>/main_page/main.jsp">	
<button type="submit" >홈으로</button></a>

<a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=my_order">	
<button type="submit" >마이페이지</button></a>