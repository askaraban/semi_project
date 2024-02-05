<?xml version="1.0" encoding="utf-8"?>
<%@page import="xyz.itwill.DTO.WishDTO"%>
<%@page import="xzy.itwill.DAO.WishDAO"%>
<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ClientDTO loginClient = (ClientDTO)session.getAttribute("loginClient");

	int productNum = Integer.parseInt(request.getParameter("productNum")); 
	
	WishDTO wish = new WishDTO();
	
	wish.setWishClientNum(loginClient.getClientNum());
	wish.setWishProductNum(productNum);
	
	WishDAO.getDAO().insertWish(wish);
%>
