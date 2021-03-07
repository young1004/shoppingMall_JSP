<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.sql.*, shoppingTeam.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>물품명으로 검색</title>
<style>
.head {
	background-color: #EAEAEA;
}

.con_text {
	font-family: arial, sans-serif;
	text-align: center;
	width: 98%;
	height: 80%;
	border: 0;
	background-color: transparent;
}

.image {width:70px;height:70px;}

th {
	border: 1px solid #dddddd;
	width: 50px;
	height: 3vh;
}

table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 80%;
}

</style>
</head>
<body>

<table align=center>

<tr>
<th class="head">상품 이미지</th>
<th class="head">제품명</th>
<th class="head">가격</th>
</tr>

<%
	//DB.getConnection();
	request.setCharacterEncoding("euc-kr");
	String pname = request.getParameter("pname");
	ResultSet rs = DB.searchNameProduct(pname);
	
	ResultSetMetaData md = rs.getMetaData();
	int count = md.getColumnCount();
	String[] columns = new String[count];
	String[] columnTypes = new String[count];
	
	for(int i=0; i<count; i++){
		columns[i] = md.getColumnLabel(i+1);
		columnTypes[i] = md.getColumnTypeName(i+1);
	}

	while(rs.next()) {
		out.print("<tr class='content'>" );
		out.print("<form action='buyPage.jsp' method='post'>" );

		for(int i=0; i<columns.length; i++){
	Object obj= rs.getObject(columns[i]);
	if(i == 0){//상품 추가 관련: 한 페이지에 상품 내용을 바꿔서 띄워야 함
		
		//out.print("<th> <a href=buyPage.jsp> <img src=img/" + obj + ".jpg width=70 height=70/> </th>");
		out.print("<th><input type='image' class='image' src='img/" + obj + "'</th>");
	}
	else if(i == 1) {
		out.print("<th><input type='text' class='con_text' readonly name='pname' value='"+ obj + "'></th>");
	}
	else if(i == 2) {
		out.print("<th><input type='text' class='con_text' readonly name='price' value='"+ obj + "'></th>");
	}
		}
		
%>

</form>
<%	
		out.print("</tr>" );
	}
	//DB.closeConnection();
%>

</table>
</body>
</html>