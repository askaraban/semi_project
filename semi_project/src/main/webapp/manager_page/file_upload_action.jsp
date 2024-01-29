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
	
	// MultipartRequest.getOriginalFileName(String name) : 전달파일의 원본 파일명을 반환하는 메소드
	String fileone = mr.getOriginalFileName("fileone");
	String filetwo = mr.getOriginalFileName("filetwo");
	
	// MultipartRequest.getFilesystemName(String name) : 전달파일의 업로드 파일명을 반환하는 메소드
	String uploadone = mr.getFilesystemName("fileone");
	String uploadtwo = mr.getFilesystemName("filetwo");
	
	ProductDTO product = new ProductDTO();
	product.setProductImgPath(uploadone);
	
	int rows = ProductDAO.getDAO().uploadFile(product);
	
%>
<!DOCTYPE html>
<!-- 사용자로부터 값과 파일을 입력받아 처리페이지(upload.itwill)를 POST 방식으로 요청하여
입력값과 입력파일을 전달하는 HTML 문서 -->
<html>
<head>
<meta charset="UTF-8">
<title>Servlet</title>
</head>
<body>
	<h1>파일 업로드</h1>
	<hr>
	<p>업로더 = <%=uploadone %></p>
	<p><%=rows %>개 파일 업로드</p>
	</body>
</html>