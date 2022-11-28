/**
 * 아이디 중복 체크
 */
$(function(){
	$("#idCheck").click(function(){
		var cpath = '<c:out value="${pageContext.request.contextPath}/>"';
		let user_id = $("#user_id").val();
		$.ajax({
			url : cpath + "/idCheck.do",
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