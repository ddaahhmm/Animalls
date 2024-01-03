package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.MemberDto;
import util.DbcpBean;

public class MemberDao {
	private static MemberDao dao;

	private MemberDao() {}
	
	public static MemberDao getInstance() {
		if (dao == null) {
			dao = new MemberDao();
		}
		
		return dao;
	}
	
	// CRUD
	// 추가
	public boolean insert(MemberDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = "INSERT INTO MEMBER" + 
					" (member_id, delivery_id, password, name, nickname, phone_number, profile_image, email, email_verified, registered_date)" + 
					" VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getMemberId());
			pstmt.setInt(2, dto.getDeliveryId());
			pstmt.setString(3, dto.getPassword());
			pstmt.setString(4, dto.getName());
			pstmt.setString(5, dto.getNickname());
			pstmt.setString(6, dto.getPhoneNumber());
			pstmt.setString(7, dto.getProfileImage());
			pstmt.setString(8, dto.getEmail());
			pstmt.setBoolean(9, dto.isEmailVerified());
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResource(conn, pstmt);
		}
		
		return rowCount > 0;
	}
	
	// 수정
	public boolean update(MemberDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = "UPDATE MEMBER" + 
					" SET delivery_id=?, password=?, nickname=?, name=?, role=?, phone_number=?, rank=?, profile_image=?, email, email_verified=?" + 
					" WHERE member_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getDeliveryId());
			pstmt.setString(2, dto.getPassword());
			pstmt.setString(3, dto.getNickname());
			pstmt.setString(4, dto.getName());
			pstmt.setString(5, dto.getRole());
			pstmt.setString(6, dto.getPhoneNumber());
			pstmt.setString(7, dto.getRank());
			pstmt.setString(8, dto.getProfileImage());
			pstmt.setString(9, dto.getEmail());
			pstmt.setBoolean(10, dto.isEmailVerified());
			pstmt.setString(11, dto.getMemberId());
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResource(conn, pstmt);
		}
		
		return rowCount > 0;
	}
	
	// 삭제
	public boolean delete(String memberId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = "DELETE FROM MEMBER" + 
					" WHERE member_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);

			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResource(conn, pstmt);
		}
		
		return rowCount > 0;
	}
	
	// 조회
	public MemberDto getData(String memberId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberDto dto = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT delivery_id, password, nickname, name, role, phone_number, rank, profile_image, email, email_verified, registered_date" + 
					" FROM MEMBER" + 
					" WHERE member_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new MemberDto();
				dto.setMemberId(memberId);
				dto.setDeliveryId(rs.getInt("delivery_id"));
	            dto.setPassword(rs.getString("password"));
	            dto.setNickname(rs.getString("nickname"));
	            dto.setName(rs.getString("name"));
	            dto.setRole(rs.getString("role"));
	            dto.setPhoneNumber( rs.getString("phone_number"));
	            dto.setRank(rs.getString("rank"));
	            dto.setProfileImage(rs.getString("profile_image"));
	            dto.setEmail(rs.getString("email"));
	            dto.setEmailVerified(rs.getBoolean("email_verified"));
	            dto.setRegisteredDate(rs.getString("registered_date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResource(conn, pstmt, rs);
		}
		
		return dto;
	}
	
	// 목록 조회
	public List<MemberDto> getList() {
		List<MemberDto> list = new ArrayList<>();
		MemberDto dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT member_id, delivery_id, password, name, nickname, role, phone_number, rank, profile_image, email, email_verified, registered_date" +
					" FROM MEMBER" +
					" ORDER BY num DESC";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
	            dto = new MemberDto();
	            dto.setMemberId(rs.getString("member_id"));
	            dto.setDeliveryId(rs.getInt("delivery_id"));
	            dto.setPassword(rs.getString("password"));
	            dto.setName(rs.getString("name"));
	            dto.setNickname(rs.getString("nickname"));
	            dto.setRole(rs.getString("role"));
	            dto.setPhoneNumber( rs.getString("phone_number"));
	            dto.setRank(rs.getString("rank"));
	            dto.setProfileImage(rs.getString("profile_image"));
	            dto.setEmail(rs.getString("email"));
	            dto.setEmailVerified(rs.getBoolean("email_verified"));
	            dto.setRegisteredDate(rs.getString("registered_date"));
	            
	            list.add(dto);
			}
		} catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	    	closeResource(conn, pstmt, rs);
	    }
		
		return list;
	}
	
	// 조회 by 이메일
	public MemberDto getEmailData(String email) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberDto dto = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT delivery_id, password, nickname, name, role, phone_number, rank, profile_image, email, email_verified, registered_date" + 
					" FROM MEMBER" + 
					" WHERE email=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new MemberDto();
				dto.setMemberId(rs.getString("memberId"));
				dto.setDeliveryId(rs.getInt("delivery_id"));
	            dto.setPassword(rs.getString("password"));
	            dto.setNickname(rs.getString("nickname"));
	            dto.setName(rs.getString("name"));
	            dto.setRole(rs.getString("role"));
	            dto.setPhoneNumber( rs.getString("phone_number"));
	            dto.setRank(rs.getString("rank"));
	            dto.setProfileImage(rs.getString("profile_image"));
	            dto.setEmail(email);
	            dto.setEmailVerified(rs.getBoolean("email_verified"));
	            dto.setRegisteredDate(rs.getString("registered_date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResource(conn, pstmt, rs);
		}
		
		return dto;
	}
	
	private void closeResource(Connection conn, PreparedStatement pstmt) {
		try {
			if (conn != null)
				conn.close();
			if (pstmt != null)
				pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void closeResource(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {
			if (conn != null)
				conn.close();
			if (pstmt != null)
				pstmt.close();
			if (rs != null)
				rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
