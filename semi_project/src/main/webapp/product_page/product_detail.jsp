<%@page import="xzy.itwill.DAO.ReviewDAO"%>
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
	// 제품번호 가져옴
	int reviewProductNum = Integer.parseInt(request.getParameter("productNum"));

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
	
	//게시글 검색 기능에 필요한 전달값(검색대상과 검색단어)을 반환받아 저장
		String search=request.getParameter("search");//검색대상
		if(search==null) {//전달값이 없는 경우 - 게시글 검색 기능을 사용하지 않은 경우
			search="";
		}
		
		String keyword=request.getParameter("keyword");//검색단어
		if(keyword==null) {//전달값이 없는 경우
			keyword="";
		}

		//페이징 처리에 필요한 전달값(페이지번호과 게시글갯수)을 반환받아 저장
		int pageNum=1;//페이지번호- 전달값이 없는 경우 저장된 초기값 설정
		if(request.getParameter("pageNum")!=null) {//전달값이 있는 경우
			pageNum=Integer.parseInt(request.getParameter("pageNum"));
		}
		
		int pageSize=10;//게시글갯수- 전달값이 없는 경우 저장된 초기값 설정
		if(request.getParameter("pageSize")!=null) {//전달값이 있는 경우
			pageSize=Integer.parseInt(request.getParameter("pageSize"));
		}

		//검색정보(검색대상과 검색단어)를 전달받아 REVIEW 테이블에 저장된 게시글 중 검색대상의 컬럼에
		//검색단어가 포함된 게시글의 갯수를 검색하여 반환하는 ReviewDAO 클래스의 메서드 호출
		// => 검색 기능을 사용하지 않을 경우 REVIEW 테이블에 저장된 모든 게시글의 갯수를 반환
		int totalReview=ReviewDAO.getDAO().selectTotalReview(search, keyword);//검색된 게시글의 총갯수
		
		// REVIEW_TABLE에 저장된 제품별 리뷰의 count(갯수)를 반환하는 메소드 호출
		int productReview=ReviewDAO.getDAO().selectReviewCountByProductNum(reviewProductNum);
%>
<body>	
	<%@include file="/product_page/product_listArea.jspf" %>
	<div>
		<img src="<%=request.getContextPath() %>/product_detail_img/<%=product.getProductImg1() %>" style="width: 100%; height: 100%; 
			object-fit:cover;" id="productDetailImg" class="card-img-top" >
	</div>
</body>
</html>