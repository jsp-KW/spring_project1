<%@page import="java.util.Iterator"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="kr.co.megait.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%

	MemberDAO memberDAO = new MemberDAO();
	LinkedHashMap member_list = new LinkedHashMap();
	LinkedHashMap member_info = new LinkedHashMap();
	
	member_list = memberDAO.MemberList();
	
	int member_idx;
	String member_id = null;
	String member_pwd = null;
	String member_name = null;
	String member_birth = null;
	String member_phone = null;
	String member_gender = null;
	String zipcode = null;
	String raddress = null;
	String jaddress = null;
	String address = null;
	String reg_dt = null;
	String mod_dt = null;
	
	int total_count;
	total_count = memberDAO.MemberTotal();

%>	
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 리스트 보기</title>

    <style>
        table{
            border: 1px solid gray;
            border-collapse: collapse;
        }
        td{
            border:1px solid gray;
            padding: 5px;
            height:25px;
        }
        button{
            margin:5px;
        }
        
        .td1{
        	background:#EEEEEE;
        	font-weight:700;
        }
    </style>


</head>
<body>
		// webapp이 루트이다.
	
	<jsp:include page="/jsphome/top.jsp"/>
	
	
	<div style="margin-top:20px;">
	
		<h3>회원 리스트 테이블</h3>
	
	</div>
	<div style="text-align:left;margin:10px;">
		전체 회원수 : <%=total_count %> 명
	</div>

	<table>
		<tr>
			<td class="td1">No.</td>
			<td class="td1">아이디</td>
			<td class="td1">비밀번호</td>
			<td class="td1">이름</td>
			<td class="td1">생년월일</td>
			<td class="td1">연락처</td>
			<td class="td1">성별</td>
			<td class="td1">우편번호</td>
			<td class="td1">도로명주소</td>
			<td class="td1">지번주소</td>
			<td class="td1">상세주소</td>
			<td class="td1">등록일</td>
			<td class="td1">수정일</td>
		</tr>
		<%
			Iterator iter = member_list.keySet().iterator();
			String str_idx = null;
		%>
		
		<%
			int cursor = 0;
			while(iter.hasNext()){
				str_idx = (String)iter.next();
				member_info = (LinkedHashMap)member_list.get(str_idx);
				
				member_idx = (Integer)member_info.get("member_idx");
				member_id = (String)member_info.get("member_id");
				member_pwd = (String)member_info.get("member_pwd");
				member_name = (String)member_info.get("member_name");
				member_birth = (String)member_info.get("member_birth");
				member_phone = (String)member_info.get("member_phone");
				member_gender = (String)member_info.get("member_gender");
				zipcode = (String)member_info.get("zipcode");
				raddress = (String)member_info.get("raddress");
				jaddress = (String)member_info.get("jaddress");
				address = (String)member_info.get("address");
				reg_dt = (String)member_info.get("reg_dt");
				mod_dt = (String)member_info.get("mod_dt");
		%>
		<tr>
			<td><%=(cursor+1) %></td>
			<td><%=member_id %></td>
			<td><%=member_pwd %></td>
			<td>
				<a href="/web_project2/Member/member_view.jsp?member_idx=<%=member_idx%>"><%=member_name %></a>
			</td>
			<td><%=member_birth %></td>
			<td><%=member_phone %></td>
			<td>
				<% if(member_gender.equals("M")){ %>
					남성
				<%}else{ %>
					여성
				<%} %>
			</td>
			<td><%=zipcode %></td>
			<td><%=raddress %></td>
			<td><%=jaddress %></td>
			<td><%=address %></td>
			<td><%=reg_dt.substring(0, 10) %></td>
			<td><%=mod_dt.substring(0,10) %></td>
		</tr>
		<%
			cursor++;
			}
		%>

	</table>
	<div style = "margin-bottom:30px;">
		<button type="button" OnClick="send_write();">등록하기</button>
	</div>
	
	<jsp:include page="/jsphome/footer.jsp"/>

</body>
</html>

<script language="javascript">	

	function send_write(){
		location.href="/web_project2/Member/member_write.jsp";
	}

</script>