<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"
    import="java.sql.*, shoppingTeam.*" %>
<!doctype html>
<html lang="utf-8">
<head>
	<meta charset="utf-8">
	<title>�α��� bar</title>

</head>
<body >
<%
	String csmID = (String)session.getAttribute("id"); 
	int account = 0;
	int point = 0;

	//DB.getConnection();

	ResultSet rs = DB.selectConsumer(csmID);

	while(rs.next()) {
		account = rs.getInt("account");
		point = rs.getInt("point");
	}
	//DB.closeConnection();
%>
<table bgcolor="gray" width=100% style="text-align:right; ">

   <tr>
          <th style=""><%= csmID%>�� �ȳ��ϼ���!!!</th>
          <th style="">�ܿ� �Ӵ� : <%=account %></th>
          <th style="">�ܿ� ����Ʈ : <%=point %></th>
          <th style="width: 50px;">
<th style="width: 50px;">
<form action="myPageHome.html" target="_top">
<input type="submit" value="���� ������">
</form>
</th>

<th style=" width: 50px;">
<form action="logOut.jsp"target="_top">
<input type="submit" value="�α׾ƿ�">
 </form>
</th>
        </tr>

</table>

</body>
</html>