<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="xzy.itwill.DAO.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf"%>
<%
String saveDirectory = request.getServletContext().getRealPath("/productImg");
MultipartRequest mr = new MultipartRequest(request, saveDirectory, 20 * 1024 * 1024, "utf-8",
		new DefaultFileRenamePolicy());

String productNum = mr.getParameter("productNum");
int num = Integer.parseInt(productNum);

int rows = ProductDAO.getDAO().deleteProduct(num);

request.setAttribute("returnURL", request.getContextPath()+"/manager_page/manager.jsp?worker=manager_product");

%>