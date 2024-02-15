package xzy.itwill.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.DTO.ReviewDTO;

public class ReviewDAO extends JdbcDAO {
	private static ReviewDAO _dao;
   
	public ReviewDAO() {
		// TODO Auto-generated constructor stub
	}
   
	static {
		_dao=new ReviewDAO();
	}
   
	public static ReviewDAO getDAO() {
		return _dao;
	}
   
	//검색정보(검색대상과 검색단어)를 전달받아 REVIEW_TABLE에 저장된 게시글 중 검색대상의 
	//컬럼에 검색단어가 포함된 게시글의 갯수를 검색하여 반환하는 메소드
	// => 검색 기능을 사용하지 않을 경우 REVIEW_TABLE에 저장된 모든 게시글의 갯수를 검색하여 반환
	public int selectTotalReview(String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int totalCount=0;
		try {
			con=getConnection();
         
			if(keyword=="") {
				String sql="select count(*) from review_table";
				pstmt=con.prepareStatement(sql);
            
			} else {
				String sql="select count(*) from review_table where "+search+" like '%'||?||'%'";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
         
			rs=pstmt.executeQuery();
         
			if(rs.next()) {
				totalCount=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectTotalReview() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return totalCount;
	}
   
	// 페이징 처리 관련 정보(시작 행번호와 종료 행번호)와 게시글 검색 기능 관련 정보(검색대상과
	// 검색단어)를 전달받아 REVIEW_TANLE에 저장된 행을 검색하여 게시글 목록을 반환하는 메소드
	public List<ReviewDTO> selectReviewList(int startRow, int endRow, String search, String keyword) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReviewDTO> reviewList = new ArrayList<ReviewDTO>();
		try {
			con = getConnection();

			if(keyword.equals("")) {//검색 기능을 사용하지 않은 경우
				String sql="select * from (select rownum rn, temp.* from (select review_num"
						+ ", review_member_num, client_name, review_subject, review_content, review_image"
						+ ", review_register, review_update, review_readcount, review_replay, review_product_num"
						+ " from review_table join client_table on review_member_num=client_num"
						+ " order by review_num desc) temp) where rn between ? and ?;";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {//검색 기능을 사용한 경우
				String sql="select * from (select rownum rn, temp.* from (select review_num"
						+ ", review_member_num, client_name, review_subject, review_content, review_image"
						+ ", review_register, review_update, review_readcount, review_replay, review_product_num"
						+ ", from review_table join client_table on review_member_num=client_num"
						+ " where "+search+" like '%'||?||'%' order by review_num desc) temp)"
						+ " where rn between ? and ?";
				pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, keyword);
	            pstmt.setInt(2, startRow);
	            pstmt.setInt(3, endRow);
			}
	     
			//여기 밑으로 확인하기
	     
			rs = pstmt.executeQuery();

			while (rs.next()) {
	            ReviewDTO review = new ReviewDTO();
	            review.setReviewNum(rs.getInt("review_num"));
	            review.setReviewMemberNum(rs.getInt("review_member_num"));
	            review.setReviewName(rs.getString("name"));
	            review.setReviewSubject(rs.getString("review_subject"));
	            review.setReviewContent(rs.getString("review_content"));
	            review.setReviewImage(rs.getString("review_image"));
	            review.setReviewRegister(rs.getString("review_register"));
	            review.setReviewUpdate(rs.getString("review_update"));
	            review.setReviewReadcount(rs.getInt("review_readcount"));
	            review.setReviewReplay(rs.getString("review_replay"));

	            reviewList.add(review);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectReviewList() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return reviewList;
	}
   
	// REVIEW_SEQ 시퀸스의 다음값(정수값)을 검색하여 반환하는 메소드
	public int selectReivewTanleNextNum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int nextNum = 0;
		try {
			con = getConnection();
		
			String sql = "select review_table_seq.nextval from dual";
			pstmt = con.prepareStatement(sql);
		
			rs = pstmt.executeQuery();
		
			if (rs.next()) {
				nextNum = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectReivewNextNum() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}
   
	//게시글을 전달받아 REVIEW_TABLE에 행으로 삽입하고 삽입행의 갯수를 반환하는 메소드
	public int insertReview(ReviewDTO review, int orderNum) {
		Connection con=null;
		PreparedStatement pstmt=null;	
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into review_table values(review_table_seq.nextval,?,?,?,?,sysdate,null,0,null,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, review.getReviewMemberNum());
			pstmt.setString(2, review.getReviewSubject());
			pstmt.setString(3, review.getReviewContent());
			pstmt.setString(4, review.getReviewImage());
			pstmt.setInt(5, review.getReviewProductNum());
			pstmt.setInt(6, orderNum);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
		System.out.println("[에러]insertReview() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
		close(con, pstmt);
		}
		return rows;
	}

//	// 제품번호를 전달받아 REVIEW_TABLE에 저장된 행을 검색하여 제품별 리뷰 목록을 반환하는 메소드
//	public List<ReviewDTO> selectReviewByProductNum(int reviewProductNum) {
//		Connection con=null;
//		PreparedStatement pstmt=null;
//		ResultSet rs=null;
//		List<ReviewDTO> reviewList = new ArrayList<ReviewDTO>();
//		try {
//			con=getConnection();
//			
//			String sql="select review_num,review_member_num,client_name,review_subject,review_content,review_image"
//					+ " ,review_register,review_update,review_readcount,review_replay,review_product_num"
//					+ " from review_table join client_table on review_member_num=client_num where review_product_num=? order by review_num desc";
//
//			pstmt=con.prepareStatement(sql);
//
//						pstmt.setInt(1, reviewProductNum);
//			rs=pstmt.executeQuery();
//			
//			while (rs.next()) {
//	            ReviewDTO review = new ReviewDTO();
//	            review.setReviewNum(rs.getInt("review_num"));
//	            review.setReviewMemberNum(rs.getInt("review_member_num"));
//	            review.setReviewName(rs.getString("client_name"));
//	            review.setReviewSubject(rs.getString("review_subject"));
//	            review.setReviewContent(rs.getString("review_content"));
//	            review.setReviewImage(rs.getString("review_image"));
//	            review.setReviewRegister(rs.getString("review_register"));
//	            review.setReviewUpdate(rs.getString("review_update"));
//	            review.setReviewReadcount(rs.getInt("review_readcount"));
//	            review.setReviewReplay(rs.getInt("review_replay"));
//	            review.setReviewProductNum(rs.getInt("review_product_num"));
//
//	            reviewList.add(review);
//			}
//		} catch (SQLException e) {
//			System.out.println("[에러]selectReviewByProductNum() 메소드의 SQL 오류 = "+e.getMessage());
//		} finally {
//			close(con, pstmt, rs);
//		}
//		return reviewList;
//	}	
	
	// 페이징 처리 관련 정보(시작 행번호와 종료 행번호)와 제품번호를 전달받아
	// REVIEW_TABLE에 저장된 행을 select 하여 게시글 목록을 반환하는 메소드
	public List<ReviewDTO> selectReviewListByReviewProductNum(int startRow, int endRow, int reviewProductNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReviewDTO> reviewList = new ArrayList<ReviewDTO>();
		try {
			con = getConnection();

			String sql="select * from (select rownum rn, temp.* from (select review_num"
					+ ", review_member_num, client_name, review_subject, review_content, review_image"
					+ ", review_register, review_update, review_readcount, review_replay, review_product_num"
					+ " from review_table join client_table on review_member_num=client_num where review_product_num=?"
					+ " order by review_num desc) temp) where rn between ? and ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, reviewProductNum);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
	     
			//여기 밑으로 확인하기
	     
			rs = pstmt.executeQuery();

			while (rs.next()) {
	            ReviewDTO review = new ReviewDTO();
	            review.setReviewNum(rs.getInt("review_num"));
	            review.setReviewMemberNum(rs.getInt("review_member_num"));
	            review.setReviewName(rs.getString("client_name"));
	            review.setReviewSubject(rs.getString("review_subject"));
	            review.setReviewContent(rs.getString("review_content"));
	            review.setReviewImage(rs.getString("review_image"));
	            review.setReviewRegister(rs.getString("review_register"));
	            review.setReviewUpdate(rs.getString("review_update"));
	            review.setReviewReadcount(rs.getInt("review_readcount"));
	            review.setReviewReplay(rs.getString("review_replay"));
	            review.setReviewProductNum(rs.getInt("review_product_num"));

	            reviewList.add(review);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectReviewListByReviewProductNum() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return reviewList;
	}
	
	// REVIEW_TABLE에 저장된 제품별 리뷰의 count(갯수)를 반환하는 메소드
	public int selectReviewCountByProductNum(int reviewProductNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int reviewCount=0;
		try {
			con=getConnection();
			
			String sql="select count(*) from review_table where review_product_num=?";

			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, reviewProductNum);
			
			rs=pstmt.executeQuery();
         
			if(rs.next()) {
				reviewCount=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectReviewCountByProductNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return reviewCount;
	}
	
//	//글번호를 전달받아 REVIEWTABLE의 단일행을 검색하여 게시글(ReviewDTO 객체)을 반환하는 메소드
//	public ReviewDTO selectRebiewTabledByNum(int reviewNum) {
//		Connection con=null;
//		PreparedStatement pstmt=null;
//		ResultSet rs=null;
//		ReviewDTO review=null;
//		try {
//			con=getConnection();
//			
//			String sql="select review_num,review_member_num,name review_name,review_subject,review_content,review_image"
//				+ ",review_register,review_update,review_readcount,review_replay from review_table join"
//				+ " client_table on review_table.review_member_num=client_table.client_num"
//				+ " where review_num=?";
//			pstmt=con.prepareStatement(sql);
//			pstmt.setInt(1, reviewNum);
//			
//			rs=pstmt.executeQuery();
//			
//			if(rs.next()) {
//				review=new ReviewDTO();
//				review.setReviewNum(rs.getInt("review_num"));
//				review.setReviewMemberNum(rs.getInt("review_member_num"));
//				review.setReviewName(rs.getString("review_name"));
//				review.setReviewSubject(rs.getString("review_subject"));
//				review.setReviewContent(rs.getString("review_content"));
//				review.setReviewImage(rs.getString("review_image"));
//				review.setReviewRegister(rs.getString("review_register"));
//				review.setReviewUpdate(rs.getString("review_update"));
//				review.setReviewReadcount(rs.getInt("review_readcount"));
//				review.setReviewReplay(rs.getString("review_replay"));
//			}
//		} catch (SQLException e) {
//			System.out.println("[에러]selectQaByNum() 메소드의 SQL 오류 = "+e.getMessage());
//		} finally {
//			close(con, pstmt, rs);
//		}
//		return review;
//		//return rows;
//		// # rows -> qa 로 변경 (row가 정의되어있지 않아 오류발생하길래 수정했습니당)
//	}   

	//글번호를 전달받아 REVIEWTABLE의 단일행을 검색하여 게시글(ReviewDTO 객체)을 반환하는 메소드
	public ReviewDTO selectReviewTableByNum(int reviewNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ReviewDTO review=null;
		try {
			con=getConnection();
			
			String sql="select review_num,review_member_num,client_name,review_subject,review_content,review_image"
					+ ",review_register,review_update,review_readcount,review_replay,review_product_num,review_order_num"
					+ " from review_table join client_table on review_table.review_member_num=client_table.client_num"
					+ " where review_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, reviewNum);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				review=new ReviewDTO();
	            review.setReviewNum(rs.getInt("review_num"));
	            review.setReviewMemberNum(rs.getInt("review_member_num"));
	            review.setReviewName(rs.getString("client_name"));
	            review.setReviewSubject(rs.getString("review_subject"));
	            review.setReviewContent(rs.getString("review_content"));
	            review.setReviewImage(rs.getString("review_image"));
	            review.setReviewRegister(rs.getString("review_register"));
	            review.setReviewUpdate(rs.getString("review_update"));
	            review.setReviewReadcount(rs.getInt("review_readcount"));
	            review.setReviewReplay(rs.getString("review_replay"));
	            review.setReviewProductNum(rs.getInt("review_product_num"));
	            review.setReviewOrderNum(rs.getInt("review_order_num"));
	            
			}
	   } catch (SQLException e) {
	      System.out.println("[에러]selectReviewTableByNum() 메소드의 SQL 오류 = "+e.getMessage());
	   } finally {
	      close(con, pstmt, rs);
	   }
	   return review;
	}
	//회원번호를 전달받아 회원번호와 상태코드에 해당하는 리뷰리스트를 가져오는 메소드
	public List<ReviewDTO> selectMyReviewList(int clientNum, int status) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ReviewDTO> reviewList = new ArrayList<>();
		try {
			con=getConnection();
			
			String sql="select review_num,review_member_num,review_subject,review_content,review_image"
					+ ",review_register,review_update,review_readcount,review_replay,review_product_num,review_order_num,order_review_status, order_num"
					+ " from review_table join order_table on order_num=review_order_num where review_member_num=? and order_review_status=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, clientNum);
			pstmt.setInt(2, status);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewDTO review=new ReviewDTO();
				review.setReviewNum(rs.getInt("review_num"));
				review.setReviewMemberNum(rs.getInt("review_member_num"));
				review.setReviewSubject(rs.getString("review_subject"));
				review.setReviewContent(rs.getString("review_content"));
				review.setReviewImage(rs.getString("review_image"));
				review.setReviewRegister(rs.getString("review_register"));
				review.setReviewUpdate(rs.getString("review_update"));
				review.setReviewReadcount(rs.getInt("review_readcount"));
				review.setReviewReplay(rs.getString("review_replay"));
				review.setReviewProductNum(rs.getInt("review_product_num"));
				review.setReviewOrderNum(rs.getInt("review_order_num"));
				review.setOrderReviewStatus(rs.getInt("order_review_status"));
				review.setOrderNum(rs.getInt("order_num"));
				reviewList.add(review);
				
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectMyReviewList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return reviewList;
	}
   
	//글번호를 전달받아 REVIEWTABLE 테이블의 저장된 행의 게시글 조회수가 1 증가되도록 변경하고 
	//변경행의 갯수를 반환하는 메소드
	public int updateReviewReadCount(int ReviewNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update review_table set review_readcount=review_readcount+1 where review_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, ReviewNum);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateQaReadCount() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	//게시글을 전달받아 REVEIEWTABLE의 저장된 행의 컬럼값을 변경하고 변경행의 갯수를 반환하는 메소드
	public int deleteReview(int reviewNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="delete from review_table where review_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, reviewNum);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteReview() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//게시글을 전달받아 REVIEW 테이블의 저장된 행의 컬럼값을 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateReview(ReviewDTO review) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			//사용자가 이미지 파일을 입력하지 않은 경우 - 이미지 파일 미변경(기존 이미지 파일 사용)
			if(review.getReviewImage()==null) {
				String sql="update review_table set review_subject=?,review_content=?,review_update=sysdate where review_num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, review.getReviewSubject());
				pstmt.setString(2, review.getReviewContent());
				pstmt.setInt(3, review.getReviewNum());
			} else {//사용자가 이미지 파일을 입력하지 않은 경우 - 이미지 파일 변경
				String sql="update review_table set review_subject=?,review_content=?,review_image=?"
						+ ",review_update=sysdate where review_num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, review.getReviewSubject());
				pstmt.setString(2, review.getReviewContent());
				pstmt.setString(3, review.getReviewImage());
				pstmt.setInt(4, review.getReviewNum());
			}			
				
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateReview() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;		
	}
	
	//게시글을 전달받아 REVIEW 테이블의 저장된 행의 컬럼값을 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateReviewReplay(ReviewDTO review) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update review_table set review_replay=? where review_num=?;";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, review.getReviewReplay());
			pstmt.setInt(2, review.getReviewNum());
				
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateReviewReplay() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;		
	}
}