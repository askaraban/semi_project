package xzy.itwill.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import xyz.itwill.DTO.CartDTO;
import xyz.itwill.DTO.ClientDTO;
import xyz.itwill.DTO.OrderDTO;

public class OrderDAO extends JdbcDAO {
	private static OrderDAO _dao;
	
	private OrderDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new OrderDAO();
	}
	
	public static OrderDAO getDAO() {
		return _dao;
	}
	
	//회원번호를 검색해서 회원번호에 해당하는 회원이 구매하기 버튼을 눌렀을 때 
	//해당제품에 대한 제품정보와 수량을 가져옴 (제품 테이블과 장바구니 테이블을 조인)
	
	public CartDTO selectCartByClientNum(ClientDTO client) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CartDTO cart=null;

		try {

			con = getConnection();

			String sql = "select cart_num, cart_client_num, cart_product_num, cart_count, product_name, product_price, product_com, "
					+ "product_dis, product_main_img from cart_table join product_table on cart_product_num = product_num where cart_client_num = ?"
					+ " order by cart_num desc";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, client.getClientNum());

			rs = pstmt.executeQuery();

			if(rs.next()) {
				cart=new CartDTO();
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
			System.out.println("[에러]selectCartList() 메소드 오류" + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return cart;
	}
	
	
		//주문정보를 전달받아 ORDER 테이블에 행으로 삽입하고 삽입행의 갯수를 반환하는 메소드
		public int insertOrder(OrderDTO order) {
			Connection con=null;
			PreparedStatement pstmt=null;
			int rows=0;
			try {
				con=getConnection();
				
				String sql="insert into order_table values(order_seq.nextval,?,?,sysdate,?,0,?,?,?,?,?,?,?,?,?)";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, order.getOrderClientNum());
				pstmt.setString(2, order.getOrderTime());
				pstmt.setInt(3, order.getOrderProductNum());
				pstmt.setInt(4, order.getOrderSum());
				pstmt.setInt(5, order.getOrderDisSum());
				pstmt.setString(6, order.getOrderContent());
				pstmt.setString(7, order.getOrderReceiver());
				pstmt.setString(8, order.getOrderZipcode());
				pstmt.setString(9, order.getOrderAddress1());
				pstmt.setString(10, order.getOrderAddress2());
				pstmt.setString(11, order.getOrderMobile());
				pstmt.setInt(12, order.getOrderCount());
						
				rows=pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러]insertOrder() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
		}
		
		
		
		//제품번호와 수량을 전달받아서 주문테이블의 행에 추가하는 메소드
		public int insertSingleOrder(int productNum, int count) {
			Connection con=null;
			
			
			PreparedStatement pstmt=null;
			int rows=0;
			try {
				con=getConnection();
				
				String sql="insert into order_table values(?,?)";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, productNum);
				pstmt.setInt(2, count);
				
				rows=pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러]insertSingleOrder() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
		}
}
