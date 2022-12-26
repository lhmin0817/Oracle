
CREATE TABLE grade_pt_rade
(
	mem_grade            varchar2(20) NOT NULL ,
	grade_pt_rate        number(3,2) NULL 
);



CREATE UNIQUE INDEX XPK회원등급 ON grade_pt_rade
(mem_grade   ASC);



ALTER TABLE grade_pt_rade
	ADD CONSTRAINT  XPK회원등급 PRIMARY KEY (mem_grade);



CREATE TABLE manager
(
	manager_id           VARCHAR2(30) NOT NULL ,
	manager_pwd          VARCHAR2(20) NOT NULL ,
	manager_tel          VARCHAR2(20) NULL 
);



CREATE UNIQUE INDEX XPK직원 ON manager
(manager_id   ASC);



ALTER TABLE manager
	ADD CONSTRAINT  XPK직원 PRIMARY KEY (manager_id);



CREATE TABLE member
(
	mem_id               varchar2(6) NOT NULL ,
	mem_grade            varchar2(20) NULL ,
	mem_pw               varchar2(20) NOT NULL ,
	mem_birth            date DEFAULT  sysdate  NOT NULL ,
	mem_tel              varchar2(20) NULL ,
	mem_pt               varchar2(10) NOT NULL 
);



CREATE UNIQUE INDEX XPK회원 ON member
(mem_id   ASC);



ALTER TABLE member
	ADD CONSTRAINT  XPK회원 PRIMARY KEY (mem_id);



CREATE TABLE nation
(
	nation_code          varchar2(26) NOT NULL ,
	nation_name          varchar2(50) NOT NULL 
);



CREATE UNIQUE INDEX XPK국가 ON nation
(nation_code   ASC);



ALTER TABLE nation
	ADD CONSTRAINT  XPK국가 PRIMARY KEY (nation_code);



CREATE TABLE sale
(
	sale_date            DATE DEFAULT  sysdate  NOT NULL ,
	wine_code            varchar2(6) NOT NULL ,
	mem_id               varchar2(30) NOT NULL ,
	sale_amount          varchar2(5) NOT NULL ,
	sale_price           varchar2(6) NOT NULL ,
	sale_tot_price       varchar2(15) NOT NULL 
);



CREATE UNIQUE INDEX XPK판매 ON sale
(sale_date   ASC);



ALTER TABLE sale
	ADD CONSTRAINT  XPK판매 PRIMARY KEY (sale_date);



CREATE TABLE stock_mamagement
(
	stock_code           VARCHAR2(6) NOT NULL ,
	wine_code            varchar2(26) NULL ,
	manager_id           VARCHAR2(30) NULL ,
	ware_date            date DEFAULT  sysdate  NOT NULL ,
	stock_amount         NUMBER(5) NOT NULL 
);



CREATE UNIQUE INDEX XPK재고관리 ON stock_mamagement
(stock_code   ASC);



ALTER TABLE stock_mamagement
	ADD CONSTRAINT  XPK재고관리 PRIMARY KEY (stock_code);



CREATE TABLE theme
(
	theme_code           VARCHAR2(6) NOT NULL ,
	theme_name           VARCHAR2(50) NOT NULL 
);



CREATE UNIQUE INDEX XPK테마 ON theme
(theme_code   ASC);



ALTER TABLE theme
	ADD CONSTRAINT  XPK테마 PRIMARY KEY (theme_code);



CREATE TABLE today
(
	today_code           varchar2(6) NOT NULL ,
	today_sens_value     NUMBER(3) NULL ,
	today_intell_value   NUMBER(3) NULL ,
	today_phy_value      NUMBER(3) NULL 
);



CREATE UNIQUE INDEX XPK오늘 ON today
(today_code   ASC);



ALTER TABLE today
	ADD CONSTRAINT  XPK오늘 PRIMARY KEY (today_code);



