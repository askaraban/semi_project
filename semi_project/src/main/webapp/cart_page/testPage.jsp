<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String[] cartNumList = request.getParameterValues("cartNum");
	System.out.println(cartNumList);
	for(String cart : cartNumList){
		System.out.println(cart);
		
	}
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>