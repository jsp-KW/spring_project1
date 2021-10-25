<%@page import="kr.co.megait.service.*"%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="kr.co.megait.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
	
	MemberDAO memberDAO = new MemberDAO();	
	LoginService loginService = new LoginServiceImpl();
	LinkedHashMap login_list = new LinkedHashMap();
	LinkedHashMap login_info = new LinkedHashMap();
	
	login_list = loginService.LoginServiceList();
	
	int login_idx;
	int member_idx;
	String login_time = null;
	String login_check_yn = null;
	String member_id = null;
	String member_name = null;


%>	
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 리스트 보기</title>

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
	
	<h3>로그인 리스트 테이블</h3>
	

	<table>
		<tr>
			<td class="td1">No.</td>
			<td class="td1">아이디</td>
			<td class="td1">이름</td>
			<td class="td1">로그인/로그아웃 종류</td>
			<td class="td1">시간</td>
				
		</tr>
		<%
			Iterator iter = login_list.keySet().iterator();
			String str_idx = null;
		%>
		
		<%
			int cursor = 0;
			while(iter.hasNext()){
				str_idx = (String)iter.next();
				login_info = (LinkedHashMap)login_list.get(str_idx);
				
				login_idx = (Integer)login_info.get("login_idx");
				member_idx = (Integer)login_info.get("member_idx");
				login_time = (String)login_info.get("login_time");
				login_check_yn = (String)login_info.get("login_check_yn");
				member_id = (String)login_info.get("member_id");
				member_name = (String)login_info.get("member_name");
			
		%>
		<tr>
			<td><%=(cursor+1) %></td>
			<td><%=member_id %></td>
			<td><%=member_name%></td>
			
			<td>
				<%if(login_check_yn.equals("I")){ %>
					Login
				<%}else{ %>
					Logout
				<%} %>
			</td>
			<td><%=login_time %></td>
		</tr>
		<%
			cursor++;
			}
		%>

	</table>
	
</body>
</html>

<script language="javascript">	



</script>