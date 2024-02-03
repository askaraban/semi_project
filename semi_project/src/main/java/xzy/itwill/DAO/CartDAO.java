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
   
   // 회원번호를 검색해 회원번호에 해당하는 cart_table에 있는 모든 cart를 가져옴
   // 가져온 cart _table에서 product_table과 조인하여 product_table의 제품정보를 가져옴
   public List<CartDTO> selectCartList(ClientDTO client){
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      
      List<CartDTO> cartList = new ArrayList<>();
      
      try {
         
         con=getConnection();
         
         String sql = "select cart_num, cart_client_num, cart_product_num, cart_count, product_name, product_price, product_com, "
               + "product_dis, product_main_img from cart_table join product_table on cart_product_num = product_num where cart_client_num = ?"
               + " order by cart_num desc";
         
         pstmt=con.prepareStatement(sql);
         
         pstmt.setInt(1, client.getClientNum());
         
         rs = pstmt.executeQuery();
         
         while(rs.next()) {
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
      } return cartList;
   }
   
   // cart_table에 해당되는 회원번호와 제품번호를 검색해 수량을 변경하는 메소드
   public int updateCart(CartDTO cart) {
      Connection con = null;
      PreparedStatement pstmt = null;
      int rows = 0;
      
      try {
         con=getConnection();
         String sql = "update cart_table set cart_count=? where cart_client_num=? and cart_product_num=?";
         
         pstmt=con.prepareStatement(sql);
         
         pstmt.setInt(1, cart.getCartCount());
         pstmt.setInt(2, cart.getCartClientNum());
         pstmt.setInt(3, cart.getCartProductNum());
         
         rows=pstmt.executeUpdate();
         
      } catch (SQLException e) {
         System.out.println("[에러]updateCart() 메소드 오류" + e.getMessage());
      } finally {
         close(con, pstmt);
      } return rows;
   }
}