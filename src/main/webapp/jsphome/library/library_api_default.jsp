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



int total_count;
total_count = libraryDAO.LibraryTotal();

int total_page = (int) Math.ceil(total_count / (10 * 1d));


out.println(library_list2);


%>


<!--  		
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>공공 도서관</title>
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />


</head>
<body>

	</body>
</html>
-->
