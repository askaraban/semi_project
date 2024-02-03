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
	ClientDTO loginClient = (ClientDTO)session.getAttribute("loginClient");

	int cartCount = Integer.parseInt(request.getParameter("cartCount"));
	int cartProductNum = Integer.parseInt(request.getParameter("cartProductNum"));
	CartDTO cart = new CartDTO();
	
	cart.setCartCount(cartCount);
	cart.setProductNum(cartProductNum);
	
	
	CartDAO.getDAO().updateCart(cart);
	
%>
