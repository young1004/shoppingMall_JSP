<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"
	import="java.sql.*, shoppingTeam.*, java.text.SimpleDateFormat, java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>로그인 페이지</title>
</head>
<body>

	<%
		try {
			//DB.getConnection();
			
	 		request.setCharacterEncoding("euc-kr");
	 
	 		String id = request.getParameter("adminID");
	 		String password = request.getParameter("adminPassword");
	 		int M_flag = 0;
	 		int U_flag = 0;
	 		
	 		if(DB.managerLogin(id,password)){
	 		 	System.out.println("성공");
	 		 	M_flag = 1;
	 		 	
	            // 지금 로그인할 id와 pw를 session에 저장하고
	            session.setAttribute("id", id); 
	            session.setAttribute("pw", password);
	            
	            session.setAttribute("M_flag", M_flag);
	            session.setAttribute("U_flag", U_flag);
	            
	            // 첫 페이지로 돌려보낸다
	            response.sendRedirect("managerMain.jsp");
	            return;
	            
	        } else {
	        	session.setAttribute("ML_flag", "FailLogin");
	        	response.sendRedirect("loginAdmin.jsp");
	            return;
	        }
	        
	        
	    } catch (Exception e) {       
	        out.println("DB 연동 실패");
	    }
	//DB.closeConnection();
	%>
</body>
</html>