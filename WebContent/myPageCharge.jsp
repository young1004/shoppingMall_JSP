<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"
	import="java.sql.*, shoppingTeam.*, java.text.SimpleDateFormat, java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<title>����Ӵ� ����</title>
<style>

.title {
	align: center;
	text-align: center;
	background-color: #BDBDBD;
	color: white;
	height: 3vh;
}

.head {
	width:40%;
	background-color: #EAEAEA;
}

.text {
	 width:100%;
	 height:98%;
 }

.button {
	width: 100%;
	height: 100%;
}

th {
	border: 1px solid #dddddd;
	width: 50px;
	height: 3vh;
}

table {
	font-family: arial, sans-serif;
	border-collapse: collapse;
	width: 70%;
}

</style>

</head>
<body>

	<form action='myPageChargeConFirm.jsp' method='post'>

		<table align=center>
			<tr>
				<th class="title" colspan=5>���� �Ӵ� ����</th>
			</tr>
			<tr>
				<td>
					<p />
				</td>
			</tr>
			<tr>
			</tr>
			<tr class='content'>
				<th class="head">������ �ݾ�</th>
				<th><input type="text" class="text" size=20 name="add_account"></th>

			</tr>
			<tr>
				<td>
					<p/>
				</td>
			</tr>
		</table>

		<table align=center>
			<tr>
				<th><input type="submit" class="button" value="����"></th>
				<th><input type="reset" class="button" value="���"></th>
			</tr>
		</table>

	</form>
</body>
</html>