<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js"></script>


</head>
<body>

	<jsp:include page="/jsphome/top.jsp" flush="true"/>	
	
	<div class="container">
		
		<h3>공공도서관 주소 분포</h3>

			<p style="margin-top:-12px">
			    사용한 데이터를 보시려면 
			    <em class="link">
			       <a href="/library_api_default.do" target="_blank">여기를 클릭하세요!</a>
			    </em>
			</p>
			<div id="map" style="width:100%;height:500px;"></div>
			
			<!-- jQuery 별도 로드가 필요합니다! -->
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=35e08d8a39642efcc4ad50018209bb21&libraries=clusterer"></script>
			<script>
			    var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
			        center : new kakao.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
			        level : 8 // 지도의 확대 레벨 
			    });
			    
			    // 마커 클러스터러를 생성합니다 
			    var clusterer = new kakao.maps.MarkerClusterer({
			        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
			        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
			        minLevel: 3, // 클러스터 할 최소 지도 레벨 
			        calculator: [10, 30, 50], // 클러스터의 크기 구분 값, 각 사이값마다 설정된 text나 style이 적용된다
			        texts: getTexts, // texts는 ['삐약', '꼬꼬', '꼬끼오', '치멘'] 이렇게 배열로도 설정할 수 있다 
			        styles: [{ // calculator 각 사이 값 마다 적용될 스타일을 지정한다
			                width : '30px', height : '30px',
			                background: 'rgba(51, 204, 255, .8)',
			                borderRadius: '15px',
			                color: '#000',
			                textAlign: 'center',
			                fontWeight: 'bold',
			                lineHeight: '31px'
			            },
			            {
			                width : '40px', height : '40px',
			                background: 'rgba(255, 153, 0, .8)',
			                borderRadius: '20px',
			                color: '#000',
			                textAlign: 'center',
			                fontWeight: 'bold',
			                lineHeight: '41px'
			            },
			            {
			                width : '50px', height : '50px',
			                background: 'rgba(255, 51, 204, .8)',
			                borderRadius: '25px',
			                color: '#000',
			                textAlign: 'center',
			                fontWeight: 'bold',
			                lineHeight: '51px'
			            },
			            {
			                width : '60px', height : '60px',
			                background: 'rgba(255, 80, 80, .8)',
			                borderRadius: '30px',
			                color: '#000',
			                textAlign: 'center',
			                fontWeight: 'bold',
			                lineHeight: '61px'
			            }
			        ]
			    });
			 
			    // 클러스터 내부에 삽입할 문자열 생성 함수입니다 
			    function getTexts( count ) {
			
			      // 한 클러스터 객체가 포함하는 마커의 개수에 따라 다른 텍스트 값을 표시합니다 
			      if(count < 10) {
			        return '10';        
			      } else if(count < 30) {
			        return '30';
			      } else if(count < 50) {
			        return '50';
			      } else {
			        return '50 이상';
			      }
			    }
			
			    // 데이터를 가져오기 위해 jQuery를 사용합니다
			    // 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다
			    $.get("/library_api_default3.do", function(data) {
			        // 데이터에서 좌표 값을 가지고 마커를 표시합니다
			        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
			        var data_object = JSON.parse(data);
			        var latitude;
			        var longitude;
			        var markers = $(data_object.positions).map(function(i, position) {
			        	latitude = position.lat;
			        	longitude = position.lng;
			            return new kakao.maps.Marker({
			                position : new kakao.maps.LatLng( position.lat, position.lng)
			            });
			        });
			
			        // 클러스터러에 마커들을 추가합니다
			        clusterer.addMarkers(markers);
			        //map.setCenter(new kakao.maps.LatLng(data_object.positions[0]));
			        map.setCenter(new kakao.maps.LatLng(latitude, longitude));
			    });
			</script>
			
	</div>

	<jsp:include page="/jsphome/footer.jsp" flush="true" />	
	
	
	<!-- Jquery CDN -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js"></script>
	
	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>        

</body>
</html>