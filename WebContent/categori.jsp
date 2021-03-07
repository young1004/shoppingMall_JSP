<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!doctype html>
<html lang="utf-8">
<head>
<meta charset="utf-8">
<title>메인 검색 부분</title>
<link href="jquery-ui.css" rel="stylesheet">

<link rel="stylesheet" href="jquery.mobile/jquery.mobile-1.4.5.min.css" />
<script src="jquery.mobile/jquery-1.11.1.min.js"></script>
<script src="jquery.mobile/jquery.mobile-1.4.5.min.js"></script>

<style>
body {
	font-family: "Trebuchet MS", sans-serif;
	margin: 50px;
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

	<div data-role="collapsible" data-collapsed="false">
		    
		<h4>카테고리 열기</h4>
		<form action="categoriQ.jsp" target="iframeContent"
			data-transition="slide">
			<input type="submit" value="잡화">
		</form>
		<form action="categoriO.jsp" target="iframeContent"
			data-transition="slide">
			<input type="submit" value="사무용품">
		</form>
		<form action="categoriE.jsp" target="iframeContent"
			data-transition="slide">
			<input type="submit" value="전자제품">
		</form>
		<form action="categoriA.jsp" target="iframeContent"
			data-transition="slide">
			<input type="submit" value="악세사리">
		</form>
	</div>

	<script src="external/jquery/jquery.js"></script>
	<script src="jquery-ui.js"></script>
	<script>
		$("#accordion").accordion();

		var availableTags = [ "ActionScript", "AppleScript", "Asp", "BASIC",
				"C", "C++", "Clojure", "COBOL", "ColdFusion", "Erlang",
				"Fortran", "Groovy", "Haskell", "Java", "JavaScript", "Lisp",
				"Perl", "PHP", "Python", "Ruby", "Scala", "Scheme" ];
		$("#autocomplete").autocomplete({
			source : availableTags
		});

		$("#button").button();
		$("#button-icon").button({
			icon : "ui-icon-gear",
			showLabel : false
		});

		$("#radioset").buttonset();

		$("#controlgroup").controlgroup();

		$("#tabs").tabs();

		$("#dialog").dialog({
			autoOpen : false,
			width : 400,
			buttons : [ {
				text : "Ok",
				click : function() {
					$(this).dialog("close");
				}
			}, {
				text : "Cancel",
				click : function() {
					$(this).dialog("close");
				}
			} ]
		});

		// Link to open the dialog
		$("#dialog-link").click(function(event) {
			$("#dialog").dialog("open");
			event.preventDefault();
		});

		$("#datepicker").datepicker({
			inline : true
		});

		$("#slider").slider({
			range : true,
			values : [ 17, 67 ]
		});

		$("#progressbar").progressbar({
			value : 20
		});

		$("#spinner").spinner();

		$("#menu").menu();

		$("#tooltip").tooltip();

		$("#selectmenu").selectmenu();

		// Hover states on the static widgets
		$("#dialog-link, #icons li").hover(function() {
			$(this).addClass("ui-state-hover");
		}, function() {
			$(this).removeClass("ui-state-hover");
		});
	</script>
</body>
</html>