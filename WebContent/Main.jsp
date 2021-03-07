<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"
	import="java.sql.*, shoppingTeam.*, java.text.SimpleDateFormat, java.util.Date"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>다판다 홈페이지</title>
	
	<meta http-equiv="content-type" content="text/html; charset=utf-8">

	<link rel="stylesheet" href="jquery.mobile/jquery.mobile-1.4.5.min.css" />
	<script src="jquery.mobile/jquery-1.11.1.min.js"></script>
	<script src="jquery.mobile/jquery.mobile-1.4.5.min.js"></script>

	<meta name="viewport" content="width=device-width" ,initial-scale="1">

	<style>
	
	.search {float:center;width:100%;height:44vh;}
 	.login {float:center;width:100%;height:7vh;}
 	.categori {float:left;width:15%;height:80vh;}
 	.content {float:left;width:80%;height:80vh; margin-top:5px;}
 	.footer {float:left;width:100%;height:30vh;}

	body{
		font-family: "Trebuchet MS", sans-serif;
	}
	.demoHeaders {
		margin-top: 2em;
	}
	#dialog-link {
		padding: .4em 1em .4em 20px;
		text-decoration: none;
		position: relative;
	}
	#dialog-link span.ui-icon {
		margin: 0 5px 0 0;
		position: absolute;
		left: .2em;
		top: 50%;
		margin-top: -8px;
	}
	#icons {
		margin: 0;
		padding: 0;
	}
	#icons li {
		margin: 2px;
		position: relative;
		padding: 4px 0;
		cursor: pointer;
		float: left;
		list-style: none;
	}
	#icons span.ui-icon {
		float: left;
		margin: 0 4px;
	}
	.fakewindowcontain .ui-widget-overlay {
		position: absolute;
	}
	select {
		width: 200px;
	}
	</style>
</head>
<body>

<%
	DB.closeConnection();
	DB.getConnection();
	int U_flag = 0;
	int M_flag = 0;

	String chkID = (String)session.getAttribute("id");
	
	if(chkID != null) {
		U_flag = Integer.parseInt(session.getAttribute("U_flag").toString());
		M_flag = Integer.parseInt(session.getAttribute("M_flag").toString());
	}
%>

<% 
	if(U_flag == 1)
		out.print("<iframe class=login src=loginAfterUser.jsp name=iframeSearch frameborder=0></iframe>");
	else if(M_flag == 1)
		out.print("<iframe class=login src=loginAfterManager.jsp name=iframeSearch frameborder=0></iframe>");
	else
		out.print("<iframe class=login src=login.jsp name=iframeSearch frameborder=0></iframe>");

%>

<iframe class="search" src=mainSearchStylish.jsp name=iframeSearch frameborder=0></iframe>
<hr>
<iframe class="categori" src=categori.jsp name=iframeCategori frameborder=0></iframe>
<iframe class="content" src=content.jsp name=iframeContent frameborder=0></iframe>
<iframe class="footer" src=footer.jsp name=iframeFooter frameborder=0></iframe>


<script src="external/jquery/jquery.js"></script>
<script src="jquery-ui.js"></script>
<script>

$( "#accordion" ).accordion();



var availableTags = [
	"ActionScript",
	"AppleScript",
	"Asp",
	"BASIC",
	"C",
	"C++",
	"Clojure",
	"COBOL",
	"ColdFusion",
	"Erlang",
	"Fortran",
	"Groovy",
	"Haskell",
	"Java",
	"JavaScript",
	"Lisp",
	"Perl",
	"PHP",
	"Python",
	"Ruby",
	"Scala",
	"Scheme"
];
$( "#autocomplete" ).autocomplete({
	source: availableTags
});



$( "#button" ).button();
$( "#button-icon" ).button({
	icon: "ui-icon-gear",
	showLabel: false
});



$( "#radioset" ).buttonset();



$( "#controlgroup" ).controlgroup();



$( "#tabs" ).tabs();



$( "#dialog" ).dialog({
	autoOpen: false,
	width: 400,
	buttons: [
		{
			text: "Ok",
			click: function() {
				$( this ).dialog( "close" );
			}
		},
		{
			text: "Cancel",
			click: function() {
				$( this ).dialog( "close" );
			}
		}
	]
});

// Link to open the dialog
$( "#dialog-link" ).click(function( event ) {
	$( "#dialog" ).dialog( "open" );
	event.preventDefault();
});



$( "#datepicker" ).datepicker({
	inline: true
});



$( "#slider" ).slider({
	range: true,
	values: [ 17, 67 ]
});



$( "#progressbar" ).progressbar({
	value: 20
});



$( "#spinner" ).spinner();



$( "#menu" ).menu();



$( "#tooltip" ).tooltip();



$( "#selectmenu" ).selectmenu();


// Hover states on the static widgets
$( "#dialog-link, #icons li" ).hover(
	function() {
		$( this ).addClass( "ui-state-hover" );
	},
	function() {
		$( this ).removeClass( "ui-state-hover" );
	}
);
</script>
</body>
</html>