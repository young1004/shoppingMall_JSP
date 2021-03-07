<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, shoppingTeam.*, java.text.SimpleDateFormat, java.util.Date, java.net.URLDecoder, java.net.URLEncoder"%>

	<%
		try {
			//DB.getConnection();
	 		request.setCharacterEncoding("UTF-8");
	 		String id = URLDecoder.decode(request.getParameter("id"),"utf-8");
	 		String name = request.getParameter("name");
	 		String foundPwd = DB.findConsumerPwd(id,name);
	 		response.setContentType("application/json");
	 		out.print("{'foundPwd' : '" + foundPwd + "'}");
	 		//DB.closeConnection();
	    } catch (Exception e) {       
	    	e.printStackTrace();
	        out.println("DB 연동 실패");
	    }
	%>