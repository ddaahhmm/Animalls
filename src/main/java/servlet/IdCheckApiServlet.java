package servlet;

import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDao;

@SuppressWarnings("serial")
@WebServlet("/api/checkId")
public class IdCheckApiServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String queryId = req.getParameter("q") == null ? "" : req.getParameter("q");
		
		if (!Pattern.matches("^[a-z][a-z0-9]{3,15}$", queryId)) {
			RequestDispatcher rd = req.getRequestDispatcher("/api/jsonResult.jsp");
			req.setAttribute("success", false);
			req.setAttribute("message", "아이디는 영문, 소문자 또는 숫자로 4~16자로 입력해주세요. 숫자로 시작하는 아이디는 만들 수 없습니다");
			rd.forward(req, resp);
			return;
		}
		
		if (MemberDao.getInstance().getData(queryId) != null) {
			RequestDispatcher rd = req.getRequestDispatcher("/api/jsonResult.jsp");
			req.setAttribute("success", false);
			req.setAttribute("message", "'" + queryId + "' 는 사용할 수 없습니다");
			rd.forward(req, resp);
			return; 
		}
		
		
		RequestDispatcher rd = req.getRequestDispatcher("/api/jsonResult.jsp");
		req.setAttribute("success", true);
		req.setAttribute("message", "'" + queryId + "' 는 사용할 수 있습니다");
		rd.forward(req, resp);
		return;
	}
}
