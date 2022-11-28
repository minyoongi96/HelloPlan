<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import= "java.util.Set" %>
<%@page import= "java.util.List" %>
<%@page import= "javax.servlet.http.HttpSession" %>
<%@page import= "kr.calender.entity.Plan" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="cpath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset='utf-8' />
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"> -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script> -->
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src='${cpath}/myView/fullcalendar-5.11.2/lib/main.js'></script>
<script src="${cpath}/myView/fullcalendar-5.11.2/lib/main.min.js"></script>
<!-- <script src='../lib/main.js'></script> -->
<!-- <script src="../lib/main.min.js"></script> -->
<!-- <link rel='stylesheet' href='../lib/btn-style.css'/> -->
<link rel='stylesheet' href='${cpath}/myView/fullcalendar-5.11.2/lib/myStyle2.css'/>
<link rel='stylesheet' href='${cpath}/myView/fullcalendar-5.11.2/lib/main.css'/>
<script>
	var today = new Date();
	var month = today.getMonth() +1;
	var date = today.getDate();
	var g_arg;
    var calendar;
	var todayStr = today.getFullYear() + '-' + month + '-' + date;
	// 현재 유저의 일
	var sch;

  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
    
      headerToolbar: {
        left: '',
        center: 'prev title next',
        right: 'dayGridMonth,timeGridDay'
      },
      height: 700,
      titleFormat: function(date){
    	  if(date.date.month + 1 < 10){
    		  return date.date.year + ". 0" + (date.date.month + 1);
    	  } else{
    		  return date.date.year + ". " + (date.date.month + 1);
    	  }
      },
      dateClick: function(info){
    	 
    	  //console.log(JSON.stringify(info.view));
      },
    	  
      locale: 'ko',
      slotMinTime: '01:00',
      slotMaxTime: '24:00',
      //initialDate: '2022-08-26',
     navLinks: true, // can click day/week names to navigate views
      selectable: true,
      selectMirror: true,
      select: function(arg){
        insertModalOpen(arg);
      },
      
      eventClick: function(info) {				// 등록된 일정클릭하면 상세보기로 이
    	  
		  var plan_seq = info.event._def.publicId;	// 해당 이벤트의 pk출력  
		  $.ajax({
			  type: "get",
			  url: "${cpath}/planSelect.do",
			  data: {"plan_seq":plan_seq},
			  dataType: "json",
			  success: function(response){
				  $("#planListModal").fadeIn();
				  $("#plan_seq").val(response.plan_seq);
				  $("#edit_YN").val(response.all_day);
				  $("#edit_s_date").val(response.plan_s_date.split(" ")[0]);
				  $("#edit_s_time").val(response.plan_s_date.split(" ")[1]);
				  $("#edit_e_date").val(response.plan_e_date.split(" ")[0]);
				  $("#edit_e_time").val(response.plan_e_date.split(" ")[1]);
				  
				  if(response.all_day == 0){
					  $("input:checkbox[id='edit_all_day']").prop("checked", false);
					  $("#edit_s_time").show();
					  $("#edit_s_time").attr("disabled", false);
					  $("#edit_e_time").show();
					  $("#edit_e_time").attr("disabled", false);
				  
				  }
				  $(".plan_lat").val(response.plan_lat);
				  $(".plan_lon").val(response.plan_lon);
				  $("#edit_map").val(getAddress(response.plan_lat, response.plan_lon));
				  $("#edit_title").val(response.plan_title);
				  $("#edit_desc").val(response.plan_desc);
				  
			  },
			  error: function(){alert("실패");}
		  })
      },
      
      /* eventChange: function(arg){
		    //allDay true로 바꾸면 end가 없어서 만듬
		    if(arg.event.end == null){
		    	var end = new Date();
		    	end.setDate(arg.event.start.getDate()+1);
		    	arg.event.setEnd(end);	
		    }
	    },
      eventResize: function(arg){
		  insertModalOpen(arg);		//이벤트 사이즈 변경시(일정변경) 모달 호출
	    }, */
      events: [				// db에서 이벤트 불러오
    		  $.ajax({
          		type: "get",
          		url: "${cpath}/planSelectAll.do",
          		//data: {},
          		dataType: "json",
          		success: function(response){
          			for(var i = 0; i < response.length; i++){
          				calendar.addEvent({
          					id : parseInt(response[i]['id']),
          					title : String(response[i]['title']),
          					start : String(response[i]['start']),
          					end : String(response[i]['end']),
          					allDay : Boolean(response[i]['allDay'])
          				});
          			}
          		},
          		
         	})
     ],
      editable: true,
      dayMaxEvents: true, // allow "more" link when too many events
      
    });

    calendar.render();
  });
	
  
  //stringFormat date.getMonth() 또는 getDate()가 한자리수 일때 0 추가
  function stringFormat(p_val){
	  if(p_val < 10)
		  return p_val = '0'+p_val;
	  else
		  return p_val;
  }

  
  
