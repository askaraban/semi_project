<%@page import="xzy.itwill.DAO.ProductDAO"%>
<%@page import="xyz.itwill.DTO.ProductDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	
	if (request.getMethod().equals("GET")) {
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
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
	int productDis=Integer.parseInt(mr.getParameter("productDis"));
	
	String productDisContent=null;
	// MultipartRequest.getFilesystemName(String name) : ���������� ���ε� ���ϸ��� ��ȯ�ϴ� �޼ҵ�
	String productMainImg=null;
	String productImg1=null;
	String productImg2=null;
	String productImg3=null;
	
	if(mr.getFilesystemName("productDisContent")!=null) {
		productDisContent=mr.getParameter("productDisContent");
	}
	
	if(mr.getFilesystemName("productMainImg")!=null){
		productMainImg = mr.getOriginalFileName("productMainImg");
	}
	if(mr.getFilesystemName("productImg1")!=null){
		productImg1 = mr.getOriginalFileName("productImg1");
	}
	if(mr.getFilesystemName("productImg2")!=null){
		productImg2 = mr.getOriginalFileName("productImg2");
	}
	if(mr.getFilesystemName("productImg3")!=null){
		productImg3 = mr.getOriginalFileName("productImg3");
	}
	
	
	// �Էµ� �� DTO ��ü �ʵ忡 �����ϱ�
	ProductDTO product = new ProductDTO();
	
	product.setProductName(productName);
	product.setProductPrice(productPrice);
	product.setProductCom(productCom);
	product.setProductCate(productCate);
	// ���� ��� DTO�ʵ忡 ����
	product.setProductMainImg(productMainImg);
	product.setProductImg1(productImg1);
	product.setProductImg2(productImg2);
	product.setProductImg3(productImg3);
	product.setProductDis(productDis);
	product.setProductDisContent(productDisContent);
	
	
	int rows = ProductDAO.getDAO().updateProduct(product);
	
	request.setAttribute("returnURL", request.getContextPath()+"/manager_page/manager.jsp?worker=manager_product");
%>
