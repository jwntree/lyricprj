<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 목록</title>
<%@ include file="../include/header.jsp"%>
<script type="text/javascript">
	$(document).ready(function(){	
		$("#btnSearch").click(function(e){
			e.preventDefault();
			location.href = "/song/list"+ "?searchOption=" + $('#searchOption').val()+ "&keyword="+ $('#keyword').val();
		})
		
	});

	function list(page){
		let url = "${path}/song/list?curPage="+page+"&perPage=${perPage}"
		<c:if test="${!searchOption.isEmpty()}">url += "&searchOption=${searchOption}"</c:if>
		<c:if test="${!keyword.isEmpty()}">url += "&keyword=${keyword}"</c:if>
        location.href=url;
    }
</script>
<style type="text/css">
li {
	list-style: none;
	float: left;
	padding: 6px;
}
</style>
</head>
<body>
    <h2>게시글 목록</h2>
    
    	<form id="SearchForm">
        <select name="searchOption" id="searchOption">
        <option value="all" <c:out value="${searchOption == 'all'?'selected':''}"/>>제목+가수+앨범</option>
        <option value="title"<c:out value="${searchOption == 'title'?'selected':''}"/>>제목</option>
        <option value="artist"<c:out value="${searchOption == 'artist'?'selected':''}"/>>가수</option>
        <option value="album"<c:out value="${searchOption == 'album'?'selected':''}"/>>앨범</option>
        
        
        </select>
        <input name="keyword" id="keyword" value="${keyword}">
    	<button type="button" type="submit" id="btnSearch">검색</button>
    	<button type="button" id="btnWrite" onclick="location.href='${path}/song/write'">글쓰기</button>
    	</form>
    <!-- 레코드의 갯수를 출력 -->
    ${count}개의 게시물이 있습니다
    <table border="1" data-width="700px">
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>가수</th>
            <th>앨범</th>
        </tr>
        <c:forEach var="row" items="${list}">
        <tr>
            	<td>${row.songId}</td>
				<td><a href="/song/view?songId=${row.songId}">${row.title}</a></td>
				<td>${row.artist}</td>
				<td>${row.album}</td>
        </tr>
        </c:forEach>
    </table>
	<div class="pagenation" id="pagenation">
		<ul>
			<c:if test="${pageMaker.prev}">
				<li><a href="javascript:list('${pageMaker.startPage - 1}')">이전</a></li>
			</c:if>

			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
				<li><a href="javascript:list(${idx})">${idx}</a></li>
			</c:forEach>

			<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			<li><a href="javascript:list(${pageMaker.endPage + 1})">다음</a></li>
			</c:if>
		</ul>
	</div>
</body>
</html>