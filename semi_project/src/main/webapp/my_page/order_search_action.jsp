<%@page import="java.text.DecimalFormat"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@page import="xyz.itwill.DTO.OrderDTO"%>
<%@page import="java.util.List"%>
<%@page import="xzy.itwill.DAO.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

String startDate = request.getParameter("startDate");
String edDate = request.getParameter("endDate");
int clientNum = Integer.parseInt(request.getParameter("clientNum"));
DecimalFormat format = new DecimalFormat("###,###,##0");


List<OrderDTO> myOrderList = OrderDAO.getDAO().myOrderList(startDate, edDate, clientNum);
String uri = Utility.toJSON("/main_page/main.jsp?group=product_page&worker=product&productNum=");
%>

<% if(myOrderList.isEmpty()) {//검색된 주문정보가 없는 경우 %>
{"code":"empty"}
<% } else {//검색된 주문정보가 있는 경우 %>
{
	"code":"success",
	"data":[
	<%-- JSON 데이타로 응답할 경우 표현 불가능한 문자값이 있는 경우 200 에러코드 발생 --%>
	<%-- => 표현 불가능한 문자값을 회피문자로 변환하여 응답 처리  --%>
	<% for(int i=0;i<myOrderList.size();i++) { %>
		<% if(i>0) { %> , <% } %>
		{"date":"<%=myOrderList.get(i).getOrderDate() %>"
		, "number":"<%=myOrderList.get(i).getOrderNum() %>"
		, "product":"<%=Utility.toJSON(myOrderList.get(i).getProductName()) %>"
		, "price":"<%=format.format(myOrderList.get(i).getOrderSum()) %>"
		, "url":"<%=request.getContextPath()%><%=uri%><%=myOrderList.get(i).getProductNum() %>"
		, "status":"<%=myOrderList.get(i).getOrderStatus() %>"}
	<% } %>	
	]
}
<% } %>