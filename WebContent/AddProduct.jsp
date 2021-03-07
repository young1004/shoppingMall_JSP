<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>상품 추가</title>

<style>
.title {
	align: center;
	text-align: center;
	background-color: #BDBDBD;
	color: white;
	height: 3vh;
}

.head {
	background-color: #EAEAEA;
}

.file {
	width: 100%;
	height: 100%;
}

.text {
	width: 98%;
	height: 98%;
}

.button {
	width: 100%;
	height: 100%;
}

.preview {
	width: 39vw;
	height: 12vh;
	overflow: hidden;
}

.image {
	onload: image_auto_resize(this, 180, 180);
	onmouseover: image_auto_resize(this, 180, 180);
	height: 100%;
}

.categori{
text-align :center;
color : gray;
}

table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 80%;
}

th {
	border: 1px solid #dddddd;
	background-color: transparent;
	height: 3vh;
}
</style>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
	$(document).ready(function() {
		// 태그에 onchange를 부여한다.
		$('.file').change(function() {
			$(".image").remove();
			addPreview($(this)); //preview form 추가하기
		});
	});
	// image preview 기능 구현
	// input = file object[]
	function addPreview(input) {
		var file = input[0].files[0];
		var reader = new FileReader();

		reader.onload = function(img) {
			//div id="preview" 내에 동적코드추가.
			//이 부분을 수정해서 이미지 링크 외 파일명, 사이즈 등의 부가설명을 할 수 있을 것이다.
			$(".preview")
					.append(
							"<img src=\"" + img.target.result + "\"\ class='image'/>");
		};

		reader.readAsDataURL(file);
	}
</script>


</head>
<body>
	<form method="post" action="uploadRes.jsp"
		enctype="multipart/form-data">
		<table align=center>

			<tr>
				<th class="title" colspan=3>상품 추가</th>
			</tr>

			<tr>
				<td>
					<p />
				</td>
			</tr>


			<tr>
				<th rowspan=4 class="preview"></th>
				<th class="head">제품명</th>
				<th><input type="text" class="text" size=20 name="pname">
				</th>
			</tr>

			<tr>
				<th class="head">제품 코드</th>
				<th><input type="text" class="text" size=20 name="pcode">
				</th>
			</tr>

			<tr>
				<th class="head">가격</th>
				<th><input type="text" class="text" size=20 name="price">
				</th>
			</tr>

			<tr>
				<th class="head">재고</th>
				<th><input type="text" class="text" size=20 name="stock">
				</th>
			</tr>

			<tr>
				<th><input type="file" class="file" name="uploadfile" /></th>
				<th class="head">최소 재고</th>
				<th><input type="text" class="text" size=20 name="minstock">
				</th>
			</tr>
				
			<tr>
			<th colspan=3 class="categori">카테고리 : E - 전자 / Q - 잡화 / O - 사무 / A - 악세서리</th>
			</tr>

			<tr>
				<td>
					<p />
				</td>
			</tr>

			<tr>
				<th><input type="submit" class="button" size=40 value="추가"></th>
				<th colspan=2><input type="reset" class="button" size=40
					value="취소" onClick="$('.image').remove();"></th>
			</tr>

		</table>
	</form>

</body>
</html>