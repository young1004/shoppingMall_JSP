<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�α׾ƿ� ó�� ������</title>
</head>
<body>
<%
    session.invalidate();
	System.out.println("�α׾ƿ�");

    response.sendRedirect("Main.jsp");
%>
</body>
</html>