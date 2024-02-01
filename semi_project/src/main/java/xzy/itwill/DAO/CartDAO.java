package xzy.itwill.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.DTO.CartDTO;
import xyz.itwill.DTO.ClientDTO;

public class CartDAO extends JdbcDAO{
	private static CartDAO _dao;
	
	static {
		_dao = new CartDAO();
	}
	
	public static CartDAO getDAO() {
		return _dao;
	}
	
	public int insertCart(int clientNum, int productNum, int count) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con=getConnection();
			String sql = "insert into cart_table values (cart_seq.nextval,?,?,?)";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, clientNum);
			pstmt.setInt(2, productNum);
			pstmt.setInt(3, count);
			
			rows=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러]insertCart() 메소드 오류" + e.getMessage());
		} finally {
			close(con, pstmt);
		} return rows;
	}
	
	// 회원번호를 검색해 회원번호에 해당하는 cart_table에 있는 모든 cart번호를 가져옴
	public List<CartDTO> selectCartList(ClientDTO client){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CartDTO> cartList = new ArrayList<>();
		
		try {
			
			con=getConnection();
			
			String sql = "select cart_num, cart_client_num, cart_product_num, cart_count where cart_client_num=?";
			
		} catch (SQLException e) {
			System.out.println("[에러]selectCartList() 메소드 오류" + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		} return cartList;
	}
}
