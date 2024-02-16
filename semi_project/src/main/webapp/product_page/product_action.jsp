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

	ClientDTO loginClient=(ClientDTO)session.getAttribute("loginClient");
	int productNum=Integer.parseInt(request.getParameter("productNum"));
	int count=Integer.parseInt(request.getParameter("totCount"));
   
	if(loginClient == null) {//비회원일 경우
		//페이지 이동
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=login_page&worker=client_login");
		// client_login 에서 이전페이지로 URL 조회 내장함수 사용하여 이동하게 설정해야함
		/* request 내장 객체의 getHeader()를 이용해서 이전 페이지의 URL 을 알 수 있다.
		request.getHeader("referer"); */
	} else {// 회원일 경우
		int clientNum = loginClient.getClientNum();
		int productCount = CartDAO.getDAO().selectProductCount(clientNum,productNum);
		if(productCount>=1) {//장바구니에 같은 productNum이 이미 있을 경우
%>
<!-- 		<script type="text/javascript">
		alert("장바구니에 이미 같은 제품이 있습니다.");
		</script> -->
<%			
			CartDAO.getDAO().updateCart(clientNum,productNum,count);
		} else {//장바구니에 같은 productNum이 없을 경우
			CartDAO.getDAO().insertCart(clientNum,productNum,count);
		}
	//페이지 이동
		request.setAttribute("returnURL", request.getContextPath()+"/main_page/main.jsp?group=cart_page&worker=cart");
	}
   
%>