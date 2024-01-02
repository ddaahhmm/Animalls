<%@page import="util.SessionManager"%>
<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDto member = SessionManager.getMember(request);
	String profile = null; // dto.getProfileImage();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<link href="/Animalls/css/common.css"  rel="stylesheet" />
<link href="/Animalls/css/bootstrap.css" rel="stylesheet" >
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</head>
<body class="d-flex flex-column">
    <jsp:include page="/include/navbar.jsp">
        <jsp:param value="member" name="current"/>
    </jsp:include>
	<div class="container flex-grow-1">
		<h5 class="form-header mt-4">회원정보 수정</h5>
		
		<form action="update.jsp" method=post>
			<!-- 아이디 -->
			<div class="mb-2">
				<label class="form-label" for="memberId">아이디</label>
				<input class="form-control" type="text" name="memberId" id="memberId" value="<%= member.getMemberId() %>" readonly/>
			</div>
			
			<!-- 비밀번호 -->
			<div class="mb-2">
				<label class="form-label" for="password">비밀번호</label>
				<input class="form-control" type="text" name="password" id="password" />
			</div>
			<!-- 비밀번호 확인 -->
			<div class="mb-2">
				<label class="form-label" for="password2">비밀번호 확인</label>
				<input class="form-control" type="text" name="password2" id="password2" />
			</div>
			
			<!-- 이름 -->
			<div class="mb-2">
				<label class="form-label" for="name">이름</label>
				<input class="form-control" type="text" name="name" id="name" value="<%= member.getName() %>" />
			</div>
			
			<!-- 주소 -->
			<div class="mb-2">
				<label class="form-label" for="deliveryId">주소</label>
				<div>
					<jsp:include page="/include/address.jsp">
						<jsp:param name="address" value=""></jsp:param>
						<jsp:param name="detailAddress" value=""></jsp:param>
						<jsp:param name="extraAddress" value=""></jsp:param>
					</jsp:include>
				</div>
			</div>
			
			<!-- 휴대전화 -->
			<div class="mb-2">
				<label class="form-label" for="phoneNumber">휴대전화</label>
				<input class="form-control" type="text" name="phoneNumber" id="phoneNumber" value="<%= member.getPhoneNumber() %>" />
			</div>
			
			<!-- 이메일 -->
			<div class="mb-2">
				<label class="form-label" for="email">이메일</label>
				<input class="form-control" type="text" name="email" id="email" value="<%= member.getEmail() %>" />
			</div>
			
			<!-- 추가정보 -->
			<div>
				<div>
		         <label for="myImage">프로필</label>
		         <div>
		            <a href="javascript:" id="profileLink">
		            <%if(profile == null) {%>
		               <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
		                  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
		                  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
		               </svg>
		            <%}else{ %>
		               <img id="profileImage" src="${pageContext.request.contextPath}/upload/<%=profile %>" alt="프로필 이미지" />
		            <%} %>
		            </a>
		         </div>
		      </div>
			</div>
			
			<!-- 버튼 -->
			<div class="btnContainer">
				<button type="button" id="deleteBtn">회원 탈퇴</button>
				<button type="submit">회원정보 수정</button>
				<button type="reset">초기화</button>
				<a href="${pageContext.request.contextPath}/">
					<button type="button">취소</button>
				</a>
			</div>
		</form>
	</div>
	
    <jsp:include page="/include/footer.jsp">
        <jsp:param value="member" name="current"/>
    </jsp:include>
	<script>
	    document.getElementById("deleteBtn").addEventListener("click", e => {
	    	if (confirm("정말 탈퇴하시겠습니까?")) {
				alert("탈퇴가 완료되었습니다.");
				location.href = "${pageContext.request.contextPath}/member/protected/delete.jsp";
			}
	    });
	    /*
	    function cancelImageSelection() {
		   	let profile=`
		   		<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
			   	<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
			    <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
		   		</svg>
		   	`;
	   		document.querySelector("#profileLink").innerHTML=profile;
	   		return;
		}
		
		document.querySelector("#profileLink").addEventListener("click", ()=>{
		   	document.querySelector("#image").click();
		});
		document.querySelector("#image").addEventListener("change", (e)=>{
		   	const fileData=e.target.files[0];      
		   	const data=new FormData();
		   	data.append("myImage", fileData);
		   	fetch("upload_profile.jsp",{
		    	method:"post",
		      	body:data
		   	})
			.then(res=>res.json())
			.then(data=>{
		      	let img=`<img id="profileImage" 
		        src="${pageContext.request.contextPath}/upload/\${data.saveFileName}">`;
		      	document.querySelector("#profileLink").innerHTML=img;
		      	document.querySelector("[name=profile]").value=data.saveFileName;
		   	});
		});
		*/
	</script>
</body>
</html>