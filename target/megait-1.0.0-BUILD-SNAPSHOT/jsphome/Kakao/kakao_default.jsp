<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="kr.co.megait.dao.LibraryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	int current_page = 1;
	if(request.getParameter("current_page")!=null){
		current_page = Integer.parseInt(request.getParameter("current_page"));
	}
	
	String latitude_temp = "";
	String longitude_temp = "";
	if(request.getParameter("latitude")!=null){
		latitude_temp = request.getParameter("latitude");
		longitude_temp = request.getParameter("longitude");
	}
	
	System.out.println(latitude_temp);
	System.out.println(longitude_temp);
	
	LibraryDAO libraryDAO = new LibraryDAO();
	JSONArray library_list = new JSONArray();
	JSONObject library_info = new JSONObject();
	
	library_list = libraryDAO.LibraryList(0);
	int total_count = libraryDAO.LibraryTotal();

	int library_idx;
	String latitude = "";
	String longitude = "";
	String name = null;
	String phone = null;
	String address = null;
	String url = null;
	

%>    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

</head>
<body>

	<jsp:include page="/jsphome/top.jsp" flush="true"/>	
	
	<div class="container">
		
		<span style="font-size:20px;font-weight:700;">도서관 주소 분포</span>
		<div class="text-right">
			전체 도서관 수 : <%=total_count %> 개
		</div>
			
		<!-- 지도를 표시할 div 입니다 -->
		<div id="map" style="width:100%;height:700px;margin-top:10px;"></div>
		
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=35e08d8a39642efcc4ad50018209bb21"></script>
		
		<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 6 // 지도의 확대 레벨
		    };
		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		<% for(int i=0;i<library_list.size();i++){ %>
		<%
			library_info = (JSONObject)library_list.get(i);
			latitude = (String)library_info.get("latitude");
			longitude = (String)library_info.get("longitude");
			
			library_idx = (Integer)library_info.get("library_idx");
			name = (String)library_info.get("name");
			address = (String)library_info.get("address");
			phone = (String)library_info.get("phone");
			url = (String)library_info.get("url");
			
		%>
		
			// 마커가 표시될 위치입니다 
			var markerPosition<%=i%>  = new kakao.maps.LatLng(<%=latitude%>, <%=longitude%>); 
			
			// 마커를 생성합니다
			var marker<%=i%> = new kakao.maps.Marker({
			    position: markerPosition<%=i%>
			});
			
			// 마커가 지도 위에 표시되도록 설정합니다
			marker<%=i%>.setMap(map);
			
			
			// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
			var contents = '<div onclick="send_view(\'<%=library_idx%>\')">';
			contents+= '<div style="width:300px;padding:5px;font-size:20px;font-weight:700;"><%=name%></div>';
			contents+='<div style="width:300px;padding:5px;"><%=address%></div>';
			contents+='<div style="width:300px;padding:5px;"><%=phone%></div>';
			contents+='</div>';
			var iwContent<%=i%> = contents, 
			    iwRemoveable = true;

			// 인포윈도우를 생성합니다
			var infowindow<%=i%> = new kakao.maps.InfoWindow({
			    content : iwContent<%=i%>,
			    removable : iwRemoveable
			});

			// 마커에 클릭이벤트를 등록합니다
			kakao.maps.event.addListener(marker<%=i%>, 'click', function() {
			      // 마커 위에 인포윈도우를 표시합니다
			      infowindow<%=i%>.open(map, marker<%=i%>);  
			});					
			
			
		<%}%>
		
		<%if(latitude_temp.equals("")){ %>
			map.setCenter(new kakao.maps.LatLng(<%=latitude%>, <%=longitude%>));
		<%}else{%>
			map.setCenter(new kakao.maps.LatLng(<%=latitude_temp%>, <%=longitude_temp%>));
			
			
			// 마커가 표시될 위치입니다 
			var markerPositionTemp  = new kakao.maps.LatLng(<%=latitude_temp%>, <%=longitude_temp%>); 
			
			// 마커를 생성합니다
			var markerTemp = new kakao.maps.Marker({
			    position: markerPositionTemp
			});
			
			// 마커가 지도 위에 표시되도록 설정합니다
			markerTemp.setMap(map);
			
			
			// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
			var contentsTemp = '<div style="padding:5px;font-size:20px;font-weight:700;">포인트</div>';
			var iwContentTemp = contentsTemp, 
			    iwRemoveable = true;

			// 인포윈도우를 생성합니다
			var infowindowTemp = new kakao.maps.InfoWindow({
			    content : iwContentTemp,
			    removable : iwRemoveable
			});

		      infowindowTemp.open(map, markerTemp);  
			
		<%}%>
		
		// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
		// marker.setMap(null);    
		</script>	

	</div>
	
	<jsp:include page="/jsphome/footer.jsp" flush="true" />	
	
	
	<!-- Jquery CDN -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js"></script>
	
	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>        

</body>
</html>

<script>
	
	//공공 도서관 상세 보기
	function send_view(library_idx){
		location.href="/library_view_default.do?library_idx="+library_idx+"";
	}

</script>