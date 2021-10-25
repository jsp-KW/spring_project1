<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.*"%>
<%@page import="kr.co.megait.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


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
	

	int current_page = 1;
	if(request.getParameter("current_page")!=null) {
		// web 에서 데이터가 왔다갔다 할 때 항상 String 으로 움직이기 때문에 int 형인 current_page 변수
		// 를 위해서 Integer.parseInt를 이용하여 Int 타입으로 바꿔주어야 한다.
		current_page = Integer.parseInt(request.getParameter("current_page"));
	}



	BoardDAO boardDAO = new BoardDAO();
	LinkedHashMap board_list = new LinkedHashMap();
	LinkedHashMap board_info = new LinkedHashMap();
	
	board_list = boardDAO.BoardList(current_page);
	
	int board_idx;
	int ref;
	int subref;
	int depth;
	int visit;
	String board_title = null;
	String board_contents = null;
	String reg_dt = null;
	String mod_dt = null;
	
	int total_count = boardDAO.BoardTotal();
	int total_page =(int) Math.ceil(total_count/(10*1d));
	
	
%>	

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 리스트</title>

    <style>
        table{
            border: 1px solid gray;
            border-collapse: collapse;
            width:700px;
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
        	text-align:center;
        }
    </style>

</head>
<body>

	<h3>게시판</h3>
	
	<div style="text-align:left;margin:10px;">
		현재 페이지: <%=current_page %>/<%=total_page%>	전체 게시글 : <%=total_count %> 개
	</div>

	<table>
		<tr>
			<td class="td1">No.</td>
			<td class="td1">게시글 제목</td>
			<td class="td1">아이디</td>
			<td class="td1">이름</td>
			<td class="td1">등록일</td>
			<td class="td1">수정일</td>
		</tr>
		
		<%if(total_count>0){ %>
			<%
				Iterator iter = board_list.keySet().iterator();
				String str_idx = null;
			%>
			
			<%
				int cursor = 0;
				while(iter.hasNext()){
					str_idx = (String)iter.next();
					board_info = (LinkedHashMap)board_list.get(str_idx);
					
					board_idx = (Integer)board_info.get("board_idx");
					ref = (Integer)board_info.get("ref");
					subref = (Integer)board_info.get("subref");
					depth = (Integer)board_info.get("depth");
					visit = (Integer)board_info.get("visit");
					board_title = (String)board_info.get("board_title");
					board_contents = (String)board_info.get("board_contents");
					member_id = (String)board_info.get("member_id");
					member_name = (String)board_info.get("member_name");
					reg_dt = (String)board_info.get("reg_dt");
					mod_dt = (String)board_info.get("mod_dt");
				
					int paddingSize = 10 * depth;
					
			%>
				<tr>
					<td><%=(total_count-(((current_page-1)*10)+(cursor+1))+1) %></td>
					<td style = "padding:<%=paddingSize%>px">
						<a href="/web_project2/Board/board_view.jsp?board_idx=<%=board_idx%>"><%=board_title %></a>
					</td>
					<td><%=member_id %></td>
					<td><%=member_name %></td>
					<td><%=reg_dt.substring(0, 10) %></td>
					<td><%=mod_dt.substring(0,10) %></td>
				</tr>
			<%
				cursor++;
				}
			%>
		<%}else{ %>

			<tr>
				<td colspan="6" style="height:150px;text-align:center;vertical-align:middle;">
					현재 등록된 게시글이 없습니다.
				</td>
			</tr>
		<%} %>

	</table>
	<div>
		<button type="button" OnClick="send_write();">등록하기</button>
		<button type= "button" OnClick = "send_write2('<%=member_idx %>');">테스트 입력하기</button>
		
	</div>
	
	<div>
		<a href="/web_project2/Board/board_list.jsp?current_page=1">처음</a>
	
		<%for(int i =0; i<total_page; i++) { %>
		
			<%if(current_page==i+1){ %>
		
			<strong>(<a href="/web_project2/Board/board_list.jsp?current_page=<%=i+1%>"><%=i+1 %></a>)</strong>
			<%}else { %>
				(<a href="/web_project2/Board/board_list.jsp?current_page=<%=i+1%>"><%=i+1 %></a>)
			<%} %>	
		<%} %>
		<a href="/web_project2/Board/board_list.jsp?current_page=<%=total_page%>">마지막</a>
	</div>

</body>
</html>

<script>

	function send_write(){
		location.href="/web_project2/Board/board_write.jsp";
	}
	
	function send_write2(member_idx){
		location.href="/web_project2/BoardTestServlet?member_idx="+member_idx;
	}
	
</script>
