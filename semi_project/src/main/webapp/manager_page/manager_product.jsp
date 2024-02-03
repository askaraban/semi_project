<%@page import="xzy.itwill.DAO.ProductDAO"%>
<%@page import="xzy.itwill.DAO.CategoryDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="xyz.itwill.DTO.CategoryDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
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
	int totalProduct = ProductDAO.getDAO().searchProductList(keyword, search);
	
	// 전체 페이지의 개수를 계산하기 위한 변수 ceil> 나머지 올림처리
	int totalPage = (int)Math.ceil((double)totalProduct/pageSize);
	
	// 전달받은 페이지 수가 비정상적인 경우 
	if(pageNum<0 || pageNum>totalPage ){
		pageNum=1;
	}
	// 페이지 번호에 대한 페이지의 시작번호를 저장하기 위한 변수 - 10의 간격으로 시작하도록 하시오
	// ex) 1) 1~10 2) 11~20 3) 21~30 ...
	int startNum = (pageNum-1)*pageSize + 1;
	
	// 페이지 번호에 대한 페이지의 끝번호를 저장하기 위한 변수
	// ex) 1) 1~10 2) 11~20 3) 21~30 ...
	int endNum = pageNum * pageSize;
	
	if(endNum>totalProduct){
		endNum=totalProduct;
	}
	
	
%>

<style>
.manager_body {
	display: block;
}

.product_Btn {
	display: inline-block;
}

.insert_div {
	display: none;
}

#productList_div {
	display: none;
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

<form
	action="<%=request.getContextPath()%>/manager_page/manager.jsp?group=manager_page&worker=manager_product_action"
	method="post" enctype="multipart/form-data" id="uploadForm">
	<div class="manager_body">
		<div class="product_Btn">
			<button type="button" id="listBtn">제품 목록</button>
		</div>
		<div class="product_Btn">
			<button type="button" id="insertBtn">제품 추가</button>
		</div>
		<div class="insert_div_content">
			<ul>
				<li>
					<div class="insert_div">
						<input type="text" name="productName"> <label>제품명</label>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<input type="text" name="productPrice"> <label>가격</label>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<input type="text" name="productCom"> <label>제조사</label>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<select name="productCate">
							<option value="10">&nbsp;스낵&nbsp;</option>
							<option value="20">&nbsp;파이&amp;쿠키&nbsp;</option>
							<option value="30">&nbsp;캔디&amp;젤리&nbsp;</option>
							<option value="40">&nbsp;초콜릿&nbsp;</option>
							<option value="50">&nbsp;껌&nbsp;</option>
						</select> <label>유형</label>
					</div>
				</li>
			</ul>
		</div>
	</div>
	<div class="insert_div_content">
		<ul>
			<li>
				<div class="insert_div">
					<input type="file" name="productMainImg"> <label>제품이미지</label>
				</div>
			</li>
			<li>
				<div class="insert_div">
					<input type="file" name="productImg1"> <label>상세이미지1</label>
				</div>
			</li>
			<li>
				<div class="insert_div">
					<input type="file" name="productImg2"> <label>상세이미지2</label>
				</div>
			</li>
			<li>
				<div class="insert_div">
					<input type="file" name="productImg3"> <label>상세이미지3</label>
				</div>
			</li>
		</ul>
	</div>
	<hr>
	<div class="insert_div">
		<button type="submit">제품등록</button>
		<button type="reset">다시입력</button>
	</div>
</form>



<div id="productList_div">
	<table>
		<tr>
			<th>제품번호</th>
			<th>제품명</th>
			<th>유형</th>
			<th>가격</th>
			<th>할인율(%)</th>
			<th>판매량</th>
		</tr>
	</table>
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
</script>