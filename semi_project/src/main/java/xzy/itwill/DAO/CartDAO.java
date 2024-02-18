package xzy.itwill.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.DTO.CartDTO;
import xyz.itwill.DTO.ClientDTO;

public class CartDAO extends JdbcDAO {
	private static CartDAO _dao;
	
	private CartDAO() {
		// TODO Auto-generated constructor stub
	}

	static {
		_dao = new CartDAO();
	}

	public static CartDAO getDAO() {
		return _dao;
	}

	// 회원번호,제품번호,제품수량을 전달받아 CART_TABLE 에 추가하는 메소드
	public int insertCart(int clientNum, int productNum, int count) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();
			String sql = "insert into cart_table values (cart_seq.nextval,?,?,?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, clientNum);
			pstmt.setInt(2, productNum);
			pstmt.setInt(3, count);

			rows = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("[에러]insertCart() 메소드 오류" + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 회원번호와 제품번호를 전달받아 CART_TABLE 에 cart_product_num의 유무를 검색하는 메소드
	public int selectProductCount(int clientNum, int productNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rows = 0;

		try {
			con = getConnection();
			String sql = "select count(cart_product_num) as cart_product_num from cart_table where cart_client_num=? and cart_product_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, clientNum);
			pstmt.setInt(2, productNum);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				rows = rs.getInt("cart_product_num");
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductCount() 메소드 오류" + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	// 카트번호를 전달받아 CART_TABLE 에 cart_product_num의 유무를 검색하는 메소드
	public int selectProductCount(int cartNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rows = 0;

		try {
			con = getConnection();
			String sql = "select count(cart_product_num) as cart_product_num from cart_table where cart_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cartNum);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				rows = rs.getInt("cart_product_num");
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductCount() 메소드 오류" + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 장바구니에 같은 productNum이 이미 있을 경우 기존 상품 주문 수량을 업데이트 하는 메소드
	public int updateCart(int clientNum, int productNum, int count) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();
			String sql = "update cart_table set cart_count=cart_count+? where cart_product_num=? and cart_client_num=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, count);
			pstmt.setInt(2, productNum);
			pstmt.setInt(3, clientNum);

			rows = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("[에러]updateCart() 메소드 오류" + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

// 장바구니의 번호를 가져와 상품 주문 수량을 업데이트 하는 메소드 (장바구니에서 실행되는 메소드)
	public int updateCartPageContent(CartDTO cart) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();
			String sql = "update cart_table set cart_count=? where cart_num=? and cart_client_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cart.getCartCount());
			pstmt.setInt(2, cart.getCartNum());
			pstmt.setInt(3, cart.getCartClientNum());

			rows = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("[에러]updateCart() 메소드 오류" + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 회원번호를 검색해 회원번호에 해당하는 cart_table에 있는 모든 cart를 가져옴
	// 가져온 cart _table에서 product_table과 조인하여 product_table의 제품정보를 가져옴
	public List<CartDTO> selectCartList(ClientDTO client) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		List<CartDTO> cartList = new ArrayList<>();

		try {

			con = getConnection();

			String sql = "select cart_num, cart_client_num, cart_product_num, cart_count, product_name, product_price, product_com, "
					+ "product_dis, product_main_img from cart_table join product_table on cart_product_num = product_num"
					+ " where cart_client_num = ? and product_status=1"
					+ " order by cart_num desc";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, client.getClientNum());

			rs = pstmt.executeQuery();

			while (rs.next()) {
				CartDTO cart = new CartDTO();
				cart.setCartNum(rs.getInt("cart_num"));
				cart.setCartClientNum(rs.getInt("cart_client_num"));
				cart.setCartProductNum(rs.getInt("cart_product_num"));
				cart.setCartCount(rs.getInt("cart_count"));
				cart.setProductName(rs.getString("product_name"));
				cart.setProductPrice(rs.getInt("product_price"));
				cart.setProductCom(rs.getString("product_com"));
				cart.setProductDis(rs.getInt("product_dis"));
				cart.setProductMainImg(rs.getString("product_main_img"));
				cartList.add(cart);
			}

		} catch (SQLException e) {
			System.out.println("[에러]selectCartList() 메소드 오류" + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return cartList;
	}
	public CartDTO selectOrder(int cartNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		CartDTO cart = null;
		
		try {
			
			con = getConnection();
			
			String sql = "select cart_num, cart_client_num, cart_product_num, cart_count, product_name, product_price, product_com, "
					+ "product_dis, product_main_img from cart_table join product_table on cart_product_num = product_num where cart_num = ?"
					+ " order by cart_num desc";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, cartNum);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				cart = new CartDTO();
				cart.setCartNum(rs.getInt("cart_num"));
				cart.setCartClientNum(rs.getInt("cart_client_num"));
				cart.setCartProductNum(rs.getInt("cart_product_num"));
				cart.setCartCount(rs.getInt("cart_count"));
				cart.setProductName(rs.getString("product_name"));
				cart.setProductPrice(rs.getInt("product_price"));
				cart.setProductCom(rs.getString("product_com"));
				cart.setProductDis(rs.getInt("product_dis"));
				cart.setProductMainImg(rs.getString("product_main_img"));
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]selectOrder() 메소드 오류" + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return cart;
	}

	public int deleteCart(int cartNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();
			String sql = "delete from cart_table where cart_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cartNum);

			rows = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("[에러]deleteCart() 메소드 오류" + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

}
