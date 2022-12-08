create table tb_zipcode(
    zipcode varchar2(7) constraint tb_zipcode_zipcode_PK primary key,
    sido varchar2(30),
    gugum varchar2(30),
    dong varchar2(30),
    bungi varchar2(30)
);

create table member(
    id varchar2(20) constraint PK_member_id primary key,
    pwd varchar2(20),
    name varchar2(20),
    zipcode varchar2(7),
    constraint FK_member_id_tb_zipcode foreign key (zipcode) references tb_zipcode(zipcode),
    address varchar2(20),
    tel varchar2(13),
    indate date default sysdate
);

create table products(
    product_code varchar2(20) constraint PK_products_product_code primary key,
    product_name varchar2(100),
    product_kind char(1),
    product_price1 varchar2(10),
    producy_price2 varchar2(10),
    product_content varchar2(1000),
    product_image varchar2(50),
    sizeSt varchar2(5),
    sizeEt varchar(5), 
    product_quantity varchar2(5),
    useyn char(1),
    indate date
);

create table orders(
    o_seq number(10) constraint PK_orders_o_seq primary key,
    product_code varchar2(20),
    constraint  FK_orders_product_code_products foreign key(product_code) references products(product_code),
    id varchar2(16),
    constraint  FK_orders_id_member foreign key(id) references member(id),
    product_size varchar2(5),
    quantity  varchar2(5),
    result char(1),
    indate date
);
    

-----------------------------------------------
insert into tb_zipcode values ('1234567', '서울','종로','인사','3');
insert into tb_zipcode values ('1234568', '서울','종로','인사','4');
insert into tb_zipcode values ('1234569', '서울','종로','인사','5');
insert into tb_zipcode values ('1234570', '서울','종로','인사','6');
insert into tb_zipcode values ('1234571', '서울','종로','인사','7');

select * from tb_zipcode;

insert into member values ('aaaaa', '1234','qwer','1234567','서울시 종로구', '010-1111-1111', '20/12/01' );
insert into member values ('bbbbb', '1234','qwer','1234567','서울시 강북구', '010-1111-2222', '20/12/02' );
insert into member values ('ccccc', '1234','qwer','1234567','서울시 성북구', '010-1111-3333', '20/12/03' );
insert into member values ('ddddd', '1234','qwer','1234567','서울시 노원구', '010-1111-4444', '20/12/04' );
insert into member values ('eeeee', '1234','qwer','1234567','서울시 동대문', '010-1111-5555', default );

select * from member;

insert into products values('00000-00001', '상품1', 'A', '500','600' ,'상품1이다.', '상품1이미지', '01', '02', '50', 'o', '20/12/01');
insert into products values('00000-00002', '상품2', 'B', '600','700' ,'상품2이다.', '상품2이미지', '02', '03', '60', 'o', '20/12/01');
insert into products values('00000-00003', '상품3', 'C', '700','800' ,'상품3이다.', '상품3이미지', '03', '04', '70', 'o', '20/12/01');
insert into products values('00000-00004', '상품4', 'D', '800','900' ,'상품4이다.', '상품4이미지', '04', '05', '80', 'o', '20/12/01');
insert into products values('00000-00005', '상품5', 'E', '900','1000' ,'상품5이다.', '상품5이미지', '05', '06', '90', 'o', default);

select * from products;

insert into orders values (0000000001, '00000-00001', 'aaaaa','10','50','y','20/11/01');
insert into orders values (0000000002, '00000-00002', 'bbbbb','20','50','n','20/11/02');
insert into orders values (0000000003, '00000-00003', 'ccccc','30','50','n','20/11/03');
insert into orders values (0000000004, '00000-00004', 'ddddd','40','50','y','20/11/04');
insert into orders values (0000000005, '00000-00005', 'eeeee','50','50','y',default);

select * from orders;











