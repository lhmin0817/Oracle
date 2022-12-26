
CREATE TABLE orders
(
	product_code         varchar2(20) NOT NULL ,
	ID                   varchar2(20) NOT NULL ,
	o_seq                number(10) NOT NULL ,
	product_size         varchar2(5) NULL ,
	quantiy              varchar2(20) NULL ,
	result               CHAR(1) NULL ,
	indate               date DEFAULT  sysdate  NULL 
);



CREATE UNIQUE INDEX XPK주문 ON orders
(o_seq   ASC);



ALTER TABLE orders
	ADD CONSTRAINT  XPK주문 PRIMARY KEY (o_seq);



CREATE TABLE orders
(
	ID                   varchar2(20) NOT NULL ,
	pwd                  varchar2(20) NULL ,
	name                 varchar2(50) NULL ,
	address              varchar2(20) NULL ,
	tell                 varchar2(13) NULL ,
	indate               date DEFAULT  sysdate  NULL ,
	zipcode              varchar2(7) NULL 
);



CREATE UNIQUE INDEX XPK회원 ON orders
(ID   ASC);



ALTER TABLE orders
	ADD CONSTRAINT  XPK회원 PRIMARY KEY (ID);



CREATE TABLE products
(
	product_code         varchar2(20) NOT NULL ,
	product_name         varchar2(20) NULL ,
	product_kind         CHAR(1) NULL ,
	product_price1       varchar2(10) NULL ,
	product_price2       varchar2(10) NULL ,
	product_content      varchar2(1000) NULL ,
	product_image        varchar2(50) NULL ,
	size_St              varchar2(5) NULL ,
	size_Et              varchar2(5) NULL ,
	product_quantiy      varchar2(5) NULL ,
	userYN               CHAR(1) NULL ,
	indate               date DEFAULT  sysdate  NULL 
);



CREATE UNIQUE INDEX XPK상품 ON products
(product_code   ASC);



ALTER TABLE products
	ADD CONSTRAINT  XPK상품 PRIMARY KEY (product_code);



CREATE TABLE tb_zipcode
(
	zipcode              varchar2(7) NOT NULL ,
	sido                 varchar2(30) NULL ,
	gugun                varchar2(30) NULL ,
	dong                 varchar2(30) NULL ,
	bungi                varchar2(30) NULL 
);



CREATE UNIQUE INDEX XPK우편번호 ON tb_zipcode
(zipcode   ASC);



ALTER TABLE tb_zipcode
	ADD CONSTRAINT  XPK우편번호 PRIMARY KEY (zipcode);



ALTER TABLE orders
	ADD (CONSTRAINT R_2 FOREIGN KEY (product_code) REFERENCES products (product_code));



ALTER TABLE orders
	ADD (CONSTRAINT R_4 FOREIGN KEY (ID) REFERENCES orders (ID));



ALTER TABLE orders
	ADD (CONSTRAINT R_6 FOREIGN KEY (zipcode) REFERENCES tb_zipcode (zipcode) ON DELETE SET NULL);



CREATE  TRIGGER tI_orders BEFORE INSERT ON orders for each row
-- ERwin Builtin Trigger
-- INSERT trigger on orders 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* products  orders on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0001e0e2", PARENT_OWNER="", PARENT_TABLE="products"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="product_code" */
    SELECT count(*) INTO NUMROWS
      FROM products
      WHERE
        /* %JoinFKPK(:%New,products," = "," AND") */
        :new.product_code = products.product_code;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert orders because products does not exist.'
      );
    END IF;

    /* ERwin Builtin Trigger */
    /* orders  orders on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="orders"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="ID" */
    SELECT count(*) INTO NUMROWS
      FROM orders
      WHERE
        /* %JoinFKPK(:%New,orders," = "," AND") */
        :new.ID = orders.ID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert orders because orders does not exist.'
      );
    END IF;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER tU_orders AFTER UPDATE ON orders for each row
-- ERwin Builtin Trigger
-- UPDATE trigger on orders 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Trigger */
  /* products  orders on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0001da30", PARENT_OWNER="", PARENT_TABLE="products"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="product_code" */
  SELECT count(*) INTO NUMROWS
    FROM products
    WHERE
      /* %JoinFKPK(:%New,products," = "," AND") */
      :new.product_code = products.product_code;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update orders because products does not exist.'
    );
  END IF;

  /* ERwin Builtin Trigger */
  /* orders  orders on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="orders"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="ID" */
  SELECT count(*) INTO NUMROWS
    FROM orders
    WHERE
      /* %JoinFKPK(:%New,orders," = "," AND") */
      :new.ID = orders.ID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update orders because orders does not exist.'
    );
  END IF;


