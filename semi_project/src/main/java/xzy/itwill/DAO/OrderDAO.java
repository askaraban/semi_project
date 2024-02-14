package xzy.itwill.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.DTO.CartDTO;
import xyz.itwill.DTO.ClientDTO;
import xyz.itwill.DTO.OrderDTO;
import xyz.itwill.DTO.ProductDTO;
import xyz.itwill.DTO.ReviewDTO;

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
	
		//주문정보를 전달받아 ORDER 테이블에 행으로 삽입하고 삽입행의 갯수를 반환하는 메소드
		public int insertOrder(OrderDTO order) {
			Connection con=null;
			PreparedStatement pstmt=null;
			int rows=0;
			try {
				con=getConnection();
				
				String sql="insert into order_table values(order_seq.nextval,?,current_timestamp,sysdate,?,0,?,?,?,?,?,?,?,?,?,1)";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, order.getOrderClientNum());
				pstmt.setInt(2, order.getOrderProductNum());
				pstmt.setInt(3, order.getOrderSum());
				pstmt.setInt(4, order.getOrderDisSum());
				pstmt.setString(5, order.getOrderContent());
				pstmt.setString(6, order.getOrderReceiver());
				pstmt.setString(7, order.getOrderZipcode());
				pstmt.setString(8, order.getOrderAddress1());
				pstmt.setString(9, order.getOrderAddress2());
				pstmt.setString(10, order.getOrderMobile());
				pstmt.setInt(11, order.getOrderCount());
						
				rows=pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러]insertOrder() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
		}
			
		// 회원번호를 검색해 회원번호에 해당하는 product_table에 있는 단일행을 가져옴
		// 가져온 product_table에서  order_table과 조인하여 제품정보를 가져옴
		public OrderDTO selectOrderList(ClientDTO client) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			OrderDTO order=null;

			try {

				con = getConnection();

				String sql = "select order_num, order_client_num, order_time, order_date, order_product_num, order_status, order_sum, order_dis_sum, order_content, order_receiver"
				        +",order_zipcode, order_address1, order_address2, order_mobile, order_count, product_num, product_name, product_price"
				        +", product_dis, product_main_img"
				        +"from order_table join product_table on order_product_num = product_num where order_client_num = ?"
				        +"order by order_num desc";

				pstmt = con.prepareStatement(sql);

				pstmt.setInt(1, client.getClientNum());

				rs = pstmt.executeQuery();

				if(rs.next()) {
					order=new OrderDTO();
					order.setOrderNum(rs.getInt("order_num"));
					order.setOrderClientNum(rs.getInt("order_client_num"));
					order.setOrderTime(rs.getString("order_time"));
					order.setOrderDate(rs.getString("order_date"));
					order.setOrderProductNum(rs.getInt("order_product_num"));
					order.setOrderStatus(rs.getInt("order_status"));
					order.setOrderSum(rs.getInt("order_sum"));;
					order.setOrderDisSum(rs.getInt("order_dis_sum"));
					order.setOrderContent(rs.getString("order_content"));
					order.setOrderReceiver(rs.getString("order_receiver"));
					order.setOrderZipcode(rs.getString("order_zipcode"));
					order.setOrderAddress1(rs.getString("order_address1"));
					order.setOrderAddress2(rs.getString("order_address2"));
					order.setOrderMobile(rs.getString("order_mobile"));
					order.setOrderCount(rs.getInt("order_count"));
					order.setProductDis(rs.getInt("order_product_dis"));
					order.setProductMainImg(rs.getString("order_product_main_img"));
					order.setProductName(rs.getString("order_product_name"));
					order.setProductNum(rs.getInt("order_product_num"));
					order.setProductPrice(rs.getInt("order_product_price"));
				
				}

			} catch (SQLException e) {
				System.out.println("[에러]selectOrderList() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return order;
		}
		// 회원번호와 회원리뷰상태코드를 전달받아 상태코드가 1인 리스트 전달받기
		public List<OrderDTO> selectOrderList(ClientDTO client, int status) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<OrderDTO> orderList = new ArrayList<>();
			
			try {
				
				con = getConnection();
				
				String sql = "select order_num, order_client_num, order_time, order_date, order_product_num, order_status, order_sum, order_dis_sum, order_content, order_receiver"
						+",order_zipcode, order_address1, order_address2, order_mobile, order_count, product_num, product_name, product_price"
						+", product_dis, product_main_img, order_review_status"
						+"from order_table join product_table on order_product_num = product_num where order_client_num = ? and order_review_status=?"
						+"order by order_num desc";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, client.getClientNum());
				pstmt.setInt(2, status);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					OrderDTO order=new OrderDTO();
					order.setOrderNum(rs.getInt("order_num"));
					order.setOrderClientNum(rs.getInt("order_client_num"));
					order.setOrderTime(rs.getString("order_time"));
					order.setOrderDate(rs.getString("order_date"));
					order.setOrderProductNum(rs.getInt("order_product_num"));
					order.setOrderStatus(rs.getInt("order_status"));
					order.setOrderSum(rs.getInt("order_sum"));;
					order.setOrderDisSum(rs.getInt("order_dis_sum"));
					order.setOrderContent(rs.getString("order_content"));
					order.setOrderReceiver(rs.getString("order_receiver"));
					order.setOrderZipcode(rs.getString("order_zipcode"));
					order.setOrderAddress1(rs.getString("order_address1"));
					order.setOrderAddress2(rs.getString("order_address2"));
					order.setOrderMobile(rs.getString("order_mobile"));
					order.setOrderCount(rs.getInt("order_count"));
					order.setProductDis(rs.getInt("order_product_dis"));
					order.setProductMainImg(rs.getString("order_product_main_img"));
					order.setProductName(rs.getString("order_product_name"));
					order.setProductNum(rs.getInt("order_product_num"));
					order.setProductPrice(rs.getInt("order_product_price"));
					order.setProductPrice(rs.getInt("order_review_status"));
					orderList.add(order);
					
				}
				
			} catch (SQLException e) {
				System.out.println("[에러]selectOrderList() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return orderList;
		}
		
		
		// 날짜와 회원번호를 전달받아 해당 날짜에 해당하는 주문번호 리스트를 가져오는 메소드
		public List<OrderDTO> myOrderList(String startDate, String endDate, int clientNum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			List<OrderDTO> orderList = new ArrayList<>();

			try {

				con = getConnection();

				String sql = "select order_num, order_client_num, order_time, order_date, order_product_num, order_status, order_sum, order_dis_sum, product_name, "
						+ "product_num, order_content, order_receiver, order_zipcode, order_address1, order_address2, order_mobile, order_count from order_table"
						+ " join product_table on order_product_num=product_num "
						+ " where order_client_num=? and to_char(order_date,'yyyy-mm-dd') between ? and ?";
				
				pstmt = con.prepareStatement(sql);

				pstmt.setInt(1, clientNum);
				pstmt.setString(2, startDate);
				pstmt.setString(3, endDate);

				rs = pstmt.executeQuery();

				while (rs.next()) {
					OrderDTO order = new OrderDTO();
					order.setOrderNum(rs.getInt("order_num"));
					order.setOrderClientNum(rs.getInt("order_client_num"));
					order.setOrderTime(rs.getString("order_time"));
					order.setOrderDate(rs.getString("order_date"));
					order.setOrderProductNum(rs.getInt("order_product_num"));
					order.setOrderStatus(rs.getInt("order_status"));
					order.setOrderSum(rs.getInt("order_sum"));
					order.setOrderDisSum(rs.getInt("order_dis_sum"));
					
					order.setProductName(rs.getString("product_name"));
					order.setProductNum(rs.getInt("product_num"));
					
					order.setOrderContent(rs.getString("order_content"));
					order.setOrderReceiver(rs.getString("order_receiver"));
					order.setOrderZipcode(rs.getString("order_zipcode"));
					order.setOrderAddress1(rs.getString("order_address1"));
					order.setOrderAddress2(rs.getString("order_address2"));
					order.setOrderMobile(rs.getString("order_mobile"));
					order.setOrderCount(rs.getInt("order_count"));
					orderList.add(order);
				}

			} catch (SQLException e) {
				System.out.println("[에러]myOrderList() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return orderList;
		}

		
}
