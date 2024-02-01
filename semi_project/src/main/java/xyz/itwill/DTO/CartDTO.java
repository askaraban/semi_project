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
	private int productNum;
	private int cartCount;
	
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
	public int getProductNum() {
		return productNum;
	}
	public void setProductNum(int productNum) {
		this.productNum = productNum;
	}
	public int getCartCount() {
		return cartCount;
	}
	public void setCartCount(int cartCount) {
		this.cartCount = cartCount;
	}
	
	
}
