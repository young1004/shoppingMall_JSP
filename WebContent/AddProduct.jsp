<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>��ǰ �߰�</title>

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
		// �±׿� onchange�� �ο��Ѵ�.
		$('.file').change(function() {
			$(".image").remove();
			addPreview($(this)); //preview form �߰��ϱ�
		});
	});
	// image preview ��� ����
	// input = file object[]
	function addPreview(input) {
		var file = input[0].files[0];
		var reader = new FileReader();

		reader.onload = function(img) {
			//div id="preview" ���� �����ڵ��߰�.
			//�� �κ��� �����ؼ� �̹��� ��ũ �� ���ϸ�, ������ ���� �ΰ������� �� �� ���� ���̴�.
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
				<th class="title" colspan=3>��ǰ �߰�</th>
			</tr>

			<tr>
				<td>
					<p />
				</td>
			</tr>


			<tr>
				<th rowspan=4 class="preview"></th>
				<th class="head">��ǰ��</th>
				<th><input type="text" class="text" size=20 name="pname">
				</th>
			</tr>

			<tr>
				<th class="head">��ǰ �ڵ�</th>
				<th><input type="text" class="text" size=20 name="pcode">
				</th>
			</tr>

			<tr>
				<th class="head">����</th>
				<th><input type="text" class="text" size=20 name="price">
				</th>
			</tr>

			<tr>
				<th class="head">���</th>
				<th><input type="text" class="text" size=20 name="stock">
				</th>
			</tr>

			<tr>
				<th><input type="file" class="file" name="uploadfile" /></th>
				<th class="head">�ּ� ���</th>
				<th><input type="text" class="text" size=20 name="minstock">
				</th>
			</tr>
				
			<tr>
			<th colspan=3 class="categori">ī�װ� : E - ���� / Q - ��ȭ / O - �繫 / A - �Ǽ�����</th>
			</tr>

			<tr>
				<td>
					<p />
				</td>
			</tr>

			<tr>
				<th><input type="submit" class="button" size=40 value="�߰�"></th>
				<th colspan=2><input type="reset" class="button" size=40
					value="���" onClick="$('.image').remove();"></th>
			</tr>

		</table>
	</form>

</body>
</html>