CREATE TABLE wine
(
	wine_code            varchar2(26) NOT NULL ,
	wine_name            VARCHAR2(100) NOT NULL ,
	wine_url             blob NULL ,
	wine_type_code       VARCHAR2(6) NULL ,
	wine_sugar_code      NUMBER(2) NULL ,
	wine_price           NUMBER(15) NULL ,
	wine_vintage         DATE DEFAULT  sysdate  NULL ,
	theme_code           VARCHAR2(6) NULL ,
	today_code           varchar2(6) NULL ,
	nation_code          varchar2(26) NULL 
);



CREATE UNIQUE INDEX XPK와인 ON wine
(wine_code   ASC);



ALTER TABLE wine
	ADD CONSTRAINT  XPK와인 PRIMARY KEY (wine_code);



CREATE TABLE wine_type
(
	wine_type_code       VARCHAR2(6) NOT NULL ,
	wine_type_name       VARCHAR2(50) NULL 
);



CREATE UNIQUE INDEX XPK와인타입 ON wine_type
(wine_type_code   ASC);



ALTER TABLE wine_type
	ADD CONSTRAINT  XPK와인타입 PRIMARY KEY (wine_type_code);



ALTER TABLE member
	ADD (CONSTRAINT R_9 FOREIGN KEY (mem_grade) REFERENCES grade_pt_rade (mem_grade) ON DELETE SET NULL);



ALTER TABLE sale
	ADD (CONSTRAINT R_6 FOREIGN KEY (mem_id) REFERENCES member (mem_id) ON DELETE SET NULL);



ALTER TABLE sale
	ADD (CONSTRAINT R_8 FOREIGN KEY (wine_code) REFERENCES wine (wine_code) ON DELETE SET NULL);



ALTER TABLE stock_mamagement
	ADD (CONSTRAINT R_18 FOREIGN KEY (wine_code) REFERENCES wine (wine_code) ON DELETE SET NULL);



ALTER TABLE stock_mamagement
	ADD (CONSTRAINT R_19 FOREIGN KEY (manager_id) REFERENCES manager (manager_id) ON DELETE SET NULL);



ALTER TABLE wine
	ADD (CONSTRAINT R_11 FOREIGN KEY (nation_code) REFERENCES nation (nation_code) ON DELETE SET NULL);



ALTER TABLE wine
	ADD (CONSTRAINT R_13 FOREIGN KEY (theme_code) REFERENCES theme (theme_code) ON DELETE SET NULL);



ALTER TABLE wine
	ADD (CONSTRAINT R_14 FOREIGN KEY (today_code) REFERENCES today (today_code) ON DELETE SET NULL);



ALTER TABLE wine
	ADD (CONSTRAINT R_16 FOREIGN KEY (wine_type_code) REFERENCES wine_type (wine_type_code) ON DELETE SET NULL);



CREATE  TRIGGER  tD_grade_pt_rade AFTER DELETE ON grade_pt_rade for each row
-- ERwin Builtin Trigger
-- DELETE trigger on grade_pt_rade 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* grade_pt_rade  member on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000ae71", PARENT_OWNER="", PARENT_TABLE="grade_pt_rade"
    CHILD_OWNER="", CHILD_TABLE="member"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="mem_grade" */
    UPDATE member
      SET
        /* %SetFK(member,NULL) */
        member.mem_grade = NULL
      WHERE
        /* %JoinFKPK(member,:%Old," = "," AND") */
        member.mem_grade = :old.mem_grade;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER tU_grade_pt_rade AFTER UPDATE ON grade_pt_rade for each row
-- ERwin Builtin Trigger
-- UPDATE trigger on grade_pt_rade 
DECLARE NUMROWS INTEGER;
BEGIN
  /* grade_pt_rade  member on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0000d134", PARENT_OWNER="", PARENT_TABLE="grade_pt_rade"
    CHILD_OWNER="", CHILD_TABLE="member"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="mem_grade" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.mem_grade <> :new.mem_grade
  THEN
    UPDATE member
      SET
        /* %SetFK(member,NULL) */
        member.mem_grade = NULL
      WHERE
        /* %JoinFKPK(member,:%Old," = ",",") */
        member.mem_grade = :old.mem_grade;
  END IF;


