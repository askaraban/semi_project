<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.DTO.WishDTO"%>
<%@page import="xzy.itwill.DAO.WishDAO"%>
<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ClientDTO loginClient = (ClientDTO)session.getAttribute("loginClient");
	

	
	String productNum = request.getParameter("productNum"); 
	System.out.println(productNum);
	
	int num =Integer.parseInt(productNum.substring(10)); 
	System.out.println(num);
	
	WishDTO wish = new WishDTO();
	
	wish.setWishClientNum(loginClient.getClientNum());
	wish.setWishProductNum(num);
	
	int id=WishDAO.getDAO().insertWish(wish);
	
	List<WishDTO> wishList = WishDAO.getDAO().selectWishList(loginClient.getClientNum());
	
%>
<result>
	<code>success</code>
	<id><%=wishList%></id>
</result>