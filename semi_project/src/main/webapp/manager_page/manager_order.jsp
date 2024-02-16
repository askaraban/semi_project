<%@page import="xyz.itwill.DTO.OrderDTO"%>
<%@page import="xzy.itwill.DAO.OrderDAO"%>
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
	// �˻���ɿ� �ʿ��� ���ް��� �����ϱ� ���� ���� ex) ��ǰ��ȣ, ��ǰ��, ���� ī�װ��� ����
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
	int pageSize = 20;
	if(request.getParameter("pageSize")!=null){
		pageSize = Integer.parseInt(request.getParameter("pageSize"));
	}
	
	// �˻� ���� �˻� �ܾ ���޹޾� product_table�� �˻� ���� �˻��ܾ �ش�Ǵ� ��ǰ�� ������ ��ȯ�ϴ� �޼ҵ� ȣ��
	int totalProduct = OrderDAO.getDAO().selectManagerOrderCnt(keyword, search);
	
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
	List<OrderDTO> productList = OrderDAO.getDAO().selectManagerOrderList(search, keyword, startRow, endRow);
	// �������� ��µ� ��ǰ���� �Ϸù�ȣ ���۰��� ����Ͽ� ����
	// => �˻��� ��ǰ�� �� ���� : 91 >> 1Page : 91 ~ 82 , 2Page: 81 ~ 3Page : 71 
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
			<th>��ȣ</th>
			<th>�ֹ���ȣ</th>
			<th>��ǰ��</th>
			<th>�ֹ���¥</th>
		</tr>
		
		<%if(totalProduct==0){%>
		<tr>
			<td colspan="6">�˻��� ��ǰ�� �����ϴ�.</td>
		</tr>
		<%} else { %>
			<%for(OrderDTO pro : productList) {%>
				<tr>
					<td><%=displayNum %></td>
					<%displayNum--; // ��ǰ �Խù����� ��ȣ�� 1�� ���ҽ�Ŵ  %>
					<td>&nbsp;<%=pro.getOrderNum() %>&nbsp;</td>
					<td>&nbsp;<a href="<%=request.getContextPath()%>/manager_page/manager.jsp?group=manager_page&worker=manager_order_update&timeStemp=<%= pro.getOrderTime()%>&orderClientNum=<%=pro.getOrderClientNum() %>" id="url" >
					<%=pro.getProductName() %></a>&nbsp;</td>
					<td>&nbsp;<%=pro.getOrderDate() %>&nbsp;</td>
				</tr>
			<%} %>
		<%} %>
	</table>
	<%-- ������ ��ȣ ��� �� ��ũ ���� - ����ȭ ó�� --%>
	<%
		// �ϳ��� ������������ ��µ� ��������ȣ�� ���� ����
		int blockSize=5;
	
		// ������ ������ ��µ� ���� ��������ȣ�� ����Ͽ� ����
		// ex) 1 ���� : 1, 2���� 6, 3���� : 11
		int startPage=(pageNum-1)/blockSize*blockSize+1;
		
		// ������������ ��µ� ������������ȣ�� ����Ͽ� ����
		// ex) 1���� : 5, 2���� : 10
		int endPage=startPage+blockSize-1;
		
		// ��Ż���������� �������������� ũ�ٸ�
		if(totalPage<endPage){
			endPage=totalPage;
		}
	%>
	
	<div id="page_list">
		
		<%if(startPage>blockSize){%>
			<a href="<%=request.getContextPath()%>/manager_page/manager.jsp?worker=manager_order&pageNum=<%=startPage-blockSize%>&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>">[����]</a>		
		<%} else {%>
			[����]
		<%} %>
		<% for(int i=startPage;i<=endPage;i++){ %>
			<%if(pageNum !=i) {%>
				<a href="<%=request.getContextPath()%>/manager_page/manager.jsp?worker=manager_order&pageNum=<%=i%>&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>">[<%=i %>]</a>
			<%}else{  %>
				[<%=i %>]
			<%} %>
		<%} %>
			<%if(endPage!=totalPage){ %>
				<a href="<%=request.getContextPath()%>/manager_page/manager.jsp?worker=manager_order&pageNum=<%=startPage+blockSize%>&pageSize=<%=pageSize%>&search=<%=search%>&keyword=<%=keyword%>">[����]</a>
			<%}else{  %>
				[����]
			<%} %>
	</div>
</div>

<script type="text/javascript">

	$("#searchBtn").click(function() {
		$("#uploadForm").attr("action",  "<%=request.getContextPath()%>/manager_page/manager.jsp?group=manager_page&worker=manager_order");
	})
	
	
</script>