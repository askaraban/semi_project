<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<style type="text/css">

.class {
    margin_bottom: 60px;
    padding: 200px;
}

h2{
	margin-bottom: 35px;
}
    
</style>  
        
<div id='class'><h2>"구매가 완료되었습니다."</h2></div>

<a href="<%=request.getContextPath()%>/main_page/main.jsp">	
<button type="submit" >홈으로</button></a>

<a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=my_order">	
<button type="submit" >나의주문내역</button></a>