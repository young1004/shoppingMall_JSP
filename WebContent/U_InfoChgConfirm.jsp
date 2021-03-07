<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.sql.*, shoppingTeam.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>개인 정보 수정 확인</title>
</head>
<body>
	<%
		request.setCharacterEncoding("euc-kr");

			String id = (String) session.getAttribute("id");

			String pw = (String) request.getParameter("pw");
			String phone = (String) request.getParameter("phone");

			//DB.getConnection();
			DB.U_InfoChgConfirm(id, pw, phone);
			//DB.closeConnection();
	%>
	<div style="text-align:center">
		
		 <br/><br/> <br/><br/><%=id %>사용자 개인정보가 변경되었습니다. <br/><br/>

	<input type="button" value="확인" onclick="location.href='U_infochg.jsp'"/>
</div>
</body>
</html>