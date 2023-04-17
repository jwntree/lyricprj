<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 히스토리</title>
<%@ include file="../include/header.jsp"%>
<style type="text/css">
li {
	list-style: none;
	float: left;
	padding: 6px;
}
</style>
<script>
function list(page){
	location.href= "${path}/song/lyricHistory?songId=${songId}&curPage="+page+"&perPage=${perPage}"
}

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
    <h2>게시글 히스토리</h2>
    <!-- 레코드의 갯수를 출력 -->
    ${count}개의 게시물이 있습니다
    <table border="1" data-width="700px">
        <tr>
        	<th>리비전ID</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>롤백</th>
        </tr>
        <c:forEach var="row" items="${list}">
        <tr>
        		<td><a href="/song/lyricHistoryView/?revId=${row.revId}">${row.revId}</a></td>
            	<td>${row.submitterName}</td>
				<td>${row.regDate}</td>
				<td><button type="button" id="btnRollback" onclick="restoreLyric(${row.lyricId},${row.revId})">롤백</button></td>
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