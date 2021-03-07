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
 
 		String id = request.getParameter("userID");
 		String password = request.getParameter("userPassword");
 		String name = request.getParameter("userName");
 		String age = request.getParameter("userAge");
 		String phone = request.getParameter("userPhone");
 		String gender = request.getParameter("userGender");
 		if(gender.equals("male"))
 			gender = "남";
 		else
 			gender = "여";
 		
 		if(DB.insertConsumer(id, password, name, age, gender, phone) == 1){
 		 	System.out.println("성공");
            // 첫 페이지로 돌려보낸다
            response.sendRedirect("Main.jsp");    
        } else {
            // DB에 내가적은 정보가 없다면 경고창을 띄워준다
            System.out.println("실패");
            response.sendRedirect("signUpUser.jsp"); 
        }
        
        
    } catch (Exception e) {       
        out.println("DB 연동 실패");
    }
	//DB.closeConnection();
    %>
</body>
</html>