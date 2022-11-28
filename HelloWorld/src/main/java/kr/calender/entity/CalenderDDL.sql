DROP TABLE users CASCADE CONSTRAINTS;
DROP TABLE plan CASCADE CONSTRAINTS;
DROP TABLE place CASCADE CONSTRAINTS;
drop table member CASCADE CONSTRAINTS;


drop sequence user_no_seq;
drop sequence plan_id_seq;
drop sequence place_id_seq;
drop sequence member_no_seq;

CREATE TABLE place (
    place_id  NUMBER NOT NULL,
    plan_id NUMBER NOT NULL,
    latitude  VARCHAR2(40) NOT NULL,
    longitude VARCHAR2(40) NOT NULL,
    category  VARCHAR2(20),
    address   VARCHAR2(100),
    place_hp  VARCHAR2(20)
);

ALTER TABLE place ADD CONSTRAINT place_pk PRIMARY KEY ( place_id );

CREATE TABLE plan (
    plan_id     NUMBER NOT NULL,
    title       VARCHAR2(50) NOT NULL,
    member_no     NUMBER NOT NULL,
    start_date  DATE NOT NULL,
    end_date    DATE NOT NULL,
    description CLOB
);

ALTER TABLE plan ADD CONSTRAINT plan_pk PRIMARY KEY ( plan_id );

CREATE TABLE member (
    member_no    NUMBER NOT NULL,
    member_id    VARCHAR2(50) NOT NULL,
    member_pw    VARCHAR2(80) NOT NULL,
    member_name  VARCHAR2(30) NOT NULL,
    member_hp    VARCHAR2(20) NOT NULL,
    member_email VARCHAR2(80) NOT NULL
);

ALTER TABLE member ADD CONSTRAINT member_pk PRIMARY KEY ( member_no );

ALTER TABLE place
    ADD CONSTRAINT place_plan_fk FOREIGN KEY ( plan_id )
        REFERENCES plan ( plan_id );

ALTER TABLE plan
    ADD CONSTRAINT plan_member_fk FOREIGN KEY ( member_no )
        REFERENCES member ( member_no ) ON DELETE CASCADE;

ALTER TABLE member
	ADD CONSTRAINT member_id_uk UNIQUE(member_id);


CREATE SEQUENCE member_no_seq
	INCREMENT BY 1
	START WITH 0
	MINVALUE 0;

CREATE SEQUENCE plan_id_seq
	INCREMENT BY 1
	START WITH 1;

CREATE SEQUENCE place_id_seq
	INCREMENT BY 1
	START WITH 1;

INSERT INTO member VALUES (member_no_seq.NEXTVAL, 'administrator', '1234', '관리자', '01011112222', 'asdf@naver.com');



INSERT INTO member VALUES (member_no_seq.NEXTVAL, 'alsdbsrl', 'alsdbsrl123', '민윤기', '01011112222', 'alsdbsrl@naver.com');