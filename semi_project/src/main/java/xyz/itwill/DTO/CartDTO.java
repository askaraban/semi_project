package xyz.itwill.DTO;

/*
CART_NUM         NOT NULL NUMBER(5) 	// 장바구니 번호  
CART_CLIENT_NUM           NUMBER     	// 장바구니에 대한 회원 번호
CART_PRODUCT_NUM          NUMBER(10) 	// 장바구니에 담긴 제품 번호
CART_COUNT                NUMBER(5) 	// 장바구니에 담긴 제품의 수량
 */

public class CartDTO {	
	private int cartNum;
	private int cartClientNum;
	private int cartProductNum;
	private int cartCount;
	
	// join 하기 위한 제품DTO 필드
	private int productNum;
	private String productName;
	private int productPrice;
	private String productCom;
	private int productCate;
	private int productDis;
	private String productMainImg;
	public int getCartNum() {
		return cartNum;
	}
	public void setCartNum(int cartNum) {
		this.cartNum = cartNum;
	}
	public int getCartClientNum() {
		return cartClientNum;
	}
	public void setCartClientNum(int cartClientNum) {
		this.cartClientNum = cartClientNum;
	}
	public int getCartProductNum() {
		return cartProductNum;
	}
	public void setCartProductNum(int cartProductNum) {
		this.cartProductNum = cartProductNum;
	}
	public int getCartCount() {
		return cartCount;
	}
	public void setCartCount(int cartCount) {
		this.cartCount = cartCount;
	}
	public int getProductNum() {
		return productNum;
	}
	public void setProductNum(int productNum) {
		this.productNum = productNum;
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
	public int getProductDis() {
		return productDis;
	}
	public void setProductDis(int productDis) {
		this.productDis = productDis;
	}
	public String getProductMainImg() {
		return productMainImg;
	}
	public void setProductMainImg(String productMainImg) {
		this.productMainImg = productMainImg;
	}
	
	
	
	
}
