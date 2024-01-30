package xyz.itwill.DTO;

/*
create table client(client_num number primary key, id varchar2(30) unique, passwd varchar2(200)
	    , name varchar2(30), email varchar2(50), mobile varchar2(20), zipcode varchar2(10)
	    , address1 varchar2(200), address2 varchar2(100), join_date date, update_date date
	    , last_login date, client_status number(1));
	    
create sequence client_seq;    
*/

/*
이름            널?       유형            
------------- -------- ------------- 
CLIENTNUM    NOT NULL NUMBER        - 회원번호(PRIMARY KEY) : 시퀸스의 증가값     
ID                     VARCHAR2(30)  - 아이디 : 사용자 입력값  
PASSWD                 VARCHAR2(200) - 비밀번호 : 사용자 입력값(암호화 처리)
NAME                   VARCHAR2(30)  - 이름 : 사용자 입력값   
EMAIL                  VARCHAR2(50)  - 이메일 : 사용자 입력값
MOBILE                 VARCHAR2(20)  - 전화번호 : 사용자 입력값
ZIPCODE                VARCHAR2(10)  - 우편번호 : 사용자 입력값(우편번호 검색서비스)
ADDRESS1               VARCHAR2(200) - 기본주소 : 사용자 입력값(우편번호 검색서비스)
ADDRESS2               VARCHAR2(100) - 상세주소 : 사용자 입력값
JOIN_DATE              DATE          - 회원가입날짜 : 시스템의 현재 날짜와 시간(SYSDATE) 
UPDATEDATE            DATE          - 회원변경날짜 : 시스템의 현재 날짜와 시간(SYSDATE)
LASTLOGIN             DATE          - 마지막 로그인날짜 : 시스템의 현재 날짜와 시간(SYSDATE)
CLIENTSTATUS          NUMBER(1)     - 회원상태(권한) : 0(탈퇴회원), 1(일반회원), 9(관리자) 
*/
/*
------------- -------- ------------- 
CLIENT_NUM    NOT NULL NUMBER        
ID                     VARCHAR2(30)  
PASSWD                 VARCHAR2(200) 
NAME                   VARCHAR2(30)  
EMAIL                  VARCHAR2(50)  
MOBILE                 VARCHAR2(20)  
ZIPCODE                VARCHAR2(10)  
ADDRESS1               VARCHAR2(200) 
ADDRESS2               VARCHAR2(100) 
JOIN_DATE              DATE          
UPDATE_DATE            DATE          
LAST_LOGIN             DATE          
CLIENT_STATUS          NUMBER(1) 
*/
public class ClientDTO {
	private int clientNum;
	private String id;
	private String passwd;
	private String name;
	private String email;
	private String mobile;
	private String zipcode;
	private String address1;
	private String address2;
	private String joinDate;
	private String updateDate;
	private String lastLogin;
	private int clientStatus;
	
	public ClientDTO() {
		// TODO Auto-generated constructor stub
	}

	public ClientDTO(int clientNum, String id, String passwd, String name, String email, String mobile, String zipcode,
			String address1, String address2, String joinDate, String updateDate, String lastLogin, int clientStatus) {
		super();
		this.clientNum = clientNum;
		this.id = id;
		this.passwd = passwd;
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.zipcode = zipcode;
		this.address1 = address1;
		this.address2 = address2;
		this.joinDate = joinDate;
		this.updateDate = updateDate;
		this.lastLogin = lastLogin;
		this.clientStatus = clientStatus;
	}

	public int getClientNum() {
		return clientNum;
	}

	public void setClientNum(int clientNum) {
		this.clientNum = clientNum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}

	public String getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}

	public String getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(String lastLogin) {
		this.lastLogin = lastLogin;
	}

	public int getClientStatus() {
		return clientStatus;
	}

	public void setClientStatus(int clientStatus) {
		this.clientStatus = clientStatus;
	}
	
	
	
	
}
	
