<%@page import="java.util.LinkedHashMap"%>
<%@page import="kr.co.megait.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="kr.co.megait.dao.*"%>

<%
	
	int current_page = 1;
	if(request.getParameter("current_page")!=null){
		current_page = Integer.parseInt(request.getParameter("current_page"));
	}
	

	int library_idx = Integer.parseInt(request.getParameter("library_idx"));
	
	LibraryDAO libraryDAO = new LibraryDAO();
	JSONObject library_info = new JSONObject();
	
	library_info = libraryDAO.LibraryInfo(library_idx);
	
	String name = (String)library_info.get("name");
	String address = (String)library_info.get("address");
	String latitude = (String)library_info.get("latitude");
	String longitude = (String)library_info.get("longitude");
	String phone = (String)library_info.get("phone");
	String url = (String)library_info.get("url");

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공공 도서관 정보 보기</title>
    
	<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

</head>
<body>

	<jsp:include page="/jsphome/top.jsp"/>	

	<div class="container">
	
	    <h3>회원 정보 보기</h3>
	    <table  class="table table-hover" style="width:100%;">
	        <tr>
	            <td style="width: 20%;">공공 도서관 이름</td>
	            <td style="width:80%">
	            	<%=name %>
	            </td>
	        </tr>
	
	        <tr>
	            <td style="width: 20%;">공공도서관 주소</td>
	            <td style="width:80%">
	            	<%=address %>
	            </td>
	        </tr>
	
	        <tr>
	            <td style="width: 20%;">연락처</td>
	            <td style="width:80%">
	            	<%=phone %>
	            </td>
	        </tr>
	
	        <tr>
	            <td style="width: 20%;">홈페이지</td>
	            <td style="width:80%">
	            	<a href="<%=url%>" target="_blank"><%=url %></a>
	            </td>
	        </tr>
	
	        <tr>
	            <td style="width: 20%;">위도</td>
	            <td style="width:80%">
	            	<%=latitude %>
	            </td>
	        </tr>

	        <tr>
	            <td style="width: 20%;">경도</td>
	            <td style="width:80%">
	            	<%=longitude %>
	            </td>
	        </tr>

	        <tr>
	            <td style="width: 100%;height:500px;" colspan="2">

					<!-- 지도를 표시할 div 입니다 -->
					<div id="map" style="width:100%;height:500px;margin-top:10px;"></div>
					
					<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=71a383ea400e6eab6628c65e3e238e5f"></script>
					
					<script>
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					    mapOption = { 
					        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
					        level: 5 // 지도의 확대 레벨
					    };
					
					var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

					// 마커가 표시될 위치입니다 
					var markerPosition  = new kakao.maps.LatLng(<%=latitude%>, <%=longitude%>); 
					
					// 마커를 생성합니다
					var marker = new kakao.maps.Marker({
					    position: markerPosition,
					    clickable: true
					});
					
					// 마커가 지도 위에 표시되도록 설정합니다
					marker.setMap(map);
					map.setCenter(new kakao.maps.LatLng(<%=latitude%>, <%=longitude%>));
					
					// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
					var contents = '<div style="width:300px;padding:5px;font-size:20px;font-weight:700;"><%=name%></div>';
					contents+='<div style="width:300px;padding:5px;"><%=address%></div>';
					contents+='<div style="width:300px;padding:5px;"><%=phone%></div>';
					
					var iwContent = contents, 
					    iwRemoveable = true;

					// 인포윈도우를 생성합니다
					var infowindow = new kakao.maps.InfoWindow({
					    content : iwContent,
					    removable : iwRemoveable
					});

				    infowindow.open(map, marker);  
				    
					// 마커에 클릭이벤트를 등록합니다
					kakao.maps.event.addListener(marker, 'click', function() {
					      // 마커 위에 인포윈도우를 표시합니다
					      infowindow.open(map, marker);  
					});					
					
					
					// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
					// marker.setMap(null);    
					</script>	
			
				</div>

	            
	            </td>
	        </tr>

	    </table>
	    
	    <div class="text-center">
		    <button class="btn btn-default btn-sm" type="button" onclick="send_list('<%=current_page%>', 'list', '<%=latitude%>', '<%=longitude%>');">전체 목록보기</button>
		    <button class="btn btn-default btn-sm" type="button" onclick="send_list('<%=current_page%>', 'map', '<%=latitude%>', '<%=longitude%>');">전체 지도보기</button>
	    </div>
	
	
	</div>

	<jsp:include page="/jsphome/footer.jsp"/>	

	<!-- Jquery CDN -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js"></script>
	
	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>        

</body>
</html>

<script>

    //공공도서관 리스트 이동
    function send_list(current_page, type, latitude, longitude){
    	
    	if(type=='list'){
        	location.href="/library_default.do?current_page="+current_page;
    	}else{
        	location.href="/kakao_default.do?latitude="+latitude+"&longitude="+longitude+"";
    	}
    }

</script>

