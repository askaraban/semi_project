package xzy.itwill.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import xyz.itwill.DTO.NoticeDTO;

public class NoticeDAO extends JdbcDAO {
	private static NoticeDAO _dao;
	
	public NoticeDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new NoticeDAO();
	}
	
	public static NoticeDAO getDAO() {
		return _dao;
	}
	
	//REVIEW_SEQ 시퀸스의 다음값(정수값)을 검색하여 반환하는 메소드
	public int selectNoticeNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		try {
			con=getConnection();
			
			String sql="select notice_seq.nextval from dual";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				nextNum=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoticeNextNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}
	
	//게시글을 전달받아 REVIEW 테이블에 행으로 삽입하고 삽입행의 갯수를 반환하는 메소드
	public int insertNotice(NoticeDTO notice) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into notice_table values(?,?,?,?,sysdate,null,0)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, notice.getNoticeNum());
			pstmt.setString(2, notice.getNoticeTitle());
			pstmt.setString(3, notice.getNoticeContent());
			pstmt.setString(4, notice.getNoticeImage());
		} catch (SQLException e) {
			System.out.println("[에러]insertNotice() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//글번호를 전달받아 REVIEW 테이블의 저장된 행의 게시글 조회수가 1 증가되도록 변경하고 
	//변경행의 갯수를 반환하는 메소드
	public int updateNoticeCount(int noticeCount) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update notice_table set notice_count=notice_count+1"
					+"where notice_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, noticeCount);
		} catch (SQLException e) {
			System.out.println("[에러]updateNoticeCount() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	//게시글을 전달받아 REVIEW 테이블의 저장된 행의 컬럼값을 변경하고 변경행의 갯수를 반환하는 메소드
	//단, ReviewDAO 에선 review_status 포함해서 작성함
	public int updateNotice(NoticeDTO notice) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			//사용자가 이미지 파일을 입력하지 않은 경우 - 이미지 파일 미변경(기존 이미지 파일 사용)
			if(notice.getNoticeImage()==null) {
				String sql="update notice_table set notice_title=?,notice_content=? where notice_num=?";
				
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, notice.getNoticeTitle());
				pstmt.setString(2, notice.getNoticeContent());
				pstmt.setInt(3, notice.getNoticeNum());
			} else {
				String sql="update notice_table set notice_title=?,notice_content=?,notice_image=? where notice_num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, notice.getNoticeTitle());
				pstmt.setString(2, notice.getNoticeContent());
				pstmt.setString(3, notice.getNoticeImage());
				pstmt.setInt(4, notice.getNoticeNum());
			}
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateNotice() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//글번호를 전달받아 REVIEW 테이블의 단일행을 검색하여 게시글(ReviewDTO 객체)을 반환하는 메소드
	public NoticeDTO selectNoticeByNum(int noticeNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		NoticeDTO notice=null;
		try {
			con=getConnection();
			
			String sql="select notice_num,notice_title,notice_content,notice_image,notice_date"
					+ ",notice_update,notice_count from notice_table where notice_num=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1, noticeNum);
					
					rs=pstmt.executeQuery();
					
					if(rs.next()) {
						notice=new NoticeDTO();
						notice.setNoticeNum(rs.getInt("notice_num"));
						notice.setNoticeTitle(rs.getString("notice_title"));
						notice.setNoticeContent(rs.getString("notice_content"));
						notice.setNoticeImage(rs.getString("notice_image"));
						notice.setNoticeDate(rs.getString("notice_date"));
						notice.setNoticeUpdate(rs.getString("notice_update"));
						notice.setNoticeCount(rs.getInt("notice_count"));
					}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoticeByNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return notice;
	}
	
}
