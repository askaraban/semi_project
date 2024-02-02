<%@page import="xyz.itwill.DTO.ClientDTO"%>
<%@page import="xyz.itwill.DTO.CartDTO"%>
<%@page import="xzy.itwill.DAO.ClientDAO"%>
<%@page import="xzy.itwill.DAO.CartDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%   
	// get 방식으로 요청했을 시 비정상적인 요청이므로 에러페이지
	if(request.getMethod().equals("GET")){
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=error&worker=error_400");
		return;
	}
 	request.setCharacterEncoding("utf-8");
	
	String saveDirectory = request.getServletContext().getRealPath("/productImg");
	MultipartRequest mr = new MultipartRequest(request, saveDirectory, 20*1024*1024, "utf-8", new DefaultFileRenamePolicy());

	//전달값을 반환받아 저장
	String id=request.getParameter("id");
	
	//회원정보를 전달받아 CLIENT 테이블에 저장된 단일행을 검색하여 ClientDTO 객체로 반환하는
	//MemberDAO 클래스의 메소드 호출
	ClientDTO client=ClientDAO.getDAO().selectClientById(id);
	
	// 전달된 값 가져오기
	//int getClientNum=Integer.parseInt(mr.getParameter("getClientNum"));
	session.setAttribute("loginClient", ClientDAO.getDAO().selectClientByNum(client.getClientNum()));	// 회원번호	// 세션으로 가져오기_액션에서
	int productNum=Integer.parseInt(mr.getParameter("productNum"));
	int count=Integer.parseInt(mr.getParameter("count"));
	
	//ClientDTO 객체를 생성하여 전달값으로 필드값 변경
	CartDTO cartTable=new CartDTO();
	cartTable.setCartProductNum(productNum);
	cartTable.setCartCount(count);
	
	int rows = CartDAO.getDAO().insertCart(cartTable);
	
	//페이지 이동
	request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=cart_page&worker=cart");
	
	
	
	
	
	
/* 	//전달값을 반환받아 저장
	String id=request.getParameter("id");

	//아이디를 전달받아 MEMBER 테이블에 저장된 단일행을 검색하여 MemberDTO 객체로 반환하는
	//MemberDAO 클래스의 메소드 호출
	ClientDTO client=ClientDAO.getDAO().selectClientById(id); */
	
/*    //전달값을 반환받아 저장
   session.setAttribute("loginClient", ClientDAO.getDAO().selectClientByNum(client.getClientNum()));	// 회원번호	// 세션으로 가져오기_액션에서
   int productNum=Integer.parseInt(request.getParameter("productNum"));		// 제품번호
   int count=Integer.parseInt(request.getParameter("count"));				// 수량 */
   
/* 	//ClientDTO 객체를 생성하여 전달값으로 필드값 변경
	CartDTO cartTable=new CartDTO();
	cartTable.setCartProductNum(productNum);
	cartTable.setCartCount(count); */
	
/*    //정보를 전달받아 CART 테이블의 행으로 삽입하고 삽입행의 갯수를 반환하는 insertCart() 메소드 호출
   CartDAO.getDAO().insertCart(cartTable);
   
   //페이지 이동
   request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=product_page&worker=cart"); */

%>