<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="kr.co.megait.dao.*"%>
<%@page import="kr.co.megait.common.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>

<%
	// 방문자 등록하기.
	
	
	
   VisitDAO visitDAO = new VisitDAO();
   visitDAO.VisitReg(request);

   JSONArray visit_list = new JSONArray();
   JSONObject visit_info = new JSONObject();
   visit_list = visitDAO.VisitList("","2021-10-01","");
   String visit_temp = visit_list.toJSONString();

%>
   
   <div class="container">   

      <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        <ol class="carousel-indicators">
          <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
          <li data-target="#carousel-example-generic" data-slide-to="1"></li>
        </ol>
      
        <!-- Wrapper for slides -->
        <div class="carousel-inner" role="listbox">
          <div class="item active container1">
            <img src="/jsphome/images/test1.jpg" alt="공공도서관" style="width:1280px;height:500px;">
            <div class="carousel-caption">
              공공 도서관 노트북
            </div>
          </div>
          <div class="item container1">
            <img src="/jsphome/images/test2.jpg" alt="공공도서관" style="width:1280px;height:500px;">
            <div class="carousel-caption">
              공공 도서관 자리
            </div>
          </div>
          ...
        </div>
      
        <!-- Controls -->
        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
          <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
          <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
          <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
          <span class="sr-only">Next</span>
        </a>
      </div>
      
      <!-- 공지사항/자주하는 질문 -->
      <div class="row" style="margin-top:20px;margin-bottom:20px;">
         <!-- 공지사항 -->
         <div class="col-lg-6 col-md-6">
            <jsp:include page="/jsphome/notice/notice_main_list.jsp" flush="true" />
         </div>

         <!-- 자주하는 질문 -->
         <div class="col-lg-6 col-md-6">
            <jsp:include page="/jsphome/notice/notice_main_list.jsp" flush="true" />
         </div>
      </div>

      <div class="row" style="margin-top:20px;margin-bottom:20px;">
        <div class="col-lg-12 col-md-12">
       		<button class = "btn btn-default btn-sm" onclick = "visitDay('7');">1주일 </button>
    		<button class = "btn btn-default btn-sm" onclick = "visitDay('30');">1개월 </button>
        	<button class = "btn btn-default btn-sm" onclick = "visitDay('180');">6개월 </button>
        	<button class = "btn btn-default btn-sm" onclick = "visitDay('360');">12개월 </button>
        	<button class = "btn btn-default btn-sm" onclick = "visitDay('A');">전체 </button>
        
         </div>
        
         <div class="col-lg-12 col-md-12">
            <div id = "chartContainer" style="width:100%;height:370px;"></div>
         </div>
      </div>

   </div>
   


<script langauge="javascript">

   $(document).ready(function(){
      visitDay("A");
   });

   
   //방문자 함수
   function visitDay(type){
      
      var params = {"type":type};
   
      
      
      $.ajax({
    	  type: "get",
    	  url: "visit_statistics_default.do",
    	  cache:false,
    	  data:params,
    	  success: function(data){
    		  
			   var data_json = JSON.parse(data);    		  
    		   var dataPoints = [];
    		   
    	
    		   for (var i =0; i<data_json.length; i++) {
    			   dataPoints.push ({
    				   x: new Date(data_json[i].str_date),
    				   y: data_json[i].counter
    			   })
    		   }
    	     // console.log(dataPoints);
    	      
    	      var chart = new CanvasJS.Chart("chartContainer", {
    	         animationEnabled:true,
    	         theme:"light2",
    	         title:{
    	            text:"일별 방문자 수",
    	            fontSize:20,
    	            fontWeight:"bold"
    	         },
    	         axisX:{
    	            title:"일별 방문자 수",
    	            titleFontSize:16,
    	            titleFontWeight:"bold",
    	            valueFormatString:"YYYY-MM-DD"
    	         },
    	         axisY:{
    	            title:"Visiter",
    	            titleFontSize:16,
    	         },
    	         data:[{
    	            type:"column",
    	            yValueFormatString:"#,### 방문",
    	            dataPoints:dataPoints,
    	         }]
    	      });
    	      
    	      chart.render();      
    	    
    	  },
    	  
    	  error:function(data,status, error) {
    		  alert("통신데이터 값: " + data);
    	  }
      })
      
       
      //방문자 함수2
      function visitDay2(type){
         
         var params = {"type":type};   
         var dataPoints = [];
         
         <%for(int i=0;i<visit_list.size();i++){ %>
         <%
            visit_info = (JSONObject)visit_list.get(i);
            String x = (String)visit_info.get("str_date");
            int y = (Integer)visit_info.get("counter");
         %>
            dataPoints.push({
               x:new Date('<%=x%>'),
               y:<%=y%>
            });
            
         <%}%>

         
         var chart = new CanvasJS.Chart("chartContainer", {
            animationEnabled: true,
            theme: "light2",
            title: {
               text: "일별 방문자수",
               fontSize:20,
               fontWeight: "bolder"
            },
            axisX: {
               title: "방문 날짜",
               titleFontSize: 16,
               titleFontWeight:"bold",
               valueFormatString: "YYYY-MM-DD"
            },
            axisY: {
               title: "Visiter",
               titleFontSize: 16
            },
            data: [{
               type: "column",
               yValueFormatString: "#,### 방문",
               dataPoints: dataPoints,
            }]
         });
         
         chart.render();      
         
      }
   }
   

</script>
