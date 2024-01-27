<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<style>
.manager_body {
	display: block;
}

.product_Btn {
	display: inline-block;
}

.insert_div {
	display: none
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
	border: 1px solid black;
}
</style>

<form>
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
						<input type="text"> <label>제품명</label>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<input type="text"> <label>제품상세내용</label>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<input type="text"> <label>가격</label>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<select name="category">
							<option value="10">&nbsp;스낵&nbsp;</option>
							<option value="20">&nbsp;파이&쿠키&nbsp;</option>
							<option value="30">&nbsp;캔디&젤리&nbsp;</option>
							<option value="40">&nbsp;초콜릿&nbsp;</option>
							<option value="50">&nbsp;껌&nbsp;</option>
						</select> <label>유형</label>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<input type="text"> <label>판매량</label>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<input type="text"> <label>할인율</label>
					</div>
				</li>
			</ul>
		</div>
	</div>
</form>
<form action="fileUploadJSP.jsp" method="post"
	enctype="multipart/form-data">
	<div class="insert_div_content">
		<ul>
			<li>
				<div class="insert_div">
					<input type="file"> <label>제품이미지</label>
				</div>
			</li>
			<li>
				<div class="insert_div">
					<input type="file"> <label>상세이미지1</label>
				</div>
			</li>
			<li>
				<div class="insert_div">
					<input type="file""> <label>상세이미지2</label>
				</div>
			</li>
			<li>
				<div class="insert_div">
					<input type="file""> <label>상세이미지3</label>
				</div>
			</li>
		</ul>
	</div>
	<div class="insert_div">
		<button type="submit">제품등록</button>
		<button type="reset">다시입력</button>
	</div>
</form>
<script type="text/javascript">
	$("#insertBtn").click(function() {
		$(".insert_div").css("display", "block");
	})
</script>