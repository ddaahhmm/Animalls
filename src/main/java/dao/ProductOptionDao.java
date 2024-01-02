package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.ProductOptionDto;
import util.DbcpBean;

public class ProductOptionDao {
	private static ProductOptionDao dao;
	private ProductOptionDao() {}
	public static ProductOptionDao getInstance() {
		if(dao==null) {
			dao=new ProductOptionDao();
		}
		return dao;
	}

	public List<ProductOptionDto> getList(){
		List<ProductOptionDto> list = new ArrayList<ProductOptionDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "SELECT option_id, product_id, description, additional_price"
					+ " FROM PRODUCT_OPTION"
					+ " ORDER BY option_id DESC";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 한다.
			
			//query 문 수행하고 결과(ResultSet) 얻어내기
			rs = pstmt.executeQuery();
			//반복문 돌면서 
			while (rs.next()) {
				ProductOptionDto dto = new ProductOptionDto();
				dto.setOptionId(rs.getInt("option_id"));
				dto.setProductId(rs.getInt("product_id"));
				dto.setDescription(rs.getString("description"));
				dto.setAdditionalPrice(rs.getInt("additional_price"));
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
	
	public List<ProductOptionDto> getListByProudctId(int productId){
		List<ProductOptionDto> list = new ArrayList<ProductOptionDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "SELECT option_id, product_id, description, additional_price"
					+ " FROM PRODUCT_OPTION "
					+ " WHERE product_id = ?"
					+ " ORDER BY option_id DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productId);
			rs = pstmt.executeQuery();
			//반복문 돌면서 
			while (rs.next()) {
				ProductOptionDto dto = new ProductOptionDto();
				dto.setOptionId(rs.getInt("option_id"));
				dto.setProductId(rs.getInt("product_id"));
				dto.setDescription(rs.getString("description"));
				dto.setAdditionalPrice(rs.getInt("additional_price"));
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
	
	public ProductOptionDto getData(int optionId) {
		ProductOptionDto dto = new ProductOptionDto();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "SELECT option_id, product_id, description, additional_price"
					+ " FROM PRODUCT_OPTION"
					+ " WHERE option_id = ?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 한다.
			pstmt.setInt(1, optionId);
			//query 문 수행하고 결과(ResultSet) 얻어내기
			rs = pstmt.executeQuery();
			//반복문 돌면서 
			if (rs.next()) {
				dto.setOptionId(optionId);
				dto.setProductId(rs.getInt("product_id"));
				dto.setDescription(rs.getString("description"));
				dto.setAdditionalPrice(rs.getInt("additional_price"));
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
	
	//추가
	
	public boolean insert(ProductOptionDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "INSERT INTO PRODUCT_OPTION"
					+ " (option_id, product_id, description, additional_price)"
					+ " VALUES(PRODUCT_OPTION_SEQ.NEXTVAL, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩 할 내용이 있으면 바인딩
			pstmt.setInt(1, dto.getProductId());
			pstmt.setString(2, dto.getDescription());
			pstmt.setInt(3, dto.getAdditionalPrice());
			
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
	
	public boolean update(ProductOptionDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "UPDATE PRODUCT_OPTION"
					+ " SET product_id = ?, description=?, additional_price=?"
					+ " WHERE option_id = ?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩 할 내용이 있으면 바인딩
			pstmt.setInt(1, dto.getProductId());
			pstmt.setString(2, dto.getDescription());
			pstmt.setInt(3, dto.getAdditionalPrice());
			pstmt.setInt(4, dto.getOptionId());
			
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
	
	public boolean delete(int optionId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "DELETE FROM PRODUCT_OPTION"
					+ " WHERE option_id = ?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩 할 내용이 있으면 바인딩
			pstmt.setInt(1, optionId);
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