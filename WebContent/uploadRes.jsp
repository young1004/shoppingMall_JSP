<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="shoppingTeam.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>파일 업로드 결과</title>
</head>
<body>
	<!-- String path는 현재 프로젝트의 WebContent/img의 절대경로 -->
	<%
		request.setCharacterEncoding("euc-kr");

			String id = (String) session.getAttribute("id");
			String path = request.getRealPath("img"); // 이미지를 넣어주기 위한 경로 get
			int postSize = 3 * 1024 * 1024;
			int check = 0;

			//파일을 불러와 폴더에 저장해주는 try catch문
			try {
		MultipartRequest mr = new MultipartRequest(request, path, postSize, "euc-kr",
				new DefaultFileRenamePolicy());
		String pname = mr.getParameter("pname");
		String pcode = mr.getParameter("pcode");
		int price = Integer.parseInt(mr.getParameter("price"));
		int stock = Integer.parseInt(mr.getParameter("stock"));
		int minstock = Integer.parseInt(mr.getParameter("minstock"));

		String file = mr.getFilesystemName("uploadfile");
		String file2 = mr.getOriginalFileName("uploadfile");
		String filename;
		int i = file2.lastIndexOf("."); // 파일 확장자 위치
		String fileExt = file2.substring(i, file2.length()); //현재시간과 확장자 합치기

		file2 = path + "\\" + file2;
		filename = path + "\\" + pcode;
		File old = new File(file2);
		File newName = new File(filename);
		old.renameTo(newName);

		//DB에 값을 넣어주기 위한 부분
		//DB.getConnection();
		check = DB.insertProduct(pcode, pname, price, stock, minstock);
		check = DB.insertAddP(id, pcode);
		
		out.print(pname + " 상품이 추가되었습니다.<br>");
		
		
			} catch (Exception e) {
		e.getStackTrace();
			}
			//DB.closeConnection();
	%>
	<form action="managerMain.jsp" target='_top'>
			<input type="submit" value="확인">
		</form>
	
</body>
</html>