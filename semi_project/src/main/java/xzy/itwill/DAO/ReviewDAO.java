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
			
/*			if(keyword=="") {
				String sql="select count(*) from review_table";
				pstmt=con.prepareStatement(sql);
				
			} else {
				String sql="select count(*) from review_table";
				pstmt=con.prepareStatement(sql);
			} else {
				String sql="select count(*) from review_table where "+search+" like '%'||?||'%'";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}*/
			
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

			if (keyword.equals("")) {// 검색 기능을 사용하지 않은 경우
				String sql = "select * from (select rownum rn, temp.* from (select review_num"
						+ ", review_member_num, name, review_subject, review_content, review_image"
						+ ", review_register, review_update, review_readcount, review_replay"
						+ ", from review_table join client_table"
						+ " on review_member_num=client_num order by review_register desc) temp)"
						+ " where rn between ? and ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {// 검색 기능을 사용한 경우
				String sql = "select * from (select rownum rn, temp.* from (select review_num"
						+ ", review_member_num, name, review_subject, review_content, review_image"
						+ ", review_register, review_update, review_readcount, review_replay"
						+ ", from review_table join client_table"
						+ " on review_member_num=client_num where " + search + " like '%'||?||'%'"
						+ " order by review_register desc) temp)"
						+ " where rn between ? and ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			
			//여기 밑으로 확인하기
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReviewDTO reviewTable = new ReviewDTO();
				reviewTable.setReviewNum(rs.getInt("review_num"));
				reviewTable.setReviewMemberNum(rs.getInt("review_member_num"));
				reviewTable.setReviewName(rs.getString("name"));
				reviewTable.setReviewSubject(rs.getString("review_subject"));
				reviewTable.setReviewContent(rs.getString("review_content"));
				reviewTable.setReviewImage(rs.getString("review_image"));
				reviewTable.setReviewRegister(rs.getString("review_register"));
				reviewTable.setReviewUpdate(rs.getString("review_update"));
				reviewTable.setReviewReadcount(rs.getInt("review_readcount"));
				reviewTable.setReviewReplay(rs.getInt("review_replay"));

				reviewList.add(reviewTable);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectReviewList() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return reviewList;
	}
	
	// REVIEW_SEQ 시퀸스의 다음값(정수값)을 검색하여 반환하는 메소드
	public int selectReivewNextNum() {
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
<<<<<<< HEAD
		public int insertReview(ReviewDTO reviewTable) {
			Connection con=null;
			PreparedStatement pstmt=null;
			int rows=0;
			try {
				con=getConnection();
				
				String sql="insert into review_table values(?,?,?,?,?,sysdate,null,0,?)";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, reviewTable.getReviewNum());
				pstmt.setInt(2, reviewTable.getReviewMemberNum());
				pstmt.setString(3, reviewTable.getReviewSubject());
				pstmt.setString(4, reviewTable.getReviewContent());
				pstmt.setString(5, reviewTable.getReviewImage());
				pstmt.setInt(6, reviewTable.getReviewReplay());
				
				rows=pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러]insertReview() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
=======
	public int insertReview(ReviewDTO review) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into review_table values(?,?,?,?,?,sysdate,null,0,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, review.getReviewNum());
			pstmt.setInt(2, review.getReviewMemberNum());
			pstmt.setString(3, review.getReviewSubject());
			pstmt.setString(4, review.getReviewContent());
			pstmt.setString(5, review.getReviewImage());
			pstmt.setInt(6, review.getReviewReplay());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertReview() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
>>>>>>> branch 'main' of https://github.com/askaraban/semi_project.git
		}
<<<<<<< HEAD
		
		
		
		
		
		
		
		//글번호를 전달받아 REVIEWTABLE의 단일행을 검색하여 게시글(ReviewDTO 객체)을 반환하는 메소드
		public ReviewDTO selectRebiewdByNum(int reviewNum) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			ReviewDTO qa=null;
			try {
				con=getConnection();
				
				String sql="select review_num,review_member_num,name review_name,review_subject,review_content,review_image"
						+ ",review_register,review_update,review_readcount,review_replay from review_table join"
						+ " client_table on review_table.review_member_num=client_table.client_num"
						+ " where review_num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, reviewNum);
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					qa=new ReviewDTO();
					qa.setReviewNum(rs.getInt("review_num"));
					qa.setReviewMemberNum(rs.getInt("review_member"));
					qa.setReviewName(rs.getString("review_name"));
					qa.setReviewSubject(rs.getString("review_subject"));
					qa.setReviewContent(rs.getString("review_content"));
					qa.setReviewImage(rs.getString("review_image"));
					qa.setReviewRegister(rs.getString("review_register"));
					qa.setReviewUpdate(rs.getString("review_update"));
					qa.setReviewReadcount(rs.getInt("review_readcount"));
					qa.setReviewReplay(rs.getInt("review_replay"));
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectQaByNum() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
=======
		return rows;
	}
	

	//글번호를 전달받아 QA 테이블의 단일행을 검색하여 게시글(ReviewDTO 객체)을 반환하는 메소드
	public QaDTO selectQaByNum(int qaNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		QaDTO qa=null;
		try {
			con=getConnection();
			
			String sql="select qa_num,qa_member,name qa_name,qa_subject,qa_content,qa_image"
					+ ",qa_register,qa_update,qa_readcount,qa_replay from qa_table join"
					+ " client_table on qa_table.qa_member=client_table.client_num"
					+ " where qa_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, qaNum);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				qa=new QaDTO();
				qa.setQaNum(rs.getInt("qa_num"));
				qa.setQaMember(rs.getInt("qa_member"));
				qa.setQaName(rs.getString("qa_name"));
				qa.setQaSubject(rs.getString("qa_subject"));
				qa.setQaContent(rs.getString("qa_content"));
				qa.setQaImage(rs.getString("qa_image"));
				qa.setQaRegister(rs.getString("qa_register"));
				qa.setQaUpdate(rs.getString("qa_update"));
				qa.setQaReadCount(rs.getInt("qa_readCount"));
				qa.setQaReplay(rs.getInt("qa_replay"));
>>>>>>> branch 'main' of https://github.com/askaraban/semi_project.git
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectQaByNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qa;
	}
	
	//글번호를 전달받아 QA 테이블의 저장된 행의 게시글 조회수가 1 증가되도록 변경하고 
	//변경행의 갯수를 반환하는 메소드
	public int updateQaReadCount(int QaNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update qa_table set qa_readcount=qa_readcount+1 where qa_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, QaNum);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateQaReadCount() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//게시글을 전달받아 QA 테이블의 저장된 행의 컬럼값을 변경하고 변경행의 갯수를 반환하는 메소드
	public int deleteQa(int qaNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="delete from qa_table where qa_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, qaNum); 
		} catch (SQLException e) {
			System.out.println("[에러]updatQA() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
}

//여기까지 입니다.






































