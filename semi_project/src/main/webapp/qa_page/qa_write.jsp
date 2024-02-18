<%@page import="xyz.itwill.DTO.ProductDTO"%>
<%@page import="xzy.itwill.DAO.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 사용자로부터 게시글(새글 또는 답글)을 입력받기 위한 JSP 문서 --%>
<%-- => 로그인 상태의 사용자만 요청 가능한 JSP 문서 --%>
<%-- => [글저장] 태그를 클릭한 경우 [/qa_page/qa_writer_action.jsp] 문서를 요청하여 페이지
이동 - 입력값(게시글) 전달 --%>

<%-- 새글 : [/review/review_list.jsp] 문서에 의해 JSP 문서를 요청한 경우 - 전달값 : X --%>
<%-- 답글 : [/review/review_detail.jsp] 문서에 의해 JSP 문서를 요청한 경우 - 전달값 : O --%>

<%-- 비로그인 상태의 사용자가 JSP 문서를 요청한 경우 에러페이지로 이동되도록 응답 처리 --%>
<%@include file="/security/login_check.jspf"%>

<%
	//전달값을 반환받아 저장 - 전달값이 없는 경우(새글) 변수에 초기값 저장
	String pageNum="1", pageSize="5";
	int reviewProductNum=Integer.parseInt(request.getParameter("reviewProductNum"));
	
	if(request.getParameter("qaReplay")!=null) {//전달값이 있는 경우 - 답글인 경우 부모글의 정보를 변수에 저장
		//부모글 관련 정보를 반환받아 저장
		pageNum=request.getParameter("pageNum");
		pageSize=request.getParameter("pageSize");
		reviewProductNum=Integer.parseInt(request.getParameter("reviewProductNum"));
	}
	
	ProductDTO product =  ProductDAO.getDAO().selectProductByNum(reviewProductNum);
%>

<style type="text/css">
#qa_write {
   width: 500px;
   margin: 0 auto;
}

.table_review {
   border: 1px solid black;
   border-collapse: collapse;
}

.th_review {
   width: 100px;
   background: pink;
   color: gray;
   border: 1px solid gray;
}

.td_review {
   text-align: left;
   border: 1px solid gray;
   width: 400px;
}

#qaContent{
   width: 400px;
}

#qa_menu {
   text-align: right;
   margin: 7px;
}

#resetBtn {
	height: 100%;
	margin-top: 10px;
	margin-bottom: 7px;
	background-color: rgb(239, 239, 239);
 	color: black;
 	font-weight: bold;
 	border-radius: 5px;
 	border: 1px solid gray;
}

#saveBtn {
	height: 100%;
	margin-top: 10px;
	margin-bottom: 7px;
	background-color: rgb(239, 239, 239);
 	color: black;
 	font-weight: bold;
 	border-radius: 5px;
 	border: 1px solid gray;
}
</style>

<div id="qa_write">
	<h1>Q&A 작성</h1>
	
	<%-- 파일(리뷰 이미지)을 입력받아 전달하기 위해 form 태그의 enctype 속성값을 반드시 [multipart/form-date]로 설정 --%>
	<form action="<%=request.getContextPath()%>/main_page/main.jsp?group=qa_page&worker=qa_writer_action"
		method="post" id="qaForm" enctype="multipart/form-data">
		<input type="hidden" name="pageNum" value="<%=pageNum %>">
		<input type="hidden" name="pageSize" value="<%=pageSize %>">
		<input type="hidden" name="productNum" value="<%=reviewProductNum %>">
		
		<table class="table_review">
			<tr>
				<th class="th_review">제목</th>
				<td class="td_review">
					<%
					  // 제품명 가져오기
					  String productName = product.getProductName();

					  // 제품명이 5글자 이상인지 확인하고, 필요에 따라 말 줄임 표시 추가
					  if (productName.length() > 9) {
					    productName = productName.substring(0, 9) + "..."; // 5글자 이상이면 말 줄임 표시 추가
					  }
					%>
					<input type="text" name="qaSubject" id="qaSubject" size="40" value="[<%= productName %>]">
				</td>					
			</tr>	
			<tr>
				<th class="th_review">내용</th>
				<td class="td_review">
					<textarea rows="7" cols="60" name="qaContent" id="qaContent"></textarea>
				</td>
			</tr>			
			<tr>
				<th class="th_review">이미지파일</th>
				<td class="td_review">
					<input type="file" name="qaImage">
				</td>
			</tr>
		</table>
		
		<div id="qa_menu">
			<button type="reset" id="resetBtn">다시쓰기</button>
			<button type="submit" id="saveBtn">저장</button>
		</div>
	</form>
</div>
<div id="message" style="color: red;"></div>

<script type="text/javascript">
$("#qaSubjest").focus();

$("#qaForm").submit(function() {
	if($("#qaSubjest").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#qaSubjest").focus();
		return false;
	}
	
	if($("#qaContent").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#qaContent").focus();
		return false;
	}
});

$("#resetBtn").click(function() {
	$("#qaSubjest").focus();
	$("#message").text("");
});
</script>