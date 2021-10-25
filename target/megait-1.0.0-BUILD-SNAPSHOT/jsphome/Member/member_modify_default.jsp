<%@page import="java.util.LinkedHashMap"%>
<%@page import="kr.co.megait.dao.*"%>
<%@page import="kr.co.megait.common.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	CommonUtil CU = new CommonUtil();
	int current_page =  1;
	if(request.getParameter("current_page")!=null) {
		current_page = Integer.parseInt(request.getParameter("current_page"));
	}
	
	int member_idx = 0;
	if (session.getAttribute("member_idx")!=null){
		member_idx = (Integer)session.getAttribute("member_idx");		
	}
	
	
	if (request.getParameter("member_idx")!=null) {
		member_idx = Integer.parseInt(request.getParameter("member_idx"));
	}
	
	MemberDAO memberDAO = new MemberDAO();
	LinkedHashMap member_info = new LinkedHashMap();
	member_info = memberDAO.MemberInfo(member_idx);
//	out.println(member_info);


	String member_id = (String)member_info.get("member_id");
	
	String member_pwd = (String)member_info.get("member_pwd");
	String member_pwd_temp= CU.getDecrypt(member_pwd); //복구화
	
	
	
	String member_name = (String)member_info.get("member_name");
	String member_birth = (String)member_info.get("member_birth");
	String member_phone = (String)member_info.get("member_phone");
	String member_gender = (String)member_info.get("member_gender");
	String zipcode = (String)member_info.get("zipcode");
	String raddress = (String)member_info.get("raddress");
	String jaddress = (String)member_info.get("jaddress");
	String address = (String)member_info.get("address");
	String member_del_yn = (String)member_info.get("member_del_yn");
	String reg_dt = (String)member_info.get("reg_dt");
	String mod_dt = (String)member_info.get("mod_dt");


%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>

	 <!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet"
		href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	
	<!-- 부가적인 테마 -->
	<link rel="stylesheet"
		href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

</head>
<body>
	<jsp:include page="/jsphome/top.jsp"/>
	
	<div class= "container">
	
		<h3>회원 정보 수정</h3>
	    <form name="WriteForm" method="POST">
	    <table class ="table table-hover"style="width:100%;">
	        <tr>
	            <td style="width: 20%;">회원 아이디</td>
	            <td style="width:80%">
	                <input class="form-control input-sm" type="text" style="width:200px;max-width: 150px;" name="member_id" id="member_id" value="<%=member_id%>" readonly>
	            </td>
	        </tr>
	
	        <tr>
	            <td style="width: 20%;">비밀번호</td>
	            <td style="width:80%">
	                <input class="form-control input-sm" type="password" style="width:200px;max-width: 150px;" name="member_pwd" id="member_pwd" value="<%=member_pwd_temp%>">
	            	<span style="color:red;"><%=member_pwd_temp %></span>
	            	<span style="color:red;"><%=member_pwd %></span>
	            </td>
	        </tr>
	
	        <tr>
	            <td style="width: 20%;">이름</td>
	            <td style="width:80%">
	                <input class="form-control input-sm" type="text" style="width:200px;max-width: 150px;" name="member_name" id="member_name" value="<%=member_name%>">
	            </td>
	        </tr>
	
	        <tr>
	            <td style="width: 20%;">생년월일</td>
	            <td style="width:80%">
	                <input class="form-control input-sm" type="number" style="width:200px;max-width: 150px;" name="member_birth" id="member_birth" value="<%=member_birth%>">
	            </td>
	        </tr>
	
	        <tr>
	            <td style="width: 20%;">연락처</td>
	            <td style="width:80%">
	                <input class="form-control input-sm" type="number" style="width:200px;max-width: 150px;" name="member_phone" id="member_phone" value="<%=member_phone%>">
	            </td>
	        </tr>
	
	        <tr>
	            <td style="width: 20%;">성별</td>
	            <td style="width:80%">
	            	<%if(member_gender.equals("M")){ %>
		                <input type="radio" name="member_gender" value="M" checked> 남성
		                <input type="radio" name="member_gender" value="F"> 여성
	            	<%}else{ %>
		                <input type="radio" name="member_gender" value="M"> 남성
		                <input type="radio" name="member_gender" value="F" checked> 여성
	            	<%} %>
	            </td>
	        </tr>
	
	        <tr>
	            <td style="width: 20%;">우편번호</td>
	            <td style="width:80%">
	            
	            	<div class= "form-inline">
		                <input class="form-control input-sm" type="number" style="width:200px;max-width: 100px;" name="zipcode" id="zipcode" value="<%=zipcode%>">
		                <button class= "btn btn-default btn-sm" type="button" onclick="sample4_execDaumPostcode();">검색</button>
		            </div>
	            </td>
	        </tr>
	
	        <tr>
	            <td style="width: 20%;" rowspan="3">주소</td>
	            <td style="width:80%">
	                <input class="form-control input-sm" type="text" style="width:300px;max-width: 250px;" name="jaddress" id="jaddress" placeholder="지번주소" value="<%=jaddress%>">
	            </td>
	        </tr>
	
	        <tr>
	            <td style="width:80%">
	                <input class="form-control input-sm" type="text" style="width:300px;max-width: 250px;" name="raddress" id="raddress" placeholder="도로명 주소" value="<%=raddress%>">
	            </td>
	        </tr>
	
	        <tr>
	            <td style="width:80%">
	                <input class="form-control input-sm"  type="text" style="width:300px;max-width: 250px;" name="address" id="address" placeholder="상세주소" value="<%=address%>">
	            </td>
	        </tr>
	
	        <tr>
	            <td style="width: 20%;">회원탈퇴여부</td>
	            <td style="width:80%">
	            	<%if(member_del_yn.equals("Y")){ %>
	            		<input type="checkbox" name="member_del_yn" checked>
	            	<%}else{ %>
	            		<input type="checkbox" name="member_del_yn">
	            	<%} %>
	            </td>
	        </tr>
	
	    </table>
	    
	    
	    <div class="text-center">
		    <button class ="btn btn-danger btn-sm" type="button" onclick="send_modify();">수정하기</button>
		    <button class ="btn btn-default btn-sm" type="button" onclick="reset();">새로작성</button>
		    <button class = "btn btn-default btn-sm" type="button" onclick="send_list();">회원리스트</button>
		    
		    <input type="hidden" name="member_idx" value="<%=member_idx%>">
		    <input type="hidden" name="current_page" value="<%=current_page %>">
		</div>
	    <jsp:include page="/jsphome/footer.jsp"/>
	    
	    </form>
	
	</div>
   

	<!-- Jquery CDN -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js"></script>
	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	

</body>
</html>

<script>

    //회원수정하기
    function send_modify(){

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
		
        var ans = confirm("정말 수정하시겠습니까?");
        
        if(ans){
            obj.action="/member_modify_ok.do";
            obj.submit();
        }else{
        	return false;
        }
        
    }
    
    function send_list(){
    	var obj =document.WriteForm;
    	obj.action="/member_list.do";
    	obj.submit();
    }

</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
