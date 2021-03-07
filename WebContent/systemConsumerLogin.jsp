<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, shoppingTeam.*, java.text.SimpleDateFormat, java.util.Date, java.net.URLEncoder"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>로그인 페이지</title>
</head>
<body>

	<%
		String url = null;
			try {
		//DB.getConnection();
		

		request.setCharacterEncoding("euc-kr");
		
		String id = request.getParameter("userID");
		String password = request.getParameter("userPassword");
		int U_flag = 0;
		int M_flag = 0;

		if (DB.consumerLogin(id, password)) {
			System.out.println("성공");
			U_flag = 1;

			// 지금 로그인할 id와 pw를 session에 저장하고
			session.setAttribute("id", id);
			session.setAttribute("pw", password);

			session.setAttribute("U_flag", U_flag);
			session.setAttribute("M_flag", M_flag);
			
			//DB.closeConnection();
			response.sendRedirect("Main.jsp");
			return;
		}
		else{
			session.setAttribute("L_flag", "FailLogin");
			
			//DB.closeConnection();
			response.sendRedirect("loginUser.jsp");
			return;
		}
		
			} catch (Exception e) {
		out.println("DB 연동 실패");
			}
	%>

</body>
</html>

