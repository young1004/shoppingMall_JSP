<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!doctype html>
<html lang="utf-8">
<head>
<meta charset="utf-8">
<title>로그인 bar</title>

</head>
<body>
	<%
		String mngID = (String) session.getAttribute("id");
	%>

	<table bgcolor="gray" width=100% style="text-align: right;">

		<tr>
			<th style="text-align: center"><%=mngID%> 관리자님 안녕하세요!!!</th>

			<th style="width: 50px;">
				<form action="managerMain.jsp" target="_top">
					<input type="submit" value="관리 페이지">
				</form>
			</th>

			<th style="width: 50px;">
				<form action="logOut.jsp" target="_top">
					<input type="submit" value="로그아웃">
				</form>
			</th>

		</tr>

	</table>

</body>
</html>