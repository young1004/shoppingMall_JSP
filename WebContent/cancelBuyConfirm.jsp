<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.sql.*, shoppingTeam.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>구매 취소 확인</title>
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
	
	String pcode = DB.getPcode(bcode); // bcode의 pcode값 가져오기
	%>
	<div style="text-align: center">
		<br /> <br /> <br /> <br />
	<%
	if(cancel_num <= bnum){

		DB.minusBnum(bcode, cancel_num); // 구매 테이블의 개수 변경
		DB.minusBuyPrice(bcode, sum); // 총 구매가격 변경
		DB.insertCBuy(id, pcode, bcode, cancel_num); // 구매 취소 테이블에 취소목록 삽입

		if (DB.deleteZeroProduct())
			out.print(pname + " 상품이 전체 취소되었습니다.<br>");
		else
			out.print(pname + " 상품이 " + cancel_num + "개 만큼 구매 취소되었습니다.<br>");

		
		DB.plusAccount(id, sum); // 가상머니 추가
		DB.plusStock(pname, cancel_num); // 재고 + 구매 개수
		
	}
	else{
		out.print("구매 개수 이상으로 취소할 수 없습니다.");
	}
	//DB.closeConnection();
	%>
	<form action="myPageHome.html" target='_top'>
		<br /> <br /> <input type="submit" value="확인">
	</form>
	</div>
</body>
</html>