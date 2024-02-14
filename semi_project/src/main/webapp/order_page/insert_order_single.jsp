<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@page import="xzy.itwill.DAO.OrderDAO"%>
<%@page import="xyz.itwill.DTO.OrderDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 주문정보를 전달받아 ORDER 테이블의 행으로 삽입하고 [payment.jsp] 문서를 요청할
수 있는 URL 주소를 클라이언트에게 전달하여 응답하는 JSP 문서 --%>    

<%-- 회원번호, 제품번호, 총금액, 할인된 총 금액, 수량  hidden name value --%> 
<%-- 폼 : 받는사람,주소1,2,3,휴대폰번호,배송요청사항 --%>

<%
   
	// get 방식으로 요청했을 시 비정상적인 요청이므로 에러페이지
	if(request.getMethod().equals("GET")){
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
		return;
	}		
		
		//POST 방식으로 요청하여 전달된 값에 대한 문자형태(CharacterSet - Encoding) 변경
		request.setCharacterEncoding("utf-8");
		
		//전달값을 반환받아 변수에 저장 ..제품번호,수량,회원번호,
		int orderClientNum=Integer.parseInt(request.getParameter("clientNum")); //
		int orderProductNum=Integer.parseInt(request.getParameter("productNum")); //
		int orderSum=Integer.parseInt(request.getParameter("orderSum")); //
		int orderDisSum=Integer.parseInt(request.getParameter("orderDIsSum"));
		String orderContent=request.getParameter("order_content");
		String orderReceiver=request.getParameter("order_receiver");
		String orderZipcode=request.getParameter("zipcode");
		String orderAddress1=request.getParameter("address1");
		String orderAddress2=request.getParameter("address2");
		String orderMobile=request.getParameter("mobile1")+"-"+request.getParameter("mobile2")
		+"-"+request.getParameter("mobile3");
		int orderCount=Integer.parseInt(request.getParameter("orderCount")); //
		
		//OrderDTO 객체를 생성하여 전달값으로 필드값 변경
		OrderDTO order=new OrderDTO();
		order.setOrderClientNum(orderClientNum);
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