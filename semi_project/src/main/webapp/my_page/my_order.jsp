<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="xzy.itwill.DAO.OrderDAO"%>
<%@page import="xyz.itwill.DTO.OrderDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/security/login_url.jspf"%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
	crossorigin="anonymous"></script>
<link href="<%=request.getContextPath()%>/style/my_page_order.css"
	type="text/css" rel="stylesheet">

<%
int clientNum = loginClient.getClientNum();

String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
DecimalFormat format = new DecimalFormat("###,###,##0");


int totalReviewOrder = OrderDAO.getDAO().selectOrderCnt(clientNum);
List<OrderDTO> tot = OrderDAO.getDAO().selectMyOrderCnt(clientNum);
int cntTot = tot.size();

//페이징 처리에 필요한 전달값(페이지번호과 게시글갯수)을 반환받아 저장
int pageNum = 1;//페이지번호- 전달값이 없는 경우 저장된 초기값 설정
if (request.getParameter("pageNum") != null) {//전달값이 있는 경우
	pageNum = Integer.parseInt(request.getParameter("pageNum"));
}

int pageSize = 20;//게시글갯수- 전달값이 없는 경우 저장된 초기값 설정
if (request.getParameter("pageSize") != null) {//전달값이 있는 경우
	pageSize = Integer.parseInt(request.getParameter("pageSize"));
}


//전체 페이지의 총갯수를 계산하여 저장
//int totalPage=totalReview/pageSize+totalReview%pageSize==0?0:1;
int totalPage = (int) Math.ceil((double) totalReviewOrder / pageSize);//페이지의 총갯수
if (totalPage == 0) {
	totalPage = 1;
}

//전달받은 페이지번호가 비정상적인 경우
if (pageNum <= 0 || pageNum > totalPage) {
	pageNum = 1;
}

//페이지번호에 대한 게시글의 시작 행번호를 계산하여 저장
//ex) 1Page : 1, 2Page : 11, 3Page : 21, 4Page : 31, ...
int startRow = (pageNum - 1) * pageSize + 1;

//페이지번호에 대한 게시글의 종료 행번호를 계산하여 저장
//ex) 1Page : 10, 2Page : 20, 3Page : 30, 4Page : 40, ...
int endRow = pageNum * pageSize;

//마지막 페이지의 게시글의 종료 행번호가 게시글의 총갯수보다 많은 경우 종료 행번호 변경
if (endRow > totalReviewOrder) {
	endRow = totalReviewOrder;
}

List<OrderDTO> myOrderList = OrderDAO.getDAO().selectMyOrderList(clientNum, startRow, endRow, currentDate, currentDate);
//페이지에 출력될 게시글의 일련번호 시작값을 계산하여 저장
//=> 검색된 게시글의 총갯수가 91개인 경우 >> 1Page : 91, 2Page : 81, 3Page, 71
int displayNum = totalReviewOrder - (pageNum - 1) * pageSize;

OrderDTO order = new OrderDTO();
int orderCnt = 0;
int cnt = 0;
if(request.getParameter("cnt")!=null){
	cnt = Integer.parseInt(request.getParameter("cnt"));
}


%>
<style>
#navigation a:hover {
    text-align: center;
	color: #F5A9D0;
	font-size: 17px;
}


</style>

