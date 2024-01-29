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
	
	// 첨부파일에 업로드한 이미지 파일의 경로를 삽입하는 메소드
	public int uploadFile(ProductDTO product) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con=getConnection();
			String sql = "insert into productList values (product_num.nextval,?)";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, product.getProductImgPath());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]uploadFile() 메소드 오류" + e.getMessage());
		} finally {
			close(con, pstmt);
		} return rows;
	}
	
	// 업로드된 파일을 모두 검색해 가져옴
	public List<ProductDTO> fileList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		
		try {
			con = getConnection();
			
			String sql = "select productId, productImgPath from productList";
			
			pstmt=con.prepareStatement(sql);
			

			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setProductId(rs.getInt("productId"));
				product.setProductImgPath(rs.getString("productImgPath"));
				productList.add(product);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]fileList() 메소드 오류" + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		} return productList;
	}
	
	/*
	PRODUCTID      NOT NULL NUMBER(10)     
	PRODUCTNAME             VARCHAR2(200)  
	PRODUCTPRICE            NUMBER(10)     
	PRODUCTCOM              VARCHAR2(30)   
	PRODUCTCATE             NUMBER(2)      
	PRODUCTREG              DATE           
	PRODUCTSALE             NUMBER(10)     
	PRODUCTDIS              NUMBER(3)      
	PRODUCTIMGPATH          VARCHAR2(50)   
	PRODUCTIMG1             VARCHAR2(50)   
	PRODUCTIMG2             VARCHAR2(50)   
	PRODUCTIMG3             VARCHAR2(50) 
	 */
	
	public int insertProduct(ProductDTO product) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con=getConnection();
			String sql = "insert into product_table values (productId.nextval,?,?,?,?,sysdate,?,?,?,?,?,?)";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, product.getProductName());
			pstmt.setInt(2, product.getProductPrice());
			pstmt.setString(3, product.getProductCom());
			pstmt.setInt(4, product.getProductCate());
			pstmt.setInt(5, product.getProductSale());
			pstmt.setInt(6, product.getProductDis());
			pstmt.setString(7, product.getProductImgPath());
			pstmt.setString(8, product.getProductImg1());
			pstmt.setString(9, product.getProductImg2());
			pstmt.setString(10, product.getProductImg3());
			
			rows=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러]insertProduct() 메소드 오류" + e.getMessage());
		} finally {
			close(con, pstmt);
		} return rows;
	}
}
