package xzy.itwill.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import xyz.itwill.DTO.CategoryDTO;

public class CategoryDAO extends JdbcDAO{
	private static CategoryDAO _dao;
	
	static {
		_dao = new CategoryDAO();
	}
	
	public static CategoryDAO getDAO() {
		return _dao;
	}
	
	public int insertCategory(CategoryDTO category) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con=getConnection();
			String sql = "insert into category_table values (category_seq.nextval,?)";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, category.getCategoryName());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertCategory() 메소드 오류" + e.getMessage());
		} finally {
			close(con, pstmt);
		} return rows;
	}
}
