<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>개인정보 수정</title>

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
<form action="U_InfoChgConfirm.jsp" method="post">
<table align=center>

<tr>
<th class="title" colspan=2>
개인 정보 수정
</th>
</tr>

<tr>
<td>
<p/>
</td>
</tr>

<tr>
<th class="head">
PW
</th>
<th>
<input type="password" class="text" size=20 name="pw">
</th>
</tr>

<tr>
<th class="head">
PH
</th>
<th>
<input type="text" class="text" size=20 name="phone">
</th>
</tr>

<tr>
<td>
<p/>
</td>
</tr>



</table>

<table align=center width=50%>

<tr>
<th>
<input type="submit" class="button" size=40 value="수정">
</th>
<th>
<input type="reset" class="button" size=40 value="취소">
</th>
</tr>

</table>
</form>
</body>
</html>