<%@page import="xzy.itwill.DAO.QaDAO"%>
<%@page import="xyz.itwill.DTO.QaDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="xyz.itwill.DTO.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="xzy.itwill.DAO.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
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

<%@include file="/security/login_check.jspf" %> 

<%
    //전달값을 반환받아 저장
    /*
    String replay=request.getParameter("replay"), pageNum="1", pageSize="5"
        , orderNum=request.getParameter("orderNum"), reviewSubject=request.getParameter("reviewSubject");
    int productNum=Integer.parseInt(request.getParameter("productNum"));
    int reviewNum=Integer.parseInt(request.getParameter("reviewNum"));
    */
    String pageNum="1", pageSize="10", search="", keyword=""; //페이지 검색 정보 유지 위해
    int qaNum=Integer.parseInt(request.getParameter("qaNum"));
    if(request.getParameter("qa_replay")!=null) {//전달값이 있는 경우 - 답글인 경우 부모글의 정보를 변수에 저장
        //부모글 관련 정보를 반환받아 저장
        //ref, restep, revlevel 제일 중요
        pageNum=request.getParameter("pageNum");
        pageSize=request.getParameter("pageSize");
        search=request.getParameter("search");
        keyword=request.getParameter("keyword");
    }
    //글번호를 전달받아 REVIEW 테이블의 단일행을 검색하여 게시글(ReviewDTO 객체)을 반환하는 
    //ReviewDAO 클래스의 메소드 호출
    //ReviewDTO review=ReviewDAO.getDAO().selectReviewTableByNum(reviewNum);
    QaDTO qa=QaDAO.getDAO().selectQaByNum(qaNum);
%>

<style type="text/css">
#qa_write {
   width: 500px;
   margin: 0 auto;
}

table {
   border: 1px solid black;
   border-collapse: collapse;
}

th {
   width: 100px;
   background: pink;
   color: gray;
   border: 1px solid gray;
}

td {
   text-align: left;
   border: 1px solid gray;
   width: 400px;
}

#qaContent{
   width: 400px;
}

#replay {
   width: 400px;
}

#qa_menu {
   text-align: right;

   margin: 5px;
}
</style>

<div id="qa_write">
    <h1>답글쓰기</h1>
    
    <form action="<%=request.getContextPath()%>/main_page/main.jsp?group=qa_page&worker=qa_replay_write_action" 
        method="post" id="qaForm">
        <input type="hidden" name="qaNum" value="<%=qaNum %>">
        <input type="hidden" name="pageNum" value="<%=pageNum %>">
        <input type="hidden" name="pageSize" value="<%=pageSize %>">
        <input type="hidden" name="search" value="<%=search %>">
        <input type="hidden" name="keyword" value="<%=keyword %>">
        <table>
            <tr>
                <th>작성자</th>
                <td>관리자</td>
            </tr>
            <tr>
                <th>내용</th>
                <td>
                    <textarea rows="7" cols="60" name="replay" id="replay"></textarea>
                </td>
            </tr>
        </table>
        
        <div id="qa_menu">
            <button type="submit">글저장</button>
            <button type="reset" id="resetBtn">다시쓰기</button>
        </div>
    </form>
</div>
<div id="message" style="color: red;"></div>

<script type="text/javascript">
$("#resetBtn").click(function() {
	$("#qaSubject").focus();
	$("#message").text("");
});
</script>