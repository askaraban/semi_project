<%@page import="xzy.itwill.DAO.ProductDAO"%>
<%@page import="xzy.itwill.DAO.OrderDAO"%>
<%@page import="xyz.itwill.DTO.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>  
<%
	request.setCharacterEncoding("utf-8");
	
	int proNum = Integer.parseInt(request.getParameter("productNum"));
	
	if(proNum==0) {
		request.setAttribute("returnURL", request.getContextPath()+"/manager_page/manager.jsp?group=error&worker=error_400");
		return;
	}
	
	ProductDTO updateProduct = (ProductDTO)session.getAttribute("updateProduct");
	updateProduct =  ProductDAO.getDAO().selectProductByNum(proNum);
	
	int productNum=updateProduct.getProductNum(); 					// 제품번호
	String productName=updateProduct.getProductName();				// 제품명
	int productPrice=updateProduct.getProductPrice();				// 제품가격
	String productCom=updateProduct.getProductCom();				// 제조사
	int productCate=updateProduct.getProductCate();					// 유형
	int productDis=updateProduct.getProductDis();					// 할인율
	String productDisContent=updateProduct.getProductDisContent();	// 할인내용
	String productMainImg=updateProduct.getProductMainImg();		// 제품이미지
	String productImg1=updateProduct.getProductImg1();				// 상세사진1
	String productImg2=updateProduct.getProductImg2();				// 상세사진2
	String productImg3=updateProduct.getProductImg3();				// 상세사진3
	
%>
<style>
.manager_body {
	display: block;
}

.product_Btn {
	display: inline-block;
}

div ul li {
	list-style-type: none;
	margin: 15px 0;
	text-align: left;
}

.insert_div_content label {
	width: 150px;
	text-align: right;
	float: left;
	margin-right: 10px;
}

.insert_div_content {
}

table {
	margin: 5px auto;
	border: 1px solid black;
	border-collapse: collapse;
}

th {
	border: 1px solid black;
	color: black;
}

td {
	border: 1px solid black;
	text-align: center;
}
</style>

<form
	action="<%=request.getContextPath()%>/manager_page/manager.jsp?group=manager_page&worker=manager_product_update_action"
	method="post" enctype="multipart/form-data" id="uploadForm">
	<div class="manager_body">
		<div class="insert_div_content">
			<ul>
				<li>
					<div class="insert_div">
						<input type="hidden" name="productNum" value="<%=productNum%>">
						<input type="text" name="productName" value="<%=productName %>"> <label>제품명</label>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<input type="text" name="productPrice" value="<%=productPrice %>"> <label>가격</label>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<input type="text" name="productCom" value="<%=productCom %>"> <label>제조사</label>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<select name="productCate">
							<option value="10" <%if(productCate==10) {%>selected="selected"<%} %>>&nbsp;스낵&nbsp;</option>
							<option value="20" <%if(productCate==20) {%>selected="selected"<%} %>>&nbsp;파이&amp;쿠키&nbsp;</option>
							<option value="30" <%if(productCate==30) {%>selected="selected"<%} %>>&nbsp;캔디&amp;젤리&nbsp;</option>
							<option value="40" <%if(productCate==40) {%>selected="selected"<%} %>>&nbsp;초콜릿&nbsp;</option>
							<option value="50" <%if(productCate==50) {%>selected="selected"<%} %>>&nbsp;껌&nbsp;</option>
						</select> <label>유형</label>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<input type="text" name="productDis" value="<%=productDis %>"> <label>할인율(%)</label>
					</div>
				</li>
				<li>
					<div class="insert_div">
					<%if(productDisContent==null){ %>
						<input type="text" name="productDisContent" value=""> <label>할인내용</label>
					<%}else{ %>
						<input type="text" name="productDisContent" value="<%=productDisContent %>"> <label>할인내용</label>
					<%} %>
					</div>
				</li>
			</ul>
		</div>
	</div>
	<div class="insert_div_content">
		<ul>
			<li>
				<div class="insert_div">
					<input type="file" name="productMainImg" value="<%=productMainImg%>"> <label>제품이미지</label>
					<label><%=productMainImg%></label>  
				</div>
			</li>
			<li>
				<div class="insert_div">
					<input type="file" name="productImg1" value="<%=productImg1%>"> <label>상세이미지1</label>
					<label><%=productImg1%></label>
				</div>
			</li>
			<li>
				<div class="insert_div">
					<input type="file" name="productImg2" value="<%=productImg2%>"> <label>상세이미지2</label>
					<label><%=productImg2%></label>
				</div>
			</li>
			<li>
				<div class="insert_div">
					<input type="file" name="productImg3" value="<%=productImg3%>"> <label>상세이미지3</label>
					<label><%=productImg3%></label>
				</div>
			</li>
		</ul>
	</div>
	<hr>
	<div class="insert_div">
		<button type="submit">제품변경</button>
		<button type="reset">다시입력</button>
	</div>
</form>