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
<title>���� ���ε� ���</title>
</head>
<body>
	<!-- String path�� ���� ������Ʈ�� WebContent/img�� ������ -->
	<%
		request.setCharacterEncoding("euc-kr");

			String id = (String) session.getAttribute("id");
			String path = request.getRealPath("img"); // �̹����� �־��ֱ� ���� ��� get
			int postSize = 3 * 1024 * 1024;
			int check = 0;

			//������ �ҷ��� ������ �������ִ� try catch��
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
		int i = file2.lastIndexOf("."); // ���� Ȯ���� ��ġ
		String fileExt = file2.substring(i, file2.length()); //����ð��� Ȯ���� ��ġ��

		file2 = path + "\\" + file2;
		filename = path + "\\" + pcode;
		File old = new File(file2);
		File newName = new File(filename);
		old.renameTo(newName);

		//DB�� ���� �־��ֱ� ���� �κ�
		//DB.getConnection();
		check = DB.insertProduct(pcode, pname, price, stock, minstock);
		check = DB.insertAddP(id, pcode);
		
		out.print(pname + " ��ǰ�� �߰��Ǿ����ϴ�.<br>");
		
		
			} catch (Exception e) {
		e.getStackTrace();
			}
			//DB.closeConnection();
	%>
	<form action="managerMain.jsp" target='_top'>
			<input type="submit" value="Ȯ��">
		</form>
	
</body>
</html>