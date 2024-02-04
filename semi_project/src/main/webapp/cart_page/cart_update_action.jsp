<%@page import="java.io.Console"%>
<%@page import="xzy.itwill.DAO.CartDAO"%>
<%@page import="xyz.itwill.DTO.CartDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	if (request.getMethod().equals("GET")) {
		request.setAttribute("returnURL", request.getContextPath() + "/main_page/main.jsp?group=error&worker=error_400");
		return;
	}
	
	ClientDTO loginClient = (ClientDTO)session.getAttribute("loginClient");
	
	List<CartDTO> cartArray = new ArrayList<>();
	int cnt=0;
	
	while(true){
		CartDTO cart = new CartDTO();
			System.out.println(cnt);
		if(request.getParameter("cartNum"+cnt+"")==null){
			break;
		}
		int cartCount =  Integer.parseInt(request.getParameter("cartCount"+cnt+"")); 
		int cartNum =  Integer.parseInt(request.getParameter("cartNum"+cnt+"")); 
		System.out.println(cartCount);
		cart.setCartCount(cartCount);
		cart.setCartNum(cartNum);
		cart.setCartClientNum(loginClient.getClientNum());
		cartArray.add(cart);
		cnt++;
	}
	for(CartDTO cartList : cartArray){
		CartDAO.getDAO().updateCartPageContent(cartList);
	}
	
	request.setAttribute("returnURL", request.getContextPath() + "/main_page/main.jsp?group=cart_page&worker=cart");
%>