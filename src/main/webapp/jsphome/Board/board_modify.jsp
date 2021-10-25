<%@page import="java.util.LinkedHashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="kr.co.megait.dao.*"%>

<%
	int member_idx=0;
	String member_id = "";
	String member_name = "";
%>

<% if (session.getAttribute("member_idx") == null || session.getAttribute("member_idx").equals("")) { %>

<script language="javascript">
		alert("로그인이 필요합니다. \n 로그인해 주시기 바랍니다.");
		location.href = "/web_project2/Login/login.jsp";
	</script>

<% }else{ %>
<%
//	if (session.getAttribute("member_idx") != null || !session.getAttribute("member_idx").equals("")) { 
		member_idx = (Integer)session.getAttribute("member_idx");
		member_id = (String)session.getAttribute("member_id");
		member_name = (String)session.getAttribute("member_name");
//	}
%>
<%} %>


<%
	
	int board_idx = Integer.parseInt( request.getParameter("board_idx") );
	BoardDAO BD = new BoardDAO();
	LinkedHashMap board_info = new LinkedHashMap();
	board_info = BD.BoardInfo(board_idx);
	
	//게시글 정보
	int author_idx = (Integer)board_info.get("member_idx");
	String board_title = (String)board_info.get("board_title");
	board_title = board_title.replaceAll("''","'");
	String board_contents = (String)board_info.get("board_contents");
	// board_contents = board_contents.replaceAll("<br>", "\r\n");
	
	//작성자 정보
	String author_name = (String)board_info.get("member_name");
	String author_id = (String)board_info.get("member_id");
	String author_phone = (String)board_info.get("member_name");

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정하기</title>

<style>
table {
	border: 1px solid gray;
	border-collapse: collapse;
}

td {
	border: 1px solid gray;
	padding: 5px;
}

button {
	margin: 5px;
}
</style>

<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js"></script>

</head>

<%
	
//	int member_idx = (Integer)session.getAttribute("member_idx");
//	String member_id = (String)session.getAttribute("member_id");
//	String member_name = (String)session.getAttribute("member_name");

%>
<body>

	<h3>게시글 수정하기</h3>
	<form name="WriteForm" method="POST">
		<table style="width: 700px;">
			<tr>
				<td style="width: 20%;">제목</td>
				<td style="width: 80%"><input type="text"
					style="width: 350px; max-width: 350px;" name="board_title"
					id="board_title" value="<%=board_title%>"></td>
			</tr>

			<tr>
				<td style="width: 20%;">아이디</td>
				<td style="width: 80%"><input type="text"
					style="width: 200px; max-width: 150px;" value="<%=member_id%>"
					disabled></td>
			</tr>

			<tr>
				<td style="width: 20%;">이름</td>
				<td style="width: 80%"><input type="text"
					style="width: 200px; max-width: 150px;" value="<%=member_name%>"
					disabled></td>
			</tr>

			<tr>
				<td style="width: 20%;">내용</td>
				<td style="width: 80%">
						
            	<script type="text/javascript" src="/web_project2/Scripts/SE/js/HuskyEZCreator.js" charset="utf-8"></script>
            	<textarea name="board_contents" id="board_contents" style="width:100%;height:300px;display:none;"><%=board_contents %></textarea>
            	
				<!--             	
            	<textarea name="board_contents" rows="10" cols="70"></textarea>
            	-->
            </tr>
		</table>
		<button type="button" onclick="send_modify();">수정하기</button>
		<button type="button" onclick="reset();">새로작성</button>
		<button type="button" onclick="send_list();">리스트</button>
		<input type="hidden" name="board_idx" value="<%=board_idx %>">
		<input type="hidden" name="member_idx" value="<%=member_idx %>">
	</form>


</body>
</html>

<script>
	
	
	$(document).ready(function(){
		
	})
	
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "board_contents",
	    sSkinURI: "/web_project2/Scripts/SE/SmartEditor2Skin.html",
	    fCreator: "createSEditor2"
	});	
	function send_modify(){
		var obj = document.WriteForm;
		
		if(obj.board_title.value==""){
			alert("게시글의 제목을 작성해 주세요");
			obj.board_title.focus();
			return false;
		}
		
		oEditors.getById["board_contents"].exec("UPDATE_CONTENTS_FIELD",[]);

		obj.action="/web_project2/BoardModifyServlet";
		obj.submit();
	}
	
	//리스트로 이동
	function send_list(){
		location.href="/web_project2/Board/board_list.jsp";
	}

</script>