-- ERwin Builtin Trigger
END;
/


CREATE  TRIGGER  tD_manager AFTER DELETE ON manager for each row
-- ERwin Builtin Trigger
-- DELETE trigger on manager 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* manager  stock_mamagement on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000caeb", PARENT_OWNER="", PARENT_TABLE="manager"
    CHILD_OWNER="", CHILD_TABLE="stock_mamagement"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_19", FK_COLUMNS="manager_id" */
    UPDATE stock_mamagement
      SET
        /* %SetFK(stock_mamagement,NULL) */
        stock_mamagement.manager_id = NULL
      WHERE
        /* %JoinFKPK(stock_mamagement,:%Old," = "," AND") */
        stock_mamagement.manager_id = :old.manager_id;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER tU_manager AFTER UPDATE ON manager for each row
-- ERwin Builtin Trigger
-- UPDATE trigger on manager 
DECLARE NUMROWS INTEGER;
BEGIN
  /* manager  stock_mamagement on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0000f02d", PARENT_OWNER="", PARENT_TABLE="manager"
    CHILD_OWNER="", CHILD_TABLE="stock_mamagement"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_19", FK_COLUMNS="manager_id" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.manager_id <> :new.manager_id
  THEN
    UPDATE stock_mamagement
      SET
        /* %SetFK(stock_mamagement,NULL) */
        stock_mamagement.manager_id = NULL
      WHERE
        /* %JoinFKPK(stock_mamagement,:%Old," = ",",") */
        stock_mamagement.manager_id = :old.manager_id;
  END IF;


-- ERwin Builtin Trigger
END;
/


CREATE  TRIGGER tI_member BEFORE INSERT ON member for each row
-- ERwin Builtin Trigger
-- INSERT trigger on member 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* grade_pt_rade  member on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="0000dfdc", PARENT_OWNER="", PARENT_TABLE="grade_pt_rade"
    CHILD_OWNER="", CHILD_TABLE="member"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="mem_grade" */
    UPDATE member
      SET
        /* %SetFK(member,NULL) */
        member.mem_grade = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM grade_pt_rade
            WHERE
              /* %JoinFKPK(:%New,grade_pt_rade," = "," AND") */
              :new.mem_grade = grade_pt_rade.mem_grade
        ) 
        /* %JoinPKPK(member,:%New," = "," AND") */
         and member.mem_id = :new.mem_id;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER  tD_member AFTER DELETE ON member for each row
-- ERwin Builtin Trigger
-- DELETE trigger on member 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* member  sale on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000a59a", PARENT_OWNER="", PARENT_TABLE="member"
    CHILD_OWNER="", CHILD_TABLE="sale"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="mem_id" */
    UPDATE sale
      SET
        /* %SetFK(sale,NULL) */
        sale.mem_id = NULL
      WHERE
        /* %JoinFKPK(sale,:%Old," = "," AND") */
        sale.mem_id = :old.mem_id;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER tU_member AFTER UPDATE ON member for each row
-- ERwin Builtin Trigger
-- UPDATE trigger on member 
DECLARE NUMROWS INTEGER;
BEGIN
  /* member  sale on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0001e3f6", PARENT_OWNER="", PARENT_TABLE="member"
    CHILD_OWNER="", CHILD_TABLE="sale"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="mem_id" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.mem_id <> :new.mem_id
  THEN
    UPDATE sale
      SET
        /* %SetFK(sale,NULL) */
        sale.mem_id = NULL
      WHERE
        /* %JoinFKPK(sale,:%Old," = ",",") */
        sale.mem_id = :old.mem_id;
  END IF;

  /* ERwin Builtin Trigger */
  /* grade_pt_rade  member on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="grade_pt_rade"
    CHILD_OWNER="", CHILD_TABLE="member"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="mem_grade" */
  SELECT count(*) INTO NUMROWS
    FROM grade_pt_rade
    WHERE
      /* %JoinFKPK(:%New,grade_pt_rade," = "," AND") */
      :new.mem_grade = grade_pt_rade.mem_grade;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.mem_grade IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update member because grade_pt_rade does not exist.'
    );
  END IF;


