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
	int pageSize = 20;
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
	
	String url="";
	
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
					<td><%=displayNum %></td>
					<%displayNum--; // 제품 게시물들의 번호를 1씩 감소시킴  %>
					<td>&nbsp;<%=pro.getProductNum() %>&nbsp;</td>
					<%if(pro.getProductStatus()==0){ %>
					<td>&nbsp;<a href="<%=request.getContextPath()%>/manager_page/manager.jsp?group=manager_page&worker=manager_product_update&productNum=<%= pro.getProductNum()%>" id="url" >
					<%=pro.getProductName() %></a>&nbsp;</td>
					<%} else { %>
					<td>&nbsp;<a href="<%=request.getContextPath()%>/manager_page/manager.jsp?group=manager_page&worker=manager_product_update&productNum=<%= pro.getProductNum()%>" id="url" >
					[삭제됨]&nbsp;&nbsp;<%=pro.getProductName() %></a>&nbsp;</td>
					<%} %>
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
	<%-- 페이지 번호 출력 및 링크 제공 - 블럭화 처리 --%>
	<%
		// 하나의 페이지블럭에 출력될 페이지번호의 개수 설정
		int blockSize=5;
	
		// 페이지 블럭에 출력될 시작 페이지번호를 계산하여 저장
		// ex) 1 블럭 : 1, 2블럭 6, 3블럭 : 11
		int startPage=(pageNum-1)/blockSize*blockSize+1;
		
		// 페이지블럭에 출력될 종료페이지번호를 계산하여 저장
		// ex) 1블럭 : 5, 2블럭 : 10
		int endPage=startPage+blockSize-1;
		
		// 토탈페이지보다 종료페이지보다 크다면
		if(totalPage<endPage){
			endPage=totalPage;
		}
	%>
	
	<div id="page_list">
		
		<%if(startPage>blockSize){%>
			<a href="<%=request.getContextPath()%>/manager_page/manager.jsp?worker=manager_product&pageNum=<%=startPage-blockSize%>&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>">[이전]</a>		
		<%} else {%>
			[이전]
		<%} %>
		<% for(int i=startPage;i<=endPage;i++){ %>
			<%if(pageNum !=i) {%>
				<a href="<%=request.getContextPath()%>/manager_page/manager.jsp?worker=manager_product&pageNum=<%=i%>&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>">[<%=i %>]</a>
			<%}else{  %>
				[<%=i %>]
			<%} %>
		<%} %>
			<%if(endPage!=totalPage){ %>
				<a href="<%=request.getContextPath()%>/manager_page/manager.jsp?worker=manager_product&pageNum=<%=startPage+blockSize%>&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>">[다음]</a>
			<%}else{  %>
				[다음]
			<%} %>
	</div>
	<div>
	<%-- 사용자로부터 검색 관련 정보를 입력받기 위한 태그 출력 --%>
	<form action="<%=request.getContextPath() %>/manager_page/manager.jsp?group=manager_page&worker=manager_product" method="post">
		<%-- select 태그를 사용하여 검색대상을 선택해 전달 - 전달값은 반드시 컬럼명으로 설정 --%>
		<select name="search">
			<option value="product_name" <%if(search.equals("product_name")) {%> selected<%} %>>&nbsp;제품이름&nbsp;</option>
			<option value="product_num" <%if(search.equals("product_num")) {%> selected<%} %>>&nbsp;제품번호&nbsp;</option>
			<option value="product_cate" <%if(search.equals("product_cate")) {%> selected<%} %>>&nbsp;유형&nbsp;</option>
		</select>
		<input type="text" name="keyword" value="<%=keyword%>">
		<button type="submit" id="searchBtn">검색</button>
	</form>
	</div>
</div>

<script type="text/javascript">

	
	
</script>