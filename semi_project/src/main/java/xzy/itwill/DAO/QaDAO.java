package xzy.itwill.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.DTO.QaDTO;
import xyz.itwill.DTO.ReviewDTO;

public class QaDAO extends JdbcDAO {
	private static QaDAO _dao;
	
	public QaDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new QaDAO();
	}
	
	public static QaDAO getDAO() {
		return _dao;
	}
	
	//검색정보(검색대상과 검색단어)를 전달받아 REVIEW 테이블에 저장된 게시글 중 검색대상의 
	//컬럼에 검색단어가 포함된 게시글의 갯수를 검색하여 반환하는 메소드
	// => 검색 기능을 사용하지 않을 경우 REVIEW 테이블에 저장된 모든 게시글의 갯수를 검색하여 반환
	public int selectTotalQa(String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int totalCount=0;
		try {
			con=getConnection();
			
			if(keyword=="") {
				String sql="select count(*) from qa_table";
				pstmt=con.prepareStatement(sql);
			} else {
				String sql="select count(*) from qa_table where "+search+" like '%'||?||'%'";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				totalCount=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectTotalQa() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return totalCount;
	}
	// 회원 페이지에서 자신의 qa 목록을 볼 수 있는 메소드
	public int selectTotalQa(int clientNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int totalCount=0;
		try {
			con=getConnection();
			
			String sql="select count(*) from qa_table where qa_member=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, clientNum);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				totalCount=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectTotalQa() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return totalCount;
	}
	
	//페이징 처리 관련 정보(시작 행번호와 종료 행번호)와 게시글 검색 기능 관련 정보(검색대상과
	//검색단어)를 전달받아 REVIEW 테이블에 저장된 행을 검색하여 게시글 목록을 반환하는 메소드
	public List<QaDTO> selectQaList(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<QaDTO> qaList=new ArrayList<QaDTO>();
		try {
			con=getConnection();
			
			if(keyword.equals("")) { //검색 기능을 사용하지 않는 경우
				String sql="select * from (select rownum rn, temp.* from (select qa_num"
						+ ", qa_member, client_name, qa_subject, qa_content, qa_image, qa_register"
						+ ", qa_update, qa_readcount, qa_replay from qa_table join client_table"
						+ " on qa_member=client_num order by qa_register desc) temp)"
						+ " where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else { //검색 기능을 사용한 경우
				String sql="select * from (select rownum rn, temp.* from (select qa_num"
						+ ", qa_member, client_name, qa_subject, qa_content, qa_image, qa_register"
						+ ", qa_update, qa_readcount, qa_replay from qa_table join client_table"
						+ " on qa_member=client_num where "+search+" like '%'||?||'%'"
						+ " order by qa_register desc) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				QaDTO qa=new QaDTO();
				qa.setQaNum(rs.getInt("qa_num"));
				qa.setQaMember(rs.getInt("qa_member"));
				qa.setQaName(rs.getString("client_name"));
				qa.setQaSubject(rs.getString("qa_subject"));
				qa.setQaContent(rs.getString("qa_content"));
				qa.setQaImage(rs.getString("qa_image"));
				qa.setQaRegister(rs.getString("qa_register"));
				qa.setQaUpdate(rs.getString("qa_update"));
				qa.setQaReadCount(rs.getInt("qa_readcount"));
				qa.setQaReplay(rs.getString("qa_replay"));
				
				qaList.add(qa);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectQaList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qaList;
	}
	
	//페이징 처리 관련 정보(시작 행번호와 종료 행번호)와 회원번호를 전달받아 회원에 대한 qa리스트 출력하는 메소드
	public List<QaDTO> selectQaList(int startRow, int endRow, int clientNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<QaDTO> qaList=new ArrayList<QaDTO>();
		try {
			con=getConnection();
			
				String sql="select * from (select rownum rn, temp.* from (select qa_num"
						+ ", qa_member, qa_subject, qa_content, qa_image, qa_register"
						+ ", qa_update, qa_readcount, qa_replay from qa_table join client_table"
						+ " on qa_member=client_num where client_num=? order by qa_register desc,qa_num desc) temp)"
						+ "where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, clientNum);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				QaDTO qa=new QaDTO();
				qa.setQaNum(rs.getInt("qa_num"));
				qa.setQaMember(rs.getInt("qa_member"));
				qa.setQaSubject(rs.getString("qa_subject"));
				qa.setQaContent(rs.getString("qa_content"));
				qa.setQaImage(rs.getString("qa_image"));
				qa.setQaRegister(rs.getString("qa_register"));
				qa.setQaUpdate(rs.getString("qa_update"));
				qa.setQaReadCount(rs.getInt("qa_readcount"));
				qa.setQaReplay(rs.getString("qa_replay"));
				
				qaList.add(qa);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectQaList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qaList;
	}
	
	// 페이징 처리 관련 정보(시작 행번호와 종료 행번호)와 제품번호를 전달받아
	// REVIEW_TABLE에 저장된 행을 select 하여 게시글 목록을 반환하는 메소드
	public List<QaDTO> selectQaListByQaProductNum(int startRow, int endRow, int qaProductNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QaDTO> qaList = new ArrayList<QaDTO>();
		try {
			con = getConnection();

			String sql="select * from (select rownum rn, temp.* from (select qa_num"
					+ " , qa_member, client_name, qa_subject, qa_content, qa_image"
					+ " , qa_register, qa_update, qa_readcount, qa_replay, qa_product_num"
					+ " from qa_table join client_table on qa_member=client_num where qa_product_num=?"
					+ " order by qa_num desc) temp) where rn between ? and ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, qaProductNum);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
	     
			//여기 밑으로 확인하기
	     
			rs = pstmt.executeQuery();

			while (rs.next()) {
				QaDTO qa = new QaDTO();
	            qa.setQaNum(rs.getInt("qa_num"));
	            qa.setQaMember(rs.getInt("qa_member"));
	            qa.setQaName(rs.getString("client_name"));
	            qa.setQaSubject(rs.getString("qa_subject"));
	            qa.setQaContent(rs.getString("qa_content"));
	            qa.setQaImage(rs.getString("qa_image"));
	            qa.setQaRegister(rs.getString("qa_register"));
	            qa.setQaUpdate(rs.getString("qa_update"));
	            qa.setQaReadCount(rs.getInt("qa_readcount"));
	            qa.setQaReplay(rs.getString("qa_replay"));
	            qa.setQaProductNum(rs.getInt("qa_product_num"));

	            qaList.add(qa);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectQaListByQaProductNum() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qaList;
	}
	
	// REVIEW_TABLE에 저장된 제품별 리뷰의 count(갯수)를 반환하는 메소드
	public int selectQaCountByQaNum(int qaProductNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int qaCount=0;
		try {
			con=getConnection();
			
			String sql="select count(*) from qa_table where qa_product_num=?";

			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, qaProductNum);
			
			rs=pstmt.executeQuery();
         
			if(rs.next()) {
				qaCount=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectQaCountByQaNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qaCount;
	}
	
	//REVIEW_SEQ 시퀸스의 다음값(정수값)을 검색하여 반환하는 메소드
	public int selectQaNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		try {
			con=getConnection();
			
			String sql="select qa_seq.nextval from dual";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				nextNum=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectQaNextNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}
	
	//게시글을 전달받아 REVIEW 테이블에 행으로 삽입하고 삽입행의 갯수를 반환하는 메소드
	public int insertQa(QaDTO qa) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into qa_table values(?,?,?,?,?,sysdate,null,0,null)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, qa.getQaNum());
			pstmt.setInt(2, qa.getQaMember());
			pstmt.setString(3, qa.getQaSubject());
			pstmt.setString(4, qa.getQaContent());
			pstmt.setString(5, qa.getQaImage());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertQa() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//글번호를 전달받아 REVIEW 테이블의 단일행을 검색하여 게시글(ReviewDTO 객체)을 반환하는 메소드
	public QaDTO selectQaByNum(int qaNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		QaDTO qa=null;
		try {
			con=getConnection();
			
			String sql="select qa_num,qa_member,name,qa_subject,qa_content,qa_image"
					+ ",qa_register,qa_update,qa_readcount,qa_replay,qa_product_num from qa_table join"
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
				qa.setQaReplay(rs.getString("qa_replay"));
				qa.setQaProductNum(rs.getInt("qa_product_num"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectQaByNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qa;
	}
	
	//글번호를 전달받아 REVIEW 테이블의 저장된 행의 게시글 조회수가 1 증가되도록 변경하고 
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
	
	//게시글을 전달받아 REVIEW 테이블의 저장된 행의 컬럼값을 변경하고 변경행의 갯수를 반환하는 메소드
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