-- ERwin Builtin Trigger
END;
/


CREATE  TRIGGER  tD_nation AFTER DELETE ON nation for each row
-- ERwin Builtin Trigger
-- DELETE trigger on nation 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* nation  wine on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000adc4", PARENT_OWNER="", PARENT_TABLE="nation"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_11", FK_COLUMNS="nation_code" */
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.nation_code = NULL
      WHERE
        /* %JoinFKPK(wine,:%Old," = "," AND") */
        wine.nation_code = :old.nation_code;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER tU_nation AFTER UPDATE ON nation for each row
-- ERwin Builtin Trigger
-- UPDATE trigger on nation 
DECLARE NUMROWS INTEGER;
BEGIN
  /* nation  wine on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0000cfce", PARENT_OWNER="", PARENT_TABLE="nation"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_11", FK_COLUMNS="nation_code" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.nation_code <> :new.nation_code
  THEN
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.nation_code = NULL
      WHERE
        /* %JoinFKPK(wine,:%Old," = ",",") */
        wine.nation_code = :old.nation_code;
  END IF;


-- ERwin Builtin Trigger
END;
/


CREATE  TRIGGER tI_sale BEFORE INSERT ON sale for each row
-- ERwin Builtin Trigger
-- INSERT trigger on sale 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* member  sale on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="0001c178", PARENT_OWNER="", PARENT_TABLE="member"
    CHILD_OWNER="", CHILD_TABLE="sale"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="mem_id" */
    UPDATE sale
      SET
        /* %SetFK(sale,NULL) */
        sale.mem_id = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM member
            WHERE
              /* %JoinFKPK(:%New,member," = "," AND") */
              :new.mem_id = member.mem_id
        ) 
        /* %JoinPKPK(sale,:%New," = "," AND") */
         and sale.sale_date = :new.sale_date;

    /* ERwin Builtin Trigger */
    /* wine  sale on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="wine"
    CHILD_OWNER="", CHILD_TABLE="sale"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="wine_code" */
    UPDATE sale
      SET
        /* %SetFK(sale,NULL) */
        sale.wine_code = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM wine
            WHERE
              /* %JoinFKPK(:%New,wine," = "," AND") */
              :new.wine_code = wine.wine_code
        ) 
        /* %JoinPKPK(sale,:%New," = "," AND") */
         and sale.sale_date = :new.sale_date;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER tU_sale AFTER UPDATE ON sale for each row
-- ERwin Builtin Trigger
-- UPDATE trigger on sale 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Trigger */
  /* member  sale on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001e1c1", PARENT_OWNER="", PARENT_TABLE="member"
    CHILD_OWNER="", CHILD_TABLE="sale"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="mem_id" */
  SELECT count(*) INTO NUMROWS
    FROM member
    WHERE
      /* %JoinFKPK(:%New,member," = "," AND") */
      :new.mem_id = member.mem_id;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.mem_id IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update sale because member does not exist.'
    );
  END IF;

  /* ERwin Builtin Trigger */
  /* wine  sale on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="wine"
    CHILD_OWNER="", CHILD_TABLE="sale"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="wine_code" */
  SELECT count(*) INTO NUMROWS
    FROM wine
    WHERE
      /* %JoinFKPK(:%New,wine," = "," AND") */
      :new.wine_code = wine.wine_code;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.wine_code IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update sale because wine does not exist.'
    );
  END IF;


-- ERwin Builtin Trigger
END;
/


