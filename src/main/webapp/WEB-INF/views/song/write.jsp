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
            var artist = $("#artist").val();
            var title = $("#title").val();
            var album = $("#album").val();
            var year = $("#year").val();
            var genre = $("#genre").val();


            if(artist == ""){
                alert("가수를 입력하세요");
                document.songForm.writer.focus();
                return;
            }
            if(title == ""){
                alert("제목을 입력하세요");
                document.songForm.title.focus();
                return;
            }
            if(album == ""){
                alert("앨범을 입력하세요");
                document.songForm.content.focus();
                return;
            }
            if(year == ""){
                alert("발매일 입력하세요");
                document.songForm.writer.focus();
                return;
            }
            if(genre == ""){
                alert("장르를 입력하세요");
                document.songForm.writer.focus();
                return;
            }
            // 폼에 입력한 데이터를 서버로 전송
            document.songForm.submit();
		})
		
		$("#btnCancel").click(function(){
			location.href = "/song/list";
		})
		
		$("#btnuploadImage").click(function(){
			window.open( "/song/ImageUpload", "이미지 업로드", "width=400, height=300, top=50, left=50" );
		})
		
	})
</script>
</head>
<body>
    <h2>게시글 작성</h2>
    <form name="songForm" method="post" action="/song/writeForm">
    <div>
    	<label for="artist">가수</label>
    	<input name="artist" id="artist">
    </div>
    <div>
    	<label for="album">앨범</label>
    	<input name="album" id="album">
    </div>
    <div>
    	<label for="title">제목</label>
    	<input name="title" id="title">
    </div>
    <div>
    	<label for="year">발매일</label>
    	<input name="year" id="year">
    </div>
    <div>
    	<label for="genre">장르</label>
    	<input name="genre" id="genre">
    </div>
    <div id="albumArt">
    	<p id="imageArea"></p>
    	<input type="hidden" name="imageUrl" id="imageUrl">
    	<button type="button" id="btnuploadImage">이미지 업로드</button>
    </div> 
    <div>
        <button type="button" id="btnSave">확인</button>
    	<button type="button" id="btnCancel">취소</button>
    </div>
    </form>
</body>
</html>