//id 중복 확인, 비밀번호 확
	$(function(){
		var result1 = 0;
		var result2 = 0;
		$("#doSignUp").attr("type", "button");
		
		$("#idCheck").click(function(){
			let user_id = $("#signupModal #user_id").val();
			$.ajax({
				url : "${cpath}/idCheck.do",
				type : "get",
				data : {"user_id":user_id},
				dataType : "json",
				success : function(result){
					if(result != "" || user_id == ""){
						alert("사용할 수 없는 ID입니다.");
						result1 = 0;
					} else{
						alert("사용할 수 있는 ID입니다.");
						result1 =1;
					}
				},
				error : function(){
					alert("통신 실패");
				}
			})
		})

		// 비밀번호 확인
		$("#signupModal #alert-success").hide();
		$("#signupModal #alert-fail").hide();
		
		$("#signupModal #user_pw2").keyup(function(){
			var pw1 = $("#signupModal #user_pw").val();
			var pw2 = $("#signupModal #user_pw2").val();
			
			if(pw1 != "" || pw2 != ""){
				if(pw1 == pw2){
					$("#signupModal #alert-success").show();
					$("#signupModal #alert-fail").hide();
					result2 = 1;
					
				} else{
					$("#signupModal #alert-success").hide();
					$("#signupModal #alert-fail").show();
					result2 = 0;
				}
			}
		});
		$("#doSignUp").click(function(){
			
			if(result1 == 1 && result2 == 1){	
				$("#doSignUp").attr("type", "submit");
			}
		})
	});
</script>

<script>	
	$(document).ready(function () {
	    //iframe url 삽입
	    let id = {{ id }};
	    let href = '/map?id='+id
	    $('#go-map').attr("src",href)
	});
</script>

<script>
//일정 추가화면에서 종일 체크박스 동작 설정 
$(function() {
	$("#plan_s_time").hide();
	$("#plan_e_time").hide();
	$("#all_day").change(function() {
		if ($(this).is(':checked')) {
			$("#plan_s_time").hide();
			$("#plan_s_time").attr("disabled")
			$("#plan_s_time").val("");
			$("#plan_e_time").hide();
			$("#plan_e_time").attr("disabled")
			$("#plan_e_time").val("");
		} else {
			$("#plan_s_time").show();
			$("#plan_s_time").attr("disabled", false);
			$("#plan_e_time").show();
			$("#plan_e_time").attr("disabled", false);
		}
	})
})
// 일정 상세보기에서 수정할 때 종일 체크박스 동작 설정 
$(function() {
	$("#edit_s_time").hide();
	$("#edit_e_time").hide();
	$("#edit_all_day").change(function() {
		if ($(this).is(':checked')) {
			$("#edit_s_time").hide();
			$("#edit_s_time").val("");
			$("#edit_s_time").attr("disabled")
			$("#edit_e_time").hide();
			$("#edit_e_time").val("");
			$("#edit_e_time").attr("disabled")
		} else {
			$("#edit_s_time").show();
			$("#edit_s_time").attr("disabled", false);
			$("#edit_e_time").show();
			$("#edit_e_time").attr("disabled", false);
		}
	})
})
// 일정 추가에서 수정할 때 all_day값 설정  
$(function(){
	$("#all_day").change(
		function(){
			if($("#all_day").is(":checked")){
				$("#YN").val(1);
		  	} else {
				$("#YN").val(0);
			}
		}
	)
})
// 일정 상세보기에서 수정 할 때 all_day값 설정 
$(function(){
	$("#edit_all_day").change(
		function(){
			if($("#edit_all_day").is(":checked")){
				$("#edit_YN").val(1);
		  	} else {
				$("#edit_YN").val(0);
			}
		}
	)
})
</script>
<script>
	// 일정 상세보기에서 삭제 기능 
	function goPlanDelete(){
		var plan_seq = $("#plan_seq").val();
		if(confirm("일정을 삭제하시겠습니까?")){
			location.href = "${cpath}/planDelete.do?plan_seq=" + plan_seq;	
		}
		
	}
</script>

<style>

  body {
    margin: 40px 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width: 1100px;
    margin: 0 auto;
  }

  .fc-toolbar-chunk {
  	display: flex;
  	align-items: center;
  }
  
  /* #userinfo button{
  	margin-bottom: 10px;
  } */
  
  .fc-next-button.fc-button.fc-button-primary, .fc-prev-button.fc-button.fc-button-primary{
  	padding: 0px 4px;
  }
  
  .fc-button-group{
  	margin: 0px;
  	border: 0px;
  	padding: 5px;
  }
  
  #fc-dom-1{
  	font-size: 30px;
  }
