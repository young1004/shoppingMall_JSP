<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.sql.*"%>
<%@ page import="shoppingTeam.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script src="jquery.mobile/jquery-1.11.1.min.js"></script>
<title>로그인 페이지</title>
<style>
.title {
	align: center;
	text-align: center;
	background-color: #486AAE;
	color: white;
	height: 4vh;
}

.button {
	width: 100%;
	height: 100%;
}

th {
	background-color: #D9E5FF;
	width: 50px;
	height: 3vh;
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
	<table align=center width=25%>
		<br>
		<tr>
			<th class="title">다판다에 오신것을 환영합니다</th>
		<tr>
	</table>
	<table align=center width=15%>
		<tr>
			<th>
				<form action="loginUser.jsp">
					<input type="submit" class="button" value="사용자 로그인">
				</form>
			</th>
		<tr>
		<tr>
			<th>
				<form action="loginAdmin.jsp">
					<input type="submit" class="button" value="관리자 로그인">
				</form>
			</th>
		</tr>
	</table>


</body>
</html>