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
	int totalProduct = ProductDAO.getDAO().searchTotalList(keyword, search);
	
	// ��ü �������� ������ ����ϱ� ���� ���� ceil> ������ �ø�ó��
	int totalPage = (int)Math.ceil((double)totalProduct/pageSize);
	
	// ���޹��� ������ ���� ���������� ��� 
	if(pageNum<=0 || pageNum>totalPage ){
		pageNum=1;
	}

	// ������ ��ȣ�� ���� �������� ���۹�ȣ�� �����ϱ� ���� ���� - 10�� �������� �����ϵ��� �Ͻÿ�
	// ex) 1) 1~10 2) 11~20 3) 21~30 ...
	int startRow = (pageNum-1)*pageSize + 1;

	// ������ ��ȣ�� ���� �������� ����ȣ�� �����ϱ� ���� ����
	// ex) 1) 1~10 2) 11~20 3) 21~30 ...
	int endRow = pageNum * pageSize;
	
	if(endRow>totalProduct){
		endRow=totalProduct;
	}
	List<ProductDTO> productList = ProductDAO.getDAO().searchProductList(search, keyword, startRow, endRow);
	// �������� ��µ� ��ǰ���� �Ϸù�ȣ ���۰��� ����Ͽ� ����
	// => �˻��� ��ǰ�� �� ���� : 91 >> 1Page : 91 ~ 82 , 2Page: 81 ~ 3Page : 71 
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
			<th>��ȣ</th>
			<th>��ǰ��ȣ</th>
			<th>��ǰ��</th>
			<th>����</th>
			<th>����</th>
			<th>������(%)</th>
			<th>���γ���</th>
		</tr>
		
		<%if(totalProduct==0){%>
		<tr>
			<td colspan="6">�˻��� ��ǰ�� �����ϴ�.</td>
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
					<%displayNum--; // ��ǰ �Խù����� ��ȣ�� 1�� ���ҽ�Ŵ  %>
					<td>&nbsp;<%=pro.getProductNum() %>&nbsp;</td>
					<td>&nbsp;<a href="<%=request.getContextPath()+"/manager_page/manager.jsp?group=manager_page&worker=manager_product_update"%>"><%=pro.getProductName() %></a>&nbsp;</td>
					<td>&nbsp;<%=pro.getProductCate() %>&nbsp;</td>
					<td>&nbsp;<%=format.format(pro.getProductPrice()) %>��&nbsp;</td>
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
	<%-- ����ڷκ��� �˻� ���� ������ �Է¹ޱ� ���� �±� ��� --%>
	<form action="<%=request.getContextPath() %>/manager_page/manager.jsp?group=manager_page&worker=manager_product" method="post">
		<%-- select �±׸� ����Ͽ� �˻������ ������ ���� - ���ް��� �ݵ�� �÷������� ���� --%>
		<select name="search">
			<option value="product_num" <%if(search.equals("product_num")) {%> selected<%} %>>&nbsp;��ǰ��ȣ&nbsp;</option>
			<option value="product_name" <%if(search.equals("product_name")) {%> selected<%} %>>&nbsp;��ǰ�̸�&nbsp;</option>
			<option value="product_cate" <%if(search.equals("product_cate")) {%> selected<%} %>>&nbsp;����&nbsp;</option>
		</select>
		<input type="text" name="keyword" value="<%=keyword%>">
		<button type="button" id="searchBtn">�˻�</button>
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