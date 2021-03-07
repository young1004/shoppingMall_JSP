<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, shoppingTeam.*, java.text.SimpleDateFormat, java.util.Date, java.net.URLDecoder, java.net.URLEncoder"%>

	<%  
	
	try {
		//DB.getConnection();
 		request.setCharacterEncoding("UTF-8");
 		String name = URLDecoder.decode(request.getParameter("name"),"utf-8");
 		String phone = request.getParameter("phone");
 		String foundId = DB.findConsumerId(name,phone);
 		response.setContentType("application/json");
 		out.print("{'foundId' : '" + foundId + "'}");
 		//DB.closeConnection();
    } catch (Exception e) {       
    	e.printStackTrace();
        out.println("DB 연동 실패");
    }
    %>