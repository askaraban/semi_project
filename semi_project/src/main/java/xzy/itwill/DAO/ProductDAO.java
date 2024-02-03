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
	

	// 업로드된 제품을 모두 검색해 가져옴
	public List<ProductDTO> selectProductList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		
		try {
			con = getConnection();
			
			String sql = "select product_num, product_name, product_price, product_com, product_cate, product_reg, "
					+ "product_dis, product_dis_content, product_main_img, product_img1, product_img2, product_img3 from product_table";
			
			pstmt=con.prepareStatement(sql);
			

			rs=pstmt.executeQuery();
	
			while(rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setProductNum(rs.getInt("product_num"));
				product.setProductName(rs.getString("product_name"));
				product.setProductPrice(rs.getInt("product_price"));
				product.setProductCom(rs.getString("product_com"));
				product.setProductCate(rs.getInt("product_cate"));
				product.setProductReg(rs.getString("product_reg"));
				product.setProductDis(rs.getInt("product_dis"));
				product.setProductDisContent(rs.getString("product_dis_content"));
				product.setProductMainImg(rs.getString("product_main_img"));
				product.setProductImg1(rs.getString("product_img1"));
				product.setProductImg2(rs.getString("product_img2"));
				product.setProductImg3(rs.getString("product_img3"));
				 
				productList.add(product);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]selectProductList() 메소드 오류" + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		} return productList;
	}
	
	
	// 제품을 등록하는 메소드
	public int insertProduct(ProductDTO product) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con=getConnection();
			String sql = "insert into product_table values (product_seq.nextval,?,?,?,?,sysdate,null,null,?,?,?,?)";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, product.getProductName());
			pstmt.setInt(2, product.getProductPrice());
			pstmt.setString(3, product.getProductCom());
			pstmt.setInt(4, product.getProductCate());
			pstmt.setString(5, product.getProductMainImg());
			pstmt.setString(6, product.getProductImg1());
			pstmt.setString(7, product.getProductImg2());
			pstmt.setString(8, product.getProductImg3());
			
			rows=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러]insertProduct() 메소드 오류" + e.getMessage());
		} finally {
			close(con, pstmt);
		} return rows;
	}
	
	// 제품번호를 전달받아 Product 테이블의 단일행을 검색하여 상품(ProductDTO 객체)을 반환하는 메소드
	public ProductDTO selectProductByNum(int productNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ProductDTO product=null;
		try {
			con=getConnection();
			
			String sql="select product_num,product_name,product_price,product_com,product_cate"
					+ ",product_reg,product_dis,product_dis_content,product_main_img"
					+ ",product_img1,product_img2,product_img3 from product_table where product_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, productNum);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				product=new ProductDTO();
				product.setProductNum(rs.getInt("product_num"));
				product.setProductName(rs.getString("product_name"));
				product.setProductPrice(rs.getInt("product_price"));
				product.setProductCom(rs.getString("product_com"));
				product.setProductCate(rs.getInt("product_cate"));
				product.setProductReg(rs.getString("product_reg"));
				product.setProductDis(rs.getInt("product_dis"));
				product.setProductDisContent(rs.getString("product_dis_content"));
				product.setProductMainImg(rs.getString("product_main_img"));
				product.setProductImg1(rs.getString("product_img1"));
				product.setProductImg2(rs.getString("product_img2"));
				product.setProductImg3(rs.getString("product_img3"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductByNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return product;
	}
	
	// 검색대상과 검색단어를 매개변수로 전달받아 검색대상과 검색단어에 해당되는 제품의 수를 반환하는 메소드
		public int searchProductList(String keyword, String search){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int totalCount = 0;
			
			try {
				con = getConnection();
				
				if(keyword.equals("")) {
					String sql = "select count(*) from product_table";
					pstmt=con.prepareStatement(sql);
					
				} else if(search.equals("제품번호")){
					String sql = "select count(*) from product_table where where number("+keyword+")=product_num";
					pstmt=con.prepareStatement(sql);
				} else {
					String sql = "select count(*) from product_table where where"+search+" like '%'||?||'%'";
					pstmt=con.prepareStatement(sql);
					
					pstmt.setString(1, keyword);
				}
				rs= pstmt.executeQuery();
				if(rs.next()) {
					totalCount = rs.getInt(1);
				}
				
			} catch (SQLException e) {
				System.out.println("[에러]searchProductList() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			} return totalCount;
		}
}
