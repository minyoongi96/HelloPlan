DROP TABLE users CASCADE CONSTRAINTS;
DROP TABLE plan CASCADE CONSTRAINTS;
DROP TABLE place CASCADE CONSTRAINTS;
drop table member CASCADE CONSTRAINTS;


drop sequence user_no_seq;
drop sequence plan_id_seq;
drop sequence place_id_seq;
drop sequence member_no_seq;


-- 테이블 순서는 관계를 고려하여 한 번에 실행해도 에러가 발생하지 않게 정렬되었습니다.

-- t_user Table Create SQL
CREATE TABLE t_user
(
    user_id          VARCHAR2(30)    NOT NULL, 
    user_pw          VARCHAR2(30)    NOT NULL, 
    user_nick        VARCHAR2(30)    NOT NULL, 
    user_hp          VARCHAR2(20)    NOT NULL, 
    user_email       VARCHAR2(60)    NOT NULL, 
    user_joindate    DATE            NOT NULL, 
    user_type        CHAR(1)         NOT NULL, 
     PRIMARY KEY (user_id)
)
/
select * from T_USER;
COMMENT ON TABLE t_user IS '회원 테이블'
/

COMMENT ON COLUMN t_user.user_id IS '회원 아이디'
/

COMMENT ON COLUMN t_user.user_pw IS '회원 비밀번호'
/

COMMENT ON COLUMN t_user.user_nick IS '회원 닉네임'
/

COMMENT ON COLUMN t_user.user_hp IS '회원 핸드폰'
/

COMMENT ON COLUMN t_user.user_email IS '회원 이메일'
/

COMMENT ON COLUMN t_user.user_joindate IS '회원 가입일자'
/

COMMENT ON COLUMN t_user.user_type IS '회원 유형. 회원 '' U'', 관리자 ''A'''
/


-- t_plan Table Create SQL
CREATE TABLE t_plan
(
    plan_seq       NUMBER(12, 0)     NOT NULL, 
    plan_title     VARCHAR2(400)     NOT NULL, 
    plan_s_date    DATE              NOT NULL, 
    plan_e_date    DATE              NOT NULL, 
    plan_desc      VARCHAR2(4000)    NOT NULL, 
    user_id        VARCHAR2(30)      NOT NULL, 
    plan_lat       NUMBER(17, 14)    NULL, 
    plan_lon       NUMBER(17, 14)    NULL, 
     PRIMARY KEY (plan_seq)
)
/

CREATE SEQUENCE t_plan_SEQ
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER t_plan_AI_TRG
BEFORE INSERT ON t_plan 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT t_plan_SEQ.NEXTVAL
    INTO :NEW.plan_seq
    FROM DUAL;
END;
/

--DROP TRIGGER t_plan_AI_TRG; /

--DROP SEQUENCE t_plan_SEQ; /

COMMENT ON TABLE t_plan IS '플랜'
/

COMMENT ON COLUMN t_plan.plan_seq IS '플랜 순번'
/

COMMENT ON COLUMN t_plan.plan_title IS '플랜 제목'
/

COMMENT ON COLUMN t_plan.plan_s_date IS '시작 일자'
/

COMMENT ON COLUMN t_plan.plan_e_date IS '종료 일자'
/

COMMENT ON COLUMN t_plan.plan_desc IS '플랜 내용'
/

COMMENT ON COLUMN t_plan.user_id IS '플랜 작성자'
/

COMMENT ON COLUMN t_plan.plan_lat IS '위도'
/

COMMENT ON COLUMN t_plan.plan_lon IS '경도'
/

ALTER TABLE t_plan
    ADD CONSTRAINT FK_t_plan_user_id_t_user_user_ FOREIGN KEY (user_id)
        REFERENCES t_user (user_id)
/


-- t_place Table Create SQL
CREATE TABLE t_place
(
    place_seq     NUMBER(12, 0)     NOT NULL, 
    place_name    VARCHAR2(30)      NULL, 
    latitude      NUMBER(17, 14)    NOT NULL, 
    longitude     NUMBER(17, 14)    NOT NULL, 
    address       VARCHAR2(400)     NOT NULL, 
    place_tel     VARCHAR2(20)      NOT NULL, 
    category      VARCHAR2(20)      NOT NULL, 
    photo1        VARCHAR2(400)     NULL, 
    photo2        VARCHAR2(400)     NULL, 
    photo3        VARCHAR2(400)     NULL, 
    photo4        VARCHAR2(400)     NULL, 
     PRIMARY KEY (place_seq)
)
/

