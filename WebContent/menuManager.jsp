<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    import="java.sql.*, shoppingTeam.*" %>
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
	body{
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
<%String id = (String)session.getAttribute("id");
  //DB.getConnection();
  %>


<div data-role="collapsible" data-collapsed="false">
    <h4>카테고리 열기</h4>
<img src="img/seller.png" width="200" height="200"/><br>
안녕하세요!!<br><%= id%> 관리자님!<br>
오늘의 매출 : <%=DB.today() %>
	<form action="M_InfoChg.jsp" target="iframeMCont"><input type="submit" value="개인정보 수정" ></form>
	<form action="AddStock.jsp" target="iframeMCont"><input type="submit" value="재고보충" ></form>
	<form action="AddProduct.jsp" target="iframeMCont"><input type="submit" value="상품추가" ></form>
	<form action="AddStockList.jsp" target="iframeMCont"><input type="submit" value="재고보충 내역" ></form>
	<form action="AddCancelBuyList.jsp" target="iframeMCont"><input type="submit" value="주문취소 내역" ></form>
	<form action="AddProductList.jsp" target="iframeMCont"><input type="submit" value="상품추가 내역" ></form>
	<form action="SalesStatement.jsp" target="iframeMCont"><input type="submit" value="매출 상세보기" ></form>
	<form action="DeliveryStatement.jsp" target="iframeMCont"><input type="submit" value="제품 배송" ></form>
	<form action="deliveryStatus.jsp" target="iframeMCont"><input type="submit" value="배송 현황 조회" ></form>
</div>
<% //DB.closeConnection(); 
%>
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