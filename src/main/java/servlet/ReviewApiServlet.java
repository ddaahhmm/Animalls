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
import dto.MemberDto;
import dto.ReviewDto;
import util.ApiResponse;
import util.IntegerUtil;
import util.SessionManager;

@SuppressWarnings("serial")
@WebServlet("/api/review")
public class ReviewApiServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String rawPage = req.getParameter("page");
		String rawPagination = req.getParameter("pagination");
		String rawProductId = req.getParameter("productId"); 
		String order = req.getParameter("order"); 
		
		int page = IntegerUtil.parseIntWithDefaultValue(rawPage, 1);
		int pagination = IntegerUtil.parseIntWithDefaultValue(rawPagination, 5);
		int productId = IntegerUtil.parseIntWithDefaultValue(rawProductId, -1);
		
		int startPage = (page - 1) * pagination +  1; 
		int endPage = page * pagination;
		
		
		List<ReviewDto> reviews = null; 
		if (productId != -1) {
			reviews =  ReviewDao.getInstance().getReviewListWithProductId(startPage, endPage, productId);
		} else {
			reviews = ReviewDao.getInstance().getList(startPage, endPage);
		}
		
		resp.setContentType("application/json; charset=UTF-8");
		String json = new Gson().toJson(reviews);
		try (PrintWriter pw  = resp.getWriter()) {
			pw.write(json);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int productId = Integer.parseInt(req.getParameter("product_id"));
		int rating = Integer.parseInt(req.getParameter("review_star"));
		String content = req.getParameter("content"); 
		String imageData = req.getParameter("image_data");
		MemberDto member = SessionManager.getMember(req);
				
		ReviewDto review = new ReviewDto();
		review.setProductId(productId);
		review.setReviewerId(member.getMemberId());
		review.setContent(content);
		review.setThumbnail(imageData);
		review.setRating(rating);
		
		boolean result = ReviewDao.getInstance().insert(review);
		
		ApiResponse api = new ApiResponse(req, resp);
		if (result) {
			api.sendMessage(result, "성공적으로 리뷰를 작성하였습니다");	
		} else {
			api.sendMessage(result, "리뷰 작성에 실패했습니다");
		}
	}
}
