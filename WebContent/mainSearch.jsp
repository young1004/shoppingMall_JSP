<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<html>
<head>
<meta charset="EUC-KR">
<title>Main Saerch</title>
</head>
<body>
<!--bgcolor="#000000"-->
<table bgcolor="#000000" width=100% height=90vh>
<tr>
<th align=center width=30%>
<a href="Main.jsp" target="_top">
<img src="img/home.jpg" width="70" height="70"/>
</a>
</th>
<th align=center width=70%>
<form action="search.jsp" method='post' target="iframeContent">
<input type=text name="pname" style="width:500px;height:30px;">
&nbsp;
<input type="submit" value="검색">
</form>
</th>

<th width=5%>
</th>

</tr>
</table>
</body>
</html>