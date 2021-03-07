<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>가입 페이지</title>

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
	height: 80%;
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

	<table align=center width=20%>
		<br>
		<tr>
			<th class="title">가입 종류 선택</th>
		<tr>
	</table>


	<table align=center width=50%>

		<tr>
			<td><form action="signUpUser.jsp">
				<input type="submit" value="사용자 회원가입"></form></td>
		</tr>
		
		<tr>
			<td><form action="signUpAdmin.jsp">
			<input type="submit" value="관리자 회원가입"></form></td>
		</tr>

		<tr>
			<td>
				<p />
			</td>
		</tr>

	</table>
</body>
</html>