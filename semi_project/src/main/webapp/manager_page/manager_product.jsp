<%@page import="java.text.DecimalFormat"%>
<%@page import="xyz.itwill.DTO.ProductDTO"%>
<%@page import="xzy.itwill.DAO.ProductDAO"%>
<%@page import="xzy.itwill.DAO.CategoryDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="xyz.itwill.DTO.CategoryDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%

	DecimalFormat format = new DecimalFormat("###,###,##0");
	// 검색기능에 필요한 전달값을 저장하기 위한 변수 ex) 제품번호, 제품명, 유형 카테고리 선택
	String search = (String)request.getParameter("search");
	if(search==null){
		search="";
	}
	// 검색하려는 단어를 찾아 저장하기 위한 변수명
	String keyword = (String)request.getParameter("keyword");
	if(keyword==null){
		keyword="";
	}
	// 페이징 처리를 위한 변수- 시작페이지 1페이지
	int pageNum = 1;
	if(request.getParameter("pageNum")!=null){
		pageNum=Integer.parseInt(request.getParameter("pageNum")); 
	}
	// 넘길 수 있는 최대 페이지 수를 저장하기 위한 변수 - 보여지는 페이지 수 10페이지
	int pageSize = 10;
	if(request.getParameter("pageSize")!=null){
		pageSize = Integer.parseInt(request.getParameter("pageSize"));
	}
	
	// 검색 대상과 검색 단어를 전달받아 product_table에 검색 대상과 검색단어에 해당되는 제품의 개수를 반환하는 메소드 호출
	int totalProduct = ProductDAO.getDAO().searchTotalList(keyword, search);
	
	// 전체 페이지의 개수를 계산하기 위한 변수 ceil> 나머지 올림처리
	int totalPage = (int)Math.ceil((double)totalProduct/pageSize);
	
	// 전달받은 페이지 수가 비정상적인 경우 
	if(pageNum<=0 || pageNum>totalPage ){
		pageNum=1;
	}

	// 페이지 번호에 대한 페이지의 시작번호를 저장하기 위한 변수 - 10의 간격으로 시작하도록 하시오
	// ex) 1) 1~10 2) 11~20 3) 21~30 ...
	int startRow = (pageNum-1)*pageSize + 1;

	// 페이지 번호에 대한 페이지의 끝번호를 저장하기 위한 변수
	// ex) 1) 1~10 2) 11~20 3) 21~30 ...
	int endRow = pageNum * pageSize;
	
	if(endRow>totalProduct){
		endRow=totalProduct;
	}
	List<ProductDTO> productList = ProductDAO.getDAO().searchProductList(search, keyword, startRow, endRow);
	// 페이지에 출력될 제품들의 일련번호 시작값을 계산하여 저장
	// => 검색된 제품의 총 개수 : 91 >> 1Page : 91 ~ 82 , 2Page: 81 ~ 3Page : 71 
	int displayNum = totalProduct - (pageNum-1) * pageSize;
	
	ProductDTO updateProduct = new ProductDTO();
	
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
	width: 100px;
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
<div id="productList_div">
	<table>
		<tr>
			<th>번호</th>
			<th>제품번호</th>
			<th>제품명</th>
			<th>유형</th>
			<th>가격</th>
			<th>할인율(%)</th>
			<th>할인내용</th>
		</tr>
		
		<%if(totalProduct==0){%>
		<tr>
			<td colspan="6">검색된 제품이 없습니다.</td>
		</tr>
		<%} else { %>
			<%for(ProductDTO pro : productList) {%>
				<tr>
					<% String url = request.getContextPath()+"/manager_page/manager.jsp?group=manager_page&worker=manager_product_update"
						+"&productNum="+pro.getProductNum()+"&productName="+pro.getProductName()+"&productPrice="+pro.getProductPrice()+"&productCom="
						+pro.getProductCom()+"&productCate="+pro.getProductCate()+"&productDis="+pro.getProductDis()+"&productDisContent="
						+pro.getProductDisContent()+"&productImg1="+pro.getProductImg1()+"&productImg2="+pro.getProductImg2()+"&productImg3="
						+pro.getProductImg3()+"&productMainImg="+pro.getProductMainImg(); 
						
					%>
					<td><%=displayNum %></td>
					<%displayNum--; // 제품 게시물들의 번호를 1씩 감소시킴  %>
					<td>&nbsp;<%=pro.getProductNum() %>&nbsp;</td>
					<td>&nbsp;<a href="<%=request.getContextPath()+"/manager_page/manager.jsp?group=manager_page&worker=manager_product_update"%>"><%=pro.getProductName() %></a>&nbsp;</td>
					<td>&nbsp;<%=pro.getProductCate() %>&nbsp;</td>
					<td>&nbsp;<%=format.format(pro.getProductPrice()) %>원&nbsp;</td>
					<td>&nbsp;<%=pro.getProductDis() %>&nbsp;</td>
					<%if(pro.getProductDisContent()==null) { %>
						<td> </td>
					<%} else {%>
					<td>&nbsp;<%=pro.getProductDisContent() %>&nbsp;</td>
					<%} %>
				</tr>
			<%} %>
		<%} %>
	</table>
	<div>
	<%-- 사용자로부터 검색 관련 정보를 입력받기 위한 태그 출력 --%>
	<form action="<%=request.getContextPath() %>/manager_page/manager.jsp?group=manager_page&worker=manager_product" method="post">
		<%-- select 태그를 사용하여 검색대상을 선택해 전달 - 전달값은 반드시 컬럼명으로 설정 --%>
		<select name="search">
			<option value="product_num" <%if(search.equals("product_num")) {%> selected<%} %>>&nbsp;제품번호&nbsp;</option>
			<option value="product_name" <%if(search.equals("product_name")) {%> selected<%} %>>&nbsp;제품이름&nbsp;</option>
			<option value="product_cate" <%if(search.equals("product_cate")) {%> selected<%} %>>&nbsp;유형&nbsp;</option>
		</select>
		<input type="text" name="keyword" value="<%=keyword%>">
		<button type="button" id="searchBtn">검색</button>
	</form>
	</div>
</div>

<script type="text/javascript">
	$("#insertBtn").click(function() {
		$(".insert_div").css("display", "block");
		$("#productList_div").css("display", "none");

	});

	$("#listBtn").click(function() {
		$("#productList_div").css("display", "block");
		$(".insert_div").css("display", "none");
	});
	
	$("#searchBtn").click(function() {
		$("#uploadForm").attr("action",  "<%=request.getContextPath()%>/manager_page/manager.jsp?group=cart_page&worker=cart_remove_action");
	})
	
</script>