<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�α���</title>

	
	<!-- �������� �ּ�ȭ�� �ֽ� CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	
	<!-- �ΰ����� �׸� -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

</head>
<body>

	<jsp:include page="/jsphome/top.jsp"/>
	<div class="container">
	
	
	<div >
		
		<div style = "margin: 20px; width:500px;">
				<form name= "LoginForm" method = "POST">
			
					<input class = "form-control input-sm" type= "text" name = "member_id" value = "" style= "margin-bottom: 5px; width:200px;" placeholder= "���̵�"> <br>
					<input class = "form-control input-sm" type= "password" name = "member_pwd" value = "" style = "margin-bottom: 5px; width:200px;" placeholder="��й�ȣ"> <br>
					<button class="btn btn-default btn-sm" type = "button" Onclick= "send_login();" style = "margin-bottom: 5px;">�α��� </button>
					<button class="btn btn-default btn-sm"type = "button" Onclick= "reset();" style = "margin-bottom: 5px;">��� </button><br><br>
			
					<a href= "/Member/member_write.jsp">ȸ�� ����</a> 
					���̵� ã�� ��й�ȣ ã��
				</form>
			</div>
		
		</div>
	
	
	</div>
	
	<jsp:include page="/jsphome/footer.jsp"/>	

	<!-- Jquery CDN -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js"></script>
	
	<!-- �������� �ּ�ȭ�� �ֽ� �ڹٽ�ũ��Ʈ -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>        
	
</body>
</html>


<script language = "javascript">
	// �α��� ������
	function send_login() {
		var obj = document.LoginForm;
		
	
		if(obj.member_id.value== "") {
			alert("���̵� �Է��� �ּ���.");
			obj.member_id.focus();
			return false;
		}
		
		
		if(obj.member_pwd.value== "") {
			alert("��й�ȣ�� �Է��� �ּ���.");
			obj.member_pwd.focus();
			return false;
		}
		
		obj.action = "/login_ok.do";
		obj.submit();
	}


</script>