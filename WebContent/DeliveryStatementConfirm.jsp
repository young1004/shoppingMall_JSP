<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.sql.*, shoppingTeam.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>��� ��� Ȯ��</title>
</head>
<body>
	<%
		request.setCharacterEncoding("euc-kr");
			String id = (String)session.getAttribute("id");
			//String id = "mng01";
			String bcode = (String) request.getParameter("bcode");
			String state = "��� ��";
			
		//DB.getConnection();
		DB.updateState(bcode,state);
		//DB.closeConnection();
	%>
<div style="text-align:center">
		
		 <br/><br/> <br/><br/><%=bcode%>�� �ֹ� ��ǰ�� *<%=state%>*(��)�� �����Ͽ����ϴ�. <br/><br/>

	<input type="button" value="Ȯ��" onclick="location.href='DeliveryStatement.jsp'"/>
</div>
</body>
</html>