<%@page import="xzy.itwill.DAO.ProductDAO"%>
<%@page import="xyz.itwill.DTO.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	//제품번호가 전달되지 않은 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getParameter("productNum")==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
	//전달값을 반환받아 저장
	int productNum=Integer.parseInt(request.getParameter("productNum"));    	// 제품번호
	
	//제품번호를 전달받아 Product 테이블의 단일행을 검색하여 상품(ProductDTO 객체)을반환하는
	//ProductDAO 클래스의 메소드 호출
	ProductDTO product=ProductDAO.getDAO().selectProductByNum(productNum);
	
	//상품이 없는 경우에 대한 응답 처리 - 비정상적인 요청
	if(product==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
%>
<body>	
	<div class="listArea">
		<ul class="menu">
			<li class="selected">
				<a href="#productDetailImg">상세정보</a>
			</li>
			<li>
				<a href="#review_list">리뷰 3</a>
			</li>
			<li>
				<a href="#qa_list">Q&A</a>
			</li>
		</ul>
	</div>
	
	<div>
		<img src="<%=request.getContextPath() %>/product_detail_img/<%=product.getProductImg1() %>" style="width: 100%; height: 100%; 
			object-fit:cover;" id="productDetailImg" class="card-img-top" >
	</div>
</body>
</html>