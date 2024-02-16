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
				
				String sql="insert into order_table values(order_table_seq.nextval,?,substr(current_timestamp,0,17),sysdate,?,0,?,?,?,?,?,?,?,?,?,0,?)";
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
				pstmt.setString(12, order.getOrder_email());
						
				rows=pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러]insertOrder() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
		}
			
		// 회원번호를 검색해 회원번호에 해당하는 product_table에 있는 제품리스트을 가져옴
		// 가져온 product_table에서  order_table과 조인하여 제품정보를 가져옴
		public List<OrderDTO> selectedOrderList(ClientDTO client) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			List<OrderDTO> orderList = new ArrayList<>();

			try {

				con = getConnection();

				String sql = "select order_num, order_client_num, order_time, order_date, order_product_num, order_status, order_sum, order_dis_sum, order_content, order_receiver"
				        +",order_zipcode, order_address1, order_address2, order_mobile, order_count, product_num, product_name, product_price"
				        +", product_dis, product_main_img, order_email "
				        +"from order_table join product_table on order_product_num = product_num where order_client_num = ?"
				        +"order by order_num desc";

				pstmt = con.prepareStatement(sql);

				pstmt.setInt(1, client.getClientNum());

				rs = pstmt.executeQuery();

				while(rs.next()) {
					OrderDTO order=new OrderDTO();
					order.setOrderNum(rs.getInt("order_num"));
					order.setOrderClientNum(rs.getInt("order_client_num"));
					order.setOrderTime(rs.getString("order_time"));
					order.setOrderDate(rs.getString("order_date"));
					order.setOrderProductNum(rs.getInt("order_product_num"));
					order.setOrderStatus(rs.getInt("order_status"));
					order.setOrderSum(rs.getInt("order_sum"));
					order.setOrderDisSum(rs.getInt("order_dis_sum"));
					order.setOrderContent(rs.getString("order_content"));
					order.setOrderReceiver(rs.getString("order_receiver"));
					order.setOrderZipcode(rs.getString("order_zipcode"));
					order.setOrderAddress1(rs.getString("order_address1"));
					order.setOrderAddress2(rs.getString("order_address2"));
					order.setOrderMobile(rs.getString("order_mobile"));
					order.setOrderCount(rs.getInt("order_count"));
					order.setProductName(rs.getString("product_name"));
					order.setProductPrice(rs.getInt("product_price"));
					order.setProductDis(rs.getInt("product_dis"));
					order.setProductMainImg(rs.getString("product_main_img"));
					order.setProductNum(rs.getInt("order_product_num"));
					order.setOrder_email(rs.getString("order_email"));
					orderList.add(order);
				}

			} catch (SQLException e) {
				System.out.println("[에러]selectOrderList() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			} return orderList;
			
		}
			// 주문번호를 검색해 회원번호에 해당하는 product_table에 있는 제품리스트을 가져옴
			// 가져온 product_table에서  order_table과 조인하여 제품정보를 가져옴
			public OrderDTO selectedOrderList(String timeStamp) {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				OrderDTO order = null;
				
				
				try {
					
					con = getConnection();
					
					String sql = "select * from (select rownum rn, temp.* from (select order_num, order_client_num, order_time, order_date, order_product_num"
							+ ", order_status, order_sum, order_dis_sum, order_content, order_receiver"
							+",order_zipcode, order_address1, order_address2, order_mobile, order_count, product_num, product_name, product_price"
							+", product_dis, product_main_img, order_email from order_table join product_table on order_product_num = product_num where order_time like '%'||?||'%' "
							+"order by order_num desc) temp) where rn=1";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, timeStamp);
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						order=new OrderDTO();
						order.setOrderNum(rs.getInt("order_num"));
						order.setOrderClientNum(rs.getInt("order_client_num"));
						order.setOrderTime(rs.getString("order_time"));
						order.setOrderDate(rs.getString("order_date"));
						order.setOrderProductNum(rs.getInt("order_product_num"));
						order.setOrderStatus(rs.getInt("order_status"));
						order.setOrderSum(rs.getInt("order_sum"));
						order.setOrderDisSum(rs.getInt("order_dis_sum"));
						order.setOrderContent(rs.getString("order_content"));
						order.setOrderReceiver(rs.getString("order_receiver"));
						order.setOrderZipcode(rs.getString("order_zipcode"));
						order.setOrderAddress1(rs.getString("order_address1"));
						order.setOrderAddress2(rs.getString("order_address2"));
						order.setOrderMobile(rs.getString("order_mobile"));
						order.setOrderCount(rs.getInt("order_count"));
						order.setProductName(rs.getString("product_name"));
						order.setProductPrice(rs.getInt("product_price"));
						order.setProductDis(rs.getInt("product_dis"));
						order.setProductMainImg(rs.getString("product_main_img"));
						order.setProductNum(rs.getInt("order_product_num"));
						order.setOrder_email(rs.getString("order_email"));
					}
					
				} catch (SQLException e) {
					System.out.println("[에러]selectOrderList() 메소드 오류" + e.getMessage());
				} finally {
					close(con, pstmt, rs);
				}
				return order;
		}
			// 타임스탬프를 전달하여 주문 개수를 반환받는 메소드
			public int selectSameOrder(String timeStamp) {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				int rows= 0;
				
				try {
					
					con = getConnection();
					
					String sql = "select count(*) from order_table where order_time like '%'||?||'%'";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, timeStamp);
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						rows=rs.getInt(1);
					}
					
				} catch (SQLException e) {
					System.out.println("[에러]selectOrderList() 메소드 오류" + e.getMessage());
				} finally {
					close(con, pstmt, rs);
				}
				return rows;
			}
			
		// 타임스탬프를 전달받아 해당 타임스탬프에 해당하는 정보를 가져오는 메소드
		public List<OrderDTO> selectOrder(String timeStamp) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			List<OrderDTO> orderList = new ArrayList<OrderDTO>();
			
			try {
				
				con = getConnection();
				
				String sql = "select order_num, order_client_num, order_time, order_date, order_product_num, order_status, order_sum, order_dis_sum, order_content, order_receiver"
						+",order_zipcode, order_address1, order_address2, order_mobile, order_count, product_num, product_name, product_price"
						+", product_dis, product_main_img, order_email from order_table join product_table on order_product_num = product_num"
						+ " where order_time like '%'||?||'%' order by order_num desc";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, timeStamp);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					OrderDTO order=new OrderDTO();
					order.setOrderNum(rs.getInt("order_num"));
					order.setOrderClientNum(rs.getInt("order_client_num"));
					order.setOrderTime(rs.getString("order_time"));
					order.setOrderDate(rs.getString("order_date"));
					order.setOrderProductNum(rs.getInt("order_product_num"));
					order.setOrderStatus(rs.getInt("order_status"));
					order.setOrderSum(rs.getInt("order_sum"));
					order.setOrderDisSum(rs.getInt("order_dis_sum"));
					order.setOrderContent(rs.getString("order_content"));
					order.setOrderReceiver(rs.getString("order_receiver"));
					order.setOrderZipcode(rs.getString("order_zipcode"));
					order.setOrderAddress1(rs.getString("order_address1"));
					order.setOrderAddress2(rs.getString("order_address2"));
					order.setOrderMobile(rs.getString("order_mobile"));
					order.setOrderCount(rs.getInt("order_count"));
					order.setProductNum(rs.getInt("product_num"));
					order.setProductName(rs.getString("product_name"));
					order.setProductPrice(rs.getInt("product_price"));
					order.setProductDis(rs.getInt("product_dis"));
					order.setProductMainImg(rs.getString("product_main_img"));
					order.setOrder_email(rs.getString("order_email"));
					
					orderList.add(order);
					
				}
				
			} catch (SQLException e) {
				System.out.println("[에러]selectOrder() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return orderList;
		}
		// 타임스탬프를 전달받아 해당 타임스탬프에 해당하는 정보를 가져오는 메소드
		public List<OrderDTO> selectManagerOrder(String timeStamp) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			List<OrderDTO> orderList = new ArrayList<OrderDTO>();
			
			try {
				
				con = getConnection();
				
				String sql = "select order_num, order_client_num, order_time, order_date, order_product_num, order_status, order_sum, order_dis_sum, order_content, order_receiver"
						+",order_zipcode, order_address1, order_address2, order_mobile, order_count, product_num, product_name, product_price"
						+", product_dis, product_main_img, order_email from order_table join product_table on order_product_num = product_num"
						+ " where order_time like '%'||?||'%' and order_status=0 order by order_num desc";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, timeStamp);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					OrderDTO order=new OrderDTO();
					order.setOrderNum(rs.getInt("order_num"));
					order.setOrderClientNum(rs.getInt("order_client_num"));
					order.setOrderTime(rs.getString("order_time"));
					order.setOrderDate(rs.getString("order_date"));
					order.setOrderProductNum(rs.getInt("order_product_num"));
					order.setOrderStatus(rs.getInt("order_status"));
					order.setOrderSum(rs.getInt("order_sum"));
					order.setOrderDisSum(rs.getInt("order_dis_sum"));
					order.setOrderContent(rs.getString("order_content"));
					order.setOrderReceiver(rs.getString("order_receiver"));
					order.setOrderZipcode(rs.getString("order_zipcode"));
					order.setOrderAddress1(rs.getString("order_address1"));
					order.setOrderAddress2(rs.getString("order_address2"));
					order.setOrderMobile(rs.getString("order_mobile"));
					order.setOrderCount(rs.getInt("order_count"));
					order.setProductNum(rs.getInt("product_num"));
					order.setProductName(rs.getString("product_name"));
					order.setProductPrice(rs.getInt("product_price"));
					order.setProductDis(rs.getInt("product_dis"));
					order.setProductMainImg(rs.getString("product_main_img"));
					order.setOrder_email(rs.getString("order_email"));
					
					orderList.add(order);
					
				}
				
			} catch (SQLException e) {
				System.out.println("[에러]selectOrder() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return orderList;
		}
		// 회원번호와 회원리뷰상태코드를 전달받아 상태코드가 1인 리스트 전달받기
		public List<OrderDTO> selectOrderList(ClientDTO client, int status) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<OrderDTO> orderList = new ArrayList<>();
			
			try {
				
				con = getConnection();
				
				String sql = "select * from (select rownum rn, temp.* from (select order_num, order_client_num, order_time, order_date, order_product_num, order_status, order_sum, order_dis_sum, order_content, order_receiver"
						+",order_zipcode, order_address1, order_address2, order_mobile, order_count, product_num, product_name, product_price"
						+", product_dis, product_main_img, order_review_status, order_email"
						+" from order_table join product_table on order_product_num = product_num where order_client_num = ? and order_review_status=? order by order_num desc) temp)";
				
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
					order.setOrderSum(rs.getInt("order_sum"));
					order.setOrderDisSum(rs.getInt("order_dis_sum"));
					order.setOrderContent(rs.getString("order_content"));
					order.setOrderReceiver(rs.getString("order_receiver"));
					order.setOrderZipcode(rs.getString("order_zipcode"));
					order.setOrderAddress1(rs.getString("order_address1"));
					order.setOrderAddress2(rs.getString("order_address2"));
					order.setOrderMobile(rs.getString("order_mobile"));
					order.setOrderCount(rs.getInt("order_count"));
					order.setProductNum(rs.getInt("product_num"));
					order.setProductName(rs.getString("product_name"));
					order.setProductPrice(rs.getInt("product_price"));
					order.setProductDis(rs.getInt("product_dis"));
					order.setProductMainImg(rs.getString("product_main_img"));
					order.setOrderReviewStatus(rs.getInt("order_review_status"));
					order.setOrder_email(rs.getString("order_email"));
					orderList.add(order);
					
				}
				
			} catch (SQLException e) {
				System.out.println("[에러]selectOrderList1() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return orderList;
		}
		// 회원번호와 회원리뷰상태코드, 시작페이지와, 끝번호를 전달받아 상태코드가 1인 리스트 전달받기
		public List<OrderDTO> selectOrderList(ClientDTO client, int status, int startRow, int endRow) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<OrderDTO> orderList = new ArrayList<>();
			
			try {
				
				con = getConnection();
				
				String sql = "select * from (select rownum rn, temp.* from "
						+ "(select order_num, order_client_num, order_time, order_date, order_product_num, order_status, order_sum"
						+ ", order_dis_sum, order_content, order_receiver"
						+", order_zipcode, order_address1, order_address2, order_mobile, order_count, product_num, product_name, product_price"
						+", product_dis, product_main_img, order_review_status, order_email from order_table join product_table"
						+ " on order_product_num = product_num where order_client_num = ? and order_review_status=? order by order_num desc)"
						+ " temp) where rn between ? and ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, client.getClientNum());
				pstmt.setInt(2, status);
				pstmt.setInt(3, startRow);
				pstmt.setInt(4, endRow);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					OrderDTO order=new OrderDTO();
					order.setOrderNum(rs.getInt("order_num"));
					order.setOrderClientNum(rs.getInt("order_client_num"));
					order.setOrderTime(rs.getString("order_time"));
					order.setOrderDate(rs.getString("order_date"));
					order.setOrderProductNum(rs.getInt("order_product_num"));
					order.setOrderStatus(rs.getInt("order_status"));
					order.setOrderSum(rs.getInt("order_sum"));
					order.setOrderDisSum(rs.getInt("order_dis_sum"));
					order.setOrderContent(rs.getString("order_content"));
					order.setOrderReceiver(rs.getString("order_receiver"));
					order.setOrderZipcode(rs.getString("order_zipcode"));
					order.setOrderAddress1(rs.getString("order_address1"));
					order.setOrderAddress2(rs.getString("order_address2"));
					order.setOrderMobile(rs.getString("order_mobile"));
					order.setOrderCount(rs.getInt("order_count"));
					order.setProductNum(rs.getInt("product_num"));
					order.setProductName(rs.getString("product_name"));
					order.setProductPrice(rs.getInt("product_price"));
					order.setProductDis(rs.getInt("product_dis"));
					order.setProductMainImg(rs.getString("product_main_img"));
					order.setOrderReviewStatus(rs.getInt("order_review_status"));
					order.setOrder_email(rs.getString("order_email"));
					orderList.add(order);
					
				}
				
			} catch (SQLException e) {
				System.out.println("[에러]selectOrderList2() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return orderList;
		}
		// 회원번호와 회원리뷰상태코드를 전달받아 상태코드가 1인 리스트 전달받기
		public int selectOrderCnt(int status, int clientNum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int rows = 0;
			
			try {
				
				con = getConnection();
				
				String sql="select count(*) from order_table where order_review_status=? and order_client_num=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, status);
				pstmt.setInt(2, clientNum);
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					rows=rs.getInt(1);
				}
								
			} catch (SQLException e) {
				System.out.println("[에러]selectOrderCnt1() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return rows;
		}
		// 회원번호와 회원리뷰상태코드를 전달받아 상태코드가 1인 리스트 전달받기
		public int selectOrderCnt(int clientNum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int rows = 0;
			
			try {
				
				con = getConnection();
				
				String sql="select count(*) from order_table where order_client_num=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, clientNum);
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					rows=rs.getInt(1);
				}
				
			} catch (SQLException e) {
				System.out.println("[에러]selectOrderCnt2() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return rows;
		}
		
		
		/*
		 * // 날짜와 회원번호를 전달받아 해당 날짜에 해당하는 주문번호 리스트를 가져오는 메소드 public List<OrderDTO>
		 * myOrderList(String startDate, String endDate, int clientNum) { Connection con
		 * = null; PreparedStatement pstmt = null; ResultSet rs = null;
		 * 
		 * List<OrderDTO> orderList = new ArrayList<>();
		 * 
		 * try {
		 * 
		 * con = getConnection();
		 * 
		 * String sql =
		 * "select order_num, order_client_num, order_time, order_date, order_product_num, order_status, order_sum, order_dis_sum, product_name, "
		 * +
		 * "product_num, order_content, order_receiver, order_zipcode, order_address1, order_address2, order_mobile, order_count, order_email from order_table"
		 * + " join product_table on order_product_num=product_num " +
		 * " where order_client_num=? and to_char(order_date,'yyyy-mm-dd') between ? and ? order by order_date desc"
		 * ;
		 * 
		 * pstmt = con.prepareStatement(sql);
		 * 
		 * pstmt.setInt(1, clientNum); pstmt.setString(2, startDate); pstmt.setString(3,
		 * endDate);
		 * 
		 * rs = pstmt.executeQuery();
		 * 
		 * while (rs.next()) { OrderDTO order = new OrderDTO();
		 * order.setOrderNum(rs.getInt("order_num"));
		 * order.setOrderClientNum(rs.getInt("order_client_num"));
		 * order.setOrderTime(rs.getString("order_time"));
		 * order.setOrderDate(rs.getString("order_date"));
		 * order.setOrderProductNum(rs.getInt("order_product_num"));
		 * order.setOrderStatus(rs.getInt("order_status"));
		 * order.setOrderSum(rs.getInt("order_sum"));
		 * order.setOrderDisSum(rs.getInt("order_dis_sum"));
		 * 
		 * order.setProductName(rs.getString("product_name"));
		 * order.setProductNum(rs.getInt("product_num"));
		 * 
		 * order.setOrderContent(rs.getString("order_content"));
		 * order.setOrderReceiver(rs.getString("order_receiver"));
		 * order.setOrderZipcode(rs.getString("order_zipcode"));
		 * order.setOrderAddress1(rs.getString("order_address1"));
		 * order.setOrderAddress2(rs.getString("order_address2"));
		 * order.setOrderMobile(rs.getString("order_mobile"));
		 * order.setOrderCount(rs.getInt("order_count"));
		 * order.setOrder_email(rs.getString("order_email")); orderList.add(order); }
		 * 
		 * } catch (SQLException e) { System.out.println("[에러]myOrderList() 메소드 오류" +
		 * e.getMessage()); } finally { close(con, pstmt, rs); } return orderList; }
		 */		// 날짜와 회원번호를 전달받아 해당 날짜에 해당하는 주문번호 리스트를 가져오는 메소드
		public List<OrderDTO> myOrderList(String startDate, String endDate, int clientNum, int startRow, int endRow) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			List<OrderDTO> orderList = new ArrayList<>();

			try {

				con = getConnection();

				String sql =  "select * from (select rownum row_num, temp.* from (select * from (select order_num, order_client_num, order_time, order_date, order_product_num"
						+ ", order_status, order_sum, order_dis_sum, order_content, order_receiver, order_zipcode, order_address1"
						+ ", order_address2, order_mobile, order_count, product_num, product_name, product_price"
						+ ", product_dis, product_main_img, order_email, row_number() over (partition by order_client_num, order_time"
						+ " order by order_time) as rn from order_table join product_table on product_num=order_product_num"
						+ " where order_client_num=? and to_char(order_date,'yyyy-mm-dd') between ? and ?)) temp where rn=1) where "
						+ " row_num between ? and ?";
				
				pstmt = con.prepareStatement(sql);

				pstmt.setInt(1, clientNum);
				pstmt.setString(2, startDate);
				pstmt.setString(3, endDate);
				pstmt.setInt(4, startRow);
				pstmt.setInt(5, endRow);

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
					order.setOrder_email(rs.getString("order_email"));
					orderList.add(order);
				}

			} catch (SQLException e) {
				System.out.println("[에러]myOrderList1() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return orderList;
		}
		public List<OrderDTO> myOrderList(int startRow, int endRow, int clientNum, String startDate, String endDate) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			List<OrderDTO> orderList = new ArrayList<>();
			
			try {
				
				con = getConnection();
				
				String sql = "select * from (select rownum rn, temp.* from (select order_num, order_client_num, order_time, order_date, order_product_num, order_status, order_sum, order_dis_sum, product_name, "
						+ "product_num, order_content, order_receiver, order_zipcode, order_address1, order_address2, order_mobile, order_count, order_email from order_table"
						+ " join product_table on order_product_num=product_num "
						+ " where order_client_num=? and to_char(order_date,'yyyy-mm-dd') between ? and ? order by order_date desc) temp) where rn between ? and ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, clientNum);
				pstmt.setString(2, startDate);
				pstmt.setString(3, endDate);
				pstmt.setInt(4, startRow);
				pstmt.setInt(5, endRow);
				
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
					order.setOrder_email(rs.getString("order_email"));
					orderList.add(order);
				}
				
			} catch (SQLException e) {
				System.out.println("[에러]myOrderList2() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return orderList;
		}
		
		public int updateReviewStatus(int orderNum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			int rows = 0;

			try {

				con = getConnection();

				String sql = "update order_table set order_review_status=2 where order_num=?";

				pstmt = con.prepareStatement(sql);

				pstmt.setInt(1, orderNum);
				
				rows=pstmt.executeUpdate();

			} catch (SQLException e) {
				System.out.println("[에러]updateReviewStatus() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
		}
		
		
		
		// 회원번호를 전달받아 주문리스트를 출력하는 메소드 중복은 제거
		public List<OrderDTO> selectMyOrderList(int clientNum, int startNum, int endNum, String startDate, String endDate) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<OrderDTO> orderList = new ArrayList<OrderDTO>();
			
			
			try {
				
				con = getConnection();
				
				String sql = "select * from (select rownum row_num, temp.* from (select * from (select order_num, order_client_num, order_time, order_date, order_product_num"
						+ ", order_status, order_sum, order_dis_sum, order_content, order_receiver, order_zipcode, order_address1"
						+ ", order_address2, order_mobile, order_count, product_num, product_name, product_price"
						+ ", product_dis, product_main_img, order_email, row_number() over (partition by order_client_num, order_time"
						+ " order by order_time) as rn from order_table join product_table on product_num=order_product_num"
						+ " where order_client_num=? and to_char(order_date,'yyyy-mm-dd') between ? and ?)) temp where rn=1) where row_num between ? and ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, clientNum);
				pstmt.setString(2, startDate);
				pstmt.setString(3, endDate);
				pstmt.setInt(4, startNum);
				pstmt.setInt(5, endNum);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					OrderDTO order=new OrderDTO();
					order.setOrderNum(rs.getInt("order_num"));
					order.setOrderClientNum(rs.getInt("order_client_num"));
					order.setOrderTime(rs.getString("order_time"));
					order.setOrderDate(rs.getString("order_date"));
					order.setOrderProductNum(rs.getInt("order_product_num"));
					order.setOrderStatus(rs.getInt("order_status"));
					order.setOrderSum(rs.getInt("order_sum"));
					order.setOrderDisSum(rs.getInt("order_dis_sum"));
					order.setOrderContent(rs.getString("order_content"));
					order.setOrderReceiver(rs.getString("order_receiver"));
					order.setOrderZipcode(rs.getString("order_zipcode"));
					order.setOrderAddress1(rs.getString("order_address1"));
					order.setOrderAddress2(rs.getString("order_address2"));
					order.setOrderMobile(rs.getString("order_mobile"));
					order.setOrderCount(rs.getInt("order_count"));
					order.setProductName(rs.getString("product_name"));
					order.setProductPrice(rs.getInt("product_price"));
					order.setProductDis(rs.getInt("product_dis"));
					order.setProductMainImg(rs.getString("product_main_img"));
					order.setProductNum(rs.getInt("order_product_num"));
					order.setOrder_email(rs.getString("order_email"));
					orderList.add(order);
				}
				
			} catch (SQLException e) {
				System.out.println("[에러]selectOrderList() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return orderList;
	}
		
		
		
		// 회원번호를 전달받아 주문리스트를 출력하는 메소드 중복은 제거
		public List<OrderDTO> selectMyOrderCnt(int clientNum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<OrderDTO> orderList = new ArrayList<OrderDTO>();
			
			
			try {
				
				con = getConnection();
				
				String sql = "select * from (select rownum row_num, temp.* from (select * from (select order_num, order_client_num, order_time, order_date, order_product_num"
						+ ", order_status, order_sum, order_dis_sum, order_content, order_receiver, order_zipcode, order_address1"
						+ ", order_address2, order_mobile, order_count, product_num, product_name, product_price"
						+ ", product_dis, product_main_img, order_email, row_number() over (partition by order_client_num, order_time"
						+ " order by order_time) as rn from order_table join product_table on product_num=order_product_num"
						+ " where order_client_num=?)) temp where rn=1)";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, clientNum);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					OrderDTO order=new OrderDTO();
					order.setOrderNum(rs.getInt("order_num"));
					order.setOrderClientNum(rs.getInt("order_client_num"));
					order.setOrderTime(rs.getString("order_time"));
					order.setOrderDate(rs.getString("order_date"));
					order.setOrderProductNum(rs.getInt("order_product_num"));
					order.setOrderStatus(rs.getInt("order_status"));
					order.setOrderSum(rs.getInt("order_sum"));
					order.setOrderDisSum(rs.getInt("order_dis_sum"));
					order.setOrderContent(rs.getString("order_content"));
					order.setOrderReceiver(rs.getString("order_receiver"));
					order.setOrderZipcode(rs.getString("order_zipcode"));
					order.setOrderAddress1(rs.getString("order_address1"));
					order.setOrderAddress2(rs.getString("order_address2"));
					order.setOrderMobile(rs.getString("order_mobile"));
					order.setOrderCount(rs.getInt("order_count"));
					order.setProductName(rs.getString("product_name"));
					order.setProductPrice(rs.getInt("product_price"));
					order.setProductDis(rs.getInt("product_dis"));
					order.setProductMainImg(rs.getString("product_main_img"));
					order.setProductNum(rs.getInt("order_product_num"));
					order.setOrder_email(rs.getString("order_email"));
					orderList.add(order);
				}
				
			} catch (SQLException e) {
				System.out.println("[에러]selectOrderList() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return orderList;
		}
		
		// 모든 주문리스트를 출력하는 메소드 중복은 제거 - 관리자용
		public List<OrderDTO> selectManagerOrderList(String search, String keyword, int startNum, int endNum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<OrderDTO> orderList = new ArrayList<OrderDTO>();
			
			try {
				
				con = getConnection();
				if(keyword.equals("")) {
					String sql = "select * from (select rownum row_num, temp.* from (select * from (select order_num, order_client_num, order_time, order_date, order_product_num"
							+ ", order_status, order_sum, order_dis_sum, order_content, order_receiver, order_zipcode, order_address1"
							+ ", order_address2, order_mobile, order_count, product_num, product_name, product_price"
							+ ", product_dis, product_main_img, order_email, row_number() over (partition by order_client_num, order_time"
							+ " order by order_time) as rn from order_table join product_table on product_num=order_product_num"
							+ " where order_status=0 order by order_date desc)) temp where rn=1) where row_num between ? and ?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setInt(1, startNum);
					pstmt.setInt(2, endNum);
					
				} else {
					String sql = "select * from (select rownum row_num, temp.* from (select * from (select order_num, order_client_num, order_time, order_date, order_product_num"
							+ ", order_status, order_sum, order_dis_sum, order_content, order_receiver, order_zipcode, order_address1"
							+ ", order_address2, order_mobile, order_count, product_num, product_name, product_price"
							+ ", product_dis, product_main_img, order_email, row_number() over (partition by order_client_num, order_time"
							+ " order by order_time) as rn from order_table join product_table on product_num=order_product_num"
							+ " where order_status=0 and "+search+" like '%'||?||'%' order by order_date desc)) temp where rn=1) where row_num between ? and ?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, keyword);
					pstmt.setInt(2, startNum);
					pstmt.setInt(3, endNum);
					
				}
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					OrderDTO order=new OrderDTO();
					order.setOrderNum(rs.getInt("order_num"));
					order.setOrderClientNum(rs.getInt("order_client_num"));
					order.setOrderTime(rs.getString("order_time"));
					order.setOrderDate(rs.getString("order_date"));
					order.setOrderProductNum(rs.getInt("order_product_num"));
					order.setOrderStatus(rs.getInt("order_status"));
					order.setOrderSum(rs.getInt("order_sum"));
					order.setOrderDisSum(rs.getInt("order_dis_sum"));
					order.setOrderContent(rs.getString("order_content"));
					order.setOrderReceiver(rs.getString("order_receiver"));
					order.setOrderZipcode(rs.getString("order_zipcode"));
					order.setOrderAddress1(rs.getString("order_address1"));
					order.setOrderAddress2(rs.getString("order_address2"));
					order.setOrderMobile(rs.getString("order_mobile"));
					order.setOrderCount(rs.getInt("order_count"));
					order.setProductName(rs.getString("product_name"));
					order.setProductPrice(rs.getInt("product_price"));
					order.setProductDis(rs.getInt("product_dis"));
					order.setProductMainImg(rs.getString("product_main_img"));
					order.setProductNum(rs.getInt("order_product_num"));
					order.setOrder_email(rs.getString("order_email"));
					orderList.add(order);
				}
				
			} catch (SQLException e) {
				System.out.println("[에러]selectManagerOrderList() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return orderList;
		}
		// 모든 주문리스트를 개수를 출력하는 메소드 중복은 제거 - 관리자용
		public int selectManagerOrderCnt(String search, String keyword) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int totalCount = 0;
			
			try {
				
				con = getConnection();
				if(keyword.equals("")) {
					String sql = "select count(*) from (select * from (select order_time, order_status, order_num"
							+ ", row_number() over (partition by order_time, order_status"
							+ " order by order_time) as rn from order_table"
							+ " where order_status=0) temp where rn=1)";
					
					pstmt = con.prepareStatement(sql);
					
				} else {
					String sql = "select count(*) from (select * from (select order_time, order_status, order_num"
							+ ", row_number() over (partition by order_time, order_status"
							+ " order by order_time) as rn from order_table"
							+ " where order_status=0 and "+search+" like '%'||?||'%') temp where rn=1)";
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, keyword);
					
				}
				
				rs= pstmt.executeQuery();
				if(rs.next()) {
					totalCount = rs.getInt(1);
				}
				
			} catch (SQLException e) {
				System.out.println("[에러]selectManagerOrderCnt() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return totalCount;
		}
		// 모든 주문상태를 변경하여 주문완료하는 메소드 - 관리자용
		public int updateOrderStatus(int clientNum, String timeStamp) {
			Connection con = null;
			PreparedStatement pstmt = null;
			int rows = 0;
			
			try {
				
				con = getConnection();
				String sql = "update order_table set order_status=1 where order_client_num=? and order_time=?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, clientNum);
				pstmt.setString(2, timeStamp);
					
				rows=pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러]updateOrderStatus() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
		}
		
		
		
}
