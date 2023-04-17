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
	$("#btnUpdete").click(function(){
		location.href = "/song/update?songId=${song.songId}";

	})
	
	$("#btnList").click(function(){
		location.href = "/song/list";
	})
	
	$("#btnLyricUpate").click(function(){
		location.href = "/song/lyricUpdate?songId=${song.songId}";
	})
	
	$("#btnLyricHistory").click(function(){
		location.href = "/song/lyricHistory?songId=${song.songId}";
	})
	   
})

</script>


</head>
<body>
    <h2>게시글 조회</h2>
    <div id="artist"><span>가수:</span><span id="value" >${song.artist}</span></div>
	<div id="title"><span>제목:</span><span id="value">${song.title}</span></div>
	<div id="album"><span>앨범:</span><span id="value">${song.album}</span></div>
	<div id="year"><span>발매일:</span><span id="value">${song.year}</span></div>
	<div id="genre"><span>장르:</span><span id="value">${song.genre}</span></div>
	<div id="albumArt">앨범아트:<c:if test="${song.imageUrl != null}"><p><img src="${song.imageUrl}"></p></c:if></div>

	<%-- 
    <div>
    	<label for="texts">가사:</label>
    	<p><textarea name="texts" id="texts" rows="10" cols="80">${lyric.texts}</textarea></p>
    </div>
    --%>
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
	<button type="button" id="btnLyricUpate">가사작성</button>
	<button type="button" id="btnLyricHistory">가사 히스토리</button>
    <button type="button" id="btnUpdete">수정</button>
    <button type="button" id="btnList">목록</button>
    <button type="button" id="btnWrite" onclick="location.href='${path}/song/write'">글쓰기</button>
    
    
        
</body>
</html>