<div class="container text-center">
	<div class="row justify-content-md-center">
		<div class="col col-lg-2">
			<%@include file="/my_page/my_side.jspf" %>
		</div>
		<div class="col col-lg-10">
			<%-- 제목 --%>
			<h1 class="subTitle1">주문내역</h1>
			<%-- 기간별/ 일자별 조회 칸 --%>
			<div class="tableTypeSearch">
				<form name="schFrm" id="schFrm" method="post" 
					action="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=order_search_action">
					<!-- 회원번호를 히든타입으로 전달 -->
					<input type="hidden" name="clientNum" id="clientNum" value="<%=clientNum%>"> 
					<input type="hidden" name="pageNo" id="pageNo" value="1"> 
					<input type="hidden" name="reqOrdStatType" id="reqOrdStatType" value="000">
					<!-- 스마트오더 구분값 추가 A:전체 -->
					<input type="hidden" name="smtFl" id="smtFl" value="A">
					<table>
						<colgroup>
							<col style="width: 175px;">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">기간별 조회</th>
								<td>
								<%if(request.getParameter("cnt")!=null) {%>
									<label class="inputRadio"><input type="radio" name="srch" id="inquiry1" <%if(cnt==1 || cnt==0) {%>checked="checked"<%} %>>
									<span>오늘</span>
									</label> 
									<label class="inputRadio"><input type="radio" name="srch" id="inquiry2" <%if(cnt==2) {%>checked="checked"<%} %>>
									<span>1주일</span>
									</label>
									<label class="inputRadio"><input type="radio" name="srch" id="inquiry3" <%if(cnt==3) {%>checked="checked"<%} %>>
									<span>1개월</span>
									</label>
									<label class="inputRadio"><input type="radio" name="srch" id="inquiry4" <%if(cnt==4) {%>checked="checked"<%} %>>
									<span>3개월</span>
									</label>
									<label class="inputRadio"><input type="radio" name="srch" id="inquiry5" <%if(cnt==5) {%>checked="checked"<%} %>>
									<span>6개월</span>
									</label>
								<%} else {%>
									<label class="inputRadio"><input type="radio" name="srch" id="inquiry1" checked="checked">
									<span>오늘</span>
									</label> 
									<label class="inputRadio"><input type="radio" name="srch" id="inquiry2">
									<span>1주일</span>
									</label>
									<label class="inputRadio"><input type="radio" name="srch" id="inquiry3">
									<span>1개월</span>
									</label>
									<label class="inputRadio"><input type="radio" name="srch" id="inquiry4" >
									<span>3개월</span>
									</label>
									<label class="inputRadio"><input type="radio" name="srch" id="inquiry5">
									<span>6개월</span>
									</label>
								<%} %>
								</td>
							</tr>
							<tr>
								<th scope="row">일자별 조회</th>
								<td><input type="text" name="stDate" readonly="" class="inputTxt datepicker hasDatepicker" style="width: 200px;"
									value="<%=currentDate %>" id="stDate"> 
									<span class="hyphen">~</span>
									<input type="text" name="endDate" readonly="" class="inputTxt datepicker hasDatepicker" style="width: 200px;"
									value="<%=currentDate%>" id="endDate">
									<button type="button" class="btnType7m" id="searchBtn">검색</button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			<div id="listArea">
				<p class="tableListLength">
					총 <strong class="ftColor1" id="countOrder"><%=myOrderList.size() %></strong> 건
				</p>
				<div class="tableType">
					<table>
						<colgroup>
							<col style="width: 150px;">
							<col style="width: 150px;">
							<col style="width: 370px;">
							<col style="width: 160px;">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">주문일자</th>
								<th scope="col">주문번호</th>
								<th scope="col">대표제품 명</th>
								<th scope="col">처리현황</th>
							</tr>
						</thead>
						<tbody id="orderList">
						<%if(myOrderList.size()==0){ %>
							<tr style="height: 100px; font-weight: bold;" class="noneList">
								<td colspan="5" class="noneList">주문 내역이 없습니다.</td>
							</tr>
						<%} else { %>
							<tr style="height: 100px; font-weight: bold; display: none;" class="noneList">
								<td colspan="5" class="noneList">주문 내역이 없습니다.</td>
							</tr>
						<%} %>
							<%for(OrderDTO orderList : myOrderList) { %>
							<tr class="<%=orderList.getOrderTime().substring(0, 17)%> orList" >
								<td class="findOrderList"><%=orderList.getOrderDate().substring(0,10) %></td>
								
								
									<td><a href="<%=request.getContextPath() %>/main_page/main.jsp?group=my_page&worker=my_order_detail&orderNum=<%=orderList.getOrderNum() %>&orderTime=<%=orderList.getOrderTime() %>" id="orderNumber_<%=orderList.getOrderNum() %>"
										 class="orderNumList"> <%=orderList.getOrderNum() %> </a>
									</td>
									<td class="left orderPrductList"><a href="<%=request.getContextPath() %>/main_page/main.jsp?group=my_page&worker=my_order_detail&orderNum=<%=orderList.getOrderNum() %>&orderTime=<%=orderList.getOrderTime() %>" id="orderNumber_<%=orderList.getOrderNum() %>" 
									 class="productName"> <%=orderList.getProductName() %> </a></td>
																
								<%if(orderList.getOrderStatus()==1) {%>
								<td id="orderStatus">배송완료</td>
								<%} else { %>
								<td id="orderStatus">제품 준비중</td>
								<%} %>
							</tr>
							<%} %>
						</tbody>
					</table>
				</div>
				<!-- paging -->
				<%
		// 하나의 페이지블럭에 출력될 페이지번호의 개수 설정
		int blockSize=5;
	
		// 페이지 블럭에 출력될 시작 페이지번호를 계산하여 저장
		// ex) 1 블럭 : 1, 2블럭 6, 3블럭 : 11
		int startPage=(pageNum-1)/blockSize*blockSize+1;
		
		// 페이지블럭에 출력될 종료페이지번호를 계산하여 저장
		// ex) 1블럭 : 5, 2블럭 : 10
		int endPage=startPage+blockSize-1;
		
		// 토탈페이지보다 종료페이지보다 크다면
		if(totalPage<endPage){
			endPage=totalPage;
		}
	%>
	
	<br>
	<div id="page_list" style="text-align: center;">
		<%
			String responseList="";
		%>
		
		<%if(startPage>blockSize){%>
			<a  href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=my_order&pageNum=<%=startPage-blockSize%>&pageSize=<%=pageSize%>">[이전]</a>		
		<%} else {%>
			[이전]
		<%} %>
		<% for(int i=startPage;i<=endPage;i++){ %>
			<%if(pageNum !=i) {%>
				<a id="cnt_<%=i %>" href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=my_order&pageNum=<%=i%>&pageSize=<%=pageSize%>" class="page">[<%=i %>]</a>
			<%}else{  %>
				[<%=i %>]
			<%} %>
		<%} %>
			<%if(endPage!=totalPage){ %>
				<a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=my_order&pageNum=<%=startPage+blockSize%>&pageSize=<%=pageSize%>">[다음]</a>
			<%}else{  %>
				[다음]
			<%} %>
	</div>
				<!-- //paging -->
				<br>
				<br>
				<div class="helpWrap">
					<ul class="bulListType">
						<li>주문번호와 대표제품 명을 클릭하시면 결제에 대한 상세정보를 확인하실 수 있습니다.</li>
						<li>배송정보는 처리현황이 배송 중, 배송완료 상태에서 조회가 가능합니다.</li>
						<li>이상없이 제품을 받으셨다면 수취확인을 해주세요. 확인하지 않으실 경우 배송시작일 부터 7일이후에
							자동으로 배송완료상태로 변경됩니다.</li>
					</ul>
				</div>
				<ol class="iconProcess">
					<li class="icon1"><span class="box"> <strong
							class="tit">결제대기</strong>
					</span></li>
					<li class="icon2"><span class="box"> <strong
							class="tit">결제완료</strong> <span> 결제가 완료되어 관리자가<br>
								주문내역을 확인 중입니다.<br> 취소가 가능합니다.
						</span>
					</span></li>
					<li class="icon3"><span class="box"> <strong
							class="tit">제품준비중</strong> <span> 결제 확인 후 택배사에서<br>
								제품을 포장하고 있습니다.
						</span>
					</span></li>
					<li class="icon5"><span class="box"> <strong
							class="tit">배송완료</strong>
					</span></li>
				</ol>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">

