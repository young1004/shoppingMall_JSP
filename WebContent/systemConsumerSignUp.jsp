<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"
	import="java.sql.*, shoppingTeam.*, java.text.SimpleDateFormat, java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�α��� ������</title>
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
 			gender = "��";
 		else
 			gender = "��";
 		
 		if(DB.insertConsumer(id, password, name, age, gender, phone) == 1){
 		 	System.out.println("����");
            // ù �������� ����������
            response.sendRedirect("Main.jsp");    
        } else {
            // DB�� �������� ������ ���ٸ� ���â�� ����ش�
            System.out.println("����");
            response.sendRedirect("signUpUser.jsp"); 
        }
        
        
    } catch (Exception e) {       
        out.println("DB ���� ����");
    }
	//DB.closeConnection();
    %>
</body>
</html>