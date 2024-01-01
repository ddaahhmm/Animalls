package dao;

import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.FileDto;
import dto.ReviewDto;
import oracle.sql.CLOB;
import util.DbcpBean;

public class ReviewDao {
	private static ReviewDao dao;
	private  ReviewDao() {}
	public static ReviewDao getInstance() {
		if(dao==null) {
			dao=new  ReviewDao();
		}
		return dao;
	}
	public List<ReviewDto> getList(int start, int end){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReviewDto> list = new ArrayList<>();
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "SELECT *"
					+ " FROM"
					+ "	(SELECT result1.*, ROWNUM AS rnum"
					+ "	FROM"
					+ "		(SELECT review_id, product_id , reviewer_id, content, thumbnail, rating, like_count, created_at, updated_at"
					+ "		FROM PRODUCT_REVIEW"
					+ "		ORDER BY review_id DESC) result1)"
					+ " WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 한다.
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			//query 문 수행하고 결과(ResultSet) 얻어내기
			rs = pstmt.executeQuery();
			//반복문 돌면서 
			while (rs.next()) {
				ReviewDto dto =new ReviewDto();
				dto.setReviewId(rs.getInt("review_id"));
				dto.setProductId(rs.getInt("product_id"));
				dto.setReviewerId(rs.getString("reviewer_id"));
				dto.setContent(rs.getString("content"));
				dto.setThumbnail(rs.getString("thumbnail"));
				dto.setRating(rs.getInt("rating"));
				dto.setLikeCount(rs.getInt("like_count"));
				dto.setCreatedAt(rs.getString("created_at"));
				dto.setUpdatedAt(rs.getString("updated_at"));
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

	public boolean insert(ReviewDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "INSERT INTO PRODUCT_REVIEW"
					+ "	(review_id, product_id , reviewer_id, content, thumbnail, rating, created_at, updated_at )"
					+ " VALUES (PRODUCT_REVIEW_SEQ.NEXTVAL, ?, ?, ?, ?, ?, SYSDATE, SYSDATE)";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩 할 내용이 있으면 바인딩
			pstmt.setInt(1,dto.getProductId());
			pstmt.setString(2, dto.getReviewerId());
			pstmt.setString(3,dto.getContent());
			pstmt.setString(4, dto.getThumbnail());
			pstmt.setInt(5, dto.getRating());
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
	
	public boolean update(ReviewDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "UPDATE PRODUCT_REVIEW"
					+ " SET  content=?, thumbnail=? , updated_at=? , rating=?"
					+ " Where review_id=?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩 할 내용이 있으면 바인딩
			pstmt.setString(1, dto.getContent());
			pstmt.setString(2, dto.getThumbnail());
			pstmt.setString(3, dto.getUpdatedAt());
			pstmt.setInt(4, dto.getRating());
			pstmt.setInt(5, dto.getReviewId());
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
	
	public boolean delete(int review_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "DELETE FROM PRODUCT_REVIEW"
					+" WHERE review_id=?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩 할 내용이 있으면 바인딩
			pstmt.setInt(1,review_id);
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
	
	public ReviewDto getData(int review_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ReviewDto dto = null;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "SELECT review_id, product_id , reviewer_id, content, thumbnail, rating, like_count, created_at, updated_at "
					+ " FROM PRODUCT_REVIEW"
					+ " WHERE review_id=?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 한다.
			pstmt.setInt(1,review_id);
			//query 문 수행하고 결과(ResultSet) 얻어내기
			rs = pstmt.executeQuery();
			//반복문 돌면서 
			while (rs.next()) {
				dto = new ReviewDto();
				dto.setReviewId(review_id);
				dto.setProductId(rs.getInt("product_id"));
				dto.setReviewerId(rs.getString("reviewer_id"));
				dto.setContent(rs.getString("content"));
				dto.setThumbnail(rs.getString("thumbnail"));
				dto.setRating(rs.getInt("rating"));
				dto.setLikeCount(rs.getInt("like_count"));
				dto.setCreatedAt(rs.getString("created_at"));
				dto.setUpdatedAt(rs.getString("updated_at"));
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
			return dto;
		}
	}
	
	public List<ReviewDto> getList(){
		List<ReviewDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "SELECT review_id, product_id , reviewer_id, content, thumbnail, rating, like_count, created_at, updated_at"
					+ " FROM PRODUCT_REVIEW"
					+ " ORDER BY review_id DESC";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 한다.
			//query 문 수행하고 결과(ResultSet) 얻어내기
			rs = pstmt.executeQuery();
			//반복문 돌면서 
			while (rs.next()) {
				ReviewDto dto =new ReviewDto();
				dto.setReviewId(rs.getInt("review_id"));
				dto.setProductId(rs.getInt("product_id"));
				dto.setReviewerId(rs.getString("reviewer_id"));
				dto.setContent(rs.getString("content"));
				dto.setThumbnail(rs.getString("thumbnail"));
				dto.setRating(rs.getInt("rating"));
				dto.setLikeCount(rs.getInt("like_count"));
				dto.setCreatedAt(rs.getString("created_at"));
				dto.setUpdatedAt(rs.getString("updated_at"));
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
}

