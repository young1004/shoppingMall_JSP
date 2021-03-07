<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.sql.*, shoppingTeam.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>구매 페이지</title>

<script>
	function goLogin() {
		alert('제품을 구매하시려면 회원으로 로그인 해주세요!!');
	}
</script>

<style>
.title {
	align: center;
	text-align: center;
	background-color: #BDBDBD;
	color: white;
	height: 3vh;
}

.head {
	width: 18%;
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

.text {
	text-align: center;
	width: 98%;
	height: 98%;
}

.button {
	width: 100%;
	height: 100%;
}

.preview {
	width: 50%;
	height: 12vh;
	overflow: hidden;
}

.image {<!--
	onload: image_auto_resize(this, 180, 180);
	onmouseover: image_auto_resize(this, 180, 180); -->
	width: 150px;
	height: 150px;
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

	<%
		//DB.getConnection();
		request.setCharacterEncoding("euc-kr");

		String pname = null;
		String pcode = null;
		pname = request.getParameter("pname");
		pcode = request.getParameter("pcode");

		if (pname == null)
			pname = DB.getPname(pcode);

		System.out.println(pname);
		int price = 0, stock = 0;
		ResultSet rs = DB.selectBProduct(pname);

		while (rs.next()) {
			pcode = rs.getString("pcode");
			price = rs.getInt("price");
			stock = rs.getInt("stock");
		}

		String chkID = (String) session.getAttribute("id");
		int U_flag = 0;
		int M_flag = 0;

		if (chkID != null) {
			U_flag = Integer.parseInt(session.getAttribute("U_flag").toString());
			M_flag = Integer.parseInt(session.getAttribute("M_flag").toString());
		}

		if (U_flag == 0) {
			out.println("<script>alert('제품을 구매하시려면 회원으로 로그인 해주세요!!');</script>");
		}
	%>
	<form method="post" action="buyConfirm.jsp" enctype="post">

		<table align=center>

			<tr>
				<th class="title" colspan=3>제품 구매</th>
			</tr>

			<tr>
				<td>
					<p />
				</td>
			</tr>


			<tr>
				<th rowspan=6 class="preview"><img src=img/<%=pcode%>
					class="image" /></th>
				<th class="head">제품명</th>
				<th><input type="text" class="con_text" size=20 name="pname"
					value="<%=pname%>" readonly></th>
			</tr>

			<tr>
				<th class="head">가격</th>
				<th><input type="text" class="con_text" size=20 name="price"
					value="<%=price%>" readonly></th>
			</tr>

			<tr>
				<th class="head">재고</th>
				<th><input type="text" class="con_text" size=20 name="stock"
					value="<%=stock%>" readonly></th>
			</tr>

			<tr>
				<th colspan=2 class="con_text">제품 구매시 3%의 포인트 적립 <br> (포인트
					사용시 적립되지 않습니다.) <br> (주문 취소시 포인트는 환불되지 않습니다.)
				</th>
			</tr>

			<tr>
				<th class="head">구매 개수</th>
				<th><input type="text" class="text" size=20 name="bnum"
					value="1"></th>
			</tr>

			<tr>
				<th class="head">포인트</th>
				<th><input type="text" class="text" size=20 name="point"
					value="0"></th>
			</tr>

			<tr>
				<td>
					<p />
				</td>
			</tr>
			<%
				if (U_flag == 1) {
					out.print(
							"<tr><th><input type=submit class=button size=40 value=구매 onclick=windows.location.reload></th>");
					out.print("<th colspan=2><input type=reset class=button size=40 value=취소></th></tr>");
				} else {
					out.print(
							"<tr><th><input type=submit class=button size=40 value=구매 onclick=windows.location.reload disabled></th>");
					out.print("<th colspan=2><input type=reset class=button size=40 value=취소 disabled></th></tr>");
					out.print("<tr><td><p/></td></tr>");
					out.print("<tr><th colspan=3 text-align='center'>제품을 구매하시려면 회원으로 로그인 해주세요!!</th></tr>");
				}

				//DB.closeConnection();
			%>

		</table>
	</form>
</body>
</html>