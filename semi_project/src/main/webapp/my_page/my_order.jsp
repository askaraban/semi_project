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



List<OrderDTO> myOrderList = OrderDAO.getDAO().myOrderList(currentDate, currentDate, clientNum);

%>


<div class="container text-center">
	<div class="row justify-content-md-center">
		<div class="col col-lg-2">
			<div id="navigation" style="padding-top: 60px;">
				<h1>
					<a class="side_menu"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=order">주문내역</a>
				</h1>
				<h2>
					<a class="side_menu"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review">리뷰</a>
				</h2>
				<h3>
					<a class="side_menu"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=qna">Q&A</a>
				</h3>
				<h4>
					<a class="side_menu"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=password_confirm&action=modify">회원정보</a>
				</h4>
			</div>
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
									<label class="inputRadio"><input type="radio" name="srch" id="inquiry1" checked="checked">
									<span>오늘</span>
									</label> 
									<label class="inputRadio"><input type="radio" name="srch" id="inquiry2">
									<span>1주일</span>
									</label>
									<label class="inputRadio"><input type="radio" name="srch" id="inquiry3">
									<span>1개월</span>
									</label>
									<label class="inputRadio"><input type="radio" name="srch" id="inquiry4">
									<span>3개월</span>
									</label>
									<label class="inputRadio"><input type="radio" name="srch" id="inquiry5">
									<span>6개월</span>
									</label>
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
					총 <strong class="ftColor1"><%=myOrderList.size() %></strong> 건
				</p>
				<div class="tableType">
					<table>
						<colgroup>
							<col style="width: 120px;">
							<col style="width: 115px;">
							<col>
							<col style="width: 110px;">
							<col style="width: 110px;">
							<col style="width: 110px;">
							<col style="width: 110px;">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">주문일자</th>
								<th scope="col">주문번호</th>
								<th scope="col">대표제품 명</th>
								<th scope="col">결제금액</th>
								<th scope="col">처리현황</th>
								<th scope="col">배송조회</th>
								<th scope="col">수취확인</th>
							</tr>
						</thead>
						<tbody id="orderList">
							<tr style="height: 100px; font-weight: bold; display: none;">
								<td colspan="7">주문 내역이 없습니다.</td>
							</tr>
							<%for(OrderDTO orderList : myOrderList) { %>
							<tr>
								<td id="orderDate"><%=orderList.getOrderDate() %></td>
								<td><a href="#" id="orderNumber"> <%=orderList.getOrderNum() %> </a>
								</td>
								<td class="left"><a href="#" id="productName"> <%=orderList.getProductName() %> </a></td>
								<td id="productAmount"><%=format.format(orderList.getOrderSum()) %>원</td>
								<td id="orderStatus">배송완료</td>
								<td class="btn">
									<button type="button" class="btnType7s" id="trackingBtn">배송조회</button>
								</td>
								<td class="btn"></td>
							</tr>
							<%} %>
						</tbody>
					</table>
				</div>
				<!-- paging -->
				<div class="paging">
					<span class="num on"><a href="javascript:void(0);">1</a></span>
				</div>
				<!-- //paging -->
				<div class="helpWrap">
					<ul class="bulListType">
						<li>주문번호와 제품명을 클릭 하시면 주문 상세 내역을 보실 수 있습니다.</li>
						<li>배송정보는 처리현황이 배송 중, 배송완료 상태에서 조회가 가능합니다.</li>
						<li>이상없이 제품을 받으셨다면 수취확인을 해주세요. 확인하지 않으실 경우 배송시작일 부터 7일이후에
							자동으로 배송완료상태로 변경됩니다.</li>
						<li>온라인에서 구매내역 표기시 제품의 정상가로 표기 됩니다. (단, 등급 반영시 실제 결제가 기준으로
							반영됩니다.)</li>
						<li>등급 반영시 반품내역, 포인트 구매내역은 제외 됩니다.</li>
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
					<li class="icon4"><span class="box"> <strong
							class="tit">배송중</strong> <span> 제품을 포장 후 배송중입니다.<br>
								송장번호를 통해 현 배송상태<br> 를 확인하실 수 있습니다.
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
	
	/* 오늘 radio가 선택되었을 때 주문 조회  */
	let today = new Date();
	let year = today.getFullYear(); // 년도
	let month = today.getMonth() + 1;  // 월
	let date = today.getDate();  // 날짜
	
	function dateFormat() {
		
		if(month.toString().length==1){
			month = "0"+month;
		}
		if(date.toString().length==1){
			date = "0"+date;
		}
	} 
	
	
	$("#inquiry1").click(function() {
		dateFormat();
		
		$("#stDate").attr("value", year + '-' + month + '-' + date);
		$("#endDate").attr("value",year + '-' + month + '-' + date);
	})
	
	$("#searchBtn").click(function() {
		var startDate = $("#stDate").val();
		var endDate = $("#endDate").val();
		$.ajax({
			type: "post",
			url: "<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=my_search_action",
			data : {"startDate" : startDate, "endDate" : endDate, "clientNum" : clientNum},
			dataType: "json",
			success: function(result) {
				//주문정보목록에 출력된 기존 주문정보들을 삭제 처리 - 초기화
				$("#orderList").children().remove();
				
				if(result.code=="success") {//검색된 주문 있는 경우
					//Array 객체의 요소값를 차례대로 제공받아 반복 처리
					$(result.data).each(function() {
						
						<tr>
						<td id="orderDate"><%=orderList.getOrderDate() %></td>
						<td><a href="#" id="orderNumber"> <%=orderList.getOrderNum() %> </a>
						</td>
						<td class="left"><a href="#" id="productName"> <%=orderList.getProductName() %> </a></td>
						<td id="productAmount"><%=format.format(orderList.getOrderSum()) %>원</td>
						<td id="orderStatus">배송완료</td>
						<td class="btn">
							<button type="button" class="btnType7s" id="trackingBtn">배송조회</button>
						</td>
						<td class="btn"></td>
					</tr>
						
						
						
						//Array 객체의 요소값(Object 객체)를 HTML 태그(div)로 변환
						var html="<div class='comment' id='comment_"+this.num+"'>";//댓글태그
						html+="<b>["+this.writer+"]</b><br>";//댓글태그에 작성자 포함
						html+=this.content.replace(/\n/g,"<br>")+"<br>";//댓글태그에 내용 포함
						html+="("+this.regdate+")<br>";//댓글태그에 작성날짜 포함
						html+="<button type='button' onclick='modifyComment("+this.num+");'>댓글변경</button>&nbsp;";//댓글태그에 댓글변경 버튼 포함
						html+="<button type='button' onclick='removeComment("+this.num+");'>댓글삭제</button>&nbsp;";//댓글태그에 댓글변경 버튼 포함
						html+="</div>";
						
						//댓글목록태그의 댓글태그를 마지막 자식태그로 추가하여 출력 처리
						$("#comment_list").append(html);
					});
				} else {//검색된 댓글정보가 없는 경우
					$("#comment_list").html("<div class='no_comment'>"+result.message+"</div>");
				}
			},
			error: function(xhr) {
				alert("에러코드 = "+xhr.status);
			}
		});
	});
</script>