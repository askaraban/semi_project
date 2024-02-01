package xzy.itwill.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import xyz.itwill.DTO.ClientDTO;

public class ClientDAO extends JdbcDAO {
	private static ClientDAO _dao;
	
	private ClientDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new ClientDAO();
	}
	
	public static ClientDAO getDAO() {
		return _dao;
	}
	
	//회원정보를 전달받아 CLIENT_TABLE 테이블의 행으로 삽입하고 삽입행의 갯수를 반환하는 메소드
	public int insertClient(ClientDTO clientTable) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into client_table values(client_seq.nextval,?,?,?,?,?,?,?,?,sysdate,null,null,1)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, clientTable.getClientID());
			pstmt.setString(2, clientTable.getClientPasswd());
			pstmt.setString(3, clientTable.getClientName());
			pstmt.setString(4, clientTable.getClientEmail());
			pstmt.setString(5, clientTable.getClientMobile());
			pstmt.setString(6, clientTable.getClientZipcode());
			pstmt.setString(7, clientTable.getClientAddress1());
			pstmt.setString(8, clientTable.getClientAddress2());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertClient() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	
	//회원정보를 전달받아 CLIENT_TABLE 테이블에 저장된 행을 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateClient(ClientDTO clientTable) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update client_table set client_passwd=?,client_name=?,client_email=?,client_mobile=?,client_zipcode=?"
					+ ",client_address1=?,client_address2=?,client_update_date=sysdate where client_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, clientTable.getClientPasswd());
			pstmt.setString(2, clientTable.getClientName());
			pstmt.setString(3, clientTable.getClientEmail());
			pstmt.setString(4, clientTable.getClientMobile());
			pstmt.setString(5, clientTable.getClientZipcode());
			pstmt.setString(6, clientTable.getClientAddress1());
			pstmt.setString(7, clientTable.getClientAddress2());
			pstmt.setInt(8, clientTable.getClientNum());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateClient() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//회원번호를 전달받아 CLIENT_TABLE 테이블에 저장된 행의 마지막 로그인 날짜를 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateLastLogin(int clientNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update client_table set client_lastlogin=sysdate where client_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, clientNum);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateLastLogin() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	//회원정보를 전달받아 CLIENT_TABLE 테이블에 저장된 행의 회원상태를 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateClientStatus(ClientDTO clientTable) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update client_table set client_status=? where client_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, clientTable.getClientStatus());
			pstmt.setInt(2, clientTable.getClientNum());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateClientStatus() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
		
	//회원번호를 전달받아  테이블에 저장된 단일행을 검색하여 회원정보를 반환하는 메소드
	public ClientDTO selectClientByNum(int clientNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ClientDTO clientTable=null;
		try {
			con=getConnection();
			
			String sql="select client_num,client_id,client_passwd,client_name,client_email,client_mobile,client_zipcode,client_address1,client_address2"
					+",client_join_date,client_update_date,client_lastlogin,client_status from client_table where client_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, clientNum);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				clientTable=new ClientDTO();
				clientTable.setClientNum(rs.getInt("client_num"));
				clientTable.setClientID(rs.getString("client_id"));
				clientTable.setClientPasswd(rs.getString("client_passwd"));
				clientTable.setClientName(rs.getString("client_name"));
				clientTable.setClientEmail(rs.getString("client_email"));
				clientTable.setClientMobile(rs.getString("client_mobile"));
				clientTable.setClientZipcode(rs.getString("client_zipcode"));
				clientTable.setClientAddress1(rs.getString("client_address1"));
				clientTable.setClientAddress2(rs.getString("client_address2"));
				clientTable.setClientJoinDate(rs.getString("client_join_date"));
				clientTable.setClientUpdateDate(rs.getString("client_update_date"));
				clientTable.setClientLastLogin(rs.getString("client_lastlogin"));
				clientTable.setClientStatus(rs.getInt("client_status"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectClientByNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return clientTable;
	}
	
	//아이디를 전달받아 CLIENT_TABLE 테이블에 저장된 단일행을 검색하여 회원정보를 반환하는 메소드
	public ClientDTO selectClientById(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ClientDTO clientTable=null;
		try {
			con=getConnection();
			
			String sql="select client_num,client_id,client_passwd,client_name,client_email,client_mobile,client_zipcode,client_address1,client_address2"
					+",client_join_date,client_update_date,client_lastlogin,client_status from client_table where client_id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				clientTable=new ClientDTO();
				clientTable.setClientNum(rs.getInt("client_num"));
				clientTable.setClientID(rs.getString("client_id"));
				clientTable.setClientPasswd(rs.getString("client_passwd"));
				clientTable.setClientName(rs.getString("client_name"));
				clientTable.setClientEmail(rs.getString("client_email"));
				clientTable.setClientMobile(rs.getString("client_mobile"));
				clientTable.setClientZipcode(rs.getString("client_zipcode"));
				clientTable.setClientAddress1(rs.getString("client_address1"));
				clientTable.setClientAddress2(rs.getString("client_address2"));
				clientTable.setClientJoinDate(rs.getString("client_join_date"));
				clientTable.setClientUpdateDate(rs.getString("client_update_date"));
				clientTable.setClientLastLogin(rs.getString("client_lastlogin"));
				clientTable.setClientStatus(rs.getInt("client_status"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectClientById() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return clientTable;
	}
	

	//회원정보(이름과 이메일)을 전달받아 CLIENT_TABLE 테이블에 저장된 단일행의 아이디를 검색하여 
	//문자열로 반환하는 메소드
	public String selectClientId(ClientDTO clientTable) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String id=null;
		try {
			con=getConnection();
			
			String sql="select client_id from client_table where client_name=? and client_email=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, clientTable.getClientName());
			pstmt.setString(2, clientTable.getClientEmail());
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				id=rs.getString(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectClientId() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return id;
	}
}