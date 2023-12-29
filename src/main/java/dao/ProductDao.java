package dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.ProductDto;
import util.DbcpBean;

public class ProductDao {
	private static ProductDao dao;
	private ProductDao() {}
	public static ProductDao getInstance() {
		if(dao==null) {
			dao=new ProductDao();
		}
		return dao;
	}
	
	public ProductDto getData(int productId) {
		ProductDto dto = new ProductDto();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "SELECT product_id, seller_id, category, title, description, org_price, sale_price, sales_state, thumbnail"
					+ " FROM PRODUCT"
					+ " WHERE product_id = ?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 한다.
			pstmt.setInt(1, productId);
			//query 문 수행하고 결과(ResultSet) 얻어내기
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
			
			dto.setProductId(productId);
			dto.setSellerId(rs.getString("seller_id"));
			dto.setCategory(rs.getString("category"));
			dto.setTitle(rs.getString("title"));
			dto.setDescription(rs.getString("description"));
			dto.setOrgPrice(rs.getInt("org_price"));
			dto.setSalePrice(rs.getInt("sale_price"));
			dto.setSalesState(rs.getString("sales_state"));
			dto.setThumbnail(rs.getString("thumbnail"));
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close(); //Connection 객체의 close() 메소드를 호출하면 Pool 에 반납된다.
			} catch (Exception e) {
			}
		}
		return dto;
	}
	
	public List<ProductDto> getList(){
		List<ProductDto> list = new ArrayList<ProductDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "SELECT product_id, seller_id, category, title, description, org_price, sale_price, sales_state, thumbnail"
					+ " FROM PRODUCT"
					+ " ORDER BY product_id DESC";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 한다.

			//query 문 수행하고 결과(ResultSet) 얻어내기
			rs = pstmt.executeQuery();
			//반복문 돌면서 
			while (rs.next()) {
			ProductDto dto = new ProductDto();
			dto.setProductId(rs.getInt("product_id"));
			dto.setSellerId(rs.getString("seller_id"));
			dto.setCategory(rs.getString("category"));
			dto.setTitle(rs.getString("title"));
			dto.setDescription(rs.getString("description"));
			dto.setOrgPrice(rs.getInt("org_price"));
			dto.setSalePrice(rs.getInt("sale_price"));
			dto.setSalesState(rs.getString("sales_state"));
			dto.setThumbnail(rs.getString("thumbnail"));
			list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close(); //Connection 객체의 close() 메소드를 호출하면 Pool 에 반납된다.
			} catch (Exception e) {
			}
		}
		return list;

	}
	
	public boolean insert(ProductDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "INSERT INTO PRODUCT"
					+ " (product_id, seller_id, category, title, description, org_price, sale_price, sales_state, thumbnail)"
					+ " VALUES(PRODUCT_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩 할 내용이 있으면 바인딩
			pstmt.setString(1, dto.getSellerId());
			pstmt.setString(2, dto.getCategory());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getDescription());
			pstmt.setInt(5, dto.getOrgPrice());
			pstmt.setInt(6, dto.getSalePrice());
			pstmt.setString(7, dto.getSalesState());
			pstmt.setString(8, dto.getThumbnail());
			
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		if (rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean update(ProductDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "UPDATE PRODUCT"
					+ " SET seller_id=?, category=?, title=?, description=?, org_price=?, sale_price=?, sales_state=?, thumbnail=?"
					+ " WHERE product_id = ?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩 할 내용이 있으면 바인딩
			pstmt.setString(1, dto.getSellerId());
			pstmt.setString(2, dto.getCategory());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getDescription());
			pstmt.setInt(5, dto.getOrgPrice());
			pstmt.setInt(6, dto.getSalePrice());
			pstmt.setString(7, dto.getSalesState());
			pstmt.setString(8, dto.getThumbnail());
			pstmt.setInt(9, dto.getProductId());
			
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		if (rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean delete(int productId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "DELETE FROM PRODUCT"
					+ " WHERE product_id = ?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩 할 내용이 있으면 바인딩
			pstmt.setInt(1, productId);
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		if (rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}
}
