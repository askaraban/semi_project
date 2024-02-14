<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<%-- 네비게이션 바 --%> 
<style type="text/css">
body {
	width: 100%;
	max-width: 1020px;
	margin: 0 auto;
	box-sizing: border-box;
	display: block;
	text-align: center;
	font-family: 'Nanum Gothic', sans-serif;
}

#navigation a:hover {
    text-align: left;
	color: #F5A9D0;
	font-size: 1.5em;
}

#navigation h1 {
	font-size: 1em;	
	margin: 5px;
	height: 50px;
	text-align: center;	
}

#navigation h2 {
	font-size: 1em;		
	margin: 5px;
	height: 50px;
	text-align: center;	
}

#navigation h3 {
	font-size: 1em;
	margin: 5px;
	height: 50px;
	text-align: center;			
}

#navigation h4 {
	font-size: 1em;
	margin: 5px;
	height: 50px;
	text-align: center;	
}

#navigation {
	position: absolute;
}

<%-- 리뷰 --%>
[class*="subTitle1"] {
    margin: 60px 0 24px;
    font-weight: 600;
    font-size: 24px;
    line-height: 32px;
    text-align: left;
}

<%-- 리뷰쓰기 --%>
[class*="tabType"] ul {
    display: flex;
}

<%-- 상자 --%>
.tabType li button,
.tabType li a {
	position: relative;
	display: block;
	width: 100%;
	height: 62px;
	text-align: center;
}

[class*="tabType"] li {
	flex:1;
	position:relative;
	font-size:16px;
	line-height:1.25;
	color:#666;
}

<%--글자 중앙--%>
.tabType li a:after {
	content: "";
	display: inline-block;
	height: 100%;
	vertical-align: middle;
}

<%--답글--%>
.tabType li.active1 a {
	font-weight:600;
	color:#000;
	background:#fff;
}

<%--점 없애기--%>
li {
    list-style: none;
}

a {
	text-decoration: none;
}

<%--1:1--%>
.tabType li.active a {
	font-weight:600;
	color:#fff;
	background:#F5A9D0;
}

.myReview_new .inProgress .sel_area {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-bottom: 20px;
    margin-top: 30px;
}



.mpCounselInfo {
    margin: 50px 0 0px;
    padding: 100px 0 0;
    text-align: center;
    font-size: 14px;
    line-height: 1.36em;
    color: #666;
    background: url(../my_page/images/icon_counsel.png) no-repeat 50% 0%; background-size: 50px;
}




<%-- 라인 --%>
.mbOutTop {
    padding: 70px 0 0;
    border-top: 3px solid #000;
}





.btnWrap {
    display: flex;
    gap: 0 10px;
    text-align: center;
    justify-content: center;
    margin-top: 60px;
}

[class*="btnType3"] {
    height: 50px;
    line-height: 50px;
    padding: 0 30px;
    font-weight: 600;
    color: #fff;
    text-align: center;
    background: #F5A9D0;
}

.btnWrap a {
	color: white;
	
}

<%-- 입력칸 --%>
table {
    width: 100%;
    border-collapse: collapse;
    border: 0;
    table-layout: fixed;
}

.tableTypeWrite th {
    padding: 24px 30px;
    border-bottom: 1px solid #F5F5F5;
    text-align: left;
    font-size: 14px;
    color: #333;
    vertical-align: top;
}

.tableTypeWrite td {
    padding: 20px 0;
    font-weight: 500;
    font-size: 16px;
    border-bottom: 1px solid #F5F5F5;
    color: #000;
}

td {
	text-align: left;
}

</style>
<div class="container text-center">
	<div class="row justify-content-md-center">
		<div class="col col-lg-2">
			<div id="navigation" style="padding-top: 60px;">
				<h1>
					<a class="side_menu"
						href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=my_order">주문내역</a>
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
			<h1 class="subTitle1">작성 가능한 리뷰</h1>
			<div class="tabType">
				<ul class="item2">
					<li class="active"><a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review"><span>작성 가능한 리뷰</span></a></li>
					<li class="active1"><a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review_list"><span>내가 작성한 리뷰</span></a></li>
				</ul>
			</div>
					
		<div class="mpCounselInfo"></div>

	<div style="text-align: right;">
		
	<div class="mbOutTop">	
<div class="tableType tb_review" id="reviewArea">

  





<script>
$("#reviewArea").removeClass();
$("#reviewArea").addClass('tableType tb_review');
</script>


	<div class="tableType tb_review">
	</div>


				</div>
		</div>
		
		<form id="writeform" name="writeform" method="post" action="/kr/ko/MypageCounselWriteProc.do" novalidate="novalidate">
						<input type="hidden" name="uppSeq" value="0">
						<input type="hidden" name="depth" value="0">
						<input type="hidden" name="subCd" value="">
						<input type="hidden" id="email" name="email" value="">
						<input type="hidden" id="mblNo" name="mblNo" value="">
						<input type="hidden" name="imgUrl" id="imgUrl" value="">
						<div class="tableTypeWrite">
							<table>
								<colgroup>
									<col style="width: 170px">
									<col>
								</colgroup>
								<tbody>
									<tr>
										<th scope="col">이름</th>
										<td class="ftColor2">김민준</td>
									</tr>
									<tr>
										<th scope="col">ID</th>
									</tr>
									<tr>
										<th scope="col">제목</th>
										<td>
											<input type="text" class="inputTxt" id="ttl" name="ttl" maxlength="30" placeholder="최대 30자 이내" style="width:70%;" title="상담 제목 입력">
										</td>
									</tr>
									<tr>
										<th scope="col">내용</th>
										<td>
											<!-- editor 영역 -->
											
											<textarea placeholder="상담내용 본문에는 개인정보를 입력하지 말아주세요. 
고객정보보호를 위해 마스킹 처리될 수 있습니다. 
(예 : 성명, 연락처, 이메일주소, 계좌번호 등)" name="cnt" id="cnt" style="width:70%; height:200px;"></textarea>
										</td>
									</tr>
									<tr>
										<th scope="col">첨부파일</th>
<!-- 									    <td class="orderSearchTd"> -->
<!-- 									    	<button type="button" class="btnType7m" onclick="attachFileClick();">사진첨부(최대 5개)</button> -->
<!-- 											<div class="prd"> -->
<!-- 				                                <ul class="pics"> -->
<!-- 				                                </ul> -->
<!-- 				                            </div> -->
<!-- 										</td> -->
										
										<td class="orderSearchTd">
											<label>
												<button type="button" class="btnType7m" onclick="attachFileClick();">사진첨부(최대 5개)</button>
											</label>
											<span id="file-name"></span>
											<span id="preview"></span>
											<span id="delete-file" style="color:red; margin-left:20px;">
												<i class="fas fa-times font-img"></i>
											</span>
										</td>
			                       </tr>
									
								</tbody>
							</table>
						</div>
						
						
					</form>
		<div class="btnWrap">
		<div class="btnType3l">
						<a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review_write">리뷰 쓰기</a>
					</div>
					</div>
					
		</div>
	</div>
</div>  
