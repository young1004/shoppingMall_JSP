<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, shoppingTeam.*, java.text.SimpleDateFormat, java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<title>관리자 ID 찾기</title>

<meta http-equiv="content-type" content="text/html; charset=utf-8">
<script src="jquery.mobile/jquery-1.11.1.min.js"></script>
 <link href="style.css" rel="stylesheet" type="text/css">

<style>
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

.admin-name{
	width: 100%;
	height: 98%;
}

.admin-phone{
	width: 100%;
	height: 98%;
}

.button {
 	width: 100%;
	height: 100%;
}

th {
	background-color: #D9E5FF;
	width: 50px;
	height: 4vh;
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
	
	<table align=center width=40%>
		<tr>
			<th class="title">관리자 ID 찾기</th>
		<tr>
		<tr>
			<td>
				<p/>
			</td>
		</tr>
	</table>
	
<form action="systemfindAdminID.jsp"  method="post">
<table align=center width=40%>

<tr>
<th class="head">
이름
</th>
<th>
<input type="text" placeholder="dapanda01" class="admin-name" size=20 /><br />
</th>
</tr>
<tr>
<th class="head">
전화번호
</th>
<th>
<input type="text" placeholder="010-0000-0000" class="admin-phone" size=20 />
</th>
</tr>

<tr>
<td>
<p/>
</td>
</tr>



</table>

<table align=center width=40%>

<tr>
<th>
<input type="button" class="button"  size=20 value="확인" onClick="findId();">
</th>
<th>
<input type="button" class="button" size=20 value="취소" onclick="location.href='loginAdmin.jsp'"/>
</th>
</tr>

</table>
</form>	

</body>
<script>
function findId() {
	var name = document.querySelector('.admin-name').value;
	var phone = document.querySelector('.admin-phone').value;
	console.log(name, phone);
	$.ajax({
	    url: "systemfindAdminID.jsp", // 클라이언트가 요청을 보낼 서버의 URL 주소
	    type: "post",                             // HTTP 요청 방식(GET, POST)
	    data :{
	    	'name' : encodeURI(name),
	    	'phone' : phone
	    },
	    dataType : 'json',
		error : function(err) {
			var foundId = err.responseText.trim().substring(14, err.responseText.trim().length-2);
			if(foundId !== "null")
				alert('찾으시려는 아이디는 ' + foundId + ' 입니다.');
			else
				alert('해당되는 아이디가 존재하지 않습니다.');
		},
		success : function(data) {
			console.log('result : ', data);
		}
	})
}
</script>
</html>
<%-- 
 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, shoppingTeam.*, java.text.SimpleDateFormat, java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<title>관리자 로그인</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<script src="jquery.mobile/jquery-1.11.1.min.js"></script>
<style>

table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #dddddd;
}
</style>
</head>
<body>
<!-- 헤더 -->
	<div data-role="header" data-fullscreen="true" data-position="fixed">
		<h1 class="demoHeaders">관리자 아이디 찾기</h1>
		<a href="Main.jsp"><img src="img/home.jpg" width="20" height="20" /></a>
		
	</div>

	<!-- 푸터 -->
	<div data-role="footer" data-fullscreen="true" data-position="fixed" style="background-color: #E0E6F8;">
            <h4 class="ui-title">다판다에 오신 것을 환영합니다!</h4>        </div>


	<!-- 컨테이너 -->
	<div class="container" style=" margin-top:10%; position:absolute; left: 50%; transform: translateX(-50%);">
<!-- 위쪽 까지 기본 틀(헤더, 푸터, 왼쪽 패널)------------------------------------------------- -->

			<h1>관리자 ID 찾기</h1>
			<fieldset>
					이름 : <input type="text" placeholder="dapanda01" class="admin-name"/><br />
					전화번호 : <input type="text" placeholder="010-0000-0000" class="admin-phone"/>
					
			</fieldset>	<br />
			<input type="button" value="확인" onclick="findId();"/>
			<input type="button" value="취소" onclick="location.href='loginAdmin.jsp'"/>
</div>





<!-- 아래로 지우면 안됨 -->
	</div>

<script>
function findId() {
	var name = document.querySelector('.admin-name').value;
	var phone = document.querySelector('.admin-phone').value;
	console.log(name, phone);
	$.ajax({
	    url: "systemfindAdminID.jsp", // 클라이언트가 요청을 보낼 서버의 URL 주소
	    type: "post",                             // HTTP 요청 방식(GET, POST)
	    data :{
	    	'name' : encodeURI(name),
	    	'phone' : phone
	    },
	    dataType : 'json',
		error : function(err) {
			var foundId = err.responseText.trim().substring(14, err.responseText.trim().length-2);
			if(foundId !== "null")
				alert('찾으시려는 아이디는 ' + foundId + ' 입니다.');
			else
				alert('해당되는 아이디가 존재하지 않습니다.');
		},
		success : function(data) {
			console.log('result : ', data);
		}
	})
}
</script>
</body>
</html>  --%>