<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.sql.*, shoppingTeam.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>배송 출발 확인</title>
</head>
<body>
	<%
		request.setCharacterEncoding("euc-kr");
			String id = (String)session.getAttribute("id");
			//String id = "mng01";
			String bcode = (String) request.getParameter("bcode");
			String state = "배송 중";
			
		//DB.getConnection();
		DB.updateState(bcode,state);
		//DB.closeConnection();
	%>
<div style="text-align:center">
		
		 <br/><br/> <br/><br/><%=bcode%>번 주문 상품이 *<%=state%>*(으)로 변경하였습니다. <br/><br/>

	<input type="button" value="확인" onclick="location.href='DeliveryStatement.jsp'"/>
</div>
</body>
</html>