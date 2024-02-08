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

	ClientDTO loginClient = (ClientDTO)session.getAttribute("loginClient"); //ȸ����ȣ�� session���� ���޹���
	String[] cartNum = request.getParameterValues("countChangeBtn"); // sumit ��ư�� name���� ���޹��� �� - ��ǰ��ȣ
	// ��ǰ��ȣ�� ������� ���޹����� �������� ���޹��� �� ����
	String productCount = request.getParameter("productCount_"+cartNum[0]); 
	
	int num = Integer.parseInt(cartNum[0]);
	
	CartDTO cart = new CartDTO();
	cart.setCartClientNum(loginClient.getClientNum());
	cart.setCartNum(num);
	cart.setCartCount(Integer.parseInt(productCount));
	
	CartDAO.getDAO().updateCartPageContent(cart);
	request.setAttribute("returnURL", request.getContextPath() + "/main_page/main.jsp?group=cart_page&worker=cart");
%>