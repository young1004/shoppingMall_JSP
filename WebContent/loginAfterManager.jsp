<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!doctype html>
<html lang="utf-8">
<head>
<meta charset="utf-8">
<title>�α��� bar</title>

</head>
<body>
	<%
		String mngID = (String) session.getAttribute("id");
	%>

	<table bgcolor="gray" width=100% style="text-align: right;">

		<tr>
			<th style="text-align: center"><%=mngID%> �����ڴ� �ȳ��ϼ���!!!</th>

			<th style="width: 50px;">
				<form action="managerMain.jsp" target="_top">
					<input type="submit" value="���� ������">
				</form>
			</th>

			<th style="width: 50px;">
				<form action="logOut.jsp" target="_top">
					<input type="submit" value="�α׾ƿ�">
				</form>
			</th>

		</tr>

	</table>

</body>
</html>