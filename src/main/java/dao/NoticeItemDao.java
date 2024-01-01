package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import dto.NoticeItemDto;
import util.DbcpBean;

public class NoticeItemDao {
	private static final int PAGINATION_COUNT = 15; 
	private static NoticeItemDao dao; 
	
	public static NoticeItemDao getInstance() {
		if (dao == null) {
			dao = new NoticeItemDao(); 
		}
		return dao; 
	}
	
	private NoticeItemDao() {}
	
	public static int getPaginationCount() {
		return PAGINATION_COUNT;
	}
	
	public int getTotalPostCount() {
		String sql = "SELECT COUNT(*) cnt FROM NOTICE_ITEM";
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		int ret = -1; 
		try {
			conn = new DbcpBean().getConn();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ret = rs.getInt("cnt");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}		
		return ret; 
	}
	
	public boolean insert(NoticeItemDto dto) {
		String sql = "INSERT INTO NOTICE_ITEM (notice_item_id, writer_id, notice_title, notice_content, created_at) "
				+ "VALUES(NOTICE_ITEM_SEQ.NEXTVAL, ?, ?, ?, SYSDATE)";
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		boolean ret = false; 
		
		try {
			conn = new DbcpBean().getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getWriterId());
			pstmt.setString(2, dto.getNoticeTitle());
			pstmt.setString(3, dto.getNoticeContent());
			ret = pstmt.executeUpdate() > 0;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return ret;
	}
	
	public boolean delete(int noticeItemId) {
		String sql = "DELTE FROM NOTICE_ITEM "
				+ "WHERE notice_item_id = ?";
		Connection conn = null;
		PreparedStatement pstmt = null; 
		boolean ret = false; 
		try {
			conn = new DbcpBean().getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, noticeItemId);
			ret = pstmt.executeUpdate() > 0;
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();			
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return ret; 
	}
	
	public boolean update(NoticeItemDto dto) {
		String sql = "UPDATE NOTICE_ITEM "
				+ "SET writer_id = ?, notice_title = ?, notice_content = ? "
				+ "WHERE notice_item_id = ?";
		Connection conn = null; 
		PreparedStatement pstmt = null ;
		boolean ret = false; 
		try {
			conn = new DbcpBean().getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getWriterId());
			pstmt.setString(2, dto.getNoticeTitle());
			pstmt.setString(3, dto.getNoticeContent());
			pstmt.setInt(4, dto.getNoticeItemId());
			
			ret = pstmt.executeUpdate() > 0;
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close(); 
			} catch(Exception e) {
				e.printStackTrace();;
			}
		}
		return ret;
	}
	
	public List<NoticeItemDto> getList(int page) {
		String sql = "SELECT notice_item_id, writer_id, notice_title, notice_content, created_at, rnum "
					+ "FROM ("
					+ "		SELECT notice_item_id, writer_id, notice_title, notice_content, created_at, ROWNUM rnum"
					+ "		FROM NOTICE_ITEM "
					+ "		ORDER BY notice_item_id DESC "
					+ ") "
					+ "WHERE rnum BETWEEN ? AND ? "
					+ "ORDER BY notice_item_id DESC";

		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<NoticeItemDto> ret = new ArrayList<>(); 
		try {
			conn = new DbcpBean().getConn();
			pstmt = conn.prepareStatement(sql);
			
			int startRowNum = PAGINATION_COUNT * (page - 1) + 1; 
			int endRowNum = PAGINATION_COUNT * page; 
			
			pstmt.setInt(1, startRowNum);
			pstmt.setInt(2, endRowNum);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int noticeItemId = rs.getInt("notice_item_id");
				String writerId = rs.getString("writer_id"); 
				String noticeTitle = rs.getString("notice_title"); 
				String noticeContent = rs.getString("notice_content");
				String createdAt = rs.getString("created_at");
				NoticeItemDto dto = new NoticeItemDto(noticeItemId,  writerId, noticeTitle, noticeContent, createdAt);
				ret.add(dto);
			}
			ret.sort(Comparator.comparing(NoticeItemDto::getNoticeItemId, Comparator.reverseOrder()));
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try	{
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return ret;
	}
	
	public NoticeItemDto getOne(int noticeItemId) {
		String sql = "SELECT writer_id, notice_title, notice_content, created_at "
				+ "FROM NOTICE_ITEM "
				+ "WHERE notice_item_id = ?";
		
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		NoticeItemDto dto = null; 
		try {
			conn = new DbcpBean().getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, noticeItemId);
			rs = pstmt.executeQuery(); 
			if (rs.next()) {
				String writerId = rs.getString("writer_id");
				String noticeTitle = rs.getString("notice_title");
				String noticeContent = rs.getString("notice_content");
				String createdAt = rs.getString("created_at");
				dto = new NoticeItemDto(noticeItemId, writerId, noticeTitle, noticeContent, createdAt);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch(Exception e) {
			}
		}
		return dto; 
	}
}
