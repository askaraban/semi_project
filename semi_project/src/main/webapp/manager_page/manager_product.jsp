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
</form>
<form action="fileUploadJSP.jsp" method="post"
	enctype="multipart/form-data">
	<div class="insert_div_content">
		<ul>
			<li>
				<div class="insert_div">
					<input type="file"> <label>��ǰ�̹���</label>
				</div>
			</li>
			<li>
				<div class="insert_div">
					<input type="file"> <label>���̹���1</label>
				</div>
			</li>
			<li>
				<div class="insert_div">
					<input type="file""> <label>���̹���2</label>
				</div>
			</li>
			<li>
				<div class="insert_div">
					<input type="file""> <label>���̹���3</label>
				</div>
			</li>
		</ul>
	</div>
	<div class="insert_div">
		<button type="submit">��ǰ���</button>
		<button type="reset">�ٽ��Է�</button>
	</div>
</form>
<script type="text/javascript">
	$("#insertBtn").click(function() {
		$(".insert_div").css("display", "block");
	})
</script>