CREATE SEQUENCE t_place_SEQ
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER t_place_AI_TRG
BEFORE INSERT ON t_place 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT t_place_SEQ.NEXTVAL
    INTO :NEW.place_seq
    FROM DUAL;
END;
/

--DROP TRIGGER t_place_AI_TRG; /

--DROP SEQUENCE t_place_SEQ; /

COMMENT ON TABLE t_place IS '플레이스'
/

COMMENT ON COLUMN t_place.place_seq IS '플레이스 순번'
/

COMMENT ON COLUMN t_place.place_name IS '플레이스 명'
/

COMMENT ON COLUMN t_place.latitude IS '위도'
/

COMMENT ON COLUMN t_place.longitude IS '경도'
/

COMMENT ON COLUMN t_place.address IS '주소'
/

COMMENT ON COLUMN t_place.place_tel IS '플레이스 전화번호'
/

COMMENT ON COLUMN t_place.category IS '카테고리'
/

COMMENT ON COLUMN t_place.photo1 IS '사진1'
/

COMMENT ON COLUMN t_place.photo2 IS '사진2'
/

COMMENT ON COLUMN t_place.photo3 IS '사진3'
/

COMMENT ON COLUMN t_place.photo4 IS '사진4'
/


-- t_recommendation Table Create SQL
CREATE TABLE t_recommendation
(
    reco_seq     NUMBER(12, 0)    NOT NULL, 
    plan_seq     NUMBER(12, 0)    NOT NULL, 
    place_seq    NUMBER(12, 0)    NOT NULL, 
    reco_date    DATE             NOT NULL, 
     PRIMARY KEY (reco_seq)
)
/

CREATE SEQUENCE t_recommendation_SEQ
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER t_recommendation_AI_TRG
BEFORE INSERT ON t_recommendation 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT t_recommendation_SEQ.NEXTVAL
    INTO :NEW.reco_seq
    FROM DUAL;
END;
/

--DROP TRIGGER t_recommendation_AI_TRG; /

--DROP SEQUENCE t_recommendation_SEQ; /

COMMENT ON TABLE t_recommendation IS '추천 장소'
/

COMMENT ON COLUMN t_recommendation.reco_seq IS '추천 순번'
/

COMMENT ON COLUMN t_recommendation.plan_seq IS '플랜 순번'
/

COMMENT ON COLUMN t_recommendation.place_seq IS '추천 플레이스 순번'
/

COMMENT ON COLUMN t_recommendation.reco_date IS '추천 날짜'
/

ALTER TABLE t_recommendation
    ADD CONSTRAINT FK_t_recommendation_place_seq_ FOREIGN KEY (place_seq)
        REFERENCES t_place (place_seq)
/

ALTER TABLE t_recommendation
    ADD CONSTRAINT FK_t_recommendation_plan_seq_t FOREIGN KEY (plan_seq)
        REFERENCES t_plan (plan_seq)
/


-- t_user_favs Table Create SQL
CREATE TABLE t_user_favs
(
    favs_seq     NUMBER(12, 0)    NOT NULL, 
    user_id      VARCHAR2(30)     NOT NULL, 
    reco_seq     NUMBER(12, 0)    NOT NULL, 
    favs_date    DATE             NOT NULL, 
     PRIMARY KEY (favs_seq)
)
/

CREATE SEQUENCE t_user_favs_SEQ
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER t_user_favs_AI_TRG
BEFORE INSERT ON t_user_favs 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT t_user_favs_SEQ.NEXTVAL
    INTO :NEW.favs_seq
    FROM DUAL;
END;
/

--DROP TRIGGER t_user_favs_AI_TRG; /

--DROP SEQUENCE t_user_favs_SEQ; /

COMMENT ON TABLE t_user_favs IS '회원 찜 목록'
/

COMMENT ON COLUMN t_user_favs.favs_seq IS '찜 순번'
/

COMMENT ON COLUMN t_user_favs.user_id IS '찜한 사람'
/

COMMENT ON COLUMN t_user_favs.reco_seq IS '추천 순번'
/

COMMENT ON COLUMN t_user_favs.favs_date IS '찜한 날짜'
/

ALTER TABLE t_user_favs
    ADD CONSTRAINT FK_t_user_favs_reco_seq_t_reco FOREIGN KEY (reco_seq)
        REFERENCES t_recommendation (reco_seq)
/

ALTER TABLE t_user_favs
    ADD CONSTRAINT FK_t_user_favs_user_id_t_user_ FOREIGN KEY (user_id)
        REFERENCES t_user (user_id)
/


