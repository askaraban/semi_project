<%@page import="xzy.itwill.DAO.ProductDAO"%>
<%@page import="xyz.itwill.DTO.ProductDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	
	if (request.getMethod().equals("GET")) {
		response.sendRedirect("fileupload.html");
		return;
	}
	request.setCharacterEncoding("utf-8");

	String saveDirectory = request.getServletContext().getRealPath("/productImg");
	MultipartRequest mr = new MultipartRequest(request, saveDirectory, 20*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	// 입력된 값 가져오기
	String productName=mr.getParameter("productName");
	int productPrice=Integer.parseInt(mr.getParameter("productPrice"));
	String productCom=mr.getParameter("productCom");
	int productCate=Integer.parseInt(mr.getParameter("productCate"));
	// MultipartRequest.getFilesystemName(String name) : 전달파일의 업로드 파일명을 반환하는 메소드
	String productImgPath = mr.getFilesystemName("productImgPath");
	String productImg1 = mr.getFilesystemName("productImg1");
	String productImg2 = mr.getFilesystemName("productImg2");
	String productImg3 = mr.getFilesystemName("productImg3");
	
	// 입력된 값 DTO 객체 필드에 저장하기
	ProductDTO product = new ProductDTO();
	
	product.setProductName(productName);
	product.setProductPrice(productPrice);
	product.setProductCom(productCom);
	product.setProductCate(productCate);
	// 사진 경로 DTO필드에 저장
	product.setProductImgPath(productImgPath);
	product.setProductImg1(productImg1);
	product.setProductImg2(productImg2);
	product.setProductImg3(productImg3);
	
	
	
	int rows = ProductDAO.getDAO().insertProduct(product);
	
	request.setAttribute("returnURL", request.getContextPath()+"/manager_page/manager.jsp?worker=manager_product");
%>
