package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.ReviewDao;
import dto.ReviewDto;
import util.IntegerUtil;

@SuppressWarnings("serial")
@WebServlet("/api/review/stats")
public class ReviewStatsApiServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String rawProductId = req.getParameter("productId"); 
		
		int productId = IntegerUtil.parseIntWithDefaultValue(rawProductId, -1);
		 
		int totalCount = 0;
		int reviewSum = 0; 
		int[] count = new int[5];
		
		List<ReviewDto> reviews = productId == -1 
						? ReviewDao.getInstance().getList() 
						: ReviewDao.getInstance().getList()
							.stream()
							.filter(r -> r.getProductId() == productId)
							.toList();
		
		for (var r : reviews) {
			int rating = r.getRating(); 
			if (1 <= rating && rating <= 5) {
				count[rating - 1] += 1;
				reviewSum += rating; 
				totalCount += 1; 
			}
		}
		Map<String, Object> m = new HashMap<String, Object>(); 
		
		m.put("avg_review", String.format("%.1f", (double)reviewSum / totalCount)); 
		m.put("total_count", totalCount);
		m.put("count", count);
		
		resp.setContentType("application/json; charset=UTF-8");
		String json = new Gson().toJson(m);
		try (PrintWriter pw  = resp.getWriter()) {
			pw.write(json);
		}
	}
}
