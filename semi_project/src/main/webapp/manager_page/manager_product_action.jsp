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
	
	// �Էµ� �� ��������
	String productName=mr.getParameter("productName");
	int productPrice=Integer.parseInt(mr.getParameter("productPrice"));
	String productCom=mr.getParameter("productCom");
	int productCate=Integer.parseInt(mr.getParameter("productCate"));
	// MultipartRequest.getFilesystemName(String name) : ���������� ���ε� ���ϸ��� ��ȯ�ϴ� �޼ҵ�
	String productImgPath = mr.getFilesystemName("productImgPath");
	String productImg1 = mr.getFilesystemName("productImg1");
	String productImg2 = mr.getFilesystemName("productImg2");
	String productImg3 = mr.getFilesystemName("productImg3");
	
	// �Էµ� �� DTO ��ü �ʵ忡 �����ϱ�
	ProductDTO product = new ProductDTO();
	
	product.setProductName(productName);
	product.setProductPrice(productPrice);
	product.setProductCom(productCom);
	product.setProductCate(productCate);
	// ���� ��� DTO�ʵ忡 ����
	product.setProductImgPath(productImgPath);
	product.setProductImg1(productImg1);
	product.setProductImg2(productImg2);
	product.setProductImg3(productImg3);
	
	
	
	int rows = ProductDAO.getDAO().insertProduct(product);
	
	request.setAttribute("returnURL", request.getContextPath()+"/manager_page/manager.jsp?worker=manager_product");
%>
