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

String[] cartNum = request.getParameterValues("cartNum");
for(int i=0;i<cartNum.length;i++){
	CartDAO.getDAO().deleteCart(Integer.parseInt(cartNum[i]));
}
	

request.setAttribute("returnURL", request.getContextPath() + "/main_page/main.jsp?group=cart_page&worker=cart");
		
%>
