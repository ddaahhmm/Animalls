package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.ReviewUploadImageDto;
import util.DbcpBean;

public class ReviewUploadImageDao {
	private static ReviewUploadImageDao dao; 
	private ReviewUploadImageDao() {} 
	
	public static ReviewUploadImageDao getInstance() {
		if (dao == null) {
			dao = new ReviewUploadImageDao(); 
		}
		return dao; 
	}
	
	public List<ReviewUploadImageDto> getReviewImages(int reviewId) {
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReviewUploadImageDto> list = new ArrayList<ReviewUploadImageDto>();
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT image_id, review_id, image_data "
					+ "FROM REVIEW_UPLOAD_IMAGE "
					+ "WHERE review_id = ? "
					+ "ORDER BY image_id";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reviewId);
			rs = pstmt.executeQuery(); 
			while (rs.next()) {
				ReviewUploadImageDto dto = new ReviewUploadImageDto();
				dto.setImageId(rs.getInt("image_id"));
				dto.setReviewId(reviewId);
				dto.setImageData(rs.getString("image_data"));
				
				list.add(dto); 
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch(Exception e) {}
		}
		return list;
	}
	
	public boolean insert(ReviewUploadImageDto dto) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		boolean result = false; 
		try {
			conn = new DbcpBean().getConn();
			String sql = "INSERT INTO REVIEW_UPLOAD_IMAGE (image_id, review_id, image_data) "
					+ "VALUES (REVIEW_UPLOAD_IMAGE_SEQ.NEXTVAL, ?, ? ) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getReviewId());
			pstmt.setString(2, dto.getImageData());
			result = pstmt.executeUpdate() > 0; 
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch(Exception e) {}
		}
		return result; 
	}
}
