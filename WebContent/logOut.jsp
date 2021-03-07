<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>로그아웃 처리 페이지</title>
</head>
<body>
<%
    session.invalidate();
	System.out.println("로그아웃");

    response.sendRedirect("Main.jsp");
%>
</body>
</html>