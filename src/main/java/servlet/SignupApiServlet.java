package servlet;

import util.ApiResponse;
import util.Crypto;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DeliveryAddressDao;
import dao.MemberDao;
import dto.DeliveryAddressDto;
import dto.MemberDto;
import dto.MemberDtoBuilder;


@SuppressWarnings("serial")
@WebServlet("/api/signup")
public class SignupApiServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ApiResponse api = new ApiResponse(req, resp);
		
		String memberId = req.getParameter("memberId");
	    String password = req.getParameter("password"); 
	    String passwordConfirm = req.getParameter("passwordConfirm");
	    String name = req.getParameter("name"); 
	    String postcode = req.getParameter("postcode");
	    String address = req.getParameter("address");
	    String detailAddress = req.getParameter("detailAddress");
	    String phoneNumber = req.getParameter("phoneNumber"); 
	    String email = req.getParameter("email"); 
	    String code = req.getParameter("code"); 
		

	    
	    if (memberId == null || password == null || name == null || postcode == null || address == null || detailAddress == null || phoneNumber == null || email == null || code == null) {
	        api.sendMessage(false, "충분한 인자가 전달되지 않았습니다");
	        return;
	    }
	    if (!Pattern.matches("^[a-z][a-z0-9]{3,15}$", memberId) || MemberDao.getInstance().getData(memberId) != null) {
	    	api.sendMessage(false, "올바르지 않은 아이디입니다");
	    	return; 
	    }
	    
	    // todo: password check algoirthm 
	    if (8 > password.length()  && password.length() > 16) {
	    	api.sendMessage(false, "올바르지 않은 비밀번호입니다");
	    	return; 
	    }
	    if (!password.equals(passwordConfirm)) {
	    	api.sendMessage(false, "비밀번호가 확인 입력값이 비밀번호와 같지 않습니다");
	    	return; 
	    }
	    if (!Pattern.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$", email)) {
	    	api.sendMessage(false, "올바르지 않은 이메일입니다");
	    	return; 
	    }
	    HttpSession session = req.getSession();
	    // verify email 
	    boolean emailVerified =  false;      
	    LocalDateTime expireTime = (LocalDateTime)session.getAttribute("verificationEmailExpireTime");
		if (email != null && email.equals(session.getAttribute("verificationEmail"))) {
			if (expireTime != null && LocalDateTime.now().isBefore(expireTime)) {
				if (code != null && code.equals(session.getAttribute("verificationEmailCode"))) {
			      emailVerified = true; 
				}
			}
		}
	    if (!emailVerified ) {
	    	api.sendMessage(false, "이메일 인증에 실패하였습니다");
	    	return;
	    }
	    
	    int numPostcode = -1;    
	    try {
	        numPostcode = Integer.parseInt(postcode);
	    } catch(Exception e) {
	    	api.sendMessage(false, "우편번호가 올바르지 않습니다");
	        return; 
	    }
	    DeliveryAddressDto delivery =  new DeliveryAddressDto(-1, numPostcode, address, detailAddress); 
	    boolean deliveryInsertResult =  DeliveryAddressDao.getInstance().insert(delivery);
	    if (!deliveryInsertResult) {
	    	api.sendMessage(false, "주소를 db 에 추가하는 도중 에러가 발생했습니다");
	    	return; 
	    }
	    
		MemberDto dto = new MemberDtoBuilder()
					.memberId(memberId)
					.deliveryId(delivery.getDeliveryId())
					.password(Crypto.hash(password))
					.name(name)
					.nickname(name)
					.phoneNumber(phoneNumber)
					.email(email)
					.emailVerified(true)
					.build();
		boolean memberInsertResult = MemberDao.getInstance().insert(dto);
		
		if (!memberInsertResult) {
			api.sendMessage(false, "멤버를 db 에 추가하는 도중 에러가 발생했습니다");
			return; 
		}
		api.sendMessage(true, "회원 가입 성공");
	}
}