function dateFormat(myDate) {
	/* 이전 날에 대한 radio가 선택되었을 때 주문 조회  */
	let year = myDate.getFullYear(); // 년도
	let month = myDate.getMonth() + 1;  // 월
	let date = myDate.getDate();  // 날짜
	
	if(month.toString().length==1){
		month = ("0"+month).slice(-2);
	}
	if(date.toString().length==1){
		date = ("0"+date).slice(-2);
	}
	
	var wantDate = year + '-' + month + '-' + date;
	return  wantDate;
}
function nowDate() {
	/* 오늘 radio가 선택되었을 때 주문 조회  */
	var day = new Date();
	let year = day.getFullYear(); // 년도
	let month = day.getMonth() + 1;  // 월
	let date = day.getDate();  // 날짜
	
	if(month.toString().length==1){
		month = ("0"+month).slice(-2);
	}
	if(date.toString().length==1){
		date = ("0"+date).slice(-2);
	}
	var wantDate = year + '-' + month + '-' + date;
	return  wantDate;
}

function lastWeek() {
	  var day = new Date();
	  var dayOfMonth = day.getDate();
	  day.setDate(dayOfMonth - 7);
	  return dateFormat(day);
}

function lastMonth() {
	  var day = new Date();
	  var monthOfYear = day.getMonth();
	  day.setMonth(monthOfYear - 1);
	  return dateFormat(day);
}
function thirdMonth() {
	  var day = new Date();
	  var monthOfYear = day.getMonth();
	  day.setMonth(monthOfYear - 3);
	  return dateFormat(day);
}
function sixthMonth() {
	  var day = new Date();
	  var monthOfYear = day.getMonth();
	  day.setMonth(monthOfYear - 6);
	  return dateFormat(day);
}


