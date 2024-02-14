package xyz.itwill.DTO;

/*
이름                널?       유형             
----------------- -------- -------------- 
REVIEW_NUM        NOT NULL NUMBER(30)     - 글번호
REVIEW_MEMBER_NUM          NUMBER(30)     - 작성자
REVIEW_SUBJECT             VARCHAR2(500)  - 제목
REVIEW_CONTENT             VARCHAR2(4000) - 내용
REVIEW_IMAGE               VARCHAR2(100)  - 이미지 파일 경로
REVIEW_REGISTER            DATE           - 작성날짜
REVIEW_UPDATE              DATE           - 변경날짜
REVIEW_READCOUNT           NUMBER(30)     - 조회수
REVIEW_REPLAY              VARCHAR2(4000) - 답글
REVIEW_PRODUCT_NUM         NUMBER(10)     - 제품번호
REVIEW_STATUS              NUMBER(10)     - 글상태(0: 리뷰작성X, 1: 리뷰작성O)
*/

public class ReviewDTO {
	private int reviewNum;
	private int reviewMemberNum;
	private String reviewName;
	private String reviewSubject;
	private String reviewContent;
	private String reviewImage;
	private String reviewRegister;
	private String reviewUpdate;
	private int  reviewReadcount;
	private String reviewReplay;
	private int reviewProductNum;
	private int reviewStatus;


	public ReviewDTO() {
		// TODO Auto-generated constructor stub
	}

	public ReviewDTO(int reviewNum, int reviewMemberNum, String reviewName, String reviewSubject, String reviewContent,
			String reviewImage, String reviewRegister, String reviewUpdate, int reviewReadcount, String reviewReplay,
			int reviewProductNum, int reviewStatus) {
		super();
		this.reviewNum = reviewNum;
		this.reviewMemberNum = reviewMemberNum;
		this.reviewName = reviewName;
		this.reviewSubject = reviewSubject;
		this.reviewContent = reviewContent;
		this.reviewImage = reviewImage;
		this.reviewRegister = reviewRegister;
		this.reviewUpdate = reviewUpdate;
		this.reviewReadcount = reviewReadcount;
		this.reviewReplay = reviewReplay;
		this.reviewProductNum = reviewProductNum;
		this.reviewStatus = reviewStatus;
	}

	public int getReviewNum() {
		return reviewNum;
	}

	public void setReviewNum(int reviewNum) {
		this.reviewNum = reviewNum;
	}

	public int getReviewMemberNum() {
		return reviewMemberNum;
	}

	public void setReviewMemberNum(int reviewMemberNum) {
		this.reviewMemberNum = reviewMemberNum;
	}

	public String getReviewName() {
		return reviewName;
	}

	public void setReviewName(String reviewName) {
		this.reviewName = reviewName;
	}

	public String getReviewSubject() {
		return reviewSubject;
	}

	public void setReviewSubject(String reviewSubject) {
		this.reviewSubject = reviewSubject;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public String getReviewImage() {
		return reviewImage;
	}

	public void setReviewImage(String reviewImage) {
		this.reviewImage = reviewImage;
	}

	public String getReviewRegister() {
		return reviewRegister;
	}

	public void setReviewRegister(String reviewRegister) {
		this.reviewRegister = reviewRegister;
	}

	public String getReviewUpdate() {
		return reviewUpdate;
	}

	public void setReviewUpdate(String reviewUpdate) {
		this.reviewUpdate = reviewUpdate;
	}

	public int getReviewReadcount() {
		return reviewReadcount;
	}

	public void setReviewReadcount(int reviewReadcount) {
		this.reviewReadcount = reviewReadcount;
	}

	public String getReviewReplay() {
		return reviewReplay;
	}

	public void setReviewReplay(String reviewReplay) {
		this.reviewReplay = reviewReplay;
	}

	public int getReviewProductNum() {
		return reviewProductNum;
	}

	public void setReviewProductNum(int reviewProductNum) {
		this.reviewProductNum = reviewProductNum;
	}

	public int getReviewStatus() {
		return reviewStatus;
	}

	public void setReviewStatus(int reviewStatus) {
		this.reviewStatus = reviewStatus;
	}
	
}