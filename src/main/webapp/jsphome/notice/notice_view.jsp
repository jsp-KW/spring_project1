<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="kr.co.megait.dao.*"%>

<%
	int current_page =  1;
	if(request.getParameter("current_page")!=null) {
		current_page = Integer.parseInt(request.getParameter("current_page"));
	}
	
	
	int notice_idx = Integer.parseInt(request.getParameter("notice_idx"));
	
	NoticeDAO noticeDAO = new NoticeDAO();
	JSONObject notice_info = new JSONObject();
	
	notice_info = noticeDAO.NoticeInfo(notice_idx);
	
	
	String notice_title = (String)notice_info.get("notice_title");
	String notice_contents = (String)notice_info.get("notice_contents");
	String reg_dt  = (String)notice_info.get("reg_dt");
	String mod_dt =(String)notice_info.get("mod_dt");
	
	
	noticeDAO.NoticeVisitUpdate(notice_idx);
 


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 보기</title>


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
	
	
		<h3>공지사항 보기</h3>
		<table class ="table table-bordered" style="width:100%;">
			<tr>
				<td style="width: 20%; text-align:center;font-weight:700; background:ivory;">제목</td>
				<td style="width: 80%"><%=notice_title %></td>
			</tr>
	
			<tr>
				<td style="width: 20%; text-align:center;font-weight:700; background:ivory;">내용</td>
				<td style="width: 80%; height:300px;"><%=notice_contents %></td>
			</tr>
	
			
	
		</table>
		
		
		<div class= "text-center">
				
				<button  class= "btn btn-primary btn-sm" type="button" onclick="send_list('<%=current_page%>')">목록</button>
				
		</div>
		
		
	</div>
	
	<jsp:include page="/jsphome/footer.jsp"/>
	
	<!-- Jquery CDN -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js"></script>
	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

	


</body>
</html>

<script>


    
    function send_list(current_page){
    	location.href="/notice_default.do?current_page="+current_page;
    }

</script>

