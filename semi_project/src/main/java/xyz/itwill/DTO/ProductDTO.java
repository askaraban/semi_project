package xyz.itwill.DTO;

/*
PRODUCTID      NOT NULL NUMBER(10)     // 제품번호
PRODUCTNAME             VARCHAR2(200)  // 제품명
PRODUCTPRICE            NUMBER(10)     // 제품가격
PRODUCTCOM              VARCHAR2(30)   // 제조사
PRODUCTCATE             NUMBER(2)      // 유형
PRODUCTREG              DATE           // 등록일
PRODUCTSALE             NUMBER(10)     // 판매량
PRODUCTDIS              NUMBER(3)      // 할인율
PRODUCTIMGPATH          VARCHAR2(50)   // 제품사진
PRODUCTIMG1             VARCHAR2(50)   // 상세사진1
PRODUCTIMG2             VARCHAR2(50)   // 상세사진2
PRODUCTIMG3             VARCHAR2(50)   // 상세사진3
 */

public class ProductDTO {
	private int productId;
	private String productName;
	private int productPrice;
	private String productCom;
	private int productCate;
	private String productReg;
	private int productSale;
	private int productDis;
	private String productImgPath;
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
	public int getProductSale() {
		return productSale;
	}
	public void setProductSale(int productSale) {
		this.productSale = productSale;
	}
	public int getProductDis() {
		return productDis;
	}
	public void setProductDis(int productDis) {
		this.productDis = productDis;
	}
	public String getProductImgPath() {
		return productImgPath;
	}
	public void setProductImgPath(String productImgPath) {
		this.productImgPath = productImgPath;
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