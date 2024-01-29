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
	String uploadone = mr.getFilesystemName("fileone");
	String uploadtwo = mr.getFilesystemName("filetwo");
	
	ProductDTO product = new ProductDTO();
	product.setProductImgPath(uploadone);
	
	int rows = ProductDAO.getDAO().uploadFile(product);
	
%>
<!DOCTYPE html>
<!-- ����ڷκ��� ���� ������ �Է¹޾� ó��������(upload.itwill)�� POST ������� ��û�Ͽ�
�Է°��� �Է������� �����ϴ� HTML ���� -->
<html>
<head>
<meta charset="UTF-8">
<title>Servlet</title>
</head>
<body>
	<h1>���� ���ε�</h1>
	<hr>
	<p>���δ� = <%=uploadone %></p>
	<p><%=rows %>�� ���� ���ε�</p>
	</body>
</html>