<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.sql.*, shoppingTeam.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>���� Ȯ�� Ȯ��</title>
</head>
<body>
	<%
		request.setCharacterEncoding("euc-kr");

			String bcode = (String) request.getParameter("bcode");
			String state = "��� �Ϸ�";

			//DB.getConnection();
			DB.updateState(bcode, state);
			
			state = "���� Ȯ��";
			//DB.closeConnection();
	%>
	<div style="text-align: center">

		<br />
		<br /> <br />
		<br /><%=bcode%>�� �ֹ� ��ǰ�� <%=state%>�Ǿ����ϴ�. <br />
		<br /> <input type="button" value="Ȯ��"
			onclick="location.href='changeStateUser.jsp'" />
	</div>

</body>
</html>