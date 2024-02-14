package xyz.itwill.DTO;

/*
create table notice(noticenum number primary key, noticeid varchar2(20), noticetitle varchar2(200)
    , noticecontent varchar2(1000), noticedate date noticeupdate date, noticereview number);

create sequence notice_seq;
*/

/*
이름             널?       유형             
-------------- -------- -------------- 
NOTICE_NUM     NOT NULL NUMBER         - 글번호 : 시퀀스의 다음값
NOTICE_TITLE            VARCHAR2(100)  - 글제목
NOTICE_CONTENT          VARCHAR2(1000) - 글내용
NOTICE_IMAGE            VARCHAR2(100)  - 이미지 파일 경로
NOTICE_DATE             DATE           - 작성날짜
NOTICE_UPDATE           DATE           - 변경날짜
NOTICE_COUNT            NUMBER         - 조회수 : 0 >> 게시글 조회 누적수
*/

public class NoticeDTO {
	private int noticeNum;
	private String noticeTitle;
	private String noticeContent;
	private String noticeImage;
	private String noticeDate;
	private String noticeUpdate;
	private int noticeCount;
	
	private int clientNum;
	
	public int getClientNum() {
		return clientNum;
	}

	public void setClientNum(int clientNum) {
		this.clientNum = clientNum;
	}

	public NoticeDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getNoticeNum() {
		return noticeNum;
	}

	public void setNoticeNum(int noticeNum) {
		this.noticeNum = noticeNum;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeContent() {
		return noticeContent;
	}

	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}

	public String getNoticeImage() {
		return noticeImage;
	}

	public void setNoticeImage(String noticeImage) {
		this.noticeImage = noticeImage;
	}

	public String getNoticeDate() {
		return noticeDate;
	}

	public void setNoticeDate(String noticeDate) {
		this.noticeDate = noticeDate;
	}

	public String getNoticeUpdate() {
		return noticeUpdate;
	}

	public void setNoticeUpdate(String noticeUpdate) {
		this.noticeUpdate = noticeUpdate;
	}

	public int getNoticeCount() {
		return noticeCount;
	}

	public void setNoticeCount(int noticeCount) {
		this.noticeCount = noticeCount;
	}

}
