<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 작성</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#btnSave").click(function(){
			if(document.getElementById("file").files.length == 0){
                alert("파일을 선택하세요");
               return;
            }

            // 폼에 입력한 데이터를 서버로 전송
            //document.FileForm.submit();
			var formData = new FormData($("#FileForm")[0]);
			//alert($("#FileForm")[0])
            //var formData = new FormData();
            //var file = document.getElementById("file").files[0];
            //formData.append("file", file);

			$.ajax({
				data : formData,
				type : "POST",
				url : '/uploadImage',
				cache : false,
				contentType : false,
				processData : false,
				success : function(data) {

					if (data.responseCode != "success") {
						alert("오류가 발생했습니다.")
						return;
					}
					//alert("파일 업로드 성공")
					opener.document.getElementById("imageUrl").value = data.url
					output =''
					output += '<img src ="' +data.url +'">'

					imageArea = opener.document.getElementById("imageArea").innerHTML= output;
					window.close();
					
				}
			});
			//*/
		})
		
		$("#btnCancel").click(function(){
			window.close();
		})
		
	})
</script>
</head>
<body>
    <h2>파일 업로드</h2>
    <form name="FileForm" id="FileForm" method="post" action="/uploadImage" enctype="multipart/form-data">
    <!--<input type="file" id="file" name="file" accept="image/png, image/jpeg" multiple>-->
    <input type="file" id="file" name="file" accept="image/png, image/jpeg">
    <div>
        <button type="button" id="btnSave">확인</button>
    	<button type="button" id="btnCancel">취소</button>
    </div>
    </form>
</body>
</html>