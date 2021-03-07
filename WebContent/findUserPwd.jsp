<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, shoppingTeam.*, java.text.SimpleDateFormat, java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<title>사용자 비밀번호 찾기</title>
<script src="jquery.mobile/jquery-1.11.1.min.js"></script>
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

.user-ID{
	width: 100%;
	height: 98%;
}

.user-name{
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
			<th class="title">사용자 비밀번호 찾기</th>
		<tr>
		<tr>
			<td>
				<p/>
			</td>
		</tr>
	</table>
	
<form action="systemfindUserPwd.jsp"  method="post">
<table align=center width=40%>

<tr>
<th class="head">
ID
</th>
<th>
<input type="text" placeholder="dapanda01" class="user-ID" size=20 /><br />
</th>
</tr>
<tr>
<th class="head">
이름
</th>
<th>
<input type="text" placeholder="O O O" class="user-name" size=20 />
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
<input type="button" class ="button" size=20 value="확인" onClick="findPwd();">
</th>
<th>
<input type="button" class= "button" size=20 value="취소" onclick="location.href='loginUser.jsp'"/>
</th>
</tr>

</table>
</form>	

</body>

<script>
function findPwd() {
	var id = document.querySelector('.user-ID').value;
	var name = document.querySelector('.user-name').value;
	console.log(id, name);
	$.ajax({
	    url: "systemfindUserPwd.jsp", // 클라이언트가 요청을 보낼 서버의 URL 주소
	    type: "post",                             // HTTP 요청 방식(GET, POST)
	    data :{
	    	'id' : encodeURI(id),
	    	'name' : name
	    },
	    dataType : 'json',
		error : function(err) {
			var foundPwd = err.responseText.trim().substring(15, err.responseText.trim().length-2);
			if(foundPwd !== "null")
				alert('찾으시려는 비밀번호는 ' + foundPwd + ' 입니다.');
			else
				alert('해당되는 비밀번호가 존재하지 않습니다.');
		},
		success : function(data) {
			console.log('result : ', data);
		}
	})
}
</script>
</body>
</html>