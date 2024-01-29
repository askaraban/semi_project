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
	border: 1px solid black;
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
	action="<%=request.getContextPath()%>/manager_page/manager?group=manager_page&worker=manager_product_action"
	method="post" enctype="multipart/form-data" id="uploadForm">
	<div class="manager_body">
		<div class="product_Btn">
			<button type="button" id="listBtn">��ǰ ���</button>
		</div>
		<div class="product_Btn">
			<button type="button" id="insertBtn">��ǰ �߰�</button>
		</div>
		<div class="insert_div_content">
			<ul>
				<li>
					<div class="insert_div">
						<input type="text"> <label>��ǰ��</label>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<input type="text"> <label>��ǰ�󼼳���</label>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<input type="text"> <label>����</label>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<select name="category">
							<option value="10">&nbsp;����&nbsp;</option>
							<option value="20">&nbsp;����&��Ű&nbsp;</option>
							<option value="30">&nbsp;ĵ��&����&nbsp;</option>
							<option value="40">&nbsp;���ݸ�&nbsp;</option>
							<option value="50">&nbsp;��&nbsp;</option>
						</select> <label>����</label>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<input type="text"> <label>�Ǹŷ�</label>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<input type="text"> <label>������</label>
					</div>
				</li>
			</ul>
		</div>
	</div>
	<div class="insert_div_content">
		<ul>
			<li>
				<div class="insert_div">
					<input type="file" name="product_img"> <label>��ǰ�̹���</label>
				</div>
			</li>
			<li>
				<div class="insert_div">
					<input type="file" name="file1"> <label>���̹���1</label>
				</div>
			</li>
			<li>
				<div class="insert_div">
					<input type="file" name="file2"> <label>���̹���2</label>
				</div>
			</li>
			<li>
				<div class="insert_div">
					<input type="file" name="file3"> <label>���̹���3</label>
				</div>
			</li>
		</ul>
	</div>
	<div class="insert_div">
		<button type="submit">��ǰ���</button>
		<button type="reset">�ٽ��Է�</button>
	</div>
</form>



<div id="productList_div">
	<table>
		<tr>
			<th>��ǰ��ȣ</th>
			<th>��ǰ��</th>
			<th>����</th>
			<th>����</th>
			<th>������</th>
			<th>�Ǹŷ�</th>
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