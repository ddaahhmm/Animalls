package servlet;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.SendMail;

@SuppressWarnings("serial")
@WebServlet("/mail_verification")
public class MailVerificationServlet extends HttpServlet{
	static final int VERIFICATION_EMAIL_RESEND_DEALAY = 60;
	static final int VERIFICATION_EMAIL_CODE_VALID_TIME = 300; 
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String mailTo = req.getParameter("mailTo");
		if (mailTo == null || mailTo.length() == 0) { 
			RequestDispatcher rd =req.getRequestDispatcher("/api/jsonResult.jsp");
			resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			req.setAttribute("success", false);
			req.setAttribute("message", "이메일 주소를 입력해주세요");
			rd.forward(req, resp);
			return;
		}
		
		HttpSession sess = req.getSession();
		LocalDateTime lastSent = (LocalDateTime)sess.getAttribute("lastEmailSentDateTime");
		if (lastSent == null || ChronoUnit.SECONDS.between(lastSent, LocalDateTime.now()) > VERIFICATION_EMAIL_RESEND_DEALAY) {
			Integer randomValue = new Random().nextInt(100_000, 1_000_000);
			sess.setAttribute("verificationEmail", mailTo);
			sess.setAttribute("verificationEmailCode", randomValue.toString());
			sess.setAttribute("verificationEmailExpireTime", LocalDateTime.now().plusSeconds(VERIFICATION_EMAIL_CODE_VALID_TIME));
			
			SendMail sm = new SendMail();
			boolean sendResult = sm.send(mailTo, "Animalls 이메일 인증번호입니다", "<body>"
					+ "<h1>Animalls 이메일 인증번호 안내</h1>"
					+ "<p>이메일 인증번호는 <strong>" + randomValue + "</strong> 입니다</p>"
					+ "</body>");
			if (sendResult) { 
				sess.setAttribute("lastEmailSentDateTime", LocalDateTime.now());
				RequestDispatcher rd = req.getRequestDispatcher("/api/jsonResult.jsp");
				resp.setStatus(HttpServletResponse.SC_OK);
				req.setAttribute("success", true);
				req.setAttribute("message", "이메일 전송에 성공하였습니다");
				rd.forward(req, resp);
				return;	
			} 
			else {
				RequestDispatcher rd = req.getRequestDispatcher("/api/jsonResult.jsp");
				resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				req.setAttribute("success", false);
				req.setAttribute("message", "알 수 없는 이유로 이메일 전송에 실패했습니다");
				rd.forward(req, resp);
				return;	
			}			 
		} else {
			RequestDispatcher rd = req.getRequestDispatcher("/api/jsonResult.jsp");
			resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
			req.setAttribute("success", false);
			req.setAttribute("message", "너무 빠른 재시도입니다. 잠시후에 다시 시도해주세요");
			rd.forward(req, resp);
			return; 
		}
	}
}
