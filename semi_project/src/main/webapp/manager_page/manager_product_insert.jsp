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

.error {
	color: red;
	position: relative;
	left: 110px;
	display: none;
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
						<input type="text" name="productName" id="name"> <label>제품명</label>
						<div id="NameMsg" class="error">제품명을 입력해주세요.</div>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<input type="text" name="productPrice" id="price"> <label>가격</label>
						<div id="PriceMsg" class="error">가격을 입력해 주세요.</div>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<input type="text" name="productCom" id="com"> <label>제조사</label>
						<div id="ComMsg" class="error">제조사를 입력해 주세요.</div>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<select name="productCate" id="cate">
							<option value="10">&nbsp;스낵&nbsp;</option>
							<option value="20">&nbsp;파이&amp;쿠키&nbsp;</option>
							<option value="30">&nbsp;캔디&amp;젤리&nbsp;</option>
							<option value="40">&nbsp;초콜릿&nbsp;</option>
							<option value="50">&nbsp;껌&nbsp;</option>
						</select> <label>유형</label>
					</div>
					<div id="CateMsg" class="error">유형을 선택해 주세요.</div>
				</li>
			</ul>
		</div>
	</div>
	<div class="insert_div_content">
		<ul>
			<li>
				<div class="insert_div">
					<input type="file" name="productMainImg" id="main"> <label>제품이미지</label>
					<div id="MainMsg" class="error">메인사진을 넣어 주세요.</div>
				</div>
			</li>
			<li>
				<div class="insert_div">
					<input type="file" name="productImg1" id="img1"> <label>상세이미지1</label>
					<div id="img1Msg" class="error">상세제품에 들어갈 이미지를 넣어 주세요.</div>
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
	<div class="insert_div" style="padding-left: 10%;">
		<button type="submit">제품등록</button>
		<button type="reset">다시입력</button>
	</div>
</form>

<script type="text/javascript">

$("#uploadForm").submit(function() {
	var submitResult = true;
	
	$(".error").css("display","none");

	if($("#name").val()=="") {
		$("#NameMsg").css("display","block");
		submitResult=false;
	}
	if($("#price").val()=="") {
		$("#PriceMsg").css("display","block");
		submitResult=false;
	}
	if($("#com").val()=="") {
		$("#ComMsg").css("display","block");
		submitResult=false;
	}
	if($("#cate").val()=="") {
		$("#CateMsg").css("display","block");
		submitResult=false;
	}
	if($("#main").val()=="") {
		$("#MainMsg").css("display","block");
		submitResult=false;
	}
	if($("#img1").val()=="") {
		$("#img1Msg").css("display","block");
		submitResult=false;
	}
	return submitResult;
});

</script>
