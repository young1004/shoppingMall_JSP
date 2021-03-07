<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.sql.*, shoppingTeam.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>제품 구매</title>
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
				DB.minusStock(pname, bnum); //재고 마이너스
				DB.buyRecord(id, pcode, bnum, buyPrice); //제품 구매내역 기록
				DB.buyProduct(id, buyPrice, point); //제품 구매에 따른 금전 계산
				DB.pointRecord(id, pname, point, buyPrice); //포인트 사용/적립 기록
				stockCheck = true;
			}
		} else {
			System.out.println("구매불가");
		}
			} else {
		if ((userAccount + userPoint) >= buyPrice && userPoint >= point) {
			balanceCheck = true;
			
			if (stock >= bnum) {
				DB.minusStock(pname, bnum); //재고 마이너스
				DB.buyRecord(id, pcode, bnum, buyPrice); //제품 구매내역 기록
				DB.buyProduct(id, buyPrice, point); //제품 구매에 따른 금전 계산
				DB.pointRecord(id, pname, point, buyPrice); //포인트 사용/적립 기록
				stockCheck = true;
			}
		} else
			System.out.println("구매불가");//구매불가
			}
	%>


	<div style="text-align: center">

		<br /> <br /> <br /> <br />
		<%
			if (balanceCheck == true && stockCheck == true) {
				out.print(pname + " 상품이 구매되었습니다.<br>");

				if (point == 0) {
					out.print(buyPrice + "원을 사용하였습니다.<br>");
					out.print("포인트" + Math.floor(buyPrice * 0.03) + "점이 적립되었습니다.");
				} else if (point != 0) {
					out.print((buyPrice - point) + "원을 사용하였습니다.<br>");
					out.print("포인트" + point + "점이 사용되었습니다.");
				}
			}
			else if(balanceCheck == false)
				out.print(id + "회원님의 잔여머니 및 잔여포인트가 부족하여 구매가 불가합니다.<br>");
			else if(stockCheck == false)
				out.print(pname + " 제품의 재고가 부족하여 구매가 불가합니다.<br>");
		
		//DB.closeConnection();
		%>
		<br /> <br /> <input type="button" value="확인"
			onclick="location.href='content.jsp'" />
	</div>
</body>
</html>