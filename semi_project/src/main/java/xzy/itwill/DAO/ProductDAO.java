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
	
	private ProductDAO() {
		// TODO Auto-generated constructor stub
	}
	
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
			String sql = "insert into product_table values (product_seq.nextval,?,?,?,?,sysdate,null,null,?,?,?,?,1)";
			
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
	
	// 제품을 등록하는 메소드
		public int updateProduct(ProductDTO product) {
			Connection con = null;
			PreparedStatement pstmt = null;
			int rows = 0;
			
			try {
					con=getConnection();
				if(product.getProductMainImg()!=null && product.getProductImg1()!=null) {
					
					String sql = "update product_table set product_name=?,product_price=?,product_com=?,product_cate=?,product_dis=?"
							+ ", product_dis_content=?, product_main_img=?, product_img1=? where product_num=?";
					
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, product.getProductName());
					pstmt.setInt(2, product.getProductPrice());
					pstmt.setString(3, product.getProductCom());
					pstmt.setInt(4, product.getProductCate());
					pstmt.setInt(5, product.getProductDis());
					pstmt.setString(6, product.getProductDisContent());
					pstmt.setString(7, product.getProductMainImg());
					pstmt.setString(8, product.getProductImg1());
					pstmt.setInt(9, product.getProductNum());
					
				} else if(product.getProductMainImg()!=null) {
					
					String sql = "update product_table set product_name=?,product_price=?,product_com=?,product_cate=?,product_dis=?"
							+ ", product_dis_content=?, product_main_img=? where product_num=?";
					
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, product.getProductName());
					pstmt.setInt(2, product.getProductPrice());
					pstmt.setString(3, product.getProductCom());
					pstmt.setInt(4, product.getProductCate());
					pstmt.setInt(5, product.getProductDis());
					pstmt.setString(6, product.getProductDisContent());
					pstmt.setString(7, product.getProductMainImg());
					pstmt.setInt(8, product.getProductNum());
				} else if(product.getProductImg1()!=null) {
					
					String sql = "update product_table set product_name=?,product_price=?,product_com=?,product_cate=?,product_dis=?"
							+ ", product_dis_content=?, product_img1=? where product_num=?";
					
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, product.getProductName());
					pstmt.setInt(2, product.getProductPrice());
					pstmt.setString(3, product.getProductCom());
					pstmt.setInt(4, product.getProductCate());
					pstmt.setInt(5, product.getProductDis());
					pstmt.setString(6, product.getProductDisContent());
					pstmt.setString(7, product.getProductImg1());
					pstmt.setInt(8, product.getProductNum());
					
				} else if(product.getProductMainImg()==null && product.getProductImg1()==null){
					
					String sql = "update product_table set product_name=?,product_price=?,product_com=?,product_cate=?,product_dis=?"
							+ ", product_dis_content=?, product_img2=?, product_img3=? where product_num=?";
					
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, product.getProductName());
					pstmt.setInt(2, product.getProductPrice());
					pstmt.setString(3, product.getProductCom());
					pstmt.setInt(4, product.getProductCate());
					pstmt.setInt(5, product.getProductDis());
					pstmt.setString(6, product.getProductDisContent());
					pstmt.setString(7, product.getProductMainImg());
					pstmt.setString(8, product.getProductImg1());
					pstmt.setInt(9, product.getProductNum());
				}
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
		public int searchTotalList(String keyword, String search){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int totalCount = 0;
			
			try {
				con = getConnection();
				
				if(keyword.equals("")) {
					String sql = "select count(*) from product_table";
					pstmt=con.prepareStatement(sql);

				} else {
					String sql = "select count(*) from product_table where "+search+" like '%'||?||'%'";
					pstmt=con.prepareStatement(sql);
					
					pstmt.setString(1, keyword);
				}
				rs= pstmt.executeQuery();
				if(rs.next()) {
					totalCount = rs.getInt(1);
				}
				
			} catch (SQLException e) {
				System.out.println("[에러]searchTotalList() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			} return totalCount;
		}
		// 관리자 제품목록에 대해 페이지 수를 만들기 위한 메소드
		public List<ProductDTO> searchProductList(String search, String keyword, int startNum, int endNum) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<ProductDTO> productList = new ArrayList<>();
			try {
				con=getConnection();
				
				if(keyword.equals("")) {
					String sql="select * from (select rownum rn, temp.* from (select product_num, product_name,product_com, product_cate"
							+ ", product_price, product_dis, product_dis_content, product_main_img, product_img1, product_img2, product_img3, product_status"
							+ " from product_table order by product_num desc) temp) where rn between ? and ?";
					
					pstmt=con.prepareStatement(sql);
					
					pstmt.setInt(1, startNum);
					pstmt.setInt(2, endNum);
					
				} else {
					String sql="select * from (select rownum rn, temp.* from (select product_num, product_name,product_com, product_cate"
							+ ", product_price, product_dis, product_dis_content, product_main_img, product_img1, product_img2, product_img3, product_status"
							+ " from product_table where "+search+" like '%'||?||'%' order by product_num desc) temp) where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
					
					pstmt.setString(1,keyword);
					pstmt.setInt(2, startNum);
					pstmt.setInt(3, endNum);
				}
				
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					ProductDTO product=new ProductDTO();
					product.setProductNum(rs.getInt("product_num"));
					product.setProductName(rs.getString("product_name"));
					product.setProductPrice(rs.getInt("product_price"));
					product.setProductCom(rs.getString("product_com"));
					product.setProductCate(rs.getInt("product_cate"));
					product.setProductDis(rs.getInt("product_dis"));
					product.setProductDisContent(rs.getString("product_dis_content"));
					product.setProductMainImg(rs.getString("product_main_img"));
					product.setProductImg1(rs.getString("product_img1"));
					product.setProductImg2(rs.getString("product_img2"));
					product.setProductImg3(rs.getString("product_img3"));
					product.setProductStatus(rs.getInt("product_status"));
					productList.add(product);
				}
			} catch (SQLException e) {
				System.out.println("[에러]searchProductList-1() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return productList;
		}
		
		// 오버로딩 - 모든 제품의 수를 반환하는 메소드
				public int searchTotalList(int category){
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					int totalCount = 0;
					
					try {
						con = getConnection();
						
						String sql = "select count(*) from product_table where product_cate=? and product_status=1";
						pstmt=con.prepareStatement(sql);
						
						pstmt.setInt(1, category);

						rs= pstmt.executeQuery();
						if(rs.next()) {
							totalCount = rs.getInt(1);
						}
						
					} catch (SQLException e) {
						System.out.println("[에러]searchTotalList() 메소드 오류" + e.getMessage());
					} finally {
						close(con, pstmt, rs);
					} return totalCount;
				}
		
		// 오버로딩 - 카테고리별 제품목록, 또는 검색된 제품목록에 대한 페이지를 만들기 위한 메소드
		public List<ProductDTO> searchProductList(int category, int startNum, int endNum) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<ProductDTO> productList = new ArrayList<>();
			try {
				con=getConnection();
			
				String sql="select * from (select rownum rn, temp.* from (select product_num, product_name,product_com, product_cate"
						+ ", product_price, product_dis, product_dis_content, product_main_img, product_img1, product_img2, product_img3"
						+ " from product_table where product_cate=? and product_status=1 order by product_num desc) temp) where rn between ? and ?";
				
				pstmt=con.prepareStatement(sql);
				
				pstmt.setInt(1, category);
				pstmt.setInt(2, startNum);
				pstmt.setInt(3, endNum);
				
				
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					ProductDTO product=new ProductDTO();
					product.setProductNum(rs.getInt("product_num"));
					product.setProductName(rs.getString("product_name"));
					product.setProductPrice(rs.getInt("product_price"));
					product.setProductCom(rs.getString("product_com"));
					product.setProductCate(rs.getInt("product_cate"));
					product.setProductDis(rs.getInt("product_dis"));
					product.setProductDisContent(rs.getString("product_dis_content"));
					product.setProductMainImg(rs.getString("product_main_img"));
					product.setProductImg1(rs.getString("product_img1"));
					product.setProductImg2(rs.getString("product_img2"));
					product.setProductImg3(rs.getString("product_img3"));
					productList.add(product);
				}
			} catch (SQLException e) {
				System.out.println("[에러]searchProductList-2() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return productList;
		}
		
		// 유형값을 전달받아 유형에 해당하는 제품목록을 나열하는 메소드
		public List<ProductDTO> searchCateProductList(int category) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<ProductDTO> productList = new ArrayList<>();
			try {
				con=getConnection();
				
				String sql="select product_num, product_name, product_price, product_com, product_cate, product_reg"
						+ ", product_dis, product_dis_content, product_main_img, product_img1, product_img2, product_img3"
						+ " from product_table where product_cate=?";
				
				pstmt=con.prepareStatement(sql);
				
				pstmt.setInt(1, category);
				
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
				System.out.println("[에러]searchCateProductList() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			} return productList;
		} 
		
		// 검색단어를 전달받아 해당 단어에 해당되는 제품목록을 출력해주는 메소드
		public List<ProductDTO> searchKeywordProductList(String keyword) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<ProductDTO> productList = new ArrayList<>();
			try {
				con=getConnection();
				
				String sql="select rownum, temp.* from (select product_num, product_name, product_price, product_com, product_cate, product_reg"
						+ ", product_dis, product_dis_content, product_main_img, product_img1, product_img2, product_img3"
						+ " from product_table where upper(product_name) like '%'||upper(?)||'%' order by product_name) "
						+ " temp where rownum <= 10";
				
				pstmt=con.prepareStatement(sql);
				
				pstmt.setString(1, keyword);
				
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
				System.out.println("[에러]searchKeywordProductList() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			} return productList;
		} 
		
				
		public int deleteProduct(int productNum) {
			Connection con=null;
			PreparedStatement pstmt=null;
			int rows = 0;
			
			try {
				con=getConnection();
				
				String sql="update product_table set product_status=0 where product_num=?";
				
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, productNum);
				
				rows = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				System.out.println("[에러]deleteProduct() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt);
			} return rows;
		}
		
		// 업로드된 제품을 모두 검색해 가져옴
		public List<ProductDTO> selectBestProudct(){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<ProductDTO> productList = new ArrayList<ProductDTO>();
			
			try {
				con = getConnection();
				
				String sql = "select rownum rn, temp.* from (select product_num, product_name, product_price, product_com, product_cate, product_reg, "
						+ "product_dis, product_dis_content, product_main_img, product_img1"
						+ ",order_product_num,product_status, count(*) as cnt from product_table join order_table on order_product_num=product_num"
						+ " group by product_num, product_name, product_price, product_com, product_cate, product_reg,product_dis, product_dis_content"
						+ ",product_main_img, product_img1, order_product_num,product_status having count(*) >1 order by cnt desc) temp";
				/*
				 * String sql =
				 * "select * from (select rownum rn, temp.* from (select product_num, product_name, product_price, product_com, product_cate, product_reg, "
				 * + "product_dis, product_dis_content, product_main_img, product_img1 " +
				 * ",order_product_num, count(*) as cnt from product_table join order_table on order_product_num=product_num"
				 * +
				 * " group by product_num, product_name, product_price, product_com, product_cate, product_reg,product_dis, product_dis_content"
				 * +
				 * ",product_main_img, product_img1, order_product_num having count(*) >1 order by cnt desc) temp)"
				 * + " where product_status =1 and (rn between 1 and 8)";
				 */				
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
					product.setOrderProductNum(rs.getInt("order_product_num"));
					product.setProductStatus(rs.getInt("product_status"));
					 
					productList.add(product);
				}
				
			} catch (SQLException e) {
				System.out.println("[에러]selectBestProudct() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			} return productList;
		}
		
		public List<ProductDTO> selectRandomProduct(){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<ProductDTO> productList = new ArrayList<ProductDTO>();
			
			try {
				con = getConnection();
				
				String sql = "select * from(select product_num, product_name, product_price, product_com, product_cate, product_reg"
						+ ", product_dis, product_dis_content, product_main_img, product_img1, product_img2, product_img3"
						+ " from product_table where product_status=1 order by DBMS_RANDOM.RANDOM) where rownum < 9";
				
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
				System.out.println("[에러]selectRandomProduct() 메소드 오류" + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			} return productList;
		}
		
}
