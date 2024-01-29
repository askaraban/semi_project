-- 회원 테이블 --
create table client(clientNum number primary key, id varchar2(30) unique, passwd varchar2(200)
	    , name varchar2(30), email varchar2(50), mobile varchar2(20), zipcode varchar2(10)
	    , address1 varchar2(200), address2 varchar2(100), joinDate date, updateDate date
	    , lastLogin date, clientStatus number(1));
	    
create sequence client_seq;   


-- 제품 테이블 --
create table product_table (productId number(10) primary key, productName varchar2(200), productPrice number(10),
productCom varchar2(30), productCate number(2), productReg date, productSale number(10), productDis number(3),
productImgPath varchar2(50), productImg1 varchar(50), productImg2 varchar2(50), productImg3 varchar2(50),
foreign key (productCate) references category_table(categoryId));

-- 제품 유형 테이블 --
create table category_table (categoryId number(2) primary key, categoryName varchar2(30));

create sequence category_seq start with 10
increment by 10
minvalue 10;

commit;