package xzy.itwill.DAO;

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
	
	
}
