<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"
	import="java.sql.*, shoppingTeam.*, java.text.SimpleDateFormat, java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>상품 추가 내역</title>
<style>
.title {
	align: center;
	text-align: center;
	background-color: #BDBDBD;
	color: white;
	height: 3vh;
}

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

.date {
	text-align: center;
	width: 98%;
	height: 98%;
}

.button {
	width: 100%;
	height: 100%;
}

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

}

</style>

</head>
<body>
	<table align=center>

		<tr>
			<th class="title" colspan=6>상품 추가 내역</th>
		</tr>

		<tr>
			<td>
				<p />
			</td>
		</tr>

		<tr>
			<form action="AddProductList.jsp" method="post">
				<%
					Date date = new Date();

					SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd");

					String c_date1 = time.format(date);
					String c_date2 = time.format(date);

					String between_A = (String) request.getParameter("between_A");
					String between_B = (String) request.getParameter("between_B");

					if (between_A != null && between_B != null) {
						c_date1 = between_A;
						c_date2 = between_B;
					}
				%>
				<th><input type="date" class="date" name="between_A"
					value="<%=c_date1%>"></th>
				<th>~</th>
				<th><input type="date" class="date" name="between_B"
					value="<%=c_date2%>"></th>
				<th><input type="submit" class="button" value="선택"></th>
			</form>
		</tr>

		<tr>
			<th class="head">관리자 ID</th>
			<th class="head">제품코드</th>
			<th class="head">제품명</th>
			<th class="head">추가 날짜</th>
		</tr>

		<%
			request.setCharacterEncoding("euc-kr");

			//DB.getConnection();
			ResultSet rs = DB.addProductList(between_A, between_B);

			ResultSetMetaData md = rs.getMetaData();
			int count = md.getColumnCount();
			String[] columns = new String[count];
			String[] columnTypes = new String[count];

			for (int i = 0; i < count; i++) {
				columns[i] = md.getColumnLabel(i + 1);
				columnTypes[i] = md.getColumnTypeName(i + 1);
			}

			while (rs.next()) {
				out.print("<tr class='content'>");
				out.print("<form action='Test.jsp' method='post'>");

				for (int i = 0; i < columns.length; i++) {

					Object obj = rs.getObject(columns[i]);

					if (i == 0)
						//out.print("<th name='pname'>"+ obj + "</th>");
						out.print("<th><input type='text' class='con_text' readonly name='pname' value='" + obj
								+ "'></th>");
					else {
						if (obj == null) // null 객체이면 null을 출력
							out.print("<th><input type='text' class='con_text' readonly value=' null '></th>");
						else if (columnTypes[i].equals("INTEGER") || columnTypes[i].equals("FLOAT")
								|| columnTypes[i].equals("DOUBLE") || columnTypes[i].equals("BIGINT"))
							out.print("<th><input type='text' class='con_text' readonly value='" + obj + "'></th>");
						else if (columnTypes[i].equals("VARCHAR") && ((String) obj).equals(""))
							out.print("<th><input type='text' class='con_text' readonly' value=' &nbsp; '></th>");
						else if (columnTypes[i].equals("VARCHAR"))
							out.print("<th><input type='text' class='con_text' readonly value='" + obj + "'></th>");
						else
							out.print("<th><input type='text' class='con_text' readonly value='" + obj + "'></th>");
					}
				}

				out.print("</tr>");
			}
		%>

	</table>
</body>
</html>