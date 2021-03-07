<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"
	import="java.sql.*, shoppingTeam.*, java.text.SimpleDateFormat, java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<title>가상머니 충전 완료</title>

</head>

<body>
	<%
		request.setCharacterEncoding("euc-kr");

		String id = (String) session.getAttribute("id");

		int add_account = Integer.parseInt(request.getParameter("add_account"));
		//int account =  DB.getAccount(id);

		//DB.getConnection();
		DB.updateAccount(add_account, id);
		//DB.insertAddAccount(id,account, add_account);

		int account = DB.getAccount(id);
		//DB.closeConnection();
	%>

	<div style="text-align: center">

		<br />
		<br /> <br />
		<br /><%=id%>님의 가상머니
		<%=add_account%>만큼 충전이 완료되었고 현재 잔액은
		<%=account%>입니다. <br />
		<br />
		<form action="myPageHome.html" target='_top'>
			<input type="submit" value="확인">
		</form>
	</div>
</body>
</html>