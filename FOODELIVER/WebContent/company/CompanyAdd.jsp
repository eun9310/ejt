<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body{
		padding:0;
		margin:0;
		background:#3EB1B0;
	}
	.sub_box{
		position:absolute;
		top:50%;left:50%;
		width:500px;height:1300px;
		margin:-440px 0px 100px -250px;
		background:white;
		box-shadow:5px 5px 10px #333333;
		padding-top:5px;
	}
	table{
		margin-left:85px;
		width:500px;
		border:0;
	}
	.inputbox{
		height:40px;
		width:300px;
		padding-left:10px;
		font-size:15px;
		border:0;
		background:rgb(245,245,245);
	}

</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
</head>
<body>

<div class="sub_box">
	<div style="padding-left:115px">
	<a href="<%=request.getContextPath() %>/adminMain.jsp"><img src="<%=request.getContextPath() %>/main_img/logo.png"></a></div><br><br>
<form action="<%=request.getContextPath() %>/companyadd.comadm" method="post" enctype="multipart/form-data">
<table>
	<tr>
		<td >
			<h1>기업 가입</h1> 
		</td>
	</tr>
	<tr>
		<td><label for="company_id">회사 아이디</label></td>
	</tr>
	<tr>
		<td><input type="text" name="company_id" id="company_id" class="inputbox" required="required"/></td>
	</tr>
	<tr>
		<td style="padding-top:20px;"><label for="company_businum" >사업자 등록번호</label></td>
	</tr>
	<tr>
		<td><input type="text" name="company_businum" id="company_businum" class="inputbox" required="required"/></td>
	</tr>
	<tr>
		<td style="padding-top:20px;"><label for="company_name">회사 이름</label></td>
	</tr>
	<tr>
		<td><input type="text" name="company_name" id="company_name" class="inputbox" required="required"/></td>
	</tr>
	<tr>
		<td style="padding-top:20px;"><label for="company_tel" >회사 전화번호</label></td>
	</tr>
	<tr>
		<td><input type="text" name="company_tel" id="company_tel" class="inputbox" required="required"/></td>
	</tr>
	<tr>
		<td style="padding-top:20px;"><label for="company_logo">회사 로고</label></td>
	</tr>
	<tr>
		<td><input type="file" name="company_logo" id="company_logo" class="inputbox" required="required"/></td>
	</tr>
	
	<tr>
		<td style="padding-top:20px;"><label for="company_category" >회사 카테고리</label></td>
	</tr>
	<tr>
		<td>
		<select name="company_category">
			<option value="치킨">치킨</option>
			<option value="피자">피자</option>
			<option value="중식">중식</option>
			<option value="한식">한식</option>
			<option value="일식">일식</option>
			<option value="족발">족발</option>
			<option value="분식">분식</option>
			<option value="디저트">디저트</option>
		</select>
		</td>
	</tr>
	<tr>
		<td style="padding-top:20px;"><label for="company_email" >이메일</label></td>
	</tr>
	<tr>
		<td><input type="email" name="company_email" id="company_email" class="inputbox" required="required"/></td>
	</tr>	
	<tr>
			<td style="padding-top:20px">회사 주소</td>
		</tr>
		<tr>
			<td><input type="text" name="company_address1" id="sample6_postcode" placeholder="우편번호" size="7" required readonly class="inputbox" style="width:70px;">
			<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="inputbox" style="width:220px;background:#3EB1B0;color:white;height:40px;cursor:pointer;margin-left:5px;"></td>
		</tr>	
		<tr>
			<td><input type="text" name="company_address2" id="sample6_address" placeholder="회사주소" size="40" required readonly class="inputbox" style="margin-top:5px"> 
			</td> 
		</tr>
		<tr>
			<td style="padding-top:5px"><input type="text" name="company_address3" id="sample6_detailAddress" placeholder="상세주소" class="inputbox"></td>
		</tr>
		<tr>
			<td style="padding-top:5px"><input type="text" name="company_address4" id="sample6_extraAddress" placeholder="참고항목" readonly class="inputbox"></td>
		</tr>
	<tr>
		<td style="padding-top:40px">
			<input type="submit" value="가입" style="width:150px;background:#3EB1B0;color:white;height:40px;cursor:pointer;border:0;font-size:20px">
			<input type="reset" value="다시쓰기" style="width:150px;background:#3EB1B0;color:white;height:40px;cursor:pointer;margin-left:5px;border:0;font-size:20px"> 
		</td>
		
	</tr>
</table>
</form>
</div>
	

</body>
</html>