header {
	height: 75px;
	padding: 1rem;
	color: white;
	background: teal;
	font-weight: bold;
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: -40px;
	margin-left: -10px;
	margin-right: -10px;
}

h1, p {
	margin: 0;
}

main {
	padding: 1rem;
	height: 100%;
}

body {
	background: #EEE;
}

body, html {
	height: 100%;
}

* {
	box-sizing: border-box;
}

header {
	margin-top: -40px;
	margin-left: -10px;
	margin-right: -10px;
}

</style>
</head>
<body>
	<%-- <c:if test="${empty user}">
		<div id="userinfo">
  		<!-- fc-dayGridWeek-button fc-button fc-button-primary -->
	    <button type="button" class="btn" data-toggle="modal" data-target="#loginModal">Login</button>
	    <button type="button" class="btn" data-toggle="modal" data-target="#signupModal">Signup</button>
	  	</div>
  </c:if>
  <c:if test="${!empty user}">
		<div id="userinfo">
  		<!-- fc-dayGridWeek-button fc-button fc-button-primary -->
	    <button type="button" class="btn" onclick="location.href='${cpath}/logout.do'">Logout</button>
	    <button type="button" class="btn" data-toggle="modal" data-target="#addPlanModal">Add Plan</button>
	    <p id="hi">${user.user_nick}님 안녕하세요.</p>
	  	</div>
  </c:if> --%>
  
  <header>
		<img src="${cpath}/image/Logo.png" style="margin-left: -7px;">
		<h1 style="margin-left: 7px;">HelloPlan</h1>
		<nav>
			<c:if test="${empty user}">
				<div id="userinfo" style="margin-left: 75px;">
					<!-- fc-dayGridWeek-button fc-button fc-button-primary -->
					<span></span>
					<button type="button" class="btn" data-toggle="modal"
						data-target="#loginModal">Login</button>
					<span><button type="button" class="btn" data-toggle="modal"
							data-target="#signupModal">Signup</button></span>
				</div>
			</c:if>
			<c:if test="${!empty user}">
				<div id="userinfo" style="margin-left: 75px;">
					<!-- fc-dayGridWeek-button fc-button fc-button-primary -->
					<span><button type="button" class="btn"
							onclick="location.href='${cpath}/logout.do'">Logout</button></span>
					<span><button type="button" class="btn" data-toggle="modal"
							data-target="#addPlanModal">AddPlan</button></span>
					<%-- <p id="hi">${user.user_nick}님안녕하세요.</p> --%>
				</div>
			</c:if>
		</nav>
	</header>
  
  <div id='calendar'></div>
  
  
  
  <!--로그인 화면-->
    <!-- The Modal -->
    <div class="modal" id="loginModal">
    	<div class="modal-dialog modal-dialog-centered">
    		<div class="modal-content">
    			<div class="modal-footer"></div>
    			<div class="modal-body">
    				<div class="container">
	        			<h1 class="westagram">MyCalendar</h1>
	        			<form action="${cpath}/login.do" method="post">
	        			<main class="bigbox">
            				<div class="inputs">
            					<input name="user_id" id ="user_id" type="text" placeholder="아이디" required></input>
            					<input name="user_pw" id = "user_pw" type="password" placeholder="비밀번호" required></input>
            				</div>
        					<div class="btn-container">
            					<button type="submit" class="btn2">로그인</button>
        					</div>
        					<div class="or">
            					<div class="line-l"></div>
            					<div class="centerchar">또는</div>
            					<div class="line-r"></div>
        					</div>
					        <div class="forget-box">
					        	<button type="button" class="btn2" onclick="location.href='${cpath}/signUp.do'">로그인하기</button>
					        </div>
					        <div class="forget-box">
					        	<button type="reset" class="btn-join" data-dismiss="modal">취소</button>
					        </div>
        				</main>
        				</form>
        			</div>
        			<div class="modal-footer"></div>
       			</div>
       		</div>
       	</div>
    </div>
    
    <!-- 회원가입 화면 -->
    <div class="modal" id="signupModal">
    	<div class="modal-dialog modal-dialog-centered">
	    	<div class="modal-content">
	    		<div class="modal-footer"></div>
	    		<div class="modal-body">
    				<div class="container">
    					<h1 class="westagram">회원가입</h1>
					    <form method="post" action="${cpath}/userInsert.do">
					    	<main class="bigbox">
					    		<div class="inputs">
									<div>
										<input type="text" id="user_id" name="user_id"
											autocomplete="off" placeholder="아이디" required
											style="width: 203px;" />
										<button type="button" id="idCheck">중복</button>
									</div>
									<input type="password" id="user_pw" name="user_pw"
										autocomplete="off" placeholder="비밀번호" required /> <input
										type="password" id="user_pw2" name="user_pw2"
										autocomplete="off" placeholder="비밀번호확인" required />
									<div id="alert-success"
										style="color: blue; float: left; position: relative; left: 23px;">비밀번호가
										일치합니다.</div>
									<div id="alert-fail"
										style="color: red; float: left; position: relative; left: 23px;">비밀번호가
										일치하지 않습니다.</div>
									<input type="text" id="user_nick" name="user_nick"
										autocomplete="off" placeholder="닉네임" required /> <input
										type="text" id="user_hp" name="user_hp" autocomplete="off"
										placeholder="핸드폰번호" required /> <input type="text"
										id="user_email" name="user_email" autocomplete="off"
										placeholder="이메일" required />
								</div>       
					       		<div class="btn-container">
					        		<button id="doSignUp" type="submit" class="btn2">가입하기</button>
					       		</div>
					        	<div class="or">
						            <div class="line-l"></div>
						            <div class="centerchar">또는</div>
						            <div class="line-r"></div>
					        	</div>
					        	<div class="btn-container">
					            	<button type="button" class="btn2" data-dismiss="modal">취소하기</button>
					        	</div>
					    	</main>
    					</form>
    				</div>	
    			</div>
    			<div class="modal-footer"></div>
    		</div>
    	</div>
    </div>
    


	<!-- 일정 추가 화면 -->
   <!-- The Modal -->
    <div class="modal" id="addPlanModal">
      <div class="modal-dialog modal-dialog-centered" >
        <div class="modal-content">
          
          <!-- <div class="modal-header"></div> -->
          
          <div class="modal-body">
            <div class="plancontainer">
              <h1 class="westagram">일정추가</h1>
              <form action="${cpath}/planInsert.do" method="post">
                <main class="bigbox">         
                  	 <!--  <div class="inputs"> -->
	               	  <div class="row">
				          <div class="col-xs-12">
				              <input type="hidden" id="YN" name="YN" value="1"/>
				              <label class="col-xs-4" for="all-day">종일</label>
				              <input type="checkbox" id ="all_day"  name="all_day" autocomplete="off" style="position:relative;right:95px;" checked>
				          </div>
				        </div>
				        <div class="row">
				          <div class="col-xs-12">
				              <label class="col-xs-4" for="plan_s_date">시작</label>
				              <input class="inputModal" type="date" id="plan_s_date" name="plan_s_date" style="position:relative;left:15px;" autocomplete="off"/>
				              <input class="inputModal" type="time" name="plan_s_time" id="plan_s_time" style="position:relative;left:58px;" disabled />
				          </div>
				        </div>
				        <div class="row">
				          <div class="col-xs-12">
				              <label class="col-xs-4" for="plan_s_date">끝</label>
				              <input class="inputModal" type="date" id="plan_e_date" name="plan_e_date" style="position:relative;left:28px;"  autocomplete="off"/>
				              <input class="inputModal" type="time" name="plan_e_time" id="plan_e_time" style="position:relative;left:58px;" disabled />
				          </div>
				        </div>
				        <div class="row">
				          <div class="col-xs-12">
				              <label class="col-xs-4" for ="plan_title">일정명</label>
				              <input class="inputModal" type="text" id ="plan_title" name="plan_title" autocomplete="off" required="required" style="position:relative;left:4px;"/>
				          </div>
				        </div>
				        <div>
				            <label class="col-xs-4" for="plan_map">장소</label>
				            <input type="text" class="inputModal mapView" id="plan_map" name="plan_map" data-toggle="modal" data-target="#mapModal" style="position:relative;left:15px;"/>
				            <input type="hidden" class="plan_lat" name="plan_lat"/>
				            <input type="hidden" class="plan_lon" name="plan_lon"/>
				        </div>  
				        <div class="row">
				          <div class="col-xs-12">
				              <label class="col-xs-4" for="edit-desc">내용</label> 
				              <textarea rows="3" cols="35" class="inputModal" id="plan_desc" name="plan_desc"
				               style='position:relative;left:15px; resize: none;'></textarea>
				          </div>
				        </div>
                 	
					<!-- </div>  -->
               
		                <div class="or2">
		                  <div class="line-l" style="position:relative;width:300px;margin-top:15px"></div>
         
		                </div>
		                 <div class="btn-container3" style="text-align: center;">
		                  <button class="btn2" type="button" id="hotplacebtn" data-toggle="modal" data-target="#hotplaceModal">맛집</button>
		                  <button class="btn2" type="button" id="cafebtn" data-toggle="modal" data-target="#cafeModal">카페</button>
		                  <button class="btn2" type="button" id="hotelbtn" data-toggle="modal" data-target="#hotelModal">숙소</button>		               
		                </div>
		                  
		                <div class="or2">		                  
		                  <div class="line-r" style="position:relative;width:300px;"></div>
		                </div>
		                <div class="btn-container2" style="text-align: center;">
		                    <button class="btn2" type="submit" id="submit" style="margin:5px;">추가</button>
		                    <button class="btn2" type="button" id="cancel" style="margin:5px;" onclick="location.href='${cpath}/index.do'">취소</button>
		                </div>
		               
     	      </main>
            </form>
          </div>
       </div>

          <div class="modal-footer">
            
          </div>
        </div>
      </div>
    </div>
    <!-- 일정 상세보기 화면 -->
    
       <div class="modal fade" id="planListModal">
      <div class="modal-dialog modal-dialog-centered" >
        <div class="modal-content">
          
          <!-- <div class="modal-header"></div> -->
          
          <div class="modal-body">
            <div class="plancontainer">
              <h1 class="westagram">상세보기</h1>
              <form action="${cpath}/planUpdate.do" method="post">
                <main class="bigbox">         
                  	 <!--  <div class="inputs"> -->
                  	 <div class="row">
				          <div class="col-xs-12">
				          	  <input type="hidden" id="plan_seq" name="plan_seq"/>
				              <input type="hidden" id="edit_YN" name="edit_YN" value="1"/>
				              <label class="col-xs-4" for="edit_all-day">종일</label>
				              <input type="checkbox" id ="edit_all_day"  name="edit_all_day" autocomplete="off" style="position:relative;right:95px;" checked>
				          </div>
				        </div>
				        <div class="row">
				          <div class="col-xs-12">
				              <label class="col-xs-4" for="edit_s_date">시작</label>
				              <input class="inputModal" type="date" id="edit_s_date" name="edit_s_date" style="position:relative;left:15px;" autocomplete="off"/>
				              <input class="inputModal" type="time" name="edit_s_time" id="edit_s_time" style="position:relative;left:58px;" disabled />
				          </div>
				        </div>
				        <div class="row">
				          <div class="col-xs-12">
				              <label class="col-xs-4" for="edit_s_date">끝</label>
				              <input class="inputModal" type="date" id="edit_e_date" name="edit_e_date" style="position:relative;left:28px;"  autocomplete="off"/>
				              <input class="inputModal" type="time" name="edit_e_time" id="edit_e_time" style="position:relative;left:58px;" disabled />
				          </div>
				        </div>
				       <div class="row">
				          <div class="col-xs-12">
				              <label class="col-xs-4" for="edit_title">일정명</label>
				              <input class="inputModal" type="text" name="edit_title" id ="edit_title" required="required" style="position:relative;left:4px;"/>
				          </div>
				       </div>
				        <div>
				            <label class="col-xs-4" for="edit_map">장소 </label>
				            <input type="text" class="inputModal mapView" id="edit_map" name="edit_map" style="position:relative;left:15px;"/>
				            <input type="hidden" class="plan_lat" name="plan_lat"/>
				            <input type="hidden" class="plan_lon" name="plan_lon"/>
				        </div>  
				        <div class="row">
				          <div class="col-xs-12">
				              <label class="col-xs-4" for="edit_desc">내용</label> 
				              <textarea rows="3" cols="35" class="inputModal" id="edit_desc" name="edit_desc"
				               style='position:relative;left:15px; resize: none;'></textarea>
				          </div>
				        </div>
                 	
					<!-- </div>  -->
               
		                <div class="or2">
		                  <div class="line-l" style="position:relative;width:300px;margin-top:15px"></div>
         
		                </div>
		                
		                <div class="btn-container3" style="text-align: center;">
			                  <button class="btn2" type="button" id="hotplacebtn" data-toggle="modal" data-target="#hotplaceModal">맛집</button>
			                  <button class="btn2" type="button" id="cafebtn" data-toggle="modal" data-target="#cafeModal">카페</button>
			                  <button class="btn2" type="button" id="hotelbtn" data-toggle="modal" data-target="#hotelModal">숙소</button>
			                  <!-- <button class="btn2" type="button" id="jjimbtn" data-toggle="modal" data-target="#jjimModal">찜</button> -->
		                </div>
		       
		                <div class="or2">		                  
		                  <div class="line-r" style="position:relative;width:300px;"></div>
		                </div>
		                <div class="btn-container2" style="text-align: center;">
		                	<button class="btn2" type="submit" id="submitPlan" style="margin:5px;">수정</button>	                    
		                    <button class="btn2" type="button" id="deletePlan" style="margin:5px;"onclick="goPlanDelete()">삭제</button>
		                    <button class="btn2" type="button" id="cancelPlan" style="margin:5px;" onclick="location.href='${cpath}/index.do'">취소</button>
		                </div>
		                
		                
     	      </main>
            </form>
          </div>
       </div>

          <div class="modal-footer">
            
          </div>
        </div>
      </div>
    </div>
    
    <!-- 지도 모달 -->
    <div class="modal" id="mapModal">
    	<div class="modal-dialog modal-dialog-centered">
    		<div class="modal-content">
    			
    			<div class="modal-body">
    				<div class="container">
	        			<div id="map" style="width: 330px; height: 600px;"></div>
        			</div>
       			</div>
       			<div class="modal-footer">
        				키워드 : <input type="text" value="" id="keyword" size="10" style="width:100px;">
						<button type="button" id="searchPlace">검색하기</button>
						<button type="button" id="insertLanLon">저장</button>
						<button type="button" onclick="closeMap()">취소</button>
        			</div>
       		</div>
       	</div>
    </div>

  <!-- 핫플레이스모달 -->
	  <div class="modal" id="hotplaceModal">
	    	<div class="modal-dialog modal-dialog-centered">
	    		<div class="modal-content">
	    			<div class="modal-footer"></div>
	    			<div class="modal-body">
	    				<div class="container">
		        			<h1 class="westagram"></h1>
		        			<form action="" method="post">
		        			<main class="bigbox">
	            				
	        				</main>
	        				</form>
	        			</div>
	        			<div class="modal-footer"></div>
	       			</div>
	       		</div>
	       	</div>
	    </div>
  <!-- 카페 모달 -->
  	  <div class="modal" id="cafeModal">
	    	<div class="modal-dialog modal-dialog-centered">
	    		<div class="modal-content">
	    			<div class="modal-footer"></div>
	    			<div class="modal-body">
	    				<div class="container">
		        			<h1 class="westagram"></h1>
		        			<form action="" method="post">
		        			<main class="bigbox">
	            	

	        				</main>
	        				</form>
	        			</div>
	        			<div class="modal-footer"></div>
	       			</div>
	       		</div>
	       	</div>
	    </div>	  
  <!-- 숙소 모달 -->
  	  <div class="modal" id="hotelModal">
	    	<div class="modal-dialog modal-dialog-centered">
	    		<div class="modal-content">
	    			<div class="modal-footer"></div>
	    			<div class="modal-body">
	    				<div class="container">
		        			<h1 class="westagram"></h1>
		        			<form action="" method="post">
		        			<main class="bigbox">
	            				
	        				</main>
	        				</form>
	        			</div>
	        			<div class="modal-footer"></div>
	       			</div>
	       		</div>
	       	</div>
	    </div>	
	    
	<!-- 찜 모달 -->
  	  <div class="modal" id="jjimModal">
	    	<div class="modal-dialog modal-dialog-centered">
	    		<div class="modal-content">
	    			<div class="modal-footer"></div>
	    			<div class="modal-body">
	    				<div class="container">
		        			<h1 class="westagram"></h1>
		        			<form action="" method="post">
		        			<main class="bigbox">
	            				
	        				</main>
	        				</form>
	        			</div>
	        			<div class="modal-footer"></div>
	       			</div>
	       		</div>
	       	</div>
	    </div>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=347043bd3d370c38a47a80dd10319839&libraries=services"></script>	
	<script>
	// 지도 모달 닫기 
	function closeMap(){
		$("#plan_map").val("");
		$("#edit_map").val("");
		$(".plan_lat").val("");
		$(".plan_lon").val("");
		$("#mapModal").fadeOut();
	}
	
	// 일정 추가에서 지도 모달 열기 
	$("#plan_map").click(function(){
		$("#mapModal").fadeIn();
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
	})
	
	// 일정 수정에서 지도 모달 열기 
	$("#edit_map").click(function(){
		var lat = 33.450701;
		var lon = 126.570667;
		if($(".plan_lat").val() != 0 || $(".plan_lon").val() != 0){
			lat = $(".plan_lat").val();
			lon = $(".plan_lon").val();
		}
		$("#mapModal").fadeIn();
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(lat, lon), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
	})
	
	// 좌표값 받아서 주소로 바꾸기 
	function getAddress(plan_lat, plan_lon){
		let geocoder = new kakao.maps.services.Geocoder();

	    let coord = new kakao.maps.LatLng(plan_lat, plan_lon);
	    let callback = function(result, status) {
	        if (status === kakao.maps.services.Status.OK) {
	            console.log(result[0].road_address.address_name);
	            
	        }
	        return result[0].road_address.address_name;
	    }
	    geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
	    
	}

	// 검색 버튼으로 주소로 좌표를 검색합니다
	$("#searchPlace").click(function(){
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 

		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places(); 

		// 키워드로 장소를 검색합니다
		ps.keywordSearch($("#keyword").val(), placesSearchCB); 

		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
		function placesSearchCB (data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        var bounds = new kakao.maps.LatLngBounds();

		        for (var i=0; i<data.length; i++) {
		            displayMarker(data[i]);    
		            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
		        }       

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		        map.setBounds(bounds);
		    } 
		}

		// 지도에 마커를 표시하는 함수입니다
		function displayMarker(place) {
		    
		    // 마커를 생성하고 지도에 표시합니다
		    var marker = new kakao.maps.Marker({
		        map: map,
		        position: new kakao.maps.LatLng(place.y, place.x) 
		    });

		    // 마커에 클릭이벤트를 등록합니다
		    kakao.maps.event.addListener(marker, 'click', function() {
		        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
		        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
		        infowindow.open(map, marker);
		        $("#plan_map").val(place.road_address_name);
				$("#edit_map").val(place.road_address_name);
				$(".plan_lat").val(place.y);
				$(".plan_lon").val(place.x);
		        console.log($("#edit_map").val());
		        console.log($(".plan_lat").val());
		        console.log($(".plan_lon").val());
		    });
		    
		    $("#insertLanLon").click(function(){
	    		$("#mapModal").fadeOut();
	        })
		}
	});
 
	</script>
	<!-- <script>
		// 마커를 담을 배열입니다
		var markers = [];

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places();

		// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
			zIndex : 1
		});

		// 키워드로 장소를 검색합니다
		searchPlaces();

		// 키워드 검색을 요청하는 함수입니다
		function searchPlaces() {

			var keyword = document.getElementById('keyword').value;

			/* if (!keyword.replace(/^\s+|\s+$/g, '')) {
				alert('키워드를 입력해주세요!');
				return false;
			} */

			// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
			ps.keywordSearch(keyword, placesSearchCB);
		}

		// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
		function placesSearchCB(data, status, pagination) {
			if (status === kakao.maps.services.Status.OK) {

				// 정상적으로 검색이 완료됐으면
				// 검색 목록과 마커를 표출합니다
				displayPlaces(data);

				// 페이지 번호를 표출합니다
				displayPagination(pagination);

			} else if (status === kakao.maps.services.Status.ZERO_RESULT) {

				alert('검색 결과가 존재하지 않습니다.');
				return;

			} else if (status === kakao.maps.services.Status.ERROR) {

				alert('검색 결과 중 오류가 발생했습니다.');
				return;

			}
		}

		// 검색 결과 목록과 마커를 표출하는 함수입니다
		function displayPlaces(places) {

			var listEl = document.getElementById('placesList'), menuEl = document
					.getElementById('menu_wrap'), fragment = document
					.createDocumentFragment(), bounds = new kakao.maps.LatLngBounds(), listStr = '';

			// 검색 결과 목록에 추가된 항목들을 제거합니다
			removeAllChildNods(listEl);

			// 지도에 표시되고 있는 마커를 제거합니다
			removeMarker();

			for (var i = 0; i < places.length; i++) {

				// 마커를 생성하고 지도에 표시합니다
				var placePosition = new kakao.maps.LatLng(places[i].y,
						places[i].x), marker = addMarker(placePosition, i), itemEl = getListItem(
						i, places[i]); // 검색 결과 항목 Element를 생성합니다

				// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
				// LatLngBounds 객체에 좌표를 추가합니다
				bounds.extend(placePosition);

				// 마커와 검색결과 항목에 mouseover 했을때
				// 해당 장소에 인포윈도우에 장소명을 표시합니다
				// mouseout 했을 때는 인포윈도우를 닫습니다
				(function(marker, title) {
					kakao.maps.event.addListener(marker, 'mouseover',
							function() {
								displayInfowindow(marker, title);
							});

					kakao.maps.event.addListener(marker, 'mouseout',
							function() {
								infowindow.close();
							});

					itemEl.onmouseover = function() {
						displayInfowindow(marker, title);
					};

					itemEl.onmouseout = function() {
						infowindow.close();
					};
				})(marker, places[i].place_name);

				fragment.appendChild(itemEl);
			}

			// 검색결과 항목들을 검색결과 목록 Element에 추가합니다
			listEl.appendChild(fragment);
			menuEl.scrollTop = 0;

			// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			map.setBounds(bounds);
		}

		// 검색결과 항목을 Element로 반환하는 함수입니다
		function getListItem(index, places) {

			var el = document.createElement('li'), itemStr = '<span class="markerbg marker_'
					+ (index + 1)
					+ '"></span>'
					+ '<div class="info">'
					+ '   <h5>' + places.place_name + '</h5>';

			if (places.road_address_name) {
				itemStr += '    <span>' + places.road_address_name + '</span>'
						+ '   <span class="jibun gray">' + places.address_name
						+ '</span>';
			} else {
				itemStr += '    <span>' + places.address_name + '</span>';
			}

			itemStr += '  <span class="tel">' + places.phone + '</span>'
					+ '</div>';

			el.innerHTML = itemStr;
			el.className = 'item';

			return el;
		}

		// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
		function addMarker(position, idx, title) {
			var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
			imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
			imgOptions = {
				spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
				spriteOrigin : new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
				offset : new kakao.maps.Point(13, 37)
			// 마커 좌표에 일치시킬 이미지 내에서의 좌표
			}, markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
					imgOptions), marker = new kakao.maps.Marker({
				position : position, // 마커의 위치
				image : markerImage
			});

			marker.setMap(map); // 지도 위에 마커를 표출합니다
			markers.push(marker); // 배열에 생성된 마커를 추가합니다

			return marker;
		}

		// 지도 위에 표시되고 있는 마커를 모두 제거합니다
		function removeMarker() {
			for (var i = 0; i < markers.length; i++) {
				markers[i].setMap(null);
			}
			markers = [];
		}

		// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
		function displayPagination(pagination) {
			var paginationEl = document.getElementById('pagination'), fragment = document
					.createDocumentFragment(), i;

			// 기존에 추가된 페이지번호를 삭제합니다
			while (paginationEl.hasChildNodes()) {
				paginationEl.removeChild(paginationEl.lastChild);
			}

			for (i = 1; i <= pagination.last; i++) {
				var el = document.createElement('a');
				el.href = "#";
				el.innerHTML = i;

				if (i === pagination.current) {
					el.className = 'on';
				} else {
					el.onclick = (function(i) {
						return function() {
							pagination.gotoPage(i);
						}
					})(i);
				}

				fragment.appendChild(el);
			}
			paginationEl.appendChild(fragment);
		}

		// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
		// 인포윈도우에 장소명을 표시합니다
		function displayInfowindow(marker, title) {
			var content = '<div style="padding:5px;z-index:1;">' + title
					+ '</div>';

			infowindow.setContent(content);
			infowindow.open(map, marker);
		}

		// 검색결과 목록의 자식 Element를 제거하는 함수입니다
		function removeAllChildNods(el) {
			while (el.hasChildNodes()) {
				el.removeChild(el.lastChild);
			}
		}
		
		/* function relayout() {    
		    var mapContainer = document.getElementById('map');
		    mapContainer.style.width = '320px';
		    mapContainer.style.height = '650px'; 
		    // 지도를 표시하는 div 크기를 변경한 이후 지도가 정상적으로 표출되지 않을 수도 있습니다
		    // 크기를 변경한 이후에는 반드시  map.relayout 함수를 호출해야 합니다 
		    // window의 resize 이벤트에 의한 크기변경은 map.relayout 함수가 자동으로 호출됩니다
		    map.relayout();
		}
		 
		 setTimeout(function(){ map.relayout(); }, 0); */
		
	</script>
	
	<script>
		var mapContainer2 = document.getElementById('map2'), // 지도를 표시할 div 
		    mapOption2 = {
		        center: new kakao.maps.LatLng(37.56646, 126.98121), // 지도의 중심좌표
		        level: 3, // 지도의 확대 레벨
		        mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
		    }; 

		// 지도를 생성한다 
		var map2 = new kakao.maps.Map(mapContainer2, mapOption2); 
		
		
	////////////////////////////////////////////////

		function locationLoadSuccess(pos){
		// 현재 위치 받아오기
		    var currentPos = new kakao.maps.LatLng(pos.coords.latitude,pos.coords.longitude);
		
		    // 지도 이동(기존 위치와 가깝다면 부드럽게 이동)
		    map2.panTo(currentPos);
		
		    // 마커 생성
		    var marker = new kakao.maps.Marker({
		        position: currentPos
		    });
		
		    // 기존에 마커가 있다면 제거
		    marker.setMap(null);
		    marker.setMap(map);
		    
		    
		};
		
		function locationLoadError(pos){
		    alert('위치 정보를 가져오는데 실패했습니다.');
		};
		
		// 위치 가져오기 버튼 클릭시
		function getCurrentPosBtn(){
		    navigator.geolocation.getCurrentPosition(locationLoadSuccess,locationLoadError);
		};
		
	////////////////////////////////////////////////////////////////////////////////////
	
</script> -->
</body>
</html>
