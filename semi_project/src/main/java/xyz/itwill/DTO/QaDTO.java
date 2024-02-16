package xyz.itwill.DTO;

/*
이름             널?       유형             
-------------- -------- -------------- 
QA_NUM         NOT NULL NUMBER       	- 글번호
QA_MEMBER               NUMBER       	- 작성자
QA_SUBJECT              VARCHAR2(500)	- 제목
QA_CONTENT              VARCHAR2(4000)	- 내용
QA_IMAGE                VARCHAR2(100)	- 이미지 파일 경로
QA_REGISTER             DATE         	- 작성날짜
QA_UPDATE               DATE         	- 변경날짜
QA_READCOUNT            NUMBER       	- 조회수
QA_REPLAY               VARCHAR2(4000)	- 답글    
QA_PRODUCT_NUM          NUMBER(10)   	- 제품번호
*/

public class QaDTO {
	private int qaNum;
	private int qaMember;
	private String qaName; //CLIENT 테이블의 회원이름(CLIENT_NAME 컬럼)을 저장하기 위한 필드 - 작성자이름
	private String qaSubject;
	private String qaContent;
	private String qaImage;
	private String qaRegister;
	private String qaUpdate;
	private int qaReadCount;
	private String qaReplay;
	private int qaProductNum;
	private int clientNum;
	private String productName;	 //PRODUCT 테이블의 상품명(PRODUCT_NAME 컬럼)을 저장하기 위한 필드 - 상품명
	
	public QaDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getClientNum() {
		return clientNum;
	}

	public void setClientNum(int clientNum) {
		this.clientNum = clientNum;
	}

	public String getQaName() {
		return qaName;
	}

	public void setQaName(String qaName) {
		this.qaName = qaName;
	}

	public int getQaNum() {
		return qaNum;
	}

	public void setQaNum(int qaNum) { 
		this.qaNum = qaNum;
	}

	public int getQaMember() {
		return qaMember;
	}

	public void setQaMember(int qaMember) {
		this.qaMember = qaMember;
	}

	/*
	public String getQaName() {
		return qaName;
	}

	public void setQaName(String qaName) {
		this.qaName = qaName;
	}
	*/

	public String getQaSubject() {
		return qaSubject;
	}

	public void setQaSubject(String qaSubject) {
		this.qaSubject = qaSubject;
	}

	public String getQaContent() {
		return qaContent;
	}

	public void setQaContent(String qaContent) {
		this.qaContent = qaContent;
	}

	public String getQaImage() {
		return qaImage;
	}

	public void setQaImage(String qaImage) {
		this.qaImage = qaImage;
	}

	public String getQaRegister() {
		return qaRegister;
	}

	public void setQaRegister(String qaRegister) {
		this.qaRegister = qaRegister;
	}

	public String getQaUpdate() {
		return qaUpdate;
	}

	public void setQaUpdate(String qaUpdate) {
		this.qaUpdate = qaUpdate;
	}

	public int getQaReadCount() {
		return qaReadCount;
	}

	public void setQaReadCount(int qaReadCount) {
		this.qaReadCount = qaReadCount;
	}

	public String getQaReplay() {
		return qaReplay;
	}

	public void setQaReplay(String qaReplay) {
		this.qaReplay = qaReplay;
	}

	public int getQaProductNum() {
		return qaProductNum;
	}

	public void setQaProductNum(int qaProductNum) {
		this.qaProductNum = qaProductNum;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}
}