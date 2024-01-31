package xzy.itwill.DAO;

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
	
	
}
