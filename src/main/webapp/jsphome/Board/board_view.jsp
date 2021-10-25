<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.*"%>
<%@page import="kr.co.megait.dao.*"%>
<%
	int member_idx=0;
	String member_id = "";
	String member_name = "";
%>    
    
    
<% if(session.getAttribute("member_idx")== null || session.getAttribute("member_idx").equals("")) { %>
	
	
	<script language="javascript">
		alert("로그인이 필요합니다. \n 로그인해 주시기 바랍니다.");
		location.href = "/web_project2/Login/login.jsp";
	</script>

<% }else{%>
<%
		member_idx = (Integer)session.getAttribute("member_idx");
	    member_id = (String)session.getAttribute("member_id");
	    member_name = (String)session.getAttribute("member_name");
		
	
}%>


<%
	int board_idx = Integer.parseInt(request.getParameter("board_idx"));
	BoardDAO BD = new BoardDAO();
	LinkedHashMap board_info = new LinkedHashMap();
	board_info = BD.BoardInfo(board_idx);
	
	
	// 게시글 정보
	int	author_idx = (Integer)board_info.get("member_idx");
	String board_title = (String)board_info.get("board_title");
	String board_contents = (String)board_info.get("board_contents");
	int visit = (Integer)board_info.get("visit");
	
	// 작성자 정보
	String author_id = (String)board_info.get("member_id");
	String author_name = (String)board_info.get("member_name");
	String author_phone = (String)board_info.get("member_phone");
	
	
	BD.BoardVisitUpdate(board_idx);
%>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 보기</title>

    <style>
        table{
            border: 1px solid gray;
            border-collapse: collapse;
        }
        td{
            border:1px solid gray;
            padding: 5px;
        }
        button{
            margin:5px;
        }
    </style>

</head>

<%
	
//	int member_idx = (Integer)session.getAttribute("member_idx");
//	String member_id = (String)session.getAttribute("member_id");
//	String member_name = (String)session.getAttribute("member_name");

%>
<body>

    <h3>게시글 보기</h3>
    <form name="WriteForm" method="POST">
    <table style="width: 700px;">
        <tr>
            <td style="width: 20%;">제목</td>
            <td style="width:80%">
            <%=board_title %>
         </td>
        </tr>

        <tr>
            <td style="width: 20%;">아이디</td>
            <td style="width:80%">
            <%=author_id %>
          </td>
        </tr>
        
        <tr>
            <td style="width: 20%;">이름</td>
            <td style="width:80%">
          	<%=author_name %>
          </td>
        </tr>
        
        
        <tr>
            <td style="width: 20%;">방문자</td>
            <td style="width:80%">
          	<%=visit %> 명
          </td>
        </tr>

        <tr>
            <td style="width: 20%;">내용</td>
            <td style="width:80%">
        
        	<%=board_contents %>
          </td>
        </tr>
    </table>
     <button type="button" onclick="send_reply();">답글쓰기</button>
     <% if(member_idx==author_idx) { %>
    
    <button type="button" onclick="send_modify();">수정하기</button>
    <button type="button" onclick="send_delete();" style="background:red;">삭제하기</button>
    
    <% } %>
    <button type="button" onclick="send_list();">리스트</button>
    <input type="hidden" name="board_idx" value="<%=board_idx %>">
      <input type="hidden" name="author_idx" value="<%=author_idx %>">
    </form>


</body>
</html>

<script>
	
	
	// 답글 작성하기.
	function send_reply(){
		var obj = document.WriteForm;
		obj.action="/web_project2/Board/board_reply.jsp";
		obj.submit();
	}
	// 수정하기 페이지 이동
	function send_modify(){
		var obj = document.WriteForm;
		obj.action="/web_project2/Board/board_modify.jsp";
		obj.submit();
	}
	
	// 게시글 삭제하기
	
	function send_delete(){
		var obj = document.WriteForm;
		var ans = confirm ("정말 삭제하시겠습니까?");
		
		if (ans) {
			
		obj.action="/web_project2/BoardDeleteOkServlet";
		obj.submit();
		}else {
			return false;
		}
	}
	
	
	//리스트로 이동
	function send_list(){
		location.href="/web_project2/Board/board_list.jsp";
	}

</script>
