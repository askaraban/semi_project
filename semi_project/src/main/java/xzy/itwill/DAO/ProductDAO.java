package xzy.itwill.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.DTO.ProductDTO;

public class ProductDAO extends JdbcDAO{
	private static ProductDAO _dao;
	
	static {
		_dao = new ProductDAO();
	}
	
	public static ProductDAO getDAO() {
		return _dao;
	}
	
	public int uploadFile(ProductDTO product) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con=getConnection();
			String sql = "insert into productList values (product_num.nextval,?)";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, product.getImagePath());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]uploadFile() 메소드 오류" + e.getMessage());
		} finally {
			close(con, pstmt);
		} return rows;
	}
	
	public List<ProductDTO> fileList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		
		try {
			con = getConnection();
			
			String sql = "select pronumber, imagepath from productList";
			
			pstmt=con.prepareStatement(sql);
			

			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setPronumber(rs.getInt("pronumber"));
				product.setImagePath(rs.getString("imagepath"));
				productList.add(product);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]fileList() 메소드 오류" + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		} return productList;
	}
}
