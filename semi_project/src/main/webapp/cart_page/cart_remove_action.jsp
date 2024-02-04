<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.DTO.CartDTO"%>
<%@page import="xzy.itwill.DAO.CartDAO"%>
<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    

<%	
	// get 방식으로 요청했을 시 비정상적인 요청이므로 에러페이지
	if(request.getMethod().equals("GET")){
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
		return;
	}
		
		CartDTO cart = new CartDTO();
		int cnt =  Integer.parseInt(request.getParameter("cnt"));
		
		
		for(int i=0;i<cnt;i++){
			String contentCheck =  (String)(request.getParameter("contentCheck")); 
			int deleteCheck =  Integer.parseInt(request.getParameter("contentCheck"));
			if(contentCheck!=null){
				CartDAO.getDAO().deleteCart(deleteCheck);
			System.out.println(deleteCheck);
			}
			
		}
		
		
		
		
	/*
	for(CartDTO cartList : cartArray){
		CartDAO.getDAO().deleteCart(cartList.getCartNum());
	}
	*/
	request.setAttribute("returnURL", request.getContextPath() + "/main_page/main.jsp?group=cart_page&worker=cart");
		
%>
