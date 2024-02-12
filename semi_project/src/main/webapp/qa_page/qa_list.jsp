<%@page import="xzy.itwill.DAO.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/style/review_list_style.css" type="text/css" rel="stylesheet">
<%
	// 제품번호 가져옴
	int reviewProductNum = Integer.parseInt(request.getParameter("productNum"));

	// REVIEW_TABLE에 저장된 제품별 리뷰의 count(갯수)를 반환하는 메소드 호출
	int productReview=ReviewDAO.getDAO().selectReviewCountByProductNum(reviewProductNum);
%>
<%@include file="/product_page/product_listArea.jspf" %>
<div id="qa_list">
	<%-- 검색된 게시글 총갯수 출력 --%>
	<div id="review_title">Q&A목록(갯수)</div>
	
	<div style="text-align: right;">
		게시글갯수 : 
		<select id="reviewCount">
			<option value="10">&nbsp;10개&nbsp;</option>	
			<option value="20">&nbsp;20개&nbsp;</option>	
			<option value="50">&nbsp;50개&nbsp;</option>	
			<option value="100" >&nbsp;100개&nbsp;</option>	
		</select>
		&nbsp;&nbsp;&nbsp;
		<button type="button" id="writeBtn">글쓰기</button>
	</div>
	
	<%-- 게시글 목록 출력 --%>
	<table>
		<tr>
			<th width="100">글번호</th>
			<th width="500">제목</th>
			<th width="100">작성자</th>
			<th width="100">조회수</th>
			<th width="200">작성일</th>
		</tr>
		<tr id="nolist">
			<td colspan="5">검색된 게시글이 없습니다.</td>
		</tr>
	</table>
	
	<%-- 페이지번호 출력 및 링크 제공 - 블럭화 처리 --%>
	<%

	%>
	
	<div id="page_list">
		<%-- 이전 페이지블럭이 있는 경우에만 링크 제공 --%>
		[이전]
		<%-- 요청 페이지번호와 출력된 페이지번호가 같지 않은 경우에만 링크 제공 --%>
		<a href="#">[i]</a>
		
		<%-- 다음 페이지블럭이 있는 경우에만 링크 제공 --%>
		<a href="">[다음]</a>
	</div>
	
	<%-- 사용자로부터 검색 관련 정보를 입력받기 위한 태그 출력 --%>
	<%

	%>
</div>
