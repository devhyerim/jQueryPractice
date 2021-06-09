<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AjaxTest01.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	$(function()
	{
		$("#sendBtn").click(function()
		{
			// 자바스크립트에는 trim이 없지만, 제이쿼리($)에는 trim 함수가 있다.
			var params = "name=" + $.trim($("#name").val())
			   + "&content=" + $.trim($("#content").val());
			
			// jQuery의 ajax() 함수 사용(호출)
			// JSON 표현방식으로 파라미터값 전달 → 순서 상관 없이 이름, 값만 일치하면 된다.
			$.ajax(
			{
				type : "POST"
				, url : "AjaxTest01_ok.jsp"
				, data : params
				, success : function(args)		// 데이터가 성공적으로 들어온 경우 함수 처리
				{
					$("#resultDiv").html(args);
					$("#name").val("");
					$("#content").val("");
					$("#name").focus();
				}
				, beforeSend : showRequest		// 전송전에 요청을 확인하는 옵션 (외부로 업무 추출) : 유효성 검사 (T/F)
				, error	: function(e)			// 에러 발생 시 함수 처리
				{
					alert(e.responseText);
				}
			});
		});	
	});
	
	function showRequest()
	{
		// 유효성 검사
		if(!$.trim($("#name").val()))
		{
			alert("이름을 입력해야 합니다.");
			$("#name").focus();
			return false;
		}	
		
		if(!$.trim($("#content").val()))
		{
			alert("내용을 입력해야 합니다.");
			$("#content").focus();
			return false;
		}
		// 궁극적으로 반환하는 값
		return true;
	}

</script>
</head>
<body>

<div>
	<h1>jQuery의 ajax() 메소드 실습</h1>
	<hr>
</div>

<div>
	이름 : <input type="text" id="name" class="txt" /><br>
	내용
	<textarea rows="3" cols="50" id="content"></textarea>
	<br><br>
	
	<input type="button" value="등록하기" id="sendBtn" class="btn" />
</div>
<br><br>

<div id="resultDiv">
</div>

</body>
</html>