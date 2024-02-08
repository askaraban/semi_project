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

	ClientDTO loginClient = (ClientDTO)session.getAttribute("loginClient"); //회원번호를 session으로 전달받음
	String[] cartNum = request.getParameterValues("countChangeBtn"); // sumit 버튼의 name으로 전달받은 값 - 제품번호
	// 제품번호를 연결시켜 전달받으면 수량값을 전달받을 수 있음
	String productCount = request.getParameter("productCount_"+cartNum[0]); 
	
	int num = Integer.parseInt(cartNum[0]);
	
	CartDTO cart = new CartDTO();
	cart.setCartClientNum(loginClient.getClientNum());
	cart.setCartNum(num);
	cart.setCartCount(Integer.parseInt(productCount));
	
	CartDAO.getDAO().updateCartPageContent(cart);
	request.setAttribute("returnURL", request.getContextPath() + "/main_page/main.jsp?group=cart_page&worker=cart");
%>