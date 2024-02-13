<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@page import="xzy.itwill.DAO.OrderDAO"%>
<%@page import="xyz.itwill.DTO.OrderDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 주문정보를 전달받아 ORDER 테이블의 행으로 삽입하고 [payment.jsp] 문서를 요청할
수 있는 URL 주소를 클라이언트에게 전달하여 응답하는 JSP 문서 --%>    

<%
	//JSP 문서를 GET 방식으로 요청한 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getMethod().equals("GET")) {		
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		return;
	}

	//System.out.println("loginClient = " + loginClient);
	
	int productNum=Integer.parseInt(request.getParameter("productNum"));
	System.out.println("제품번호 = "+productNum);
	
	//POST 방식으로 요청하여 전달된 값에 대한 문자형태(CharacterSet - Encoding) 변경
	request.setCharacterEncoding("utf-8");
	
	
	//전달값을 반환받아 변수에 저장
	int orderClientNum=Integer.parseInt(request.getParameter("order_client_num")); //
	String orderTime=request.getParameter("order_time"); //
	int orderProductNum=Integer.parseInt(request.getParameter("order_product_num")); //
	int orderSum=Integer.parseInt(request.getParameter("order_sum")); //
	int orderDisSum=Integer.parseInt(request.getParameter("order_dis_sum"));
	String orderContent=request.getParameter("order_content");
	String orderReceiver=request.getParameter("order_receiver");
	String orderZipcode=request.getParameter("order_zipcode");
	String orderAddress1=request.getParameter("order_address1");
	String orderAddress2=request.getParameter("order_address2");
	String orderMobile=request.getParameter("order_mobile");
	int orderCount=Integer.parseInt(request.getParameter("order_count")); //
	
	//OrderDTO 객체를 생성하여 전달값으로 필드값 변경
	OrderDTO order=new OrderDTO();
	order.setOrderClientNum(orderClientNum);
	order.setOrderTime(orderTime);
	order.setOrderProductNum(orderProductNum);
	order.setOrderSum(orderSum);
	order.setOrderDisSum(orderDisSum);
	order.setOrderContent(orderContent);
	order.setOrderReceiver(orderReceiver);
	order.setOrderZipcode(orderZipcode);
	order.setOrderAddress1(orderAddress1);
	order.setOrderAddress2(orderAddress2);
	order.setOrderMobile(orderMobile);
	order.setOrderCount(orderCount);
	
	
	//주문정보를 전달받아 Order 테이블의 행으로 삽입하고 삽입행의 갯수를 반환하는 OrderDAO 클래스의 메소드 호출
	int rows=OrderDAO.getDAO().insertOrder(order);
	
	//클라이언트에게 URL 주소를 전달하여 응답
	response.sendRedirect(request.getContextPath()+"/order_page/payment.jsp");
	
	
%>

    
