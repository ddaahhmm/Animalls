package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.CartItemDto;
import util.DbcpBean;

public class CartItemDao {
	
	private static CartItemDao dao;
	private CartItemDao() {}
	public static CartItemDao getInstance() {
		if(dao==null) {
			dao=new CartItemDao();
		}
		return dao;
	}
	
	public boolean optUpdate(int cartItemId, int optionId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "UPDATE CART_ITEM"
					+ " SET option_id=?"
					+ " WHERE cart_item_id=?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩 할 내용이 있으면 바인딩
			pstmt.setInt(1, optionId);
			pstmt.setInt(2, cartItemId);
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
	
	
	public boolean amountUpdate(int cartItemId, int amount) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "UPDATE CART_ITEM"
					+ " SET amount=?"
					+ " WHERE cart_item_id=?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩 할 내용이 있으면 바인딩
			pstmt.setInt(1, amount);
			pstmt.setInt(2, cartItemId);
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
	
	public boolean update(CartItemDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "UPDATE CART_ITEM"
					+ " SET buyer_id=?, product_id=?, option_id=?, amount=?"
					+ " WHERE cart_item_id=?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩 할 내용이 있으면 바인딩
			pstmt.setString(1, dto.getBuyerId());
			pstmt.setInt(2, dto.getProductId());
			pstmt.setInt(3, dto.getOptionId());
			pstmt.setInt(4, dto.getAmount());
			pstmt.setInt(5, dto.getCartItemId());
			
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
	
	
	public CartItemDto getData(int cartItemId) {
		CartItemDto dto = new CartItemDto();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "SELECT cart_item_id, buyer_id, product_id, option_id, amount"
					+ " FROM CART_ITEM"
					+ " WHERE cart_item_id = ?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 여기서 한다.
			pstmt.setInt(1, cartItemId);
			//query 문 수행하고 결과(ResultSet) 얻어내기
			rs = pstmt.executeQuery();
			//반복문 돌면서 
			while (rs.next()) {
				dto.setCartItemId(cartItemId);
				dto.setBuyerId(rs.getString("buyer_id"));
				dto.setProductId(rs.getInt("product_id"));
				dto.setOptionId(rs.getInt("option_id"));
				dto.setAmount(rs.getInt("amount"));
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
	
	public boolean delete(int cartItemId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "DELETE FROM CART_ITEM"
					+ " WHERE cart_item_id=?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩 할 내용이 있으면 바인딩
			pstmt.setInt(1, cartItemId);
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
	
	public boolean insert(CartItemDto dto) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		int rowCount=0;
		try {
			conn=new DbcpBean().getConn();
			String sql="INSERT INTO CART_ITEM"
					+ " (cart_item_id, buyer_id, product_id, option_id, amount)"
					+ " VALUES(CART_ITEM_SEQ.NEXTVAL,?,?,?,?)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getBuyerId());
			pstmt.setInt(2, dto.getProductId());
			pstmt.setInt(3,dto.getOptionId());
			pstmt.setInt(4, dto.getAmount());
			rowCount=pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			}catch(Exception e) {}
		}
		if(rowCount>0) {
			return true;
		}else {
			return false;
		}
	}
public List<CartItemDto> getList(){
		
		List<CartItemDto> list=new ArrayList<>();

		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			//DbcpBean() 객체를 이용해서 Connection 객체 하나 얻어내기 (Connection Pool 에서 하나 꺼내오기)
			conn=new DbcpBean().getConn();
			//실행할 sql 문
			String sql="SELECT cart_item_id, buyer_id,product_id,option_id,amount"+
			 	" FROM CART_ITEM"+
				" ORDER BY cart_item_id DESC";
			pstmt=conn.prepareStatement(sql);
			//query 문 수행하고 결과(ResultSet) 얻어내기
			rs=pstmt.executeQuery();
			//반복문 돌면서 
			while(rs.next()){
				
				CartItemDto dto=new CartItemDto();
				dto.setCartItemId(rs.getInt("cart_item_id"));
				dto.setBuyerId(rs.getString("buyer_id"));
				dto.setProductId(rs.getInt("product_id"));
				dto.setOptionId(rs.getInt("option_id"));
				dto.setAmount(rs.getInt("amount"));
				//ArrayList 객체에 누적 시킨다.
				list.add(dto);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close(); //Connection 객체의 close() 메소드를 호출하면 Pool 에 반납된다.
			}catch(Exception e){}
		}
		return list;
	}
	
}