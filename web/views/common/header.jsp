<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.member.model.vo.Member" %>
<%
	Member loginMember=(Member)session.getAttribute("loginMember");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카복동</title>

    <script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>  

    <link
      href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=East+Sea+Dokdo&display=swap"
      rel="stylesheet">
      
 	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/headerStyle.css">   

  </head>
  
 <header> 
     <nav class="navbar__main">
      <div class="navbar__logo">
        <i class="fas fa-campground"></i>
        <a href=""> 차박왕카복동</a>
      </div>
      <div class="navbar__menu">
        <li><a href="">커뮤니티</a></li>
        <li>
          <a
            href="https://www.google.com/maps/d/u/0/viewer?ie=UTF8&oe=UTF8&msa=0&mid=1GS6L7YRskgtfzVebJsDhbgbNsyQ&ll=36.12610142320005%2C128.9769752008968&z=8"
          >
            여행지 지도
          </a>
        </li>
        <li><a href="">렌트 차 종류</a></li>
        <li><a href="">마이페이지</a></li>
        <li><a href="">Q&A</a></li>
      </div>
      <ul class="navbar__icons">
        <div class="headbar">
       <%if(loginMember==null) {%>
      <ul class="list">
        <li><a href="<%=request.getContextPath() %>/loginPage">로그인</a></li>
        <li><a href="<%=request.getContextPath() %>/enrollMember">회원 가입</a></li>
      </ul>
	<%}else {%>
	  <ul class="head-list">
	  	<li><a href="<%=request.getContextPath()%>/myPage">마이페이지</a></li>
	  	<li><a href="<%=request.getContextPath()%>/logout">로그아웃</a></li>
	  </ul>
	<%} %>
      </ul>

      <a href="#" class="navbar__toggleBtn">
        <i class="fas fa-bars"></i>
      </a>
    </nav>
  </header>
