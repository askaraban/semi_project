<%@page import="xzy.itwill.DAO.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if (request.getMethod().equals("GET")) {
	request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
	return;
}

request.setCharacterEncoding("utf-8");

int orderNum = Integer.parseInt(request.getParameter("orderNum"));
int orderClientNum = Integer.parseInt(request.getParameter("orderClientNum"));
String timeStamp = request.getParameter("timeStamp");

int rows = OrderDAO.getDAO().updateOrderStatus(orderClientNum, timeStamp);
System.out.println(rows);
request.setAttribute("returnURL", request.getContextPath()+"/manager_page/manager.jsp?group=manager_page&worker=manager_order");
System.out.println("실행됨02");

%>