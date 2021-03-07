<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.sql.*, shoppingTeam.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>구매 취소</title>
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

.cancel {
	width: 98%;
	height: 100%;
}

.text {
	text-align: right;
	width: 98%;
	height: 98%;
}

.con_text {
	font-family: arial, sans-serif;
	text-align: center;
	width: 98%;
	height: 80%;
	border: 0;
	background-color: transparent;
}

.b_size {
	width:10%;
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

</style>

</head>
<body>

	<table align=center>

		<tr>
			<th class="title" colspan=8>구매 취소</th>
		</tr>

		<tr>
			<td>
				<p />
			</td>
		</tr>

		<tr>
			<th class="head">구매 코드</th>
			<th class="head">제품명</th>
			<th class="head">구매 개수</th>
			<th class="head">전체 가격</th>
			<th class="head">구매 날짜</th>
			<th class="head">배송 상태</th>
			<th class="head" colspan="2"></th>
		</tr>

		<%
			String id = (String) session.getAttribute("id");
			//DB.getConnection();
			ResultSet rs = DB.selectCancelBuy(id);

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
				out.print("<form action='cancelBuyConfirm.jsp' method='post'>");

				for (int i = 0; i < columns.length; i++) {

					Object obj = rs.getObject(columns[i]);

					if (i == 0)
						out.print("<th><input type='text' class='con_text' readonly name='bcode' value='" + obj
								+ "'></th>");
					else if (i == 1)
						out.print("<th><input type='text' class='con_text' readonly name='pname' value='" + obj
								+ "'></th>");
					else if (i == 2)
						out.print("<th><input type='text' class='con_text' readonly name='bnum' value='" + obj
								+ "'></th>");
					else if (i == 3)
						out.print("<th><input type='text' class='con_text' readonly name='buyprice' value='" + obj
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
		%>

		<th><input type="text" class="text" name="cancel_num"></th>
		<th class="b_size"><input type="submit" class="cancel" value="구매 취소"></th>
		</form>
		<%
			out.print("</tr>");
			}
			//DB.closeConnection();
		%>

	</table>
</body>
</html>