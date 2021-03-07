<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>관리자 로그인</title>

<style>
td {
	text-align: center;
	font-family: Georgia;
}

th {
	background-color: #D9E5FF;
	height: 4vh;
}

.title {
	align: center;
	text-align: center;
	background-color: #486AAE;
	color: white;
	height: 4vh;
}

.head {
	width:35%;
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

.find {
	background-color: transparent;
}

</style>

</head>
<body>
	<br>
	<br>
	<br>
	<br>
		<% request.setCharacterEncoding("euc-kr");
	String chkLogin = (String)session.getAttribute("ML_flag");
	if(chkLogin != null){
		out.println("<script type=text/javascript> alert('정확한 ID/PW를 입력해주세요')</script>");
		session.setAttribute("L_flag", null);
	}
	%>
	<table align=center width=7%>
		<th><a href="Main.jsp" target="_top"> <img
				src="img/home.jpg" width="100" height="100" />
		</a></th>
	</table>


	<form action="systemManagerLogin.jsp" target="_top" method="post">
		<table align=center width=40%>

			<tr>
				<th class="title" colspan=2>관리자 로그인</th>
			</tr>

			<tr>
				<td>
					<p />
				</td>
			</tr>

			<tr>
				<th class="head">ID</th>
				<th><input type="text" class="text" size=20 name="adminID" placeholder="dapanda01">
				</th>
			</tr>

			<tr>
				<th class="head">PW</th>
				<th><input type="password" class="text" size=20 name="adminPassword" placeholder="********"></th>
			</tr>
			<tr>
				<td>
					<p />
				</td>
			</tr>



		</table>

		<table align=center width=40%>

			<tr>
				<th width=50%><input type="submit" class="button" size=40 value="로그인">
				</th>
				<th width=50%><input type="reset" class="button" size=40 value="취소">
				</th>
			</tr>
		</table>
		<table align=center width=20%>
			<tr>
				<th class="find"><a href="findAdminID.jsp">아이디 찾기</a></th>
				<th class="find"><a href="findAdminPwd.jsp">비밀번호 찾기</a></th>
			</tr>

		</table>
	</form>
</body>
</html>