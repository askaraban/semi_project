package xyz.itwill.DTO;

/*
이름           널?       유형             
------------ -------- -------------- 
QA_NUM       NOT NULL NUMBER         
QA_MEMBER             NUMBER         
QA_SUBJECT            VARCHAR2(500)  
QA_CONTENT            VARCHAR2(4000) 
QA_IMAGE              VARCHAR2(100)  
QA_REGISTER           DATE           
QA_UPDATE             DATE           
QA_READCOUNT          NUMBER         
QA_REPLAY             NUMBER      
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
	private int qaReplay;
	
	public QaDTO() {
		// TODO Auto-generated constructor stub
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

	public String getQaName() {
		return qaName;
	}

	public void setQaName(String qaName) {
		this.qaName = qaName;
	}

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

	public int getQaReplay() {
		return qaReplay;
	}

	public void setQaReplay(int qaReplay) {
		this.qaReplay = qaReplay;
	}

}
