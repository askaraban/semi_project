package xzy.itwill.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
	
	public List<CategoryDTO> selectCategoryList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CategoryDTO> categoryList = new ArrayList<>();
		
		try {
			con = getConnection();
			
			String sql = "select categoryId, categoryName from category_table";
			
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				CategoryDTO category = new CategoryDTO();
				category.setCategoryId(rs.getInt(1));
				category.setCategoryName(rs.getString(2));
				categoryList.add(category);
			}

		} catch (SQLException e) {
			System.out.println("[에러]selectCategoryList() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return categoryList;
		
	}
}
