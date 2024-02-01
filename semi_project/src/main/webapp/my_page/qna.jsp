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
	color: blue;
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

<%-- 내가 쓴 Q&A --%>
[class*="logo1"] {
    margin: 60px 0 50px;
    font-weight: 600;
    font-size: 24px;
    line-height: 32px;
    text-align: left;

}

[class*="tableHeadTxt"] {
    margin: 60px 0 50px;
    font-weight: 600;
    font-size: 12px;
    line-height: 32px;
    text-align: left;


</style>
<div class="container text-center">
	<div class="row justify-content-md-center">
		<div class="col col-lg-2">
			<div id="navigation">
				<h1>
					<a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=order">주문내역</a>
				</h1>
				<h2>
					<a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review">리뷰</a>
				</h2>
				<h3>
					<a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=qna">Q&A</a>
				</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=password_confirm&action=modify">회원정보</a>
				</h4>
			</div>
		</div>
		
		<div class="col col-lg-10">
			<h2 class="logo1">내가 쓴 Q&A</h2>		
			<p class="tableHeadTxt">고객님이 문의하신 내용에 대한 처리 결과입니다.<br>
						<span class="sub ftColor7">(고객님께서 적어주신 문의글에 개인정보가 포함된 경우, 고객정보보호를 위해 마스킹처리가 될 수 있습니다.)</span>
					</p>
					<div id="counselList">
						
<div class="tableType noLine2">
	<table>
	<caption>1:1 상담내역</caption>
	<colgroup>
		<col style="width:100px;">
		<col>
		<col style="width:170px;">
		<col style="width:170px;">
	</colgroup>
	<thead>
		<tr>
			<th scope="col">No.</th>
			<th scope="col">제목</th>
			<th scope="col">작성일</th>
			<th scope="col">처리현황</th>
		</tr>
	</thead>
	<tbody>
		
		
			<tr>
				<td colspan="4" class="nonList">
					검색된 문의내역이 없습니다.
				</td>
			</tr>			
				
		</tbody>
	</table>
</div>
	
<!-- paging -->

<!-- //paging -->	


<script type="text/javascript">
$(function(){
	$('.tableStyle1 .question a').on('click', function(){
		if (!$(this).parents('.question').hasClass('open'))
		{
			$('.tableStyle1 .question').removeClass('open');
			$('.tableStyle1 .answer').hide();
		}
		$(this).parents('.question').toggleClass('open').next('.answer').toggle();
		return false;
	});
});
</script>


			
					</div>
				<ul>
					<li>
			
			
		</div>
	</div>
</div> 

