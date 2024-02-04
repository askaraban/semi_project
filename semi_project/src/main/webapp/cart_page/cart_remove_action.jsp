<%@page import="java.io.Console"%>
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
	// 장바구니에 있는 총 개수를 전달받음
	int plzCheck = Integer.parseInt(request.getParameter("plzCheck"));
	// 장바구니에 있는거 중에서 null이 아닌것이 check 된 것이므로 check된것만 삭제하는 for문
	for(int i=0;i<plzCheck;i++){
		CartDTO cart = new CartDTO();
		if(request.getParameter("contentCheck"+i+"")==null){
			continue;
		}
		int contentCheck =  Integer.parseInt(request.getParameter("contentCheck"+i+"")); 
		cart.setCartNum(contentCheck);
		cartArray.add(cart);
		
	}
		
	for(CartDTO cartList : cartArray){
		CartDAO.getDAO().deleteCart(cartList);
	}

	request.setAttribute("returnURL", request.getContextPath() + "/main_page/main.jsp?group=cart_page&worker=cart");
		
%>
