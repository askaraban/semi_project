<%@page import="xzy.itwill.DAO.CategoryDAO"%>
<%@page import="xyz.itwill.DTO.CategoryDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	if (request.getMethod().equals("GET")) {
		response.sendRedirect("fileupload.html"); // 에러메시지 출력하는걸로 고쳐라 경로
		return;
	}
	request.setCharacterEncoding("utf-8");
	
	String CategoryName =request.getParameter("CategoryName");
	
	CategoryDTO category = new CategoryDTO();
	
	category.setCategoryName(CategoryName);
	
	int rosw=CategoryDAO.getDAO().insertCategory(category);
	
	request.setAttribute("returnURL", request.getContextPath()+"/manager_page/manager.jsp?worker=manager_category");
%>