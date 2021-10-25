<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.*"%>
<%@page import="kr.co.megait.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<%
	




	NoticeDAO noticeDAO = new NoticeDAO();
	JSONArray notice_list = new JSONArray();
	JSONObject  notice_info = new JSONObject();
	
	notice_list = noticeDAO.NoticeList2(10);
	
	int notice_idx;
	
	int visit;
	String notice_title = null;
	String notice_contents = null;
	String reg_dt = null;
	String mod_dt = null;
	
	int total_count = noticeDAO.NoticeTotal();

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 리스트</title>




</head>
<body>


	<div class="row">
		<div class="col-lg-6">
			<h3>공지사항</h3>
		</div>

		<div class="col-lg-6 text-right">
			<a href="/notice_default.do">더보기</a>
		</div>
	</div>


	<div style="text-align: left; margin: 10px;">
		전체 게시글 :
		<%=total_count %>
		개
	</div>

	<table class = "table">
		<tr>
			<td class="td1">No.</td>
			<td class="td1">제목</td>
			<td class="td1">등록일</td>
			<td class= "td1">수정일 </td>
		</tr>

		<%if(notice_list.size()>0){ %>
		<%for (int i=0; i<notice_list.size();i++) {%>


		<%
				notice_info = (JSONObject)notice_list.get(i);
				notice_idx = (Integer)notice_info.get("notice_idx");
				notice_title = (String)notice_info.get("notice_title");
				notice_contents = (String)notice_info.get("notice_contents");
				reg_dt = (String)notice_info.get("reg_dt");
				mod_dt = (String)notice_info.get("mod_dt");
			%>



		<tr>
			<td><%= notice_list.size()-i %></td>
			<td><a href="/notice_view.do?notice_idx=<%=notice_idx%>"><%=notice_title %></a>
			</td>

			<td><%=reg_dt.substring(0, 10) %></td>
			<td><%=mod_dt.substring(0,10) %></td>
		</tr>


		<%} %>





		<%}else{ %>

		<tr>
			<td colspan="4"
				style="height: 150px; text-align: center; vertical-align: middle;">
				현재 등록된 게시글이 없습니다.</td>
		</tr>
		<%} %>

	</table>
	
	
	

</body>
</html>

<script>


	
</script>
