<%@page import="xyz.itwill.util.Utility"%>
<%@page import="xyz.itwill.DTO.OrderDTO"%>
<%@page import="java.util.List"%>
<%@page import="xzy.itwill.DAO.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

String startDate = request.getParameter("stDate");
String edDate = request.getParameter("endDate");
String clNum = request.getParameter("clientNum");
int clientNum = Integer.parseInt(clNum);

List<OrderDTO> myOrderList = OrderDAO.getDAO().myOrderList(startDate, edDate, clientNum);


%>
