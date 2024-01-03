package servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.oauth.kakao.KakaoToken;
import model.oauth.kakao.KakaoUserInfo;
import util.HttpsRequestBuilder;
import util.QueryString;

@SuppressWarnings("serial")
@WebServlet("/oauth/login")
public class OAuthLoginServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String code = req.getParameter("code");
		if (code == null) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
		
		HttpsURLConnection conn = null;
		try {
			String qs = QueryString.from(Map.ofEntries(
					Map.entry("grant_type", "authorization_code"),
					Map.entry("client_id", "ef92a29740c9a6b3265d100c512dda87"), 
					Map.entry("redirect_uri", "http://localhost:8888/Animalls/oauth/login"),
					Map.entry("code", code)
			));

			KakaoToken token = new HttpsRequestBuilder("https://kauth.kakao.com/oauth/token")
					.method("POST")
					.contentType("application/x-www-form-urlencoded;charset=utf-8")
					.send(qs)
					.json(KakaoToken.class);
	
			
			String propertyKeys = new Gson().toJson(List.of(
					"kakao_account.profile"
			));
			KakaoUserInfo userInfo = new HttpsRequestBuilder("https://kapi.kakao.com/v2/user/me")
					.method("GET")
					.authorization("Bearer " + token.getAccessToken())
					.contentType("application/x-www-form-urlencoded;charset=utf-8")
					.send(QueryString.from(Map.of("property_keys", propertyKeys)))
					.json(KakaoUserInfo.class);
			System.out.println("user info is " + userInfo);
			
			
			RequestDispatcher rd = req.getRequestDispatcher("/social/oauthResultPreview.jsp");
			req.setAttribute("info", userInfo);
			rd.forward(req, resp);
	    
		} catch(Exception e) {
			e.printStackTrace();
			resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		} 
	}
}
