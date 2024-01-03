<%@page import="dto.MemberDto"%>
<%@page import="util.SessionManager" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% 
    MemberDto member = SessionManager.getMember(request); 
    if (member !=null) {
        response.sendRedirect(request.getContextPath() + "/" ); 
    } 
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>회원가입</title>
        <link rel="stylesheet" href="/Animalls/css/bootstrap.css"/>
        <link rel="stylesheet" href="/Animalls/css/common.css" /> 
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    </head>
    
    <body class="d-flex flex-column">
        <jsp:include page="/include/navbar.jsp">
          <jsp:param value="member" name="current" />
        </jsp:include>
    
        <div class="container flex-grow-1">
          <h1 class="form-header mt-4">회원가입</h1>
          <hr />
          
          <form id="registerForm" class="py-2" action="/Animalls/member/signup.jsp" method="post" onsubmit="return false;">
            <!-- 회원 정보 -->
            <section id="infoSection">
              <!-- 아이디 -->
              <div class="mb-2">
                <label class="form-label" for="memberId">아이디</label>
                <input class="form-control" type="text" name="memberId" id="memberId" oninput="checkId()" />
                <small class="form-text">(영문소문자/숫자, 4~16자)</small>
                <div class="valid-feedback" id="idValidFeedback">사용 가능한 아이디입니다.</div>
                <div class="invalid-feedback" id="idInvalidFeedback">사용할 수 없는 아이디입니다.</div>
              </div>
        
              <!-- 비밀번호 -->
              <div class="mb-2">
                <label class="form-label" for="password">비밀번호</label>
                <input class="form-control" type="password" name="password" id="password" onchange="checkPw()" />
                <div class="form-text">(알파벳/숫자/특수문자 조합, 8자~16자)</div>
                <div class="valid-feedback">사용 가능한 비밀번호입니다.</div>
                <div class="invalid-feedback" id="pwdExText">비밀번호를 확인하세요.</div>
              </div>
              
              
              <div class="mb-2">
                <label class="form-label" for="passwordConfirm">비밀번호 확인</label>
                <input class="form-control" type="password" name="passwordConfirm" id="passwordConfirm" oninput="checkPwConfirm()" />
                <div class="valid-feedback">비밀번호와 동일합니다</div>
                <div class="invalid-feedback" id="pwdExText">비밀번호와 다릅니다</div>
              </div>
        
              <!-- 이름 -->
              <div class="mb-2">
                <label class="form-label" for="name">이름</label>
                <input class="form-control" type="text" name="name" id="name" />
                <div class="invalid-feedback">이름을 입력해주세요.</div>
              </div>
        
              <!-- 주소 -->
              <div class="mb-2">
                <label class="form-label" for="deliveryId">주소</label>    
                <div class="input-group my-1">
                    <input class="form-control" onclick="findPostcode()" type="text" id="postcode" name="postcode" placeholder="우편번호"  readonly />
                    <input class="btn btn-primary" onclick="findPostcode()" type="button" value="우편번호 찾기">
                </div>
                <input class="form-control my-1" onclick="findPostcode()" type="text" id="address" name="address" placeholder="주소" readonly>
                <input class="form-control my-1" type="text" id="detailAddress" name="detailAddress" placeholder="상세주소">
              </div>
        
              <!-- 휴대전화 -->
              <div class="mb-2">
                <label class="form-label" for="phoneNumber">휴대전화</label>
                <input class="form-control" type="tel" pattern="[0-9]{11}" maxlength='11' name="phoneNumber" id="phoneNumber"  placeholder='01012345678 처럼 - 는 빼고 입력해주세요'/>                
              </div>
        
              <!-- 이메일 -->
              <div class="mb-2">
                <label class="form-label" for="email">이메일</label>
                <div class="input-group">
                    <input class="form-control" type="email" name="email" id="email" />
                    <input type="button" class="btn btn-primary" id="sendAuthEmailBtn" onclick="sendVerifyMail()" value="인증번호 받기">
                </div>
                
              </div>
        
              <!-- 이메일 인증 -->
              <div class="mb-2" id="ChkEmailAuth">
                <label class="form-label" for="code">인증번호</label>
                <input class="form-control" type="text" name="code" id="code" maxlength="6" disabled/>                
              </div>
            </section>
        
              <div class="d-flex justify-content-end">
                <button class="btn btn-primary" id="submitBtn" type="submit" onclick="submitForm()">
                  회원가입
                </button>
              </div>
          </form>
        </div>
        
        <div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:9999;-webkit-overflow-scrolling:touch;">
            <div class="bg-dark text-light">
                <p class="mx-2">우편번호 찾기</p>
                
                <img src="//img.echosting.cafe24.com/postcode/btn_close.gif" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:5px;top:5px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
            </div>
            
        </div>
        
        <jsp:include page="/include/footer.jsp">
          <jsp:param value="member" name="current" />
        </jsp:include>
    <script>
    	const element_layer = document.querySelector('#layer');
    	
        function closeDaumPostcode() {
            // iframe을 넣은 element를 안보이게 한다.
            element_layer.style.display = 'none';
        }
        
    	function findPostcode() {
    		 new daum.Postcode({
    	            oncomplete: function(data) {
    	                var addr = ''; // 주소 변수
    	                var extraAddr = ''; // 참고항목 변수
    	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
    	                    addr = data.roadAddress;
    	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
    	                    addr = data.jibunAddress;
    	                }
    	                if(data.userSelectedType === 'R'){
    	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
    	                        extraAddr += data.bname;
    	                    }
    	                    if(data.buildingName !== '' && data.apartment === 'Y'){
    	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
    	                    }
    	                    if(extraAddr !== ''){
    	                        extraAddr = ' (' + extraAddr + ')';
    	                    }
    	                
    	                } 
    	                document.getElementById('postcode').value = data.zonecode;
    	                document.getElementById("address").value = addr + " " + extraAddr;
    	                document.getElementById("detailAddress").focus();
    	                element_layer.style.display = 'none';
    	            },
    	            width : '100%',
    	            height : '100%',
    	            maxSuggestItems : 5
    	        }).embed(element_layer);
    	        element_layer.style.display = 'block';
    	        initLayerPosition();
    	}
    	
        function initLayerPosition(){
            var width = 800; //우편번호서비스가 들어갈 element의 width
            var height = 600; //우편번호서비스가 들어갈 element의 height
            var borderWidth = 1; //샘플에서 사용하는 border의 두께

            element_layer.style.width = width + 'px';
            element_layer.style.height = height + 'px';
            element_layer.style.border = borderWidth + 'px solid';
            element_layer.style.borderColor = 'black'
            element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
            element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
        }
        
        async function checkId() {
        	const $memberInput = document.querySelector('#memberId'); 
        	const $idValidFeedback = document.querySelector('#idValidFeedback');
        	const $idInvalidFeedback = document.querySelector('#idInvalidFeedback');
        	
        	const id = $memberInput.value; 
        	
        	const resp = await fetch(`/Animalls/api/checkId?q=\${id}`, {method: 'get'});
        	const data = await resp.json();
        	
        	if (data.success) {
    			$memberInput.classList.remove('is-invalid');
    			$memberInput.classList.add('is-valid');
    			$idValidFeedback.innerText = data.message; 
        	} else {
        		$memberInput.classList.remove('is-valid');
    			$memberInput.classList.add('is-invalid');
    			$idInvalidFeedback.innerText = data.message;
        	}
        }
        
        function checkPw() {
        	const $password = document.querySelector('#password');
        	if (/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~`!@#$%^&*()_\-={}[\]|;:<>,.?/]).{8,16}$/.test($password.value)) {
        		$password.classList.remove('is-invalid'); 
        		$password.classList.add('is-valid');	
        	} else {
        		$password.classList.remove('is-valid'); 
        		$password.classList.add('is-invalid');
        	}
        }
        
        function checkPwConfirm() {
        	const $password = document.querySelector('#password')
        	const $passwordConfirm = document.querySelector('#passwordConfirm');
        	if ($password.value === $passwordConfirm.value) {
        		$passwordConfirm.classList.remove('is-invalid'); 
        		$passwordConfirm.classList.add('is-valid');
        	} else {
        		$passwordConfirm.classList.remove('is-valid'); 
        		$passwordConfirm.classList.add('is-invalid');
        	}
        	
        }
        
        async function sendVerifyMail() {
        	const $email = document.querySelector('#email');
        	const $code = document.querySelector('#code'); 
        	
        	const resp = await fetch(`/Animalls/mail_verification?mailTo=\${$email.value}`, { method: 'get' });
        	const data = await resp.json();
       
        	if (data.success) {
				alert("이메일이 전송되었습니다!");				
        		$code.disabled = false;       
				
        	} else {
        		alert(data.message);
        		$code.innerText = '';
        		$code.disabled = true; 
        	} 	
        }
        
        async function submitForm() {
        	const $registerForm = document.querySelector('#registerForm');
        	const formdata = new FormData($registerForm);
        	const qs = new URLSearchParams(formdata).toString();
        	
        	const resp = await fetch('/Animalls/api/signup', { method: 'post', body: qs, headers: {'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'}});
        	const data = await resp.json(); 
        	if (data.success) {
        		alert("회원 가입 완료!");
        		document.location.href = '/Animalls'; 
        	} else { 
        		alert(data.message);
        	}
        }
    </script>
    </body>
</html>