CREATE  TRIGGER tI_stock_mamagement BEFORE INSERT ON stock_mamagement for each row
-- ERwin Builtin Trigger
-- INSERT trigger on stock_mamagement 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* wine  stock_mamagement on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="000213c8", PARENT_OWNER="", PARENT_TABLE="wine"
    CHILD_OWNER="", CHILD_TABLE="stock_mamagement"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_18", FK_COLUMNS="wine_code" */
    UPDATE stock_mamagement
      SET
        /* %SetFK(stock_mamagement,NULL) */
        stock_mamagement.wine_code = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM wine
            WHERE
              /* %JoinFKPK(:%New,wine," = "," AND") */
              :new.wine_code = wine.wine_code
        ) 
        /* %JoinPKPK(stock_mamagement,:%New," = "," AND") */
         and stock_mamagement.stock_code = :new.stock_code;

    /* ERwin Builtin Trigger */
    /* manager  stock_mamagement on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="manager"
    CHILD_OWNER="", CHILD_TABLE="stock_mamagement"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_19", FK_COLUMNS="manager_id" */
    UPDATE stock_mamagement
      SET
        /* %SetFK(stock_mamagement,NULL) */
        stock_mamagement.manager_id = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM manager
            WHERE
              /* %JoinFKPK(:%New,manager," = "," AND") */
              :new.manager_id = manager.manager_id
        ) 
        /* %JoinPKPK(stock_mamagement,:%New," = "," AND") */
         and stock_mamagement.stock_code = :new.stock_code;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER tU_stock_mamagement AFTER UPDATE ON stock_mamagement for each row
-- ERwin Builtin Trigger
-- UPDATE trigger on stock_mamagement 
DECLARE NUMROWS INTEGER;
BEGIN
  /* ERwin Builtin Trigger */
  /* wine  stock_mamagement on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00021c0f", PARENT_OWNER="", PARENT_TABLE="wine"
    CHILD_OWNER="", CHILD_TABLE="stock_mamagement"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_18", FK_COLUMNS="wine_code" */
  SELECT count(*) INTO NUMROWS
    FROM wine
    WHERE
      /* %JoinFKPK(:%New,wine," = "," AND") */
      :new.wine_code = wine.wine_code;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.wine_code IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update stock_mamagement because wine does not exist.'
    );
  END IF;

  /* ERwin Builtin Trigger */
  /* manager  stock_mamagement on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="manager"
    CHILD_OWNER="", CHILD_TABLE="stock_mamagement"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_19", FK_COLUMNS="manager_id" */
  SELECT count(*) INTO NUMROWS
    FROM manager
    WHERE
      /* %JoinFKPK(:%New,manager," = "," AND") */
      :new.manager_id = manager.manager_id;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.manager_id IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update stock_mamagement because manager does not exist.'
    );
  END IF;


-- ERwin Builtin Trigger
END;
/


CREATE  TRIGGER  tD_theme AFTER DELETE ON theme for each row
-- ERwin Builtin Trigger
-- DELETE trigger on theme 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* theme  wine on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000a12d", PARENT_OWNER="", PARENT_TABLE="theme"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="theme_code" */
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.theme_code = NULL
      WHERE
        /* %JoinFKPK(wine,:%Old," = "," AND") */
        wine.theme_code = :old.theme_code;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER tU_theme AFTER UPDATE ON theme for each row
-- ERwin Builtin Trigger
-- UPDATE trigger on theme 
DECLARE NUMROWS INTEGER;
BEGIN
  /* theme  wine on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0000d1d4", PARENT_OWNER="", PARENT_TABLE="theme"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="theme_code" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.theme_code <> :new.theme_code
  THEN
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.theme_code = NULL
      WHERE
        /* %JoinFKPK(wine,:%Old," = ",",") */
        wine.theme_code = :old.theme_code;
  END IF;


-- ERwin Builtin Trigger
END;
/


CREATE  TRIGGER  tD_today AFTER DELETE ON today for each row
-- ERwin Builtin Trigger
-- DELETE trigger on today 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* today  wine on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000b03d", PARENT_OWNER="", PARENT_TABLE="today"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="today_code" */
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.today_code = NULL
      WHERE
        /* %JoinFKPK(wine,:%Old," = "," AND") */
        wine.today_code = :old.today_code;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER tU_today AFTER UPDATE ON today for each row
