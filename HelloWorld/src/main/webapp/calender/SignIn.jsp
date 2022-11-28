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
	<title>회원가입 페이지</title>
	<link rel="stylesheet" href="css/SignIn.css">
	<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js" integrity="sha256-u7e5khyithlIdTpu22PHhENmPcRdFiHRjhAuHcs05RI=" crossorigin="anonymous"></script>
	<script>
	// 비밀번호 확인 기능
		$(function(){
			$("#alert-success").hide();
			$("#alert-fail").hide();
			
			$(".pw").keyup(function(){
				var pw1 = $("#user_pw").val();
				var pw2 = $("#user_pw2").val();
				
				if(pw1 != "" || pw2 != ""){
					if(pw1 == pw2){
						$("#alert-success").show();
						$("#alert-fail").hide();
						$("#submit").removeAttr("disabled");
					} else{
						$("#alert-success").hide();
						$("#alert-fail").show();
						$("#submit").attr("disabled", "disabled");
					}
				}
			})
		})
	</script>

	<script>
	// 아이디 중복 확인 기능
	$(function(){
		$("#idCheck").click(function(){
			let user_id = $("#user_id").val();
			$.ajax({
				url : "${cpath}/idCheck.do",
				type : "get",
				data : {"user_id":user_id},
				dataType : "json",
				success : function(result){
					if(result != ""){
						alert("사용할 수 없는 ID입니다.");
					} else{
						alert("사용할 수 있는 ID입니다.");
					}
				},
				error : function(){
					alert("통신 실패");
				}
			})
			
		})
	 })
	</script>

	<!-- <script src="${cpath}/calender/js/confirmID.js"></script>-->
</head>
<body>
<div class="form-group">
	<section class="Regist-form">
        <h1>회 원 가 입</h1>
        <form method="post" action="${cpath}/userInsert.do">
             <!-- 아이디 --> 
            <div class="reg-area">
                <input type="text" class="form-control" id="user_id" name="user_id" autocomplete="off" required>
                <label for="id">ID</label>
                <button type="button" id="idCheck">중복</button>
            </div>
            <!-- 비밀번호 -->
            <div class="reg-area">
                <input type="password" class="pw form-control" id="user_pw" name="user_pw" autocomplete="off" required>
                <label for="user_pw">PASSWORD</label>
            </div>
            <!-- 비밀번호 확인 -->
            <div class="reg-area">
                <input type="password" class="pw form-control" id="user_pw2" name="user_pw2" autocomplete="off" required>
                <label for="user_pw2">Confirm PASSWORD</label>
                <div id="alert-success" style="color:blue;">비밀번호가 일치합니다.</div>
                <div id="alert-fail" style="color:red;">비밀번호가 일치하지 않습니다.</div>
            </div>
             <!-- 이름 -->
            <div class="reg-area">
                <input class="form-control" id="user_nick" name="user_nick" autocomplete="off" required>
                <label for="user_nick">NickName</label>
            </div>
            <!-- 휴대전화 -->
            <div class="reg-area">
                <input type="text" class="form-control" id="user_hp" name="user_hp" autocomplete="off" required>
                <label for="user_hp">Phone Number</label>
            </div>

            <!--  이메일 -->
            <div class="reg-area">
                <input type="text" class="form-control" name="user_email" id="user_email" autocomplete="off" required>
                <label for="user_email">E-mail</label>
            </div>
            <div class="btn-area">
                <button type="submit" class="signup_btn">가입</button>
                <button type="submit" class="cancel_btn" onclick="location.href='${cpath}/index.do'">취소</button>
            </div>
        </form>
    </section>
</div>
</body>
</html>