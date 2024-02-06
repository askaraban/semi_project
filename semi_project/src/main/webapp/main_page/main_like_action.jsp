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
	String title = request.getParameter("title"); 
	WishDTO wish = new WishDTO();
	//System.out.println(productNum);
	//System.out.println(title);
	//System.out.println(wish);
	int num =Integer.parseInt(productNum.substring(10));
	
	if(loginClient.getClientNum()>0){
		
		wish.setWishClientNum(loginClient.getClientNum());
		wish.setWishProductNum(num);
		
		if(title.equals("on")){
			WishDAO.getDAO().deleteWish(wish.getWishClientNum(), wish.getWishProductNum());
		} else if(title.equals("off")){
			WishDAO.getDAO().insertWish(wish);
		}		
	} else{
		return;
	}
	
%>

<result>
	<%if(title.equals("off")){%>
	<code>success</code>
	<title>on</title>
	<%} else {%>
	<code>fail</code>
	<title>off</title>
	<%}%>
</result>