-- ERwin Builtin Trigger
-- UPDATE trigger on today 
DECLARE NUMROWS INTEGER;
BEGIN
  /* today  wine on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0000cda5", PARENT_OWNER="", PARENT_TABLE="today"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="today_code" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.today_code <> :new.today_code
  THEN
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.today_code = NULL
      WHERE
        /* %JoinFKPK(wine,:%Old," = ",",") */
        wine.today_code = :old.today_code;
  END IF;


-- ERwin Builtin Trigger
END;
/


CREATE  TRIGGER tI_wine BEFORE INSERT ON wine for each row
-- ERwin Builtin Trigger
-- INSERT trigger on wine 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* nation  wine on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="0003b06f", PARENT_OWNER="", PARENT_TABLE="nation"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_11", FK_COLUMNS="nation_code" */
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.nation_code = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM nation
            WHERE
              /* %JoinFKPK(:%New,nation," = "," AND") */
              :new.nation_code = nation.nation_code
        ) 
        /* %JoinPKPK(wine,:%New," = "," AND") */
         and wine.wine_code = :new.wine_code;

    /* ERwin Builtin Trigger */
    /* theme  wine on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="theme"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="theme_code" */
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.theme_code = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM theme
            WHERE
              /* %JoinFKPK(:%New,theme," = "," AND") */
              :new.theme_code = theme.theme_code
        ) 
        /* %JoinPKPK(wine,:%New," = "," AND") */
         and wine.wine_code = :new.wine_code;

    /* ERwin Builtin Trigger */
    /* today  wine on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="today"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="today_code" */
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.today_code = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM today
            WHERE
              /* %JoinFKPK(:%New,today," = "," AND") */
              :new.today_code = today.today_code
        ) 
        /* %JoinPKPK(wine,:%New," = "," AND") */
         and wine.wine_code = :new.wine_code;

    /* ERwin Builtin Trigger */
    /* wine_type  wine on child insert set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="wine_type"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="wine_type_code" */
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.wine_type_code = NULL
      WHERE
        NOT EXISTS (
          SELECT * FROM wine_type
            WHERE
              /* %JoinFKPK(:%New,wine_type," = "," AND") */
              :new.wine_type_code = wine_type.wine_type_code
        ) 
        /* %JoinPKPK(wine,:%New," = "," AND") */
         and wine.wine_code = :new.wine_code;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER  tD_wine AFTER DELETE ON wine for each row
-- ERwin Builtin Trigger
-- DELETE trigger on wine 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* wine  sale on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0001862d", PARENT_OWNER="", PARENT_TABLE="wine"
    CHILD_OWNER="", CHILD_TABLE="sale"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="wine_code" */
    UPDATE sale
      SET
        /* %SetFK(sale,NULL) */
        sale.wine_code = NULL
      WHERE
        /* %JoinFKPK(sale,:%Old," = "," AND") */
        sale.wine_code = :old.wine_code;

    /* ERwin Builtin Trigger */
    /* wine  stock_mamagement on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="wine"
    CHILD_OWNER="", CHILD_TABLE="stock_mamagement"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_18", FK_COLUMNS="wine_code" */
    UPDATE stock_mamagement
      SET
        /* %SetFK(stock_mamagement,NULL) */
        stock_mamagement.wine_code = NULL
      WHERE
        /* %JoinFKPK(stock_mamagement,:%Old," = "," AND") */
        stock_mamagement.wine_code = :old.wine_code;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER tU_wine AFTER UPDATE ON wine for each row
