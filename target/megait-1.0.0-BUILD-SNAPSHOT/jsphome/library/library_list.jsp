<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="kr.co.megait.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	int current_page = 1;
if (request.getParameter("current_page") != null) {
	current_page = Integer.parseInt(request.getParameter("current_page"));
}

LibraryDAO libraryDAO = new LibraryDAO();

JSONArray library_list = new JSONArray();
JSONArray library_list2 = new JSONArray();

JSONObject library_info = new JSONObject();
JSONObject library_info2 = new JSONObject();

library_list = libraryDAO.LibraryList(current_page);
library_list2 = libraryDAO.LibraryList(0);



int library_idx;
String name = null;
String address = null;
String phone = null;
String url = null;
String latitude = "0.0";
String longitude = "0.0";

int total_count;
total_count = libraryDAO.LibraryTotal();

int total_page = (int) Math.ceil(total_count / (10 * 1d));


// 블록 페이지
int iPerPage = 10; // 10개씩 가져온다는
int iPagePerBlock = 10;
double dStartPage = current_page/(iPagePerBlock*1d);
int iStartPage = ((int)Math.ceil(dStartPage)-1)* iPagePerBlock+1;
int iPageNum = (int)Math.ceil(total_count/(10*1d));
%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>공공 도서관</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!--         
        <style>
        	td{
        		border:1px solid red;
        	}
        </style>
        -->

</head>
<body>

	<jsp:include page="/jsphome/top.jsp" />

	<!-- Page Content-->
	<div class="container px-4 px-lg-5">


		<div style="margin-top: 20px;">
			<h3>공공 도서관 리스트</h3>
		</div>

		<div style="text-align: left; margin: 10px;">
			전체 도서관수 :
			<%=total_count%>
			명
		</div>
		
		<!-- 공공도서관 Restful API -->
		<div>
			<textarea style ="width:100%; height:300px;"><%=library_list %></textarea>
			
		</div>

		<table class="table table-hover">
			<thead>
				<tr>
					<th>No.</th>
					<th>idx</th>
					<th>도서관 이름</th>
					<th>주소</th>
					<th style="width:150px;">위도</th>
					<th style="width:150px;">경도</th>
					<th style="width:150px;">연락처</th>
					<th>사이트</th>
					</tr>
			</thead>
			
			<tbody>
			
			

			<% for(int i=0; i<library_list.size();i++) { %>	
			<% 
					library_info = (JSONObject)library_list.get(i);	
					library_idx = (Integer)library_info.get("library_idx");
					name = (String)library_info.get("name");
					address = (String)library_info.get("address");
					latitude = (String)library_info.get("latitude");
					longitude = (String)library_info.get("longitude");
					phone = (String)library_info.get("phone");
					url = (String)library_info.get("url");		
				
			%>

				<tr>
					<td><%=total_count - (((current_page - 1) * 10) + (i + 1)) + 1%></td>
					<td><%=library_idx%></td>
					<td><a
						href="javascript:send_view('<%=library_idx%>', '<%=current_page%>');"><%=name%></a>
					</td>
					<td><%=address%></td>
					<td><%=latitude%></td>
					<td><%=longitude%></td>
					<td><%=phone%></td>
					<td>
						<a href="<%=url%>" target="_blank"><%=url %></a></td>
				</tr>
			<% } %>
			</tbody>

		</table>
		<div class="text-center">
			<button type="button" class="btn btn-primary btn-sm"
				OnClick="send_gps();">GPS 변경</button>
		</div>

		<div class="text-center" style="margin-bottom: 30px;">

			<nav>
				<ul class="pagination">
					<li>
					  <a href="/library_default.do?current_page=1" aria-label="Previous">
					   <span aria-hidden="true">&laquo;</span>
					  </a>
					</li>
					
					<li>
					<%if(current_page>1){ %>
					  <a href="/library_default.do?current_page=<%=current_page-1%>" aria-label="Previous">
					   <span aria-hidden="true">preview</span>
					  </a>
					<%}else{ %>
						<span aria-hidden="true">preview</span>
					<%} %>
					  
					</li>

					<% for (int iLoop = iStartPage; (iLoop<iStartPage+iPagePerBlock)&&(iLoop <= iPageNum); iLoop++) { %>
					<% if (iLoop == current_page) { %>
						<li><a href="/library_default.do?current_page=<%=iLoop%>"><strong><%=iLoop%></strong></a></li>
					<% } else { %>
						<li><a href="/library_default.do?current_page=<%=iLoop%>"><%=iLoop%></a></li>
					<%} %>
				<%}%>

			
				<li>
					<%if(current_page < total_page){ %>
					  <a href="/library_default.do?current_page=<%=current_page+1%>" aria-label="Previous">
					   <span aria-hidden="true">next</span>
					  </a>
					<%}else{ %>
						<span aria-hidden="true">next</span>
					<%} %>
					  
				</li>
			
					
					
				 <li>
					<a href="/library_default.do?current_page=<%=total_page%>"aria-label="Previous">
					   <span aria-hidden="true">&raquo;</span>
					 </a>
				 </li>	
				</ul>
			</nav>

		</div>

	</div>

	<jsp:include page="/jsphome/footer.jsp" />

		<!-- Jquery CDN -->
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js"></script>
		<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
		<script
			src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

	</body>
</html>

<script language="javascript">


	// 회원 등록하는 페이지 이동.
	function send_gps() {
		location.href = "/gps_write_default.do";
	}
	
	function send_view(library_idx,current_page) {
		
		location.href ="/library_view_default.do?library_idx="+library_idx+"&current_page="+current_page;
	}
	
	
</script>
