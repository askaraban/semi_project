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

	String saveDirectory = request.getServletContext().getRealPath("/upload");
	MultipartRequest mr = new MultipartRequest(request, saveDirectory, 20*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	String uploader = mr.getParameter("uploader");
	
	// MultipartRequest.getOriginalFileName(String name) : ���������� ���� ���ϸ��� ��ȯ�ϴ� �޼ҵ�
	String fileone = mr.getOriginalFileName("fileone");
	String filetwo = mr.getOriginalFileName("filetwo");
	
	// MultipartRequest.getFilesystemName(String name) : ���������� ���ε� ���ϸ��� ��ȯ�ϴ� �޼ҵ�
	String upload_product_img = mr.getFilesystemName("product_img");
	String upload1 = mr.getFilesystemName("file1");
	String upload2 = mr.getFilesystemName("file2");
	String upload3 = mr.getFilesystemName("file3");
	
	ProductDTO product = new ProductDTO();
	product.setProductImgPath(upload_product_img);
	product.setProductImg1(upload1);
	product.setProductImg2(upload2);
	product.setProductImg3(upload3);
	
	int rows = ProductDAO.getDAO().insertProduct(product);
	
