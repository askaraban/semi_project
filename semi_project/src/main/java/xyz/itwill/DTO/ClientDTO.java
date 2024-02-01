package xyz.itwill.DTO;

/*
create table client_table(client_num number primary key, client_id varchar2(30) unique, client_passwd varchar2(200)
	    , client_name varchar2(30), client_email varchar2(50), client_mobile varchar2(20), client_zipcode varchar2(10)
	    , client_address1 varchar2(200), client_address2 varchar2(100), client_joinDate date, client_updatedate date
	    , client_lastLogin date, client_clientStatus number(1));
	    
create sequence client_table_seq;    
*/

/*
이름            널?       유형            
------------- -------- ------------- 
CLIENT_NUM    NOT NULL NUMBER        		- 회원번호(PRIMARY KEY) : 시퀸스의 증가값     
CLIENT_ID                     VARCHAR2(30)  - 아이디 : 사용자 입력값  
CLIENT_PASSWD                 VARCHAR2(200) - 비밀번호 : 사용자 입력값(암호화 처리)
CLIENT_NAME                   VARCHAR2(30)  - 이름 : 사용자 입력값   
CLIENT_EMAIL                  VARCHAR2(50)  - 이메일 : 사용자 입력값
CLIENT_MOBILE                 VARCHAR2(20)  - 전화번호 : 사용자 입력값
CLIENT_ZIPCODE                VARCHAR2(10)  - 우편번호 : 사용자 입력값(우편번호 검색서비스)
CLIENT_ADDRESS1               VARCHAR2(200) - 기본주소 : 사용자 입력값(우편번호 검색서비스)
CLIENT_ADDRESS2               VARCHAR2(100) - 상세주소 : 사용자 입력값
CLIENT_JOIN_DATE              DATE          - 회원가입날짜 : 시스템의 현재 날짜와 시간(SYSDATE) 
CLIENT_UPDATE_DATE             DATE          - 회원변경날짜 : 시스템의 현재 날짜와 시간(SYSDATE)
CLIENT_LASTLOGIN             DATE          - 마지막 로그인날짜 : 시스템의 현재 날짜와 시간(SYSDATE)
CLIENT_STATUS         		 NUMBER(1)     - 회원상태(권한) : 0(탈퇴회원), 1(일반회원), 9(관리자) 

CLIENT_NUM          NOT NULL NUMBER        
CLIENT_ID                    VARCHAR2(30)  
CLIENT_PASSWD                VARCHAR2(200) 
CLIENT_NAME                  VARCHAR2(30)  
CLIENT_EMAIL                 VARCHAR2(50)  
CLIENT_MOBILE                VARCHAR2(20)  
CLIENT_ZIPCODE               VARCHAR2(10)  
CLIENT_ADDRESS1              VARCHAR2(200) 
CLIENT_ADDRESS2              VARCHAR2(100) 
CLIENT_JOIN_DATE             DATE          
CLIENT_UPDATE_DATE           DATE          
CLIENT_LASTLOGIN             DATE          
CLIENT_CLIENTSTATUS          NUMBER(1) 
*/

public class ClientDTO {
	private int clientNum;
	private String clientID;
	private String clientPasswd;
	private String clientName;
	private String clientEmail;
	private String clientMobile;
	private String clientZipcode;
	private String clientAddress1;
	private String clientAddress2;
	private String clientJoinDate;
	private String clientUpdateDate;
	private String clientLastLogin;
	private int clientStatus;

	public int getClientNum() {
		return clientNum;
	}
	public void setClientNum(int clientNum) {
		this.clientNum = clientNum;
	}
	public String getClientID() {
		return clientID;
	}
	public void setClientID(String clientID) {
		this.clientID = clientID;
	}
	public String getClientPasswd() {
		return clientPasswd;
	}
	public void setClientPasswd(String clientPasswd) {
		this.clientPasswd = clientPasswd;
	}
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	public String getClientEmail() {
		return clientEmail;
	}
	public void setClientEmail(String clientEmail) {
		this.clientEmail = clientEmail;
	}
	public String getClientMobile() {
		return clientMobile;
	}
	public void setClientMobile(String clientMobile) {
		this.clientMobile = clientMobile;
	}
	public String getClientZipcode() {
		return clientZipcode;
	}
	public void setClientZipcode(String clientZipcode) {
		this.clientZipcode = clientZipcode;
	}
	public String getClientAddress1() {
		return clientAddress1;
	}
	public void setClientAddress1(String clientAddress1) {
		this.clientAddress1 = clientAddress1;
	}
	public String getClientAddress2() {
		return clientAddress2;
	}
	public void setClientAddress2(String clientAddress2) {
		this.clientAddress2 = clientAddress2;
	}
	public String getClientJoinDate() {
		return clientJoinDate;
	}
	public void setClientJoinDate(String clientJoinDate) {
		this.clientJoinDate = clientJoinDate;
	}
	public String getClientUpdateDate() {
		return clientUpdateDate;
	}
	public void setClientUpdateDate(String clientUpdateDate) {
		this.clientUpdateDate = clientUpdateDate;
	}
	public String getClientLastLogin() {
		return clientLastLogin;
	}
	public void setClientLastLogin(String clientLastLogin) {
		this.clientLastLogin = clientLastLogin;
	}
	public int getClientStatus() {
		return clientStatus;
	}
	public void setClientStatus(int clientStatus) {
		this.clientStatus = clientStatus;
	}

	
}