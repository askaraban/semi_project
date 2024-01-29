package xyz.itwill.DTO;

/*
 이름           널?       유형           
------------ -------- ------------ 
CATEGORYID   NOT NULL NUMBER(2)    
CATEGORYNAME          VARCHAR2(30) 
 */

public class CategoryDTO {
	private int categoryId;
	private String categoryName;
	
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	
	
}
