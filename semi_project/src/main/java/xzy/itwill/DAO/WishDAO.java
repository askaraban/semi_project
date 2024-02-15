package xzy.itwill.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.DTO.ProductDTO;
import xyz.itwill.DTO.WishDTO;

public class WishDAO extends JdbcDAO{
	private static WishDAO _dao;
	
	private WishDAO() {
		// TODO Auto-generated constructor stub
	}

	static {
		_dao = new WishDAO();
	}

	public static WishDAO getDAO() {
		return _dao;
	}

	// 좋아요 버튼 클릭 시 좋아요번호, 회원번호, 제품번호가 삽입되는 메소드
	public int insertWish(WishDTO wish) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con=getConnection();
			String sql = "insert into wishList_table values (wishlist_seq.nextval,?,?)";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, wish.getWishClientNum());
			pstmt.setInt(2, wish.getWishProductNum());
			
			rows=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러]insertWish() 메소드 오류" + e.getMessage());
		} finally {
			close(con, pstmt);
		} return rows;
	}
	
	// 회원번호를 전달받아 좋아요 번호를 가져오는 메소드;
	public List<WishDTO> selectWishList(int clientNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		List<WishDTO> wishList = new ArrayList<>();
		try {
			con=getConnection();
			
			String sql="select wish_num,wish_product_num,wish_client_num, from wishList_table where wish_client_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, clientNum);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				WishDTO wish=new WishDTO();
				wish.setWishNum(rs.getInt("wish_num"));
				wish.setWishProductNum(rs.getInt("wish_product_num"));
				wish.setWishClientNum(rs.getInt("wish_client_num"));
				wishList.add(wish);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectWishList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return wishList;
	}
	
	// 회원번호를 전달받아 좋아요 번호를 가져오는 메소드;
	public List<WishDTO> selectWishListAll(int clientNum, int startRow, int endRow) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		List<WishDTO> wishList = new ArrayList<>();
		try {
			con=getConnection();
			
			String sql="select * from (select rownum rn, temp.*from (select wish_num,wish_product_num,wish_client_num, product_name, product_main_img, product_price"
					+ " from wishList_table join product_table on wish_product_num=product_num where wish_client_num=?) temp) where rn between ? and ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, clientNum);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				WishDTO wish=new WishDTO();
				wish.setWishNum(rs.getInt("wish_num"));
				wish.setWishProductNum(rs.getInt("wish_product_num"));
				wish.setWishClientNum(rs.getInt("wish_client_num"));
				wish.setProductName(rs.getString("product_name"));
				wish.setProductMainImg(rs.getString("product_main_img"));
				wish.setProductPrice(rs.getInt("product_price"));
				
				wishList.add(wish);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectWishList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return wishList;
	}
	
	// 회원번호와 제품번호를 전달받아 좋아요 번호를 가져오는 메소드;
		public Integer selectWish(int productNum, int clientNum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs=null;
			Integer wishProductNum=0;
			try {
				con=getConnection();
				
				String sql="select wish_product_num from wishList_table where wish_product_num=? and wish_client_num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, productNum);
				pstmt.setInt(2, clientNum);
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					wishProductNum=(rs.getInt("wish_product_num"));
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectWish() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return wishProductNum;
		}
	
	public int deleteWish(int clientNum, int productNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con=getConnection();
			String sql = "delete from wishList_table where wish_client_num=? and wish_product_num=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, clientNum);
			pstmt.setInt(2, productNum);
			
			rows=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러]deleteWish() 메소드 오류" + e.getMessage());
		} finally {
			close(con, pstmt);
		} return rows;
	}
	
		
}
