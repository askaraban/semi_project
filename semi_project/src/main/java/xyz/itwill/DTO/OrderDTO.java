package xyz.itwill.DTO;

/*
이름                널?       유형            
----------------- -------- ------------- 
ORDER_NUM         NOT NULL NUMBER(5)      - 주문번호(PK)
ORDER_CLIENT_NUM           NUMBER(5)      - 회원번호(FK)
ORDER_TIME                 VARCHAR2(100)  - 결제번호
ORDER_DATE                 DATE           - 주문일자
ORDER_PRODUCT_NUM          NUMBER(5)      - 제품번호(FK)
ORDER_COUNT                NUMBER(5)      - 수량
ORDER_STATUS               NUMBER(1)      - 배송상태
ORDER_SUM                  NUMBER(10)     - 총 금액
ORDER_DIS_SUM              NUMBER(10)     - 할인된 총 금액
ORDER_CONTENT              VARCHAR2(200)  - 배송 요청사항
ORDER_RECEIVER             VARCHAR2(20)   - 받는 사람
ORDER_ZIPCODE              VARCHAR2(10)   - 우편번호
ORDER_ADDRESS1             VARCHAR2(200)  - 기본주소
ORDER_ADDRESS2             VARCHAR2(100)  - 상세주소
ORDER_MOBILE               VARCHAR2(20)   - 전화번호
*/

public class OrderDTO {
	private int orderNum;
	private int orderClientNum;
	private String orderTime;
	private String orderDate;
	private int orderProductNum;
	private int orderCount;
	private int orderStatus;
	private int orderSum;
	private int orderDisSum;
	private String orderContent;
	private String orderReceiver;
	private String orderZipcode;
	private String orderAddress1;
	private String orderAddress2;
	private String orderMobile;
	
	public OrderDTO() {
		// TODO Auto-generated constructor stub
	}

	public OrderDTO(int orderNum, int orderClientNum, String orderTime, String orderDate, int orderProductNum,
			int orderCount, int orderStatus, int orderSum, int orderDisSum, String orderContent, String orderReceiver,
			String orderZipcode, String orderAddress1, String orderAddress2, String orderMobile) {
		super();
		this.orderNum = orderNum;
		this.orderClientNum = orderClientNum;
		this.orderTime = orderTime;
		this.orderDate = orderDate;
		this.orderProductNum = orderProductNum;
		this.orderCount = orderCount;
		this.orderStatus = orderStatus;
		this.orderSum = orderSum;
		this.orderDisSum = orderDisSum;
		this.orderContent = orderContent;
		this.orderReceiver = orderReceiver;
		this.orderZipcode = orderZipcode;
		this.orderAddress1 = orderAddress1;
		this.orderAddress2 = orderAddress2;
		this.orderMobile = orderMobile;
	}

	public int getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}

	public int getOrderClientNum() {
		return orderClientNum;
	}

	public void setOrderClientNum(int orderClientNum) {
		this.orderClientNum = orderClientNum;
	}

	public String getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public int getOrderProductNum() {
		return orderProductNum;
	}

	public void setOrderProductNum(int orderProductNum) {
		this.orderProductNum = orderProductNum;
	}

	public int getOrderCount() {
		return orderCount;
	}

	public void setOrderCount(int orderCount) {
		this.orderCount = orderCount;
	}

	public int getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(int orderStatus) {
		this.orderStatus = orderStatus;
	}

	public int getOrderSum() {
		return orderSum;
	}

	public void setOrderSum(int orderSum) {
		this.orderSum = orderSum;
	}

	public int getOrderDisSum() {
		return orderDisSum;
	}

	public void setOrderDisSum(int orderDisSum) {
		this.orderDisSum = orderDisSum;
	}

	public String getOrderContent() {
		return orderContent;
	}

	public void setOrderContent(String orderContent) {
		this.orderContent = orderContent;
	}

	public String getOrderReceiver() {
		return orderReceiver;
	}

	public void setOrderReceiver(String orderReceiver) {
		this.orderReceiver = orderReceiver;
	}

	public String getOrderZipcode() {
		return orderZipcode;
	}

	public void setOrderZipcode(String orderZipcode) {
		this.orderZipcode = orderZipcode;
	}

	public String getOrderAddress1() {
		return orderAddress1;
	}

	public void setOrderAddress1(String orderAddress1) {
		this.orderAddress1 = orderAddress1;
	}

	public String getOrderAddress2() {
		return orderAddress2;
	}

	public void setOrderAddress2(String orderAddress2) {
		this.orderAddress2 = orderAddress2;
	}

	public String getOrderMobile() {
		return orderMobile;
	}

	public void setOrderMobile(String orderMobile) {
		this.orderMobile = orderMobile;
	}
	
}