-- ERwin Builtin Trigger
END;
/


CREATE  TRIGGER tI_orders BEFORE INSERT ON orders for each row
-- ERwin Builtin Trigger
-- INSERT trigger on orders 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* tb_zipcode  orders on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="0000e0e1", PARENT_OWNER="", PARENT_TABLE="tb_zipcode"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="zipcode" */
    UPDATE orders
      SET
        /* %SetFK(orders,NULL) */
        orders.zipcode = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM tb_zipcode
            WHERE
              /* %JoinFKPK(:%New,tb_zipcode," = "," AND") */
              :new.zipcode = tb_zipcode.zipcode
        ) 
        /* %JoinPKPK(orders,:%New," = "," AND") */
         and orders.ID = :new.ID;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER  tD_orders AFTER DELETE ON orders for each row
-- ERwin Builtin Trigger
-- DELETE trigger on orders 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* orders  orders on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000bc28", PARENT_OWNER="", PARENT_TABLE="orders"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="ID" */
    SELECT count(*) INTO NUMROWS
      FROM orders
      WHERE
        /*  %JoinFKPK(orders,:%Old," = "," AND") */
        orders.ID = :old.ID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete orders because orders exists.'
      );
    END IF;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER tU_orders AFTER UPDATE ON orders for each row
-- ERwin Builtin Trigger
-- UPDATE trigger on orders 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Trigger */
  /* orders  orders on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="0001f2f8", PARENT_OWNER="", PARENT_TABLE="orders"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="ID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.ID <> :new.ID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM orders
      WHERE
        /*  %JoinFKPK(orders,:%Old," = "," AND") */
        orders.ID = :old.ID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update orders because orders exists.'
      );
    END IF;
  END IF;

  /* ERwin Builtin Trigger */
  /* tb_zipcode  orders on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="tb_zipcode"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="zipcode" */
  SELECT count(*) INTO NUMROWS
    FROM tb_zipcode
    WHERE
      /* %JoinFKPK(:%New,tb_zipcode," = "," AND") */
      :new.zipcode = tb_zipcode.zipcode;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.zipcode IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update orders because tb_zipcode does not exist.'
    );
  END IF;


-- ERwin Builtin Trigger
END;
/


CREATE  TRIGGER  tD_products AFTER DELETE ON products for each row
-- ERwin Builtin Trigger
-- DELETE trigger on products 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* products  orders on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000da62", PARENT_OWNER="", PARENT_TABLE="products"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="product_code" */
    SELECT count(*) INTO NUMROWS
      FROM orders
      WHERE
        /*  %JoinFKPK(orders,:%Old," = "," AND") */
        orders.product_code = :old.product_code;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete products because orders exists.'
      );
    END IF;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER tU_products AFTER UPDATE ON products for each row
-- ERwin Builtin Trigger
-- UPDATE trigger on products 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Trigger */
  /* products  orders on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00010678", PARENT_OWNER="", PARENT_TABLE="products"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="product_code" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.product_code <> :new.product_code
  THEN
    SELECT count(*) INTO NUMROWS
      FROM orders
      WHERE
        /*  %JoinFKPK(orders,:%Old," = "," AND") */
        orders.product_code = :old.product_code;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update products because orders exists.'
      );
    END IF;
  END IF;


-- ERwin Builtin Trigger
END;
/


CREATE  TRIGGER  tD_tb_zipcode AFTER DELETE ON tb_zipcode for each row
-- ERwin Builtin Trigger
-- DELETE trigger on tb_zipcode 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* tb_zipcode  orders on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000aaa7", PARENT_OWNER="", PARENT_TABLE="tb_zipcode"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="zipcode" */
    UPDATE orders
      SET
        /* %SetFK(orders,NULL) */
        orders.zipcode = NULL
      WHERE
        /* %JoinFKPK(orders,:%Old," = "," AND") */
        orders.zipcode = :old.zipcode;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER tU_tb_zipcode AFTER UPDATE ON tb_zipcode for each row
-- ERwin Builtin Trigger
-- UPDATE trigger on tb_zipcode 
DECLARE NUMROWS INTEGER;
BEGIN
  /* tb_zipcode  orders on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0000d042", PARENT_OWNER="", PARENT_TABLE="tb_zipcode"
    CHILD_OWNER="", CHILD_TABLE="orders"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="zipcode" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.zipcode <> :new.zipcode
  THEN
    UPDATE orders
      SET
        /* %SetFK(orders,NULL) */
        orders.zipcode = NULL
      WHERE
        /* %JoinFKPK(orders,:%Old," = ",",") */
        orders.zipcode = :old.zipcode;
  END IF;


-- ERwin Builtin Trigger
END;
/
