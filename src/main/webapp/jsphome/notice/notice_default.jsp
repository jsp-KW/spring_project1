<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.*"%>
<%@page import="kr.co.megait.dao.*"%>

<%@page import ="org.json.simple.JSONArray"  %>
<%@page import ="org.json.simple.JSONObject"  %>



<%
	int current_page =1;
	if(request.getParameter("current_page")!=null) {
		current_page = Integer.parseInt(request.getParameter("current_page"));
	}

%>
<%
	




	NoticeDAO noticeDAO = new NoticeDAO();
	JSONArray notice_list = new JSONArray();
	JSONObject  notice_info = new JSONObject();
	
	notice_list = noticeDAO.NoticeList1(current_page);
	
	int notice_idx;
	
	int visit;
	String notice_title = null;
	String notice_contents = null;
	String reg_dt = null;
	String mod_dt = null;
	
	int total_count = noticeDAO.NoticeTotal();
	int total_page =(int) Math.ceil(total_count/(10*1d));

%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 리스트</title>


		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	
</head>
<body>

	<jsp:include page="/jsphome/top.jsp" flush="true" />
	 
	 
	 <div class ="container">
	 
	 	<h3>게시판</h3>
	
	<div style="text-align:right;margin:10px;">
		현재 페이지: <%=current_page %>/<%=total_page%> 	|    전체 게시글 : <%=total_count %> 개
	</div>

	<table class = "table table-hover">
		<tr>
			<td >No.</td>
			<td >타이틀</td>
			<td >방문자 </td>
			<td >등록일</td>
			<td >수정일</td>
		</tr>
		
		<%if(total_count>0){ %>
			
			<%for (int i=0; i<notice_list.size();i++) {%>


			<%
				notice_info = (JSONObject)notice_list.get(i);
				notice_idx = (Integer)notice_info.get("notice_idx");
				notice_title = (String)notice_info.get("notice_title");
				notice_contents = (String)notice_info.get("notice_contents");
				visit= (Integer)notice_info.get("visit");
				reg_dt = (String)notice_info.get("reg_dt");
				mod_dt = (String)notice_info.get("mod_dt");
			%>



				<tr>
					<td style= "width: 50px;"><%= notice_list.size()-i %></td>
					<td><a href="/notice_view.do?notice_idx=<%=notice_idx%>"><%=notice_title %></a>
					</td>
					<td style= "width: 100px;"><%=visit %></td>
					<td style= "width: 100px;"><%=reg_dt.substring(0, 10) %></td>
					<td style= "width: 100px;"><%=mod_dt.substring(0,10) %></td>
				</tr>


		<%} %>
		<%}else{ %>

			<tr>
				<td colspan="6" style="height:150px;text-align:center;vertical-align:middle;">
					현재 등록된 게시글이 없습니다.
				</td>
			</tr>
		<%} %>

	</table>
	
	
		<div class="text-center">

			<nav>
				<ul class="pagination">
					<li><a href="/notice_default.do?current_page=1"
						aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
					</a></li>

					<%
						for (int i = 0; i < total_page; i++) {
					%>
					<%
						if (current_page == i + 1) {
					%>
					<li class= "active"><a href="/notice_default.do?current_page=<%=i + 1%>"><%=i + 1%></a></li>
					<%
						} else {
					%>
					<li ><a href="/notice_default.do?current_page=<%=i + 1%>"><%=i + 1%></a></li>
					<%
						}
					%>
					<%
						}
					%>

					<li><a href="/notice_default.do?current_page=<%=total_page%>"
						aria-label="Next"> <span aria-hidden="true">&raquo;</span>
					</a></li>
				</ul>
			</nav>

		</div>
		
		<div class ="text-center" style= "margin-bottom:30px;">
		<button type="button" class = "btn btn-default btn-sm" OnClick="send_home();">HOME</button>		
		</div>
	
	
	
	 
	 </div>   

	
	    
	    <jsp:include page="/jsphome/footer.jsp" flush="true" />
	

		<!-- Jquery CDN -->
		<script type="text/javascript"
			src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js"></script>
	
		<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
		<script
			src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	
</body>
</html>

<script>

	function send_home(){
		location.href="/";
	}
	
	function send_write2(member_idx){
		location.href="/web_project2/BoardTestServlet?member_idx="+member_idx;
	}
	
</script>
