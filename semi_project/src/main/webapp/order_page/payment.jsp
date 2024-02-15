<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <style>
        .body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            text-align: center;
            background-color: #fff;
            border-radius: 8px;
            padding: 40px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
            font-size: 28px;
            margin-bottom: 20px;
        }

        p {
            color: #666;
            margin-bottom: 30px;
            font-size: 18px;
        }
 
	
		.home {
			color: #fff;
            background-color: black;
            border: none;
            border-radius: 4px;
            padding: 10px 20px;
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.3s;
		}
		
		.home:hover{
			background-color: black;
		}
		
		.myorderBtn {
			color: #fff;
            background-color: black;
            border: none;
            border-radius: 4px;
            padding: 10px 20px;
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.3s;
		}
		
		.myorderBtn:hover{
			background-color: #0056b3;
		}
		
    </style>
    
    
<div class="body">
    <div class="container">
         <img
			alt="로고" src="<%=request.getContextPath()%>/images/icon/checked_icon_170.png"
			width="200" >
        <h1>구매가 완료되었습니다.</h1>
        <p>감사합니다! 주문하신 상품이 정상적으로 처리되었습니다.</p>
        <a href="<%=request.getContextPath()%>/main_page/main.jsp">	
			<button type="submit"  class="home">홈으로</button></a>
		
		<a href="<%=request.getContextPath()%>/main_page/main.jsp?group=my_page&worker=my_order">	
		<button type="submit"  class="myorderBtn">나의주문내역</button></a>
    </div>
</div>




	
