<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="EUC-KR">
<title>관리자 페이지</title>
<link rel="stylesheet" href="jquery.mobile/jquery.mobile-1.4.5.min.css" />
<script src="jquery.mobile/jquery-1.11.1.min.js"></script>
<script src="jquery.mobile/jquery.mobile-1.4.5.min.js"></script>

<meta name="viewport" content="width=device-width" ,initial-scale="1">


<style>
.search {float:center;width:100%;height:42vh;}
 .login {float:center;width:100%;height:6vh;}
 .menu {float:left;width:15%;height:150vh;}
 .mCont {float:left;width:80%;height:150vh;}
 </style>
</head>
<body>

<iframe class="login" src=loginAfterManager.jsp name=iframeSearch frameborder=0></iframe>
<iframe class="search" src=mainSearchStylishManager.jsp name=iframeSearch frameborder=0></iframe>
<iframe class="menu" src=menuManager.jsp name=iframeLogin frameborder=0></iframe>
<iframe class="mCont" src=managerFirstScreen.jsp name=iframeMCont frameborder=0 align="middle"></iframe>
</body>
</html>