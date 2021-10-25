<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">



</head>
<body>
	<jsp:include page="/jsphome/top.jsp" />


	<!-- Page Content-->
	<!-- container 는 html 5를 이용 -->
	<div class="container center">
		<div style="margin-top: 20px;">
			<div class="col-lg-12 text-center">
				<span style="font-size: 20px; font-weight: 700;">회원 가입</span>
			</div>

			<form name="WriteForm" method="POST">
				<table class="table table-bordered" style="width:100%;">
					<tr>
						<td style="width: 20%;">회원 아이디<span style="color: red;">*</span></td>
						<td style="width: 80%"><input type="text"
							class="form-control" style="width: 200px; max-width: 150px;"
							name="member_id" id="member_id" placeholder="회원 아이디"></td>
					</tr>

					<tr>
						<td style="width: 20%;">비밀번호<span style="color: red;">*</span></td>
						<td style="width: 80%"><input type="password"
							class="form-control" style="width: 200px; max-width: 150px;"
							name="member_pwd" id="member_pwd" placeholder="비밀번호"></td>
					</tr>


					<tr>
						<td style="width: 20%;">비밀번호 확인<span style="color: red;">*</span></td>
						<td style="width: 80%"><input type="password"
							class="form-control" style="width: 200px; max-width: 150px;"
							name="member_pwd2" id="member_pwd2" placeholder="비밀번호 확인">
						</td>
					</tr>

					<tr>
						<td style="width: 20%;">이름<span style="color: red;">*</span></td>
						<td style="width: 80%"><input type="text"
							class="form-control" style="width: 200px; max-width: 150px;"
							name="member_name" id="member_name" placeholder="이름"></td>
					</tr>

					<tr>
						<td style="width: 20%;">생년월일<span style="color: red;">*</span></td>
						<td style="width: 80%"><input type="number"
							class="form-control" style="width: 200px; max-width: 150px;"
							name="member_birth" id="member_birth" placeholder="생년월일">
							<span style="color: red;">(※ 생년월일은 8자로 입력해주세요. 예:
								20001101)</span></td>
					</tr>

					<tr>
						<td style="width: 20%;">연락처<span style="color: red;">*</span></td>
						<td style="width: 80%"><input type="number"
							class="form-control" style="width: 200px; max-width: 150px;"
							name="member_phone" id="member_phone" placeholder="연락처">
							<span style="color: red;">(※ 연락처는 "-"를 빼고 넣어주세요.)</span></td>
					</tr>

					<tr>
						<td style="width: 20%;">성별</td>
						<td style="width: 80%"><input type="radio"
							name="member_gender" value="M" checked> 남성 <input
							type="radio" name="member_gender" value="F"> 여성</td>
					</tr>

					<tr>
						<td style="width: 20%;">우편번호<span style="color: red;">*</span></td>
						<td style="width: 80%">
						   <div class = "form-inline">
								<input type="number" class="form-control" style="width: 200px; max-width: 100px;" name="zipcode" id="zipcode">
								<button type="button" class="btn btn-danger btn-sm" onclick="sample4_execDaumPostcode();">검색</button></td>
							</div>
					
					</tr>

					<tr>
						<td style="width: 20%;" rowspan="3">주소<span
							style="color: red;">*</span></td>
						<td style="width: 80%"><input type="text"
							class="form-control" style="width: 300px; max-width: 250px;"
							name="jaddress" id="jaddress" placeholder="지번주소"></td>
					</tr>

					<tr>
						<td style="width: 80%"><input type="text"
							class="form-control" style="width: 300px; max-width: 250px;"
							name="raddress" id="raddress" placeholder="도로명 주소"></td>
					</tr>

					<tr>
						<td style="width: 80%"><input type="text"
							class="form-control" style="width: 300px; max-width: 250px;"
							name="address" id="address" placeholder="상세주소"></td>
					</tr>

				</table>
				<div class="col-lg-12 text-center">
					<button type="button" class="btn btn-primary btn-sm"
						onclick="send_write();">등록하기</button>
					<button type="button" class="btn btn-default btn-sm"
						onclick="reset();">새로작성</button>
					<button type="button" class="btn btn-default btn-sm"
						onclick="send_list();">회원리스트</button>
					<input type="hidden" name="member_del_yn" value="N">
				</div>
			</form>


		</div>
		<jsp:include page="/jsphome/footer.jsp" />


		<!-- Jquery CDN -->
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js"></script>
		<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>

<script>

    //회원등록하기
    function send_write(){

        var obj = document.WriteForm;
        
        if(obj.member_id.value==""){
        	alert("회원 아이디를 입력해 주세요.");
        	obj.member_id.focus();
        	return false;
        }

        if(obj.member_pwd.value==""){
        	alert("회원 비밀번호를 입력해 주세요.");
        	obj.member_pwd.focus();
        	return false;
        }
        

        if(obj.member_pwd2.value==""){
        	alert("회원 비밀번호 확인을 입력해 주세요.");
        	obj.member_pwd2.focus();
        	return false;
        }

        

        if(obj.member_pwd.value!=obj.member_pwd2.value){
        	alert("비밀번호와 비밀번호 확인이 같지 않습니다.");
        	obj.member_pwd2.focus();
        	return false;
        }
        
        
        if(obj.member_name.value==""){
        	alert("회원 이름를 입력해 주세요.");
        	obj.member_name.focus();
        	return false;
        }

        if(obj.member_birth.value==""){
        	alert("회원 생년원일을 입력해 주세요.");
        	obj.member_birth.focus();
        	return false;
        }

        if(obj.member_phone.value==""){
        	alert("회원 연락처를 입력해 주세요.");
        	obj.member_phone.focus();
        	return false;
        }

        if(obj.zipcode.value==""){
        	alert("우련번호를 입력해 주세요.");
        	obj.zipcode.focus();
        	return false;
        }

        if(obj.jaddress.value==""){
        	alert("지번 주소를 입력해 주세요.");
        	obj.jaddress.focus();
        	return false;
        }
        
        if(obj.raddress.value==""){
        	alert("도로명 주소를 입력해 주세요.");
        	obj.raddrress.focus();
        	return false;
        }
        
        if(obj.address.value==""){
        	alert("상세주소를 입력해 주세요.");
        	obj.address.focus();
        	return false;
        }

        obj.action="/member_write_ok.do";
        obj.submit();
        
    }
    
    function send_list(){
    	location.href="/member_list.do";
    }

</script>

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode;
                document.getElementById("raddress").value = roadAddr;
                document.getElementById("jaddress").value = data.jibunAddress;
                
            }
        }).open();
    }
</script>
