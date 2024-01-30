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
	
	//회원정보를 전달받아 CLIENT 테이블의 행으로 삽입하고 삽입행의 갯수를 반환하는 메소드d
	public int insertClient(ClientDTO client) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into client values(client_seq.nextval,?,?,?,?,?,?,?,?,sysdate,null,null,1)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, client.getId());
			pstmt.setString(2, client.getPasswd());
			pstmt.setString(3, client.getName());
			pstmt.setString(4, client.getEmail());
			pstmt.setString(5, client.getMobile());
			pstmt.setString(6, client.getZipcode());
			pstmt.setString(7, client.getAddress1());
			pstmt.setString(8, client.getAddress2());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertClient() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	
	//회원정보를 전달받아 CLIENT 테이블에 저장된 행을 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateClient(ClientDTO client) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update client set passwd=?,name=?,email=?,mobile=?,zipcode=?"
					+ ",address1=?,address2=?,update_date=sysdate where client_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, client.getPasswd());
			pstmt.setString(2, client.getName());
			pstmt.setString(3, client.getEmail());
			pstmt.setString(4, client.getMobile());
			pstmt.setString(5, client.getZipcode());
			pstmt.setString(6, client.getAddress1());
			pstmt.setString(7, client.getAddress2());
			pstmt.setInt(8, client.getClientNum());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateClient() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//회원번호를 전달받아 CLIENT 테이블에 저장된 행의 마지막 로그인 날짜를 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateLastLogin(int clientNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update client set last_login=sysdate where client_num=?";
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

	//회원정보를 전달받아 CLIENT 테이블에 저장된 행의 회원상태를 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateClientStatus(ClientDTO client) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update client set client_status=? where client_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, client.getClientStatus());
			pstmt.setInt(2, client.getClientNum());
			
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
		ClientDTO client=null;
		try {
			con=getConnection();
			
			String sql="select client_num,id,passwd,name,email,mobile,zipcode,address1,address2"
					+",join_date,update_date,last_login,client_status from client where client_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, clientNum);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				client=new ClientDTO();
				client.setClientNum(rs.getInt("client_num"));
				client.setId(rs.getString("id"));
				client.setPasswd(rs.getString("passwd"));
				client.setName(rs.getString("name"));
				client.setEmail(rs.getString("email"));
				client.setMobile(rs.getString("mobile"));
				client.setZipcode(rs.getString("zipcode"));
				client.setAddress1(rs.getString("address1"));
				client.setAddress2(rs.getString("address2"));
				client.setJoinDate(rs.getString("join_date"));
				client.setUpdateDate(rs.getString("update_date"));
				client.setLastLogin(rs.getString("last_login"));
				client.setClientStatus(rs.getInt("client_status"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectClientByNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return client;
	}
	
	//아이디를 전달받아 CLIENT 테이블에 저장된 단일행을 검색하여 회원정보를 반환하는 메소드
	public ClientDTO selectClientById(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ClientDTO client=null;
		try {
			con=getConnection();
			
			String sql="select client_num,id,passwd,name,email,mobile,zipcode,address1,address2"
					+",join_date,update_date,last_login,client_status from client where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				client=new ClientDTO();
				client.setClientNum(rs.getInt("client_num"));
				client.setId(rs.getString("id"));
				client.setPasswd(rs.getString("passwd"));
				client.setName(rs.getString("name"));
				client.setEmail(rs.getString("email"));
				client.setMobile(rs.getString("mobile"));
				client.setZipcode(rs.getString("zipcode"));
				client.setAddress1(rs.getString("address1"));
				client.setAddress2(rs.getString("address2"));
				client.setJoinDate(rs.getString("join_date"));
				client.setUpdateDate(rs.getString("update_date"));
				client.setLastLogin(rs.getString("last_login"));
				client.setClientStatus(rs.getInt("client_status"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectClientById() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return client;
	}
	

	//회원정보(이름과 이메일)을 전달받아 CLIENT 테이블에 저장된 단일행의 아이디를 검색하여 
	//문자열로 반환하는 메소드
	public String selectClientId(ClientDTO client) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String id=null;
		try {
			con=getConnection();
			
			String sql="select id from client where name=? and email=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, client.getName());
			pstmt.setString(2, client.getEmail());
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				id=rs.getString(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectClientById() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return id;
	}
}