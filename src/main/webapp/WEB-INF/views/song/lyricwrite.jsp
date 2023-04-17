<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 작성</title>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript">
	$(document).ready(function(){
		$("#btnSave").click(function(){
            var submitterName = $("#submitterName").val();
            var submitterEmail = $("#submitterEmail").val();
            var regDate = $("#regDate").val();
            var texts = $("#texts").val();


            if(submitterName == ""){
                alert("작성자 이름을 입력하세요");
                document.songForm.title.focus();
                return;
            }
            if(submitterName == ""){
                alert("작성자 이메일을 입력하세요");
                document.songForm.content.focus();
                return;
            }
            if(texts == ""){
                alert("내용을 입력하세요");
                document.songForm.writer.focus();
                return;
            }
            // 폼에 입력한 데이터를 서버로 전송
            document.songForm.submit();
		})
		
		$("#btnCancel").click(function(){
			location.href = "/song/list";
		})
		
	})
</script>
</head>
<body>
    <h2>가사 작성</h2>
    <div>
    	<span>제목</span>
    	<span>${song.title}</span>
    </div>
    <div>
    	<span>앨범</span>
    	<span>${song.album}</span>
    </div>
    <div>
    	<span>가수</span>
    	<span>${song.artist}</span>
    </div>
    
    <form name="songForm" method="post" action="/song/writeLyricForm">

   
    <input type="hidden" id="songId" name="songId" value="${song.songId}">
    <div>
    	<label for="texts">가사</label>
    	<p><textarea name="texts" id="texts" rows="10" cols="80">${lyric.texts}</textarea></p>
    </div>
    
    <div>
    	<label for="submitterName">작성자 이름</label>
    	<input name="submitterName" id="submitterName">
    </div>
    
    <div>
    	<label for="submitterEmail">작성자 이메일</label>
    	<input name="submitterEmail" id="submitterEmail">
    </div>

    <div>
        <button type="button" id="btnSave">확인</button>
    	<button type="button" id="btnCancel">취소</button>
    </div>
    </form>
</body>
</html>