<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.sql.*"%>
<%@ page import="shoppingTeam.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>배송 현황 보기</title>
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
	width: 70%;
}
</style>

</head>
<body>
	<table align=center width=70%>
		<tr>
			<th class="title" colspan=9>포인트 현황 보기</th>
		</tr>
		
		<tr>
			<td>
				<p />
			</td>
		</tr>
		
		<tr>
			<form action="myPagePoint.jsp" method="post">
				<%
					request.setCharacterEncoding("euc-kr");
					Date date = new Date();

					SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd");

					String c_date1 = time.format(date);
					String c_date2 = time.format(date);
					String status = "전체";

					String between_A = (String) request.getParameter("between_A");
					String between_B = (String) request.getParameter("between_B");
					String temp = (String) request.getParameter("state");

					if (between_A != null && between_B != null) {
						c_date1 = between_A;
						c_date2 = between_B;
					}

					if (temp != null)
						status = temp;
				%>
				
				<th colspan=3><input type="date" class="date" name="between_A"
					value="<%=c_date1%>"></th>
				<th>~</th>
				<th colspan=3><input type="date" class="date" name="between_B"
					value="<%=c_date2%>"></th>
				<th><select name="state" class="button">
						<%
							if (status.equals("전체"))
								out.print("<option selected=selected>전체</option>");
							else
								out.print("<option>전체</option>");

							if (status.equals("적립"))
								out.print("<option selected=selected>적립</option>");
							else
								out.print("<option>적립</option>");
							if (status.equals("사용"))
								out.print("<option selected=selected>사용</option>");
							else
								out.print("<option>사용</option>");
						%>
				</select></th>
				<th><input type="submit" class="button" value="검색"></th>
			</form>
		</tr>
		
		<tr>
			<th class="head" colspan=3>적립/사용 날짜</th>
			<th class="head" colspan=3>포인트</th>
			<th class="head" colspan=3>적립/사용 여부</th>
		</tr>

		<%
			String id = (String) session.getAttribute("id");
			request.setCharacterEncoding("euc-kr");
			String poiSt = status;

			//DB.getConnection();
			ResultSet rs = DB.selectPointStatus(id, poiSt, between_A, between_B);

			ResultSetMetaData md = rs.getMetaData();
			int count = md.getColumnCount();
			String[] columns = new String[count];
			String[] columnTypes = new String[count];

			for (int i = 0; i < count; i++) {
				columns[i] = md.getColumnLabel(i + 1);
				columnTypes[i] = md.getColumnTypeName(i + 1);
			}

			while (rs.next()) {
				out.print("<tr>");
				out.print("<form action='showPointStatus.jsp' method='post'>");

				for (int i = 0; i < columns.length; i++) {

					Object obj = rs.getObject(columns[i]);

					if (obj == null) // null 객체이면 null을 출력
						out.print("<th colspan=3><input type='text' class='con_text' readonly value=' null '></th>");
					else if (columnTypes[i].equals("INTEGER") || columnTypes[i].equals("FLOAT")
							|| columnTypes[i].equals("DOUBLE") || columnTypes[i].equals("BIGINT"))
						out.print(
								"<th colspan=3><input type='text' class='con_text' readonly value='" + obj + "'></th>");
					else if (columnTypes[i].equals("VARCHAR") && ((String) obj).equals(""))
						out.print("<th colspan=3><input type='text' class='con_text' readonly' value=' &nbsp; '></th>");
					else if (columnTypes[i].equals("VARCHAR"))
						out.print(
								"<th colspan=3><input type='text' class='con_text' readonly value='" + obj + "'></th>");
					else
						out.print(
								"<th colspan=3><input type='text' class='con_text' readonly value='" + obj + "'></th>");
				}

				out.print("</tr>");
			}
			//DB.closeConnection();
		%>

	</table>
</body>
</html>