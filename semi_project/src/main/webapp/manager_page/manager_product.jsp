<%@page import="xzy.itwill.DAO.ProductDAO"%>
<%@page import="xzy.itwill.DAO.CategoryDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="xyz.itwill.DTO.CategoryDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	// �˻���ɿ� �ʿ��� ���ް��� �����ϱ� ���� ���� ex) ��ǰ��ȣ, ��ǰ��, ���� ī�װ� ����
	String search = (String)request.getParameter("search");
	if(search==null){
		search="";
	}
	// �˻��Ϸ��� �ܾ ã�� �����ϱ� ���� ������
	String keyword = (String)request.getParameter("keyword");
	if(keyword==null){
		keyword="";
	}
	// ����¡ ó���� ���� ����- ���������� 1������
	int pageNum = 1;
	if(request.getParameter("pageNum")!=null){
		pageNum=Integer.parseInt(request.getParameter("pageNum")); 
	}
	// �ѱ� �� �ִ� �ִ� ������ ���� �����ϱ� ���� ���� - �������� ������ �� 10������
	int pageSize = 10;
	if(request.getParameter("pageSize")!=null){
		pageSize = Integer.parseInt(request.getParameter("pageSize"));
	}
	
	// �˻� ���� �˻� �ܾ ���޹޾� product_table�� �˻� ���� �˻��ܾ �ش�Ǵ� ��ǰ�� ������ ��ȯ�ϴ� �޼ҵ� ȣ��
	int totalProduct = ProductDAO.getDAO().searchProductList(keyword, search);
	
	// ��ü �������� ������ ����ϱ� ���� ���� ceil> ������ �ø�ó��
	int totalPage = (int)Math.ceil((double)totalProduct/pageSize);
	
	// ���޹��� ������ ���� ���������� ��� 
	if(pageNum<0 || pageNum>totalPage ){
		pageNum=1;
	}
	// ������ ��ȣ�� ���� �������� ���۹�ȣ�� �����ϱ� ���� ���� - 10�� �������� �����ϵ��� �Ͻÿ�
	// ex) 1) 1~10 2) 11~20 3) 21~30 ...
	int startNum = (pageNum-1)*pageSize + 1;
	
	// ������ ��ȣ�� ���� �������� ����ȣ�� �����ϱ� ���� ����
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
			<button type="button" id="listBtn">��ǰ ���</button>
		</div>
		<div class="product_Btn">
			<button type="button" id="insertBtn">��ǰ �߰�</button>
		</div>
		<div class="insert_div_content">
			<ul>
				<li>
					<div class="insert_div">
						<input type="text" name="productName"> <label>��ǰ��</label>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<input type="text" name="productPrice"> <label>����</label>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<input type="text" name="productCom"> <label>������</label>
					</div>
				</li>
				<li>
					<div class="insert_div">
						<select name="productCate">
							<option value="10">&nbsp;����&nbsp;</option>
							<option value="20">&nbsp;����&amp;��Ű&nbsp;</option>
							<option value="30">&nbsp;ĵ��&amp;����&nbsp;</option>
							<option value="40">&nbsp;���ݸ�&nbsp;</option>
							<option value="50">&nbsp;��&nbsp;</option>
						</select> <label>����</label>
					</div>
				</li>
			</ul>
		</div>
	</div>
	<div class="insert_div_content">
		<ul>
			<li>
				<div class="insert_div">
					<input type="file" name="productMainImg"> <label>��ǰ�̹���</label>
				</div>
			</li>
			<li>
				<div class="insert_div">
					<input type="file" name="productImg1"> <label>���̹���1</label>
				</div>
			</li>
			<li>
				<div class="insert_div">
					<input type="file" name="productImg2"> <label>���̹���2</label>
				</div>
			</li>
			<li>
				<div class="insert_div">
					<input type="file" name="productImg3"> <label>���̹���3</label>
				</div>
			</li>
		</ul>
	</div>
	<hr>
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
			<th>������(%)</th>
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