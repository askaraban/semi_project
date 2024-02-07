<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<form
	action="<%=request.getContextPath()%>/manager_page/manager.jsp?group=manager_page&worker=manager_product_action"
	method="post" enctype="multipart/form-data" id="uploadForm">
	<div class="manager_body">
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