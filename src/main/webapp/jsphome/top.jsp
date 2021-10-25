<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<nav class="navbar navbar-default">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="/">서울시 공공 도서관 정보</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
      <!--  
        <li class="active"><a href="#">Link <span class="sr-only">(current)</span></a></li>
       -->
       
        
         <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">공공도서관 <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="/library_default.do">공공도서관 리스트</a></li>
            <li><a href="/library_api_default.do" target= "blank">Restful API</a></li>
	   		<li><a href="/library_api_default2.do" target= "blank">Restful API2</a></li>
	
           </ul>
        </li>
        
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">공공도서관 지도 <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="/kakao_default.do">카카오 지도 보기</a></li>
            <li><a href="/kakao_cluster_default.do">클러스터 지도 보기</a></li>
            <li><a href="#">네이버 지도</a></li>
            <li><a href="#">구글 지도</a></li>
           </ul>
        </li>
        
        
        
         <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">커뮤니티 <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="/library_default.do">공지사항</a></li>
            <li><a href="/kakao_default.do">자유게시판</a></li>
            <li><a href="/kakao_cluster_default.do">자주하는 질문</a></li>
            <li class="divider"></li>
            <li><a href="#">Contact Us</a></li>
           </ul> 
        </li>
        
        
            
       <li class="dropdown">
         <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">관리자 <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
                <li><a href="/member_list.do">회원 리스트</a></li>
                <li><a href="/member_write_default.do">회원가입</a></li>
				<li><a href="/loginlist_default.do">로그인 리스트</a></li>
                <li class="divider"></li>
            	<li><a href="">게시판 관리</a></li>
            	<li><a href="/board_list.do">게시판</a></li>
            	<li><a href="">메일 관리</a></li>
           </ul>
        </li>
        
      </ul>
      
      <!-- 
      <form class="navbar-form navbar-left" role="search">
        <div class="form-group">
          <input type="text" class="form-control" placeholder="Search">
        </div>
        <button type="submit" class="btn btn-default">Submit</button>
      </form>
      
       -->
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#">Home</a></li>
        
        <%if((Integer)session.getAttribute("member_idx")!=null && (Integer)session.getAttribute("member_idx")!=0) {  %>
        
	        
	        <li><a href="/logout_ok.do">로그아웃</a></li>
	        <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">회원정보 <span class="caret"></span></a>
	          <ul class="dropdown-menu" role="menu">
	            <li><a href="/member_view_default.do">회원정보</a></li>
	             <li><a href="/member_modify_default.do">회원정보 수정</a></li>
	            <li><a href="/pwd_modify_default.do">비밀번호수정</a></li>
	          </ul>
	        </li>
        <%}else{ %>
	        <li><a href="/login_default.do">로그인</a></li>
        
        <%} %>
        
        
      </ul>
      
      
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>