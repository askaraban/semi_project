package xyz.itwill.DTO;

/*
WISH_NUM         NOT NULL NUMBER(10)  // 좋아요를 누른 번호
WISH_CLIENT_NUM           NUMBER(30)  // 좋아요를 누른 회원번호
WISH_PRODUCT_NUM          NUMBER(30)  // 좋아요를 누른 제품
 */

public class WishDTO {
	private int wishNum;
	private int wishClientNum;
	private int wishProductNum;
	private String productName;
	private String productMainImg;
	private int productPrice;
	
	
	
	public String getProductMainImg() {
		return productMainImg;
	}
	public void setProductMainImg(String productMainImg) {
		this.productMainImg = productMainImg;
	}
	public int getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getWishNum() {
		return wishNum;
	}
	public void setWishNum(int wishNum) {
		this.wishNum = wishNum;
	}
	public int getWishClientNum() {
		return wishClientNum;
	}
	public void setWishClientNum(int wishClientNum) {
		this.wishClientNum = wishClientNum;
	}
	public int getWishProductNum() {
		return wishProductNum;
	}
	public void setWishProductNum(int wishProductNum) {
		this.wishProductNum = wishProductNum;
	}
	
	
}
