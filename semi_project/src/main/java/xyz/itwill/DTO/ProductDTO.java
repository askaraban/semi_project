package xyz.itwill.DTO;

/*
PRODUCT_ID          NOT NULL NUMBER(10)    // 제품id
PRODUCT_NAME                 VARCHAR2(200) // 제품명
PRODUCT_PRICE                NUMBER(10)    // 제품가격
PRODUCT_COM                  VARCHAR2(30)  // 제조사
PRODUCT_CATE                 NUMBER(2)     // 유형
PRODUCT_REG                  DATE          // 등록일
PRODUCT_DIS                  NUMBER(3)     // 할인율
PRODUCT_DIS_CONTENT          VARCHAR2(300) // 할인내용
PRODUCT_MAIN_IMG             VARCHAR2(50)  // 제품이미지
PRODUCT_IMG1                 VARCHAR2(50)  // 상세사진1
PRODUCT_IMG2                 VARCHAR2(50)  // 상세사진2
PRODUCT_IMG3                 VARCHAR2(50)   // 상세사진3
 */

 

public class ProductDTO {
	private int productId;
	private String productName;
	private int productPrice;
	private String productCom;
	private int productCate;
	private String productReg;
	private int productDis;
	private String productDisContent;
	private String productMainImg;
	private String productImg1;
	private String productImg2;
	private String productImg3;
	
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}
	public String getProductCom() {
		return productCom;
	}
	public void setProductCom(String productCom) {
		this.productCom = productCom;
	}
	public int getProductCate() {
		return productCate;
	}
	public void setProductCate(int productCate) {
		this.productCate = productCate;
	}
	public String getProductReg() {
		return productReg;
	}
	public void setProductReg(String productReg) {
		this.productReg = productReg;
	}
	public int getProductDis() {
		return productDis;
	}
	public void setProductDis(int productDis) {
		this.productDis = productDis;
	}
	public String getProductDisContent() {
		return productDisContent;
	}
	public void setProductDisContent(String productDisContent) {
		this.productDisContent = productDisContent;
	}
	public String getProductMainImg() {
		return productMainImg;
	}
	public void setProductMainImg(String productMainImg) {
		this.productMainImg = productMainImg;
	}
	public String getProductImg1() {
		return productImg1;
	}
	public void setProductImg1(String productImg1) {
		this.productImg1 = productImg1;
	}
	public String getProductImg2() {
		return productImg2;
	}
	public void setProductImg2(String productImg2) {
		this.productImg2 = productImg2;
	}
	public String getProductImg3() {
		return productImg3;
	}
	public void setProductImg3(String productImg3) {
		this.productImg3 = productImg3;
	}
	
	
	
}	