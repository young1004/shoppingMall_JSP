<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.sql.*, shoppingTeam.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>���� ��� Ȯ��</title>
</head>
<body>
	<%
	request.setCharacterEncoding("euc-kr");

	String id = (String) session.getAttribute("id");
	int bcode = Integer.parseInt(request.getParameter("bcode"));
	int bnum = Integer.parseInt(request.getParameter("bnum"));
	int price = Integer.parseInt(request.getParameter("buyprice")) / bnum;
	String pname = request.getParameter("pname");
	int cancel_num = Integer.parseInt(request.getParameter("cancel_num"));
	int sum = price * cancel_num;
	
	//DB.getConnection();
	
	String pcode = DB.getPcode(bcode); // bcode�� pcode�� ��������
	%>
	<div style="text-align: center">
		<br /> <br /> <br /> <br />
	<%
	if(cancel_num <= bnum){

		DB.minusBnum(bcode, cancel_num); // ���� ���̺��� ���� ����
		DB.minusBuyPrice(bcode, sum); // �� ���Ű��� ����
		DB.insertCBuy(id, pcode, bcode, cancel_num); // ���� ��� ���̺� ��Ҹ�� ����

		if (DB.deleteZeroProduct())
			out.print(pname + " ��ǰ�� ��ü ��ҵǾ����ϴ�.<br>");
		else
			out.print(pname + " ��ǰ�� " + cancel_num + "�� ��ŭ ���� ��ҵǾ����ϴ�.<br>");

		
		DB.plusAccount(id, sum); // ����Ӵ� �߰�
		DB.plusStock(pname, cancel_num); // ��� + ���� ����
		
	}
	else{
		out.print("���� ���� �̻����� ����� �� �����ϴ�.");
	}
	//DB.closeConnection();
	%>
	<form action="myPageHome.html" target='_top'>
		<br /> <br /> <input type="submit" value="Ȯ��">
	</form>
	</div>
</body>
</html>