<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_url.jspf" %>    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<link href="<%=request.getContextPath()%>/style/my_page_order.css" type="text/css" rel="stylesheet">

<%-- 네비게이션 바 --%> 
<div class="container text-center">
	<div class="row justify-content-md-center">
		<div class="col col-lg-2">
			<div id="navigation" style="padding-top: 60px;">
				<h1>
					<a class="side_menu" href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=order">주문내역</a>
				</h1>
				<h2>
					<a class="side_menu" href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review">리뷰</a>
				</h2>
				<h3>
					<a class="side_menu" href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=qna">Q&A</a>
				</h3>
				<h4>
					<a class="side_menu" href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=password_confirm&action=modify">회원정보</a>
				</h4>
			</div>
		</div>
		<div class="col col-lg-10">
			<%-- 제목 --%>
			<h1 class="subTitle1">주문내역</h1>
			<%-- 기간별/ 일자별 조회 칸 --%>
			<div class="tableTypeSearch">
				<form name="schFrm" id="schFrm" method="post">
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
								<label class="inputRadio"><input type="radio" name="srch" onclick="javascript:$.jdate.addDays('Dday', document.schFrm.stDate, document.schFrm.endDate);" id="inquiry1"> <span>오늘</span></label>
								<label class="inputRadio"><input type="radio" name="srch" onclick="javascript:$.jdate.addDays('W1', document.schFrm.stDate, document.schFrm.endDate);" id="inquiry2"> <span>1주일</span></label>
								<label class="inputRadio"><input type="radio" name="srch" onclick="javascript:$.jdate.addDays('M1', document.schFrm.stDate, document.schFrm.endDate);" id="inquiry3"> <span>1개월</span></label>
								<label class="inputRadio"><input type="radio" name="srch" onclick="javascript:$.jdate.addDays('M3', document.schFrm.stDate, document.schFrm.endDate);" id="inquiry4"> <span>3개월</span></label>
								<label class="inputRadio"><input type="radio" name="srch" onclick="javascript:$.jdate.addDays('M6', document.schFrm.stDate, document.schFrm.endDate);" id="inquiry5"> <span>6개월</span></label>
							</td>
							</tr>
							<tr>
								<th scope="row">일자별 조회</th>
							<td>
								<input type="text" name="stDate" readonly="" class="inputTxt datepicker hasDatepicker" style="width: 200px;" value="" id="dp1706857231636">
								<span class="hyphen">~</span>
								<input type="text" name="endDate" readonly="" class="inputTxt datepicker hasDatepicker" style="width: 200px;" value="" id="dp1706857231637">
								<button type="button" class="btnType7m" onclick="goSearch(1);">검색</button>
							</td>
							</tr>
						</tbody>
					</table>
				</form>	
			</div>
			
			<div id="listArea">





<p class="tableListLength">총 <strong class="ftColor1">1</strong> 건</p>
<div class="tableType">
	<table>
		<colgroup>
			<col style="width:120px;">
			<col style="width:115px;">
			<col>
			<col style="width:110px;">
			<col style="width:110px;">
			<col style="width:110px;">
			<col style="width:110px;">
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
		<tbody>
			
			
			
						
			<tr>
				<td>2023.11.15</td>
				<td>
					<a href="javascript:void(0)" onclick="goOrderDetail('20691308', '000', 'N')">
						20691308
						
						
					</a>				
				</td>
				<td class="left">
										
					<a href="javascript:void(0)" onclick="goOrderDetail('20691308', '000', 'N')">
					
						비자 트러블 토너 외1건
					</a>				
				</td>
				<td>66,500원</td>
				<td>배송완료</td>
				<td class="btn">
				
					<button type="button" class="btnType7s" onclick="getInvoceList('20691308')">배송조회</button>
					
				
				</td>
				<td class="btn">
				
				</td>
			</tr>
			
			
			
		</tbody>
	</table>
</div>
<!-- paging -->

	<div class="paging"><span class="num on"><a href="javascript:void(0);">1</a></span></div>

<!-- //paging -->
<div class="helpWrap">
	<ul class="bulListType">
		<li>주문번호와 제품명을 클릭 하시면 주문 상세 내역을 보실 수 있습니다.</li>
		<li>배송정보는 처리현황이 배송 중, 배송완료 상태에서 조회가 가능합니다.</li>
		<li>이상없이 제품을 받으셨다면 수취확인을 해주세요. 확인하지 않으실 경우 배송시작일 부터 7일이후에 자동으로 배송완료상태로 변경됩니다.</li>
		<li>온라인에서 구매내역 표기시 제품의 정상가로 표기 됩니다. (단, 등급 반영시 실제 결제가 기준으로 반영됩니다.)</li>
		<li>등급 반영시 반품내역, 포인트 구매내역은 제외 됩니다.</li>
	</ul>
</div>

<ol class="iconProcess">
	<li class="icon1">
		<span class="box">
			<strong class="tit">결제대기</strong>
		</span>
		
		
	</li>
	<li class="icon2">
		<span class="box">
			<strong class="tit">결제완료</strong>
			<span>
				결제가 완료되어 관리자가<br>
				주문내역을 확인 중입니다.<br>
				취소가 가능합니다.
			</span>
		</span>
	</li>
	<li class="icon3">
		<span class="box">
			<strong class="tit">제품준비중</strong>
			<span>
				결제 확인 후 택배사에서<br>
				제품을 포장하고 있습니다.
			</span>
		</span>
	</li>
	<li class="icon4">
		<span class="box">
			<strong class="tit">배송중</strong>
			<span>
				제품을 포장 후 배송중입니다.<br>
				송장번호를 통해 현 배송상태<br>
				를 확인하실 수 있습니다.
			</span>
		</span>
	</li>
	<li class="icon5">
		<span class="box">
			<strong class="tit">배송완료</strong>
		</span>
	</li>
</ol>
</div>
		</div>
	</div>
</div>