<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.manager_body {
	display: block;
}

.category_Btn {
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
	action="<%=request.getContextPath()%>/manager_page/manager.jsp?group=manager_page&worker=manager_category_action"
	method="post" id="uploadForm">
	<div class="manager_body">
		<div class="category_Btn">
			<button type="button" id="listBtn">유형 목록</button>
		</div>
		<div class="category_Btn">
			<button type="button" id="insertBtn">유형 추가</button>
		</div>
		<div class="insert_div_content">
			<ul>
				<li>
					<div class="insert_div">
						<input type="text" name="CategoryName"><label>유형명</label>
					</div>
				</li>
			</ul>
		</div>
	</div>
	<hr>
	<div class="insert_div">
		<button type="submit">유형등록</button>
		<button type="reset">다시입력</button>
	</div>
</form>
<div id="productList_div">
	<table>
		<tr>
			<th>유형번호</th>
			<th>유형명</th>
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