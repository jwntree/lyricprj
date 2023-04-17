<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 수정</title>
<%@ include file="../include/header.jsp" %>
<%-- 
<%@ include file="../include/sessionCheck.jsp" %>
--%>
<script type="text/javascript">
	$(document).ready(function(){
		$("#btnSave").click(function(){
            var title = $("#title").val();
            var album = $("#album").val();
            var artist = $("#artist").val();
            var year = $("#year").val();
            var genre = $("#genre").val();
            
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
            if(artist == ""){
                alert("가수를 입력하세요");
                document.songForm.writer.focus();
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
            //document.songForm.submit();
            f_submit();
		})
		
		$("#btnCancel").click(function(){
			location.href = "/song/list";
		})
		$("#btnuploadImage").click(function(){
			window.open( "/song/ImageUpload", "이미지 업로드", "width=400, height=300, top=50, left=50" );
		})
		
	    function f_submit(){
	        var formData = $("#songForm").serialize();
	        $.ajax({
				type : "POST",
				cache: false,
				async: false,
	            data : formData, 
				url : "/song/updateForm",
				success : function(data) {
					if($.trim(data) == "false") {
						alert('게시물 수정에 실패했습니다.');
					} 
	                if($.trim(data) == "true") {
					   location.href = "/song/list";
	                }
				},
	    		error : function(request,status,error) {
	    	        //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    	        alert("code:"+request.status +" 에러 발생");

				}
	    })
	    }
		
	})
</script>

</head>
<body>
    <h2>게시글 수정</h2>
    <form name="songForm" id="songForm">
    <div>
    	<input type="hidden" name="songId" id="songId" value="${song.songId}">
    </div>
    <div>
    	<label for="artist">가수</label>
    	<input name="artist" id="artist" value="${song.artist}">
    </div>
    <div>
    	<label for="album">앨범</label>
    	<input name="album" id="album" value="${song.album}">
    </div>
    <div>
    	<label for="title">제목</label>
    	<input name="title" id="title" value="${song.title}">
    </div>
    <div>
    	<label for="year">발매일</label>
    	<input name="year" id="year" value="${song.year}">
    </div>
    <div>
    	<label for="genre">장르</label>
    	<input name="genre" id="genre" value="${song.genre}">
    </div>
    <div id="albumArt">
    	<p id="imageArea">
    	<c:if test="${song.imageUrl != null}">
    	<img src="${song.imageUrl}">
		</c:if>
    	</p>
    	<input type="hidden" name="imageUrl" id="imageUrl" value="${song.imageUrl}">
    	<button type="button" id="btnuploadImage">이미지 업로드</button>
    </div> 
    <div>
        <button type="button" id="btnSave">확인</button>
    	<button type="button" id="btnCancel">취소</button>
    </div>
    </form>
</body>
</html>