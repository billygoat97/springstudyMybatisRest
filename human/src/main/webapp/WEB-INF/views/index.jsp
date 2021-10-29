<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Human myBatis Rest Test</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<h1>Human myBatis Rest Test</h1>
		
<!-- 	등록 -->
	<div style="border: 1px solid black;">
		<form id="insertForm" method="post" action="">
			<label for="name">이름</label>
			<input type="text" id="name" name="name" placeholder="이름">
			<label for="age">나이</label>
			<input type="text" id="age" name="age" placeholder="나이">
			<button type="button" id="registerBtn">추가</button>
			<button type="reset">초기화</button>
			<div id="checkMsg"></div>
		</form>
	</div>
	
<!-- 	검색 -->
	<div style="border: 1px solid black;">
		<label for="searchName">이름</label>
		<input type="text" id="searchName" name="searchName" placeholder="검색할 이름">
		<button type="button" id="searchBtn">검색</button>
	</div>
	
<!-- 	리스트 -->
	<table>
		<colgroup>
			<col width="200">
			<col width="200">
			<col width="200">
		</colgroup>
		<thead>
			<tr>
				<td>이름</td>
				<td>나이</td>
			</tr>
		</thead>
		<tbody id="humanlist">
		</tbody>
	</table>
	
	<script type="text/javascript">
	$(document).ready(function() {
		$.ajax({ //회원 목록  // 리스트 지우고 다시 작성하기
			url:'${root}/list',  
			type:'GET',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			success:function(humans) {
				makeList(humans);
			},
			error:function(xhr, status, error){
				console.log("상태값 : " + xhr.status + "\tHttp 에러메시지 : " + xhr.responseText);
			},
			statusCode: {
				500: function() {
					alert("서버에러.");
					// location.href = "/error/e500";
				},
				404: function() {
					alert("페이지없다.");
					// location.href = "/error/e404";
				}
			}	
		}); // $.ajax
		
		// 회원 정보 수정 보기.
		$(document).on("click", ".modiBtn", function() {
			let name = $(this).parents("tr").attr("data-id");
			$("#view_" + name).css("display", "none");
			$("#mview_" + name).css("display", "");
		});
		
		// 회원 정보 수정 실행.
		$(document).on("click", ".modifyBtn", function() {
			let name = $(this).parents("tr").attr("data-id");
			let modifyinfo = JSON.stringify({
						"name" : name, 
						"age" : $("#age" + name).val()
					   });
			$.ajax({
				url:'${root}/human',  
				type:'PUT',
				contentType:'application/json;charset=utf-8',
				dataType:'json', // 받을 데이터 타입
				data: modifyinfo, // 컨트롤러로 보내는 데이터
				success:function(humans) {
					makeList(humans);
				},
				error:function(xhr,status,msg){
					console.log("상태값 : " + status + " Http에러메시지 : "+msg);
				}
			});
		});
		
		// 회원 정보 수정 취소.
		$(document).on("click", ".cancelBtn", function() {
			let name = $(this).parents("tr").attr("data-id");
			$("#view_" + name).css("display", "");
			$("#mview_" + name).css("display", "none");
		});
		
		// 회원 탈퇴.
		$(document).on("click", ".delBtn", function() {
			if(confirm("정말 삭제?")) {
				let name = $(this).parents("tr").attr("data-id");
				$.ajax({
					url:'${root}/human/' + name,  
					type:'DELETE',
					contentType:'application/json;charset=utf-8',
					dataType:'json',
					success:function(humans) {
						makeList(humans);
					},
					error:function(xhr,status,msg){
						console.log("상태값 : " + status + " Http에러메시지 : "+msg);
					}
				});
			}
		});
		
		// 키워드로 이름 검색하기
		$(document).on("click", "#searchBtn", function() {
			var searchName = $("#searchName").val();
			$.ajax({ //회원 목록  // 리스트 지우고 다시 작성하기
				url:'${root}/list/' + searchName,  
				type:'GET',
				contentType:'application/json;charset=utf-8',
				dataType:'json',
				success:function(humans) {
					makeList(humans);
				},
				error:function(xhr, status, error){
					console.log("상태값 : " + xhr.status + "\tHttp 에러메시지 : " + xhr.responseText);
				},
				statusCode: {
					500: function() {
						alert("서버에러.");
						// location.href = "/error/e500";
					},
					404: function() {
						alert("페이지없다.");
						// location.href = "/error/e404";
					}
				}	
			}); // $.ajax
		});
		
		// 이름 중복 검사
		// 아이디 중복검사
    	$("#name").keyup(function () {
    		var checkName = $("#name").val();
            $.ajax({
            	url: '${root}/humanCount/' + checkName,
              	type: 'GET',
              	dataType: 'json',
              	success: function (response) {
              		console.log(response);
                	var cnt = response.cnt;
                	if(cnt == 0) {
                		$("#checkMsg").text(checkName + "는 사용가능합니다.");
                	} else {
                		$("#checkMsg").text(checkName + "는 사용할 수 없습니다.");
                	}
              	}, 
              	error: function(request, status, error) {
              		console.log("status : " + request.status + "\tmsg : " + error);
              	}
			});
		}); 
		
    	// 회원가입
        $("#registerBtn").click(function () {
            if (!$("#name").val()) {
                alert("이름 입력!!!");
                return;
            } else if (!$("#age").val()) {
                alert("나이 입력!!!");
                return;
            } else {
//                 $("#memberform").attr("action", "${root}/user/register").submit();
            	let registerinfo = JSON.stringify({
					"name" : $("#name").val(), 
					"age" : $("#age").val()
				   });
				$.ajax({
					url:'${root}/human',  
					type:'POST',
					contentType:'application/json;charset=utf-8',
					dataType:'json', // 받을 데이터 타입
					data: registerinfo, // 컨트롤러로 보내는 데이터
					success:function(humans) {
						$("#name").val("");
						$("#age").val("");
						makeList(humans);
					},
					error:function(xhr,status,msg){
						console.log("상태값 : " + status + " Http에러메시지 : "+msg);
					}
				});
            }
        });
	}); // $(document).ready()
	
	function makeList(humans) { // 리스트 테이블 바디를 모두 지우고, 다시 작성하기 
		$("#humanlist").empty();
		$(humans).each(function(index, human) {
			let str = `
			<tr id="view_${'${human.name}'}" data-id="${'${human.name}'}">
				<td>${'${human.name}'}</td>
				<td>${'${human.age}'}</td>
				<td>
					<button type="button" class="modiBtn">수정</button>
					<button type="button" class="delBtn">삭제</button>
				</td>
			</tr>
			<tr id="mview_${'${human.name}'}" data-id="${'${human.name}'}" style="display: none;">
				<td>${'${human.name}'}</td>
				<td><input type="text" name="age" id="age${'${human.name}'}" value="${'${human.age}'}"></td>
				<td>
					<button type="button" class="modifyBtn">수정</button>
					<button type="button" class="cancelBtn">취소</button>
				</td>
			</tr>
			`;
		$("#humanlist").append(str);
		});//each
	} // end of makeList()
	</script>
</body>
</html>














