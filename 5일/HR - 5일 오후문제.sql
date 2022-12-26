create table sale(
    sale_date date default sysdate constraint PK_SALE_SALE_DATE primary key ,
    wine_code varchar2(6),
    constraint FK_SALE_WINE_CODE foreign key (wine_code) references wine(wine_code),
    mem_id varchar2(30),
    constraint FK_SALE_MEM_ID foreign key (mem_id) references member(mem_id),
    sale_amount varchar2(5) unique,
    sale_price varchar2(6) unique,
    sale_tot_price varchar2(15) unique
);

create table member(
    mem_id varchar2(6) constraint PK_MEMBER_MEM_ID primary key,
    mem_grade varchar2(20),
    constraint FK_MEMBER_MEM_GRADE foreign key(mem_grade) references grade_pt_rade(mem_grade),
    mem_pw varchar2(20) unique,
    mem_birth date default sysdate unique,
    mem_tel varchar2(20),
    mem_pt varchar2(10) unique
);


create table grade_pt_rade(
    mem_grade varchar2(20) constraint PK_GRADE_PT_RADE_MEM_GRADE primary key,
    grade_pt_rate number(3,2)
);

create table today(
    today_code varchar2(6)constraint PK_TODAY_TODAY_CODE primary key,
    today_sens_value number (3),
    today_intell_value number (3),
    today_phy_value number (3)
);

create table nation(
    nation_code varchar2(26) constraint PK_NATION_NATION_CODE primary key,
    nation_name varchar2 (50) unique
);

create table wine(
    wine_code varchar2(26) constraint PK_WINE_WINE_CODE primary key,
    wine_name varchar2(100) unique,
    wine_url blob,
    nation_code varchar2(6),
    constraint FK_WINE_NATION_CODE foreign key(nation_code) references nation(nation_code),
    wine_type_code varchar2(6), 
    constraint FK_WINE_WINE_TYPE_CODE foreign key (wine_type_code) references wine_type(wine_type_code), 
    wine_sugar_code number(2),
    wine_price number(15) unique,
    wine_vintage date,
    theme_code varchar2(6),
    constraint FK_WINE_THEME_CODE foreign key (theme_code) references theme(theme_code),
    today_code varchar2(6),
    constraint FK_WINE_TODAY_CODE foreign key (today_code) references today(today_code)
);

create table theme(
    theme_code varchar2(6) constraint PK_THEME_THRME_CODE primary key,
    theme_name varchar2(6) unique
);

create table stock_mamagement(
    stock_code varchar2(6) constraint PK_STOCK_MAMAGEMENT_STOCK_CODE primary key,
    wine_code varchar2(6),
    constraint FK_STOCK_MAMAGEMENT_WINE_CODE foreign key (wine_code) references wine(wine_code),
    manager_id varchar2(30),
    constraint FK_STOCK_MAMAGEMENT_MANAGER_ID foreign key (manager_id) references manager(manager_id),
    ware_date date  unique,
    stock_amount number(5) unique
);

create table manager(
    manager_id varchar2(30) constraint PK_MANAGER_MANAGER_ID primary key,
    manager_pwd varchar2(20) unique,
    manager_tel varchar2(20)
);

create table wine_type(
    wine_type_code varchar2(6) constraint PK_WINE_TYPE_WINE_TYPE_CODE primary key,
    wine_type_name varchar2(50)
);


insert into sale values ('22/12/01', '00001','aaaa','50','4000','5000');
insert into sale values ('22/12/02', '00002','bbbb','50','4000','5000');
insert into sale values ('22/12/03', '00003','cccc','50','4000','5000');
insert into sale values (default, '00004','dddd','50','4000','5000');
insert into sale values (default, '00005','eeee','50','4000','5000');



insert into member values('aaaa','00000-0001','1234','95/08/17','010-0000-0000',0);
insert into member values('bbbb','00000-0002','1234','00/08/17','010-0000-1111',0);
insert into member values('cccc','00000-0003','1234','05/08/17','010-0000-2222',0);
insert into member values('dddd','00000-0004','1234','10/08/17','010-0000-3333',0);
insert into member values('eeee','00000-0005','1234',default,'010-0000-4444',0);



insert into grade_pt_rade values('00000-0001','1');
insert into grade_pt_rade values('00000-0002','2');
insert into grade_pt_rade values('00000-0003','3');
insert into grade_pt_rade values('00000-0004','4');
insert into grade_pt_rade values('00000-0005','5');



insert into today values('111111',10,20,30);
insert into today values('222222',10,20,30);
insert into today values('333333',10,20,30);
insert into today values('444444',10,20,30);
insert into today values('555555',10,20,30);



insert into nation values ('01','한국');
insert into nation values ('02','미국');
insert into nation values ('03','영국');
insert into nation values ('04','독일');
insert into nation values ('05','프랑스');



insert into wine values ('00001','A', null, '01','A1','1','400','81/02/13','ABC01','111111');
insert into wine values ('00002','B', null, '02','B1','2','500','86/03/13','ABC02','222222');
insert into wine values ('00003','C', null, '03','C1','3','600','91/04/13','ABC03','333333');
insert into wine values ('00004','D', null, '04','D1','4','700','96/05/13','ABC04','444444');
insert into wine values ('00005','E', null, '05','E1','5','800','20/06/13','ABC05','555555');



insert into theme values ('ABC01', '1');
insert into theme values ('ABC02', '2');
insert into theme values ('ABC03', '3');
insert into theme values ('ABC04', '4');
insert into theme values ('ABC05', '5');



insert into stock_mamagement values ('Aa0001','00001','AAAAA1','21/12/04','40');
insert into stock_mamagement values ('Bb0001','00002','BBBBB1','21/12/05','50');
insert into stock_mamagement values ('Cc0001','00003','CCCCC1','21/12/06','60');
insert into stock_mamagement values ('Dd0001','00004','DDDDD1','21/12/07','70');
insert into stock_mamagement values ('Ee0001','00005','EEEEE1',DEFAULT,'80');



insert into manager values ('AAAAA1','11111','010-1111-1111');
insert into manager values ('BBBBB1','22222','010-2222-1111');
insert into manager values ('CCCCC1','33333','010-3333-1111');
insert into manager values ('DDDDD1','44444',NULL);
insert into manager values ('EEEEE1','55555',NULL);



insert into wine_type values ('A1', 'wine1');
insert into wine_type values ('B1', 'wine2');
insert into wine_type values ('C1', 'wine3');
insert into wine_type values ('D1', 'wine4');
insert into wine_type values ('E1', 'wine5');






select * from sale;
select * from member;
select * from grade_pt_rade;
select * from today;
select * from nation;
select * from wine;
select * from theme;
select * from stock_mamagement;
select * from manager;
select * from wine_type;



