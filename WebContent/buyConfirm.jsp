<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.sql.*, shoppingTeam.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>��ǰ ����</title>
</head>
<body>
	<%
		request.setCharacterEncoding("euc-kr");

			String id = (String) session.getAttribute("id");

			String pname = (String) request.getParameter("pname");
			int price = Integer.parseInt(request.getParameter("price"));
			int stock = Integer.parseInt(request.getParameter("stock"));
			int bnum = Integer.parseInt(request.getParameter("bnum"));
			int point = Integer.parseInt(request.getParameter("point"));

			String pcode = DB.getPcode(pname);

			int userAccount = 0;
			int userPoint = 0;
			int buyPrice = price * bnum;
			boolean balanceCheck = false;
			boolean stockCheck = false;

			//DB.getConnection();

			ResultSet rs = DB.selectConsumer(id);

			while (rs.next()) {
		userAccount = rs.getInt("account");
		userPoint = rs.getInt("point");
			}

			if (point == 0) {
		if (userAccount >= buyPrice) {
			balanceCheck = true;
			
			if (stock >= bnum) {
				DB.minusStock(pname, bnum); //��� ���̳ʽ�
				DB.buyRecord(id, pcode, bnum, buyPrice); //��ǰ ���ų��� ���
				DB.buyProduct(id, buyPrice, point); //��ǰ ���ſ� ���� ���� ���
				DB.pointRecord(id, pname, point, buyPrice); //����Ʈ ���/���� ���
				stockCheck = true;
			}
		} else {
			System.out.println("���źҰ�");
		}
			} else {
		if ((userAccount + userPoint) >= buyPrice && userPoint >= point) {
			balanceCheck = true;
			
			if (stock >= bnum) {
				DB.minusStock(pname, bnum); //��� ���̳ʽ�
				DB.buyRecord(id, pcode, bnum, buyPrice); //��ǰ ���ų��� ���
				DB.buyProduct(id, buyPrice, point); //��ǰ ���ſ� ���� ���� ���
				DB.pointRecord(id, pname, point, buyPrice); //����Ʈ ���/���� ���
				stockCheck = true;
			}
		} else
			System.out.println("���źҰ�");//���źҰ�
			}
	%>


	<div style="text-align: center">

		<br /> <br /> <br /> <br />
		<%
			if (balanceCheck == true && stockCheck == true) {
				out.print(pname + " ��ǰ�� ���ŵǾ����ϴ�.<br>");

				if (point == 0) {
					out.print(buyPrice + "���� ����Ͽ����ϴ�.<br>");
					out.print("����Ʈ" + Math.floor(buyPrice * 0.03) + "���� �����Ǿ����ϴ�.");
				} else if (point != 0) {
					out.print((buyPrice - point) + "���� ����Ͽ����ϴ�.<br>");
					out.print("����Ʈ" + point + "���� ���Ǿ����ϴ�.");
				}
			}
			else if(balanceCheck == false)
				out.print(id + "ȸ������ �ܿ��Ӵ� �� �ܿ�����Ʈ�� �����Ͽ� ���Ű� �Ұ��մϴ�.<br>");
			else if(stockCheck == false)
				out.print(pname + " ��ǰ�� ��� �����Ͽ� ���Ű� �Ұ��մϴ�.<br>");
		
		//DB.closeConnection();
		%>
		<br /> <br /> <input type="button" value="Ȯ��"
			onclick="location.href='content.jsp'" />
	</div>
</body>
</html>