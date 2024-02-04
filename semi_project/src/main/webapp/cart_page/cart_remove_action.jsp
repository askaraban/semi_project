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
		
	List<CartDTO> cartArray = new ArrayList<>();
	int cnt=0;
	
	while(true){
		CartDTO cart = new CartDTO();
		if(request.getParameter("contentCheck"+cnt+"")==null){
			break;
		}
		int contentCheck =  Integer.parseInt(request.getParameter("contentCheck"+cnt+"")); 
		cart.setCartNum(contentCheck);
		cartArray.add(cart);
		cnt++;
	}
	for(CartDTO cartList : cartArray){
		CartDAO.getDAO().deleteCart(cartList);
	}
		
		
		
		
	/*
	for(CartDTO cartList : cartArray){
		CartDAO.getDAO().deleteCart(cartList.getCartNum());
	}
	*/
	request.setAttribute("returnURL", request.getContextPath() + "/main_page/main.jsp?group=cart_page&worker=cart");
		
%>