$("#inquiry1").click(function() {
	$("#stDate").attr("value",nowDate());
	$("#endDate").attr("value",nowDate());
})
$("#inquiry2").click(function() {
	$("#stDate").attr("value",lastWeek());
})
$("#inquiry3").click(function() {
	$("#stDate").attr("value",lastMonth());
})
$("#inquiry4").click(function() {
	$("#stDate").attr("value",thirdMonth());
})
$("#inquiry5").click(function() {
	$("#stDate").attr("value",sixthMonth());
})

	
	
	
	$("#searchBtn").click(function() {
		var startDate = $("#stDate").val();
		var endDate = $("#endDate").val();
		var clientNum = $("#clientNum").val();
		var startRow = <%=startRow%>
		var endRow = <%=endRow%>
		$.ajax({
			type: "post",
			url: "<%=request.getContextPath()%>/my_page/order_search_action.jsp",
			data : {"startDate" : startDate, "endDate" : endDate, "clientNum" : clientNum, "startRow" : startRow, "endRow" : endRow},
			dataType: "json",
			success: function(result) {
				//주문정보목록에 출력된 기존 주문정보들을 삭제 처리 - 초기화
				$("#orderList").children().remove();
				
				if(result.code=="success") {//검색된 주문 있는 경우
					//Array 객체의 요소값를 차례대로 제공받아 반복 처리
					$(result.data).each(function() {
						$("#countOrder").text(result.data.length);
						//Array 객체의 요소값(Object 객체)를 HTML 태그(div)로 변환
						var html="<tr>";
						html+="<td>"+this.date+"</td>";//주문날짜
						html+="<td><a href='"+this.url2+"'>"+this.number+" </a></td>";//주문번호
						html+="<td class='left productName'><a href='"+this.url+"'>"+this.product+" </a></td>";//제품이름
						html+="<td>"+this.price+"원</td>";//가격
						if(this.status==1){
						html+="<td>제품 준비중</td>";//주문상태
						} else {
						html+="<td>배송 완료</td>";//주문상태
						}
						html+="</tr>";
						
						//리스트 추가
						$("#orderList").append(html);
					});
				} else {//검색된 댓글정보가 없는 경우
					$("#orderList").children().remove();
					
					var html="<tr style='height: 100px; font-weight: bold;'>"
					html+="<td colspan=5>주문 내역이 없습니다.</td>"
					html+="</tr>"
					$("#orderList").append(html);
				
				}
			},
			error: function(xhr) {
				alert("에러코드 = "+xhr.status);
			}
		});
	});

	
</script>