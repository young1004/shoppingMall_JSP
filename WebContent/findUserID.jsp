<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, shoppingTeam.*, java.text.SimpleDateFormat, java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<title>사용자 ID 찾기</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
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

.user-name{
	width: 100%;
	height: 98%;
}
.user-phone{
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
			<th class="title">사용자 ID 찾기</th>
		<tr>
		<tr>
			<td>
				<p/>
			</td>
		</tr>
	</table>
	
<form action="systemfindUserID.jsp"  method="post">
<table align=center width=40%>

<tr>
<th class="head">
이름
</th>
<th>
<input type="text" placeholder="dapanda01" class="user-name" size=20 /><br />
</th>
</tr>
<tr>
<th class="head">
전화번호
</th>
<th>
<input type="text" placeholder="010-0000-0000" class="user-phone" size=20 />
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
<input type="button" class="button" size=20 value="확인" onClick="findId();">
</th>
<th>
<input type="button" class="button" size=20 value="취소" onclick="location.href='loginUser.jsp'"/>
</th>
</tr>

</table>
</form>	

</body>

<script>
function findId() {
	var name = document.querySelector('.user-name').value;
	var phone = document.querySelector('.user-phone').value;
	console.log(name, phone);
	$.ajax({
	    url: "systemfindUserID.jsp", // 클라이언트가 요청을 보낼 서버의 URL 주소
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
</html>