-- ERwin Builtin Trigger
-- UPDATE trigger on wine 
DECLARE NUMROWS INTEGER;
BEGIN
  /* wine  sale on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0005eb95", PARENT_OWNER="", PARENT_TABLE="wine"
    CHILD_OWNER="", CHILD_TABLE="sale"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="wine_code" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.wine_code <> :new.wine_code
  THEN
    UPDATE sale
      SET
        /* %SetFK(sale,NULL) */
        sale.wine_code = NULL
      WHERE
        /* %JoinFKPK(sale,:%Old," = ",",") */
        sale.wine_code = :old.wine_code;
  END IF;

  /* wine  stock_mamagement on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="wine"
    CHILD_OWNER="", CHILD_TABLE="stock_mamagement"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_18", FK_COLUMNS="wine_code" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.wine_code <> :new.wine_code
  THEN
    UPDATE stock_mamagement
      SET
        /* %SetFK(stock_mamagement,NULL) */
        stock_mamagement.wine_code = NULL
      WHERE
        /* %JoinFKPK(stock_mamagement,:%Old," = ",",") */
        stock_mamagement.wine_code = :old.wine_code;
  END IF;

  /* ERwin Builtin Trigger */
  /* nation  wine on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="nation"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_11", FK_COLUMNS="nation_code" */
  SELECT count(*) INTO NUMROWS
    FROM nation
    WHERE
      /* %JoinFKPK(:%New,nation," = "," AND") */
      :new.nation_code = nation.nation_code;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.nation_code IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update wine because nation does not exist.'
    );
  END IF;

  /* ERwin Builtin Trigger */
  /* theme  wine on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="theme"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="theme_code" */
  SELECT count(*) INTO NUMROWS
    FROM theme
    WHERE
      /* %JoinFKPK(:%New,theme," = "," AND") */
      :new.theme_code = theme.theme_code;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.theme_code IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update wine because theme does not exist.'
    );
  END IF;

  /* ERwin Builtin Trigger */
  /* today  wine on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="today"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="today_code" */
  SELECT count(*) INTO NUMROWS
    FROM today
    WHERE
      /* %JoinFKPK(:%New,today," = "," AND") */
      :new.today_code = today.today_code;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.today_code IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update wine because today does not exist.'
    );
  END IF;

  /* ERwin Builtin Trigger */
  /* wine_type  wine on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="wine_type"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="wine_type_code" */
  SELECT count(*) INTO NUMROWS
    FROM wine_type
    WHERE
      /* %JoinFKPK(:%New,wine_type," = "," AND") */
      :new.wine_type_code = wine_type.wine_type_code;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    :new.wine_type_code IS NOT NULL AND
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update wine because wine_type does not exist.'
    );
  END IF;


-- ERwin Builtin Trigger
END;
/


CREATE  TRIGGER  tD_wine_type AFTER DELETE ON wine_type for each row
-- ERwin Builtin Trigger
-- DELETE trigger on wine_type 
DECLARE NUMROWS INTEGER;
BEGIN
    /* ERwin Builtin Trigger */
    /* wine_type  wine on parent delete set null */
    /* ERWIN_RELATION:CHECKSUM="0000ab51", PARENT_OWNER="", PARENT_TABLE="wine_type"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="wine_type_code" */
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.wine_type_code = NULL
      WHERE
        /* %JoinFKPK(wine,:%Old," = "," AND") */
        wine.wine_type_code = :old.wine_type_code;


-- ERwin Builtin Trigger
END;
/

CREATE  TRIGGER tU_wine_type AFTER UPDATE ON wine_type for each row
-- ERwin Builtin Trigger
-- UPDATE trigger on wine_type 
DECLARE NUMROWS INTEGER;
BEGIN
  /* wine_type  wine on parent update set null */
  /* ERWIN_RELATION:CHECKSUM="0000daf5", PARENT_OWNER="", PARENT_TABLE="wine_type"
    CHILD_OWNER="", CHILD_TABLE="wine"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="wine_type_code" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.wine_type_code <> :new.wine_type_code
  THEN
    UPDATE wine
      SET
        /* %SetFK(wine,NULL) */
        wine.wine_type_code = NULL
      WHERE
        /* %JoinFKPK(wine,:%Old," = ",",") */
        wine.wine_type_code = :old.wine_type_code;
  END IF;


-- ERwin Builtin Trigger
END;
/

