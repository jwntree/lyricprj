<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글</title>
<%@ include file="../include/header.jsp" %>
<style>
	ul{
    display: inline-block;
	}
	li {
		list-style: none;
		float: left;
		padding: 10px;
	}
    
</style>

<script type="text/javascript">
$(document).ready(function(){
	$("#btnList").click(function(){
		location.href = "/song/list";
	})	   
})

function restoreLyric(lyricId, revId) {
	var form_data = new FormData();
	form_data.append('lyricId', lyricId);
	form_data.append('revId', revId);
	$.ajax({
		data : form_data,
		type : "POST",
		url : '/song/restoreLyric',
		cache : false,
		contentType : false,
		processData : false,
		success : function(data) {

			if (data.responseCode != "success") {
				alert("오류가 발생했습니다.")
				return;
			}else{
				location.href = "/song/list";
			}
			
		}
	});
}

</script>


</head>
<body>
    <h2>게시글 조회</h2>
    <div>
    <span>작성자:</span> <span>${lyric.submitterName}</span>
    </div>
    <div>
    <span>작성시간:</span> <span>${lyric.regDate}</span>
    </div>
    
    <c:choose>
    <c:when test="${lyric.texts != null}">
        	<label for="texts">가사:</label>
        	<p><textarea name="texts" id="texts" rows="10" cols="80">${lyric.texts}</textarea></p>
    </c:when>    
    <c:otherwise>
            	<label for="texts">가사:</label>
            	<p>가사가 존재하지 않습니다. 가사를 추가해주세요</p>
    </c:otherwise>
	</c:choose>
    <button type="button" id="btnList">목록</button>
    <button type="button" id="btnRollback" onclick="restoreLyric(${lyric.lyricId},${lyric.revId})">롤백</button>
    
    
        
</body>
</html>