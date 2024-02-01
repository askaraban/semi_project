<%@page import="xyz.itwill.DTO.ProductDTO"%>
<%@page import="xzy.itwill.DAO.ProductDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//제품번호가 전달되지 않은 경우에 대한 응답 처리 - 비정상적인 요청
	if(request.getParameter("productNum")==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
	//전달값을 반환받아 저장
	int productNum=Integer.parseInt(request.getParameter("productNum"));    	// 제품번호
	String productName=request.getParameter("productName");                 	// 제품명
	int productPrice=Integer.parseInt(request.getParameter("productPrice"));	// 제품가격
	String productCom=request.getParameter("productCom");                   	// 제조사
	//int productCate=Integer.parseInt(request.getParameter("productCate"));  	// 유형
	String productReg=request.getParameter("productReg");                   	// 등록일
	//int productDis=Integer.parseInt(request.getParameter("productDis"));    	// 할인율
	String productDisContent=request.getParameter("productDisContent");     	// 할인내용
	String productMainImg=request.getParameter("productMainImg");           	// 제품이미지
	String productImg1=request.getParameter("productImg1");                 	// 상세사진1
	String productImg2=request.getParameter("productImg2");                 	// 상세사진2
	String productImg3=request.getParameter("productImg3");                 	// 상세사진3
	
	//제품번호를 전달받아 Product 테이블의 단일행을 검색하여 상품(ProductDTO 객체)을반환하는
	//ProductDAO 클래스의 메소드 호출
	ProductDTO product=ProductDAO.getDAO().selectProductByNum(productNum);
	
	//상품이 없는 경우에 대한 응답 처리 - 비정상적인 요청
	if(product==null) {
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
		return;
	}
%>

<%
	List<ProductDTO> productList = new ArrayList<>();
	productList = ProductDAO.getDAO().selectProductList();
%>	
    
<link href="<%=request.getContextPath()%>/style/product_style.css" type="text/css" rel="stylesheet">
<body>
	<!-- 상품명 ~ 주문하기/위시리스트/장바구니 버튼까지 -->
	<div id="imgArea" class="row"">
			<img src="<%=request.getContextPath() %>/productImg/<%=product.getProductMainImg() %>" class="card-img-top" >
	</div>
	<div id="infoArea" class="row">
		<div class="row">
			<div class="col-sm-3" style="font-size:20px;">상품명</div>
			<div class="col-sm-9" style="text-align:left; padding-left:100px; font-size:20px;"><b><%=product.getProductName()%></b></div>
			
			<div class="col-sm-3">제조사</div>
			<div class="col-sm-9" style="text-align:left; padding-left:100px;"><%=product.getProductCom()%></div>
			
			<div class="col-sm-3">원산지</div>	
			<div class="col-sm-9" style="text-align:left; padding-left:100px;">상세설명참조</div>
					
			<div class="col-sm-3">판매가</div>
			<div class="col-sm-9" style="text-align:left; padding-left:100px;"><%=product.getProductPrice()%></div>
			
			<div class="col-sm-3">배송비</div>
			<div class="col-sm-9" style="text-align:left; padding-left:100px;">무료배송</div>
			
			<div class="row">
		    	<div class="col-sm-3">수량</div>
				<div class="col" style="text-align:right;">
					<input id="countBtn" type="button" onclick="count('minus')" value="-"/>
						<span id="result">1</span>
					<input id="countBtn" type="button" onclick="count('plus')" value="+"/>
				</div>
			</div>
			
			<div class="row">
				<table>
					<tr>
						<td style="text-align:right; height:50px; font-weight: bold;" width=80%;>총 상품금액 : </td>
						<td id="totalResult" style="text-align:right; padding-right:10px; font-weight: bold;"><%=product.getProductPrice()%></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	
	<div id="infoBtnArea" class="row productInfo">
		<div class="d-grid gap-2">
			<button class="nowOrderBtn" type="button">바로 구매하기</button>
		</div>
		<div class="d-grid gap-2 d-md-block">
			<button class="orderBtn" type="button">장바구니 담기</button>
			<button class="JjimBtn" type="button">관심상품 등록</button>
		</div>
	</div>
</body>
</html>

<script type="text/javascript">
function count(type)  {
	// 결과를 표시할 element
	const resultElement = document.getElementById('result');
	const totalResultElement = document.getElementById('totalResult');
	 
	// 현재 화면에 표시된 값
	let number = resultElement.innerText;
	let totalNumber = totalResultElement.innerText;

	if(type === 'plus') {	// 더하기
		number = parseInt(number) + 1;
		totalNumber = number * 1700;
		totalNumber = totalNumber.toLocaleString() + " 원";
	} else if(type === 'minus' && number > 1)  {	// 빼기
		number = parseInt(number) - 1;
		totalNumber = parseInt(totalNumber.replace(",","")) - 1700;
		totalNumber = totalNumber.toLocaleString() + " 원";
	}
	
	// 결과 출력
	resultElement.innerText = number;
	totalResultElement.innerText = totalNumber;
}
</script>