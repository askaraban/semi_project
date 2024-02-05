package xzy.itwill.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import xyz.itwill.DTO.CartDTO;
import xyz.itwill.DTO.ClientDTO;

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
	
	//회원번호를 전달받아  테이블에 저장된 단일행을 검색하여 회원정보를 반환하는 메소드
	//주문자의 이름, 전화번호, 이메일 
	//public ClientDTO selectClientByNum(int clientNum)  -> ClientDAO 사용
	
	
	//단일행 검색  
	//배송지 작성 -> 주문자 정보와 동일 누를 경우 이름 연락처 이메일 주소 자동 입력 +
	//배송 요청사항 INSERT
	
	
	//새로운 배송지 버튼 누르면 입력창 초기화, 받는 사람 연락처 이메일 주소 배송요청사항을 전달받아
	//주문 테이블에 행으로 삽입하고 삽입행의 갯수를 반환하는 메소드 
	
	//결제하기 버튼을 누르면 TIMESTAMP 객체 만들어서 데이터 삽입 
	
	
	 
	
}
