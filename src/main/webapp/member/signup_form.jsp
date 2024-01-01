<%@page import="util.SessionManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String memberId = SessionManager.getInstance().getMemberId(request);
	if (memberId != null) {
		response.sendRedirect(request.getContextPath() + "/");
	}
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>회원가입</title>
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
    />
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
      crossorigin="anonymous"
    ></script>
  </head>
  <body>
    <div class="container">
      <h3 class="form-header mt-4">회원가입</h3>
      <form action="signup.jsp" method="post">
        <!-- 회원 정보 -->
        <section id="infoSection">
          <!-- 기본 정보 -->
          <div class="container">
            <h3>기본정보</h3>
            <!-- 아이디 -->
            <div class="mb-2">
              <label class="form-label" for="memberId">아이디</label>
              <input
                class="form-control"
                type="text"
                name="memberId"
                id="memberId"
              />
              <small class="form-text">(영문소문자/숫자, 4~16자)</small>
              <div class="valid-feedback">사용 가능한 아이디입니다.</div>
              <div class="invalid-feedback">사용할 수 없는 아이디입니다.</div>
            </div>

            <!-- 비밀번호 -->
            <div class="mb-2">
              <label class="form-label" for="password">비밀번호</label>
              <input
                class="form-control"
                type="password"
                name="password"
                id="password"
              />
              <div class="form-text">(알파벳/숫자/특수문자 조합, 8자~16자)</div>
              <div class="valid-feedback">사용 가능한 비밀번호입니다.</div>
              <div class="invalid-feedback" id="pwdExText">
                비밀번호를 확인하세요.
              </div>
            </div>
            <div class="mb-2">
              <label class="form-label" for="password2">비밀번호 확인</label>
              <input class="form-control" type="password" id="password2" />
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
              <input
                class="form-control"
                type="tel"
                name="phoneNumber"
                id="phoneNumber"
              />
            </div>

            <!-- 이메일 -->
            <div class="mb-2">
              <label class="form-label" for="email">이메일</label>
              <input
                class="form-control"
                type="email"
                name="email"
                id="email"
              />
              <div class="invalid-feedback">사용할 수 없는 이메일입니다.</div>
              <button
                type="submit"
                class="btn btn-primary"
                id="sendAuthEmailBtn"
                disabled
              >
                인증번호 받기
              </button>
            </div>

            <!-- 이메일 인증 -->
            <div class="mb-2" id="ChkEmailAuth">
              <label calss="form-label" for="emailAuth">인증번호</label>
              <input
                class="form-control"
                type="emailAuth"
                name="emailAuth"
                id="emailAuth"
                maxlength="6"
              />
              <div class="valid-feedback"></div>
              <div class="invalid-feedback">올바른 인증번호가 아닙니다.</div>
            </div>
        </section>

        <!-- 버튼 -->
        <section id="btnSection">
          <div class="container">
              <button class="btn btn-primary" id="submitBtn" type="submit">
                회원가입
              </button>
           </div>
        </section>
      </form>
    </div>

    <script>
      /*
      // 아이디 유효성 검사

      // 비밀번호 유효성 검사 (알파벳/숫자/특수문자 조합, 8자~16자)
      const reg_password =
        /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~`!@#$%^&*()_\-={}[\]|;:<>,.?/]).{8,16}$/;
      const pwd = document.getElementById("password");
      const pwd2 = document.getElementById("password2");
      const chkPwd = () => {
        if (pwd.value != pwd2.value) {
          document.getElementById("pwdExText").innerText =
            "비밀번호가 일치하지 않습니다.";
          pwd.classList.remove("is-valid");
          pwd.classList.add("is-invalid");
          pwd2.classList.remove("is-valid");
          pwd2.classList.add("is-invalid");
          return;
        } else {
          pwd.classList.remove("is-invalid");
          pwd.classList.add("is-valid");
          pwd2.classList.remove("is-invalid");
          pwd2.classList.add("is-valid");
          checkForm();
        }
      };
      pwd.addEventListener("blur", () => {
        if (!reg_password.test(pwd.value)) {
          document.getElementById("pwdExText").innerText =
            "비밀번호를 규칙에 맞게 작성해주세요.";
          pwd.classList.remove("is-valid");
          pwd.classList.add("is-invalid");
          pwd2.classList.remove("is-valid");
          pwd2.classList.add("is-invalid");
          checkForm();
          return;
        }
        chkPwd();
      });

      pwd2.addEventListener("blur", () => {
        chkPwd();
      });

      // 이름 유효성 검사
      document.getElementById("name").addEventListener("blur", (e) => {
        if (e.target.value == null) {
          e.target.classList.remove("is-valid");
          e.target.classList.add("is-invalid");
          checkForm();
        } else {
          e.target.classList.remove("is-invalid");
          e.target.classList.add("is-valid");
          checkForm();
        }
      });

      // 주소 유효성 검사

      // 휴대폰 유효성 검사

      // 이메일 유효성 검사
      const reg_email = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
      const email = document.getElementById("email");
      const sendAuthEmailBtn = document.getElementById("sendAuthEmailBtn");
      email.addEventListener("blur", (e) => {
        email.classList.remove("is-valid", "is-invalid");
        if (reg_email.test(email.value)) {
          email.classList.add("is-valid");
        } else {
          email.classList.add("is-invalid");
          sendAuthEmailBtn.disabled = true;
          isValid.email = false;
          return;
        }
        fetch(
          "${pageContext.request.contextPath}/member/check_email.jsp?email=" +
            email.value
        )
          .then((res) => res.json())
          .then((data) => {
            email.classList.remove("is-valid", "is-invalid");
            if (data.canUse) {
              email.classList.add("is-valid");
              sendAuthEmailBtn.disabled = false;
            } else {
              email.classList.add("is-invalid");
              sendAuthEmailBtn.disabled = true;
              isValid.email = false;
            }
          });
      });

      // 이메일 인증번호 보내기
      let emailAuthCode;
      sendAuthEmailBtn.addEventListener("click", (e) => {
        e.preventDefault();
        sendAuthEmailBtn.disabled = false;
        emailAuthCode = Math.random().toString(36).substring(2, 8);
        document.getElementById("ChkEmailAuth").style.display = "block";
        fetch(
          "${pageContext.request.contextPath}/member/check_authEmail.jsp?email=" +
            email.value +
            "&emailAuthCode=" +
            emailAuthCode
        )
          .then((res) => res.json())
          .then((data) => {});
      });

      document.getElementById("emailAuth").addEventListener("input", (e) => {
        e.target.classList.remove("is-invalid", "is-valid");
        if (e.target.value.toLowerCase() == emailAuthCode) {
          e.target.classList.add("is-valid");
        } else {
          e.target.classList.add("is-invalid");
        }
      });
      */
    </script>
  </body>
</html>
