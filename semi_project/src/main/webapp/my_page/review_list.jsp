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
	background:#F5A9D0;;
}

<%-- 라인 --%>
.mbOutTop {
    padding: 70px 0 0;
    border-top: 3px solid #000;
}

<%-- 리뷰 목록 --%>
#review_title {
	font-size: 1.2em;
	font-weight: bold;
	margin: 60px;
}

<%-- 수정 삭제 --%>
.userIntro .n2 {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 10px;
}

<%-- 아이디 작성자 날짜 --%>
.userIntro .n2 .left {
    display: flex;
    align-items: center;
    font-size: 14px;
    letter-spacing: -0.01em;
}






.myReview_new .endProgress .summary {
    display: flex;
    align-items: center;
    padding: 40px 0 30px;
}

.userIntro .n2 {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 10px;
}




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
			<h1 class="subTitle1">내가 작성한 리뷰</h1>
			<div class="tabType">
				<ul class="item2">
					<li class="active"><a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review"><span>작성 가능한 리뷰</span></a></li>
					<li class="active1"><a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=review_list"><span>내가 작성한 리뷰</span></a></li>
				</ul>
			</div>
					
					
										<div id="review_title">리뷰 목록</div>

	<div style="text-align: right;">
		게시글갯수 : 
		<select id="reviewCount">
			<option value="10" <%  { %> selected <% } %>>&nbsp;10개&nbsp;</option>	
			<option value="20" <%  { %> selected <% } %>>&nbsp;20개&nbsp;</option>	
			<option value="50" <%  { %> selected <% } %>>&nbsp;50개&nbsp;</option>	
			<option value="100" <% { %> selected <% } %>>&nbsp;100개&nbsp;</option>	
		</select>
		&nbsp;&nbsp;&nbsp;
		
		
		
		
	<div class="mbOutTop">	
	<div class="tableType tb_review" id="reviewArea">
					
					
					
		</div>
		
<li>
					<!-- 상단 프로필과 제품 -->
					<div class="summary">
						<!-- 프로필 -->						
						<div class="userIntro">
							
								
								
									<div class="n2">
										<!-- 좌 -->
										<div class="left">
											<span class="name">kmi*******</span>
                                            <div class="age">홍길동</div>
                                            <div class="gomin">남성
	                                            
											</div>
                                            <!-- 날짜 FO 개선 : 위치변경 -->
                                            <span class="date">2023.05.03</span>
										</div>
										
										<!-- 우 -->
										<div class="right">
											<div class="btn_wrap">						
                                                <button type="button" class="mod" onclick="modifyProductReview('1946335')">수정</button>
                                                <button type="button" class="del" onclick="deleteProductReview('1946335', 'N')">삭제</button>
                                            </div>
										</div>
									</div>
								
								
						</div>
					</div>
					
					<!-- 포토 리스트 -->
					
						<div class="list_photo">							
							<ul>
								
									
										
																													
												
													<li>
														<div class="pImg">
															<a href="#" onclick="openProductReviewView('1946335','N')">
																<img src="https://images.innisfree.co.kr/upload/productReview/128665434382134310.jpeg" onerror="this.src='/kr/ko/resources/error/img/140x186.png'" alt="">
															</a>	
															
														</div>																			
													</li>
																						
											
										
										
									
														
							</ul>
						</div>
					
					
					<!-- 리뷰 텍스트 내용 -->					
					<div class="reviewCnt">
	                    <p class="rcTxt">
	                    	
								
								
									
									
									
								
							
							<!-- 20201027 미구매 리뷰 노출키워드 추가-->
							
							너무 좋아서 또 구입 했네요!! 여드름 직방
						</p>
                	</div>

					<!-- 제품-->
					<div class="vwProduct">
						<div class="reviewPro">
							
								
								
										
								
						</div>
					</div>
				</li>
                	
                	
	</div>
</div>  
