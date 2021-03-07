<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.sql.*, shoppingTeam.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>재고보충 확인</title>
</head>
<body>
	<%
		request.setCharacterEncoding("euc-kr");

		String id = (String) session.getAttribute("id");

		String pname = (String) request.getParameter("pname");
		int add_num = Integer.parseInt(request.getParameter("add_num"));

		String pcode = DB.getPcode(pname);

		//DB.getConnection();
		DB.updateProductOfStock(pname, add_num);
		DB.insertAddStock(id, pcode, add_num);
		//DB.closeConnection();
	%>

	<div style="text-align: center">

		<br /> <br /> <br /> <br /><%=pname%>상품의 재고보충이 완료되었습니다. <br /> <br />
		<input type="button" value="확인" onclick="location.href='AddStock.jsp'" />
	</div>
</body>
</html>