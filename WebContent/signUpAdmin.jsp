<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>������ ����</title>

<style>
td {
	text-align: center;
	font-family: Georgia;
}

th {
	background-color: #D9E5FF;
	height: 3vh;
}

.title {
	align: center;
	text-align: center;
	background-color: #486AAE;
	color: white;
	height: 4vh;
}

.head {
	background-color: #B2CCFF;
}

.text {
	width: 100%;
	height: 98%;
}

.button {
	width: 100%;
	height: 100%;
}
</style>

</head>
<body>
	<br>
	<br>
	<br>
	<br>
	<table align=center width=7%>
		<th><a href="Main.jsp" target="_top"> <img
				src="img/home.jpg" width="100" height="100" />
		</a></th>
	</table>


	<form action="systemManagerSignUp.jsp" target="_top" method="post">
		<table align=center width=50%>

			<tr>
				<th class="title" colspan=2>������ ����</th>
			</tr>

			<tr>
				<td>
					<p />
				</td>
			</tr>

			<tr>
				<th class="head">ID</th>
				<th><input type="text" name="adminID" class="text" size=20 placeholder="dapanda01">
				</th>
			</tr>

			<tr>
				<th class="head">PW</th>
				<th><input type="password"  name="adminPassword" class="text" size=20
					placeholder="********"></th>
			</tr>

			<tr>
				<th class="head">�̸�</th>
				<th><input type="text" name="adminName" class="text" size=20 placeholder="ȫ�浿">
				</th>
			</tr>

			<tr>
				<th class="head">����</th>
				<th><input type="text" name="adminAge" class="text" size=20 placeholder="24">
				</th>
			</tr>

			<tr>
				<th class="head">��ȭ��ȣ</th>
				<th><input type="text" name="adminPhone" class="text" size=20
					placeholder="010-0000-0000"></th>
			</tr>

			<tr>
				<th class="head" size=20>����</th>
				<th><select style="width:100%;height:100%" name="adminGender">
						<option value="male">����</option>
						<option value="female">����</option>
				</select></th>
			</tr>

			<tr>
				<td>
					<p />
				</td>
			</tr>



		</table>

		<table align=center>

			<tr>
				<th><input type="submit" style="WIDTH: 70pt;" class="button" size=40 value="������ ����"
					></th>
				<th><input type="reset" style="WIDTH: 70pt;" class="button" size=40 value="���">
				</th>
			</tr>

		</table>
	</form>
</body>
</html>