package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.ProductDao;
import dto.ProductDto;
import util.IntegerUtil;

@SuppressWarnings("serial")
@WebServlet("/api/product")
public class ProductApiServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int productId = IntegerUtil.parseIntWithDefaultValue(req.getParameter("productId"), -1);
		
		
		resp.setContentType("application/json; charset=UTF-8");
		if (productId == -1) {
			List<ProductDto> list =  ProductDao.getInstance().getList();
			String json = new Gson().toJson(list);
			try (PrintWriter pr = resp.getWriter()) {
				pr.write(json);
			}
		} else {
			ProductDto dto = ProductDao.getInstance().getData(productId);
			String json = new Gson().toJson(dto); 
			
			try (PrintWriter pr = resp.getWriter()) {
				pr.write(json);
			}
		}
	}
}
