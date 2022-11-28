<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@page import= "java.util.Set" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="cpath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>로그인 페이지</title>
	 <!--<link rel="stylesheet" href="css/login.css"> -->
	<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js" integrity="sha256-u7e5khyithlIdTpu22PHhENmPcRdFiHRjhAuHcs05RI=" crossorigin="anonymous"></script>
	<script>
	// 로그아웃 기능
		$(function(){
			$("#logout").click(function(){
				alert("로그아웃 완료");
				location.href='${cpath}/logout.do';				
			});
		});
	</script>
</head>
<body>
	<div class="panel-heading">
		<c:if test="${empty user}">
		<!-- <form class="form-inline" for="user_pw"action="${cpath}/login.do" method="post">
        	<div class="form-group">
               <label for="member_id">ID : </label>
               <input type="text" class="form-control" name="user_id"/>
        	</div>
        	<div class="form-group">
               <label >Password : </label>
               <input type="password" class="form-control" name="user_pw"/>
        	</div>
        	<button type="submit" class="btn btn-default">로그인</button>
        	<button type="button" class="btn btn-default" onclick="location.href='${cpath}/signIn.do'">회원가입</button>
    	</form>  -->
    	<section class="login-form">
        	<h1>LOGIN</h1>
        	<form class="form-inline" action="${cpath}/login.do" method="post"> 
            	<div class="int-area">
                	<input type="text" class="form-control" name="user_id" autocomplete="off" required>
                	<label for="member_id">ID</label>
            	</div>
            	<div class="int-area">
                	<input type="password" class="form-control" name="user_pw" autocomplete="off" required>
                	<label>PASSWORD</label>
            	</div>
            	<div class="btn-area">
                	<button type="submit" class="btn btn-default">LOGIN</button>
                	<button type="button" class="btn btn-default" onclick="location.href='${cpath}/signIn.do'">회원가입</button>
            	</div>
        	</form>
        	<div class="caption">
            	<a href="">Forgot Password>?</a>
        	</div>
    	</section>
		</c:if>
		<c:if test="${!empty user}">
			<div class="form-group">
				<label>${user.user_nick}(${user.user_id})님 방문을 환영합니다.</label>
			</div>
			<div class="form-group">
				<button type="submit" id="logout" class="btn btn-default">로그아웃</button>
				<button class="btn btn-default" onclick="location.href='${cpath}/userDelete.do'">회원탈퇴</button>
			</div>
			<div class="form-group">
				<button type="button" onclick="location.href='${cpath}/planInsertForm.do'">일정 추가</button>
			</div>
		</c:if>
	</div>
</body>
</html>