/* 관리자 계정(sys) 접속 후 수행*/
--
--ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
--
---- 계정 생성
--CREATE USER SPRING_JHJ IDENTIFIED BY SPRING1234;
---- 권한 부여
--GRANT CONNECT, RESOURCE TO SPRING_JHJ;
--
---- 테이블 저장 공간 할당
--ALTER USER SPRING_JHJ
--DEFAULT TABLESPACE USERS
--QUOTA 100M ON USERS;

------------------------------------------------

/*SPRING 계정 접속 후 테이블, 시퀀스 생성*/

/* 회원("MEMBER") */
CREATE TABLE "MEMBER"(
	"MEMBER_NO" 		  NUMBER ,
	"MEMBER_EMAIL" 	  VARCHAR2(50)  NOT NULL,
	"MEMBER_PW" 		  VARCHAR2(100)	NOT NULL,
	"MEMBER_NICKNAME" NVARCHAR2(10) NOT NULL,
	"MEMBER_TEL"			CHAR(11)      NOT NULL,
	"MEMBER_ADDRESS"  NVARCHAR2(150),
	"PROFILE_IMG"			VARCHAR2(300),
	"ENROLL_DATE"			DATE DEFAULT CURRENT_DATE,
	"MEMBER_DEL_FL"   CHAR(1) DEFAULT 'N',
	"AUTHORITY"   		NUMBER DEFAULT 1,
	
	CONSTRAINT "MEMBER_PK" PRIMARY KEY("MEMBER_NO"),
	
	CONSTRAINT "MEMBER_DEL_FL_CHK" 
	CHECK("MEMBER_DEL_FL" IN('Y', 'N')),
	
	CONSTRAINT "AUTHORITY_CHK"
	CHECK("AUTHORITY" IN(1,2))
);

-- COMMENT 추가
COMMENT ON COLUMN "MEMBER"."MEMBER_NO" IS  '회원번호(PK)';
COMMENT ON COLUMN "MEMBER"."MEMBER_EMAIL" IS  '회원 이메일(ID)';
COMMENT ON COLUMN "MEMBER"."MEMBER_PW" IS  '회원 비밀번호';
COMMENT ON COLUMN "MEMBER"."MEMBER_NICKNAME" IS  '회원명(별명)';
COMMENT ON COLUMN "MEMBER"."MEMBER_TEL" IS  '회원 전화번호(-제외)';
COMMENT ON COLUMN "MEMBER"."MEMBER_ADDRESS" IS  '회원주소';
COMMENT ON COLUMN "MEMBER"."PROFILE_IMG" IS  '프로필 이미지 경로';
COMMENT ON COLUMN "MEMBER"."ENROLL_DATE" IS  '가입일';
COMMENT ON COLUMN "MEMBER"."MEMBER_DEL_FL" IS  '탈퇴여부(Y,N)';
COMMENT ON COLUMN "MEMBER"."AUTHORITY" IS  '권한(1:일반, 2:관리자)';

-- 회원 번호 시퀀스 생성
CREATE SEQUENCE SEQ_MEMBER_NO NOCACHE;

-- 샘플 회원 데이터 삽입
INSERT INTO "MEMBER"
VALUES(SEQ_MEMBER_NO.NEXTVAL, 'member01@kh.or.kr', 'pass01!',
				'샘플1', '01012341234', NULL, NULL, DEFAULT, DEFAULT, DEFAULT);

COMMIT;

SELECT * FROM MEMBER;

ROLLBACK;
-- 샘플 데이터 비밀번호 암호화 적용
UPDATE "MEMBER"
SET 
	"MEMBER_PW" = '$2a$10$cgoULlE17OHxfugSk7BufO8TmyVTBOJ5.Pxad4B0rtu7C20juuwli'
WHERE
	"MEMBER_NO" = 1;
COMMIT;

SELECT * FROM MEMBER;''

/* 회원 정보 수정*/
UPDATE "MEMBER"
SET
	MEMBER_NICKNAME = ?,
	MEMBER_TEL = ?,
	MEMBER_ADDRESS=?
WHERE 
	MEMBER_NO=?;

UPDATE "MEMBER"
SET
MEMBER_DEL_FL = DECODE(MEMBER_DEL_FL, 'N','Y','Y','N')
WHERE
MEMBER_NO=?;


INSERT INTO "MEMBER"
VALUES(
	SEQ_MEMBER_NO.NEXTVAL, 
	'member02@kh.or.kr', 
	'$2a$10$KzFKEvO4C65xBTetZDV8QufZvhQnIGU0SE5ZEaZo0T9SrdYS5oFMC',
	 '샘플2', 
	 '01022222222', 
	 NULL, NULL, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO "MEMBER"
VALUES(
	SEQ_MEMBER_NO.NEXTVAL, 
	'member03@kh.or.kr', 
	'$2a$10$KzFKEvO4C65xBTetZDV8QufZvhQnIGU0SE5ZEaZo0T9SrdYS5oFMC',
	 '샘플3', 
	 '01033333333', 
	 NULL, NULL, DEFAULT, DEFAULT, DEFAULT);
	
	SELECT * FROM "MEMBER";
COMMIT;


-- 파일 업로드 테스트용 테이블
CREATE TABLE TB_FILE_TEST(
	FILE_NO NUMBER PRIMARY KEY,
	FILE_ORIGINAL_NAME VARCHAR2(300), -- 원본 파일명
	FILE_RENAME VARCHAR2(300), -- 변경된 파일명
	FILE_PATH VARCHAR2(300), -- 파일이 저장된 폴더명
	UPDATE_DATE DATE DEFAULT CURRENT_DATE -- 저장된 날짜
);

CREATE SEQUENCE SEQ_FILE_NO NOCACHE; -- 시퀀스 생성
  
SELECT * FROM TB_FILE_TEST;

UPDATE TB_FILE_TEST
SET
FILE_PATH = '/images/test/';
COMMIT;

------------------------------------------------------
CREATE TABLE "MEMBER" (
	"MEMBER_NO"	NUMBER		NOT NULL,
	"MEMBER_EMAIL"	VARCHAR2(50)		NOT NULL,
	"MEMBER_PW"	VARCHAR2(100)		NOT NULL,
	"MEMBER_NICKNAME"	NVARCHAR2(10)		NOT NULL,
	"MEMBER_TEL"	CHAR(11)		NOT NULL,
	"MEMBER_ADDRESS"	NVARCHAR2(150)		NULL,
	"PROFILE_IMG"	VARCHAR(300)		NULL,
	"ENROLL_DATE"	DATE	DEFAULT CURRENT_DATE	NOT NULL,
	"MEMBER_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"AUTHORITY"	NUMBER	DEFAULT 1	NOT NULL
);

COMMENT ON COLUMN "MEMBER"."MEMBER_NO" IS '회원번호(SEQ_MEMBER_NO)';

COMMENT ON COLUMN "MEMBER"."MEMBER_EMAIL" IS '회원 이메일(ID)';

COMMENT ON COLUMN "MEMBER"."MEMBER_PW" IS '회원 비밀번호(암호화)';

COMMENT ON COLUMN "MEMBER"."MEMBER_NICKNAME" IS '회원명(별명)';

COMMENT ON COLUMN "MEMBER"."MEMBER_TEL" IS '회원 전화번호(-제외)';

COMMENT ON COLUMN "MEMBER"."MEMBER_ADDRESS" IS '회원 주소';

COMMENT ON COLUMN "MEMBER"."PROFILE_IMG" IS '프로필 이미지 경로';

COMMENT ON COLUMN "MEMBER"."ENROLL_DATE" IS '가입일';

COMMENT ON COLUMN "MEMBER"."MEMBER_DEL_FL" IS '탈퇴여부('Y', 'N')';

COMMENT ON COLUMN "MEMBER"."AUTHORITY" IS '권한(1:일반,2:관리자)';

CREATE TABLE "BOARD" (
	"BOARD_NO"	NUMBER		NOT NULL,
	"BOARD_TITLE"	NVARCHAR2(100)	NOT NULL,
	"BOARD_CONTENT"	VARCHAR2(4000)	NOT NULL,
	"BOARD_WRITE_DATE"	DATE		NOT NULL,
	"BOARD_UPDATE_DATE"	DATE		NULL,
	"READ_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"BOARD_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"BOARD_CODE"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "BOARD"."BOARD_NO" IS '게시글 번호(SEQ_BOARD_NO)';
COMMENT ON COLUMN "BOARD"."BOARD_TITLE" IS '게시글 제목';
COMMENT ON COLUMN "BOARD"."BOARD_CONTENT" IS '게시글 내용';
COMMENT ON COLUMN "BOARD"."BOARD_WRITE_DATE" IS '게시글 작성일';
COMMENT ON COLUMN "BOARD"."BOARD_UPDATE_DATE" IS '마지막 수정일';
COMMENT ON COLUMN "BOARD"."READ_COUNT" IS '조회수';
COMMENT ON COLUMN "BOARD"."BOARD_DEL_FL" IS '삭제여부(N, Y)';
COMMENT ON COLUMN "BOARD"."MEMBER_NO" IS '작성자 회원 번호';
COMMENT ON COLUMN "BOARD"."BOARD_CODE" IS '게시판 종류 코드 번호';


CREATE TABLE "BOARD_IMG" (
	"IMG_NO"	NUMBER		NOT NULL,
	"IMG_PATH"	VARCHAR2(200)		NOT NULL,
	"IMG_ORIGINAL_NAME"	NVARCHAR2(50)		NOT NULL,
	"IMG_RENAME"	NVARCHAR2(50)		NOT NULL,
	"IMG_ORDER"	NUMBER		NULL,
	"BOARD_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "BOARD_IMG"."IMG_NO" IS '이미지 번호(SEQ_IMG_NO)';

COMMENT ON COLUMN "BOARD_IMG"."IMG_PATH" IS '이미지 요청 경로';

COMMENT ON COLUMN "BOARD_IMG"."IMG_ORIGINAL_NAME" IS '이미지 원본명';

COMMENT ON COLUMN "BOARD_IMG"."IMG_RENAME" IS '이미지 변경명';

COMMENT ON COLUMN "BOARD_IMG"."IMG_ORDER" IS '이미지 순서';

COMMENT ON COLUMN "BOARD_IMG"."BOARD_NO" IS '이미지 첨부된 게시글';

CREATE TABLE "BOARD_TYPE" (
	"BOARD_CODE"	NUMBER		NOT NULL,
	"BOARD_NAME"	NVARCHAR2(20)		NOT NULL
);

COMMENT ON COLUMN "BOARD_TYPE"."BOARD_CODE" IS '게시판 종류 코드 번호';
COMMENT ON COLUMN "BOARD_TYPE"."BOARD_NAME" IS '게시판 이름';


CREATE TABLE "BOARD_LIKE" (
	"MEMBER_NO"	NUMBER		NOT NULL,
	"BOARD_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "BOARD_LIKE"."MEMBER_NO" IS '좋아요를 누른 회원 번호';

COMMENT ON COLUMN "BOARD_LIKE"."BOARD_NO" IS '좋아요가 눌러진 게시글 번호';

CREATE TABLE "COMMENT" (
	"COMMENT_NO"	NUMBER		NOT NULL,
	"COMMENT_CONTENT"	VARCHAR2(4000)		NULL,
	"COMMENT_WRITE_DATE"	DATE	DEFAULT CURRENT_DATE	NOT NULL,
	"COMMENT_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"BOARD_NO"	NUMBER		NOT NULL,
	"PARENT_COMMENT_NO"	NUMBER		NULL
);

COMMENT ON COLUMN "COMMENT"."COMMENT_NO" IS '댓글 번호(SEQ_COMMENT_NO)';

COMMENT ON COLUMN "COMMENT"."COMMENT_CONTENT" IS '댓글 내용';

COMMENT ON COLUMN "COMMENT"."COMMENT_WRITE_DATE" IS '댓글 작성일';

COMMENT ON COLUMN "COMMENT"."COMMENT_DEL_FL" IS '댓글 삭제 여부(N, Y)';

COMMENT ON COLUMN "COMMENT"."MEMBER_NO" IS '회원번호(SEQ_MEMBER_NO)';

COMMENT ON COLUMN "COMMENT"."BOARD_NO" IS '게시글 번호(SEQ_BOARD_NO)';

COMMENT ON COLUMN "COMMENT"."PARENT_COMMENT_NO" IS '부모 댓글 번호';

ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY (
	"MEMBER_NO"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "PK_BOARD" PRIMARY KEY (
	"BOARD_NO"
);

ALTER TABLE "BOARD_IMG" ADD CONSTRAINT "PK_BOARD_IMG" PRIMARY KEY (
	"IMG_NO"
);

ALTER TABLE "BOARD_TYPE" ADD CONSTRAINT "PK_BOARD_TYPE" PRIMARY KEY (
	"BOARD_CODE"
);

ALTER TABLE "BOARD_LIKE" ADD CONSTRAINT "PK_BOARD_LIKE" PRIMARY KEY (
	"MEMBER_NO",
	"BOARD_NO"
);

ALTER TABLE "COMMENT" ADD CONSTRAINT "PK_COMMENT" PRIMARY KEY (
	"COMMENT_NO"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "FK_MEMBER_TO_BOARD_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "FK_BOARD_TYPE_TO_BOARD_1" FOREIGN KEY (
	"BOARD_CODE"
)
REFERENCES "BOARD_TYPE" (
	"BOARD_CODE"
);

ALTER TABLE "BOARD_IMG" ADD CONSTRAINT "FK_BOARD_TO_BOARD_IMG_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "BOARD" (
	"BOARD_NO"
);

ALTER TABLE "BOARD_LIKE" ADD CONSTRAINT "FK_MEMBER_TO_BOARD_LIKE_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "BOARD_LIKE" ADD CONSTRAINT "FK_BOARD_TO_BOARD_LIKE_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "BOARD" (
	"BOARD_NO"
);

ALTER TABLE "COMMENT" ADD CONSTRAINT "FK_MEMBER_TO_COMMENT_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "COMMENT" ADD CONSTRAINT "FK_BOARD_TO_COMMENT_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "BOARD" (
	"BOARD_NO"
);

ALTER TABLE "COMMENT" ADD CONSTRAINT "FK_COMMENT_TO_COMMENT_1" FOREIGN KEY (
	"PARENT_COMMENT_NO"
)
REFERENCES "COMMENT" (
	"COMMENT_NO"
);

/* BOARD 테이블 BOARD_DEL_FL CHECK 제약 조건 추가*/
ALTER TABLE "BOARD"
ADD CONSTRAINT "CHK_BOARD_DEL_FL"
CHECK(BOARD_DEL_FL IN ('Y', 'N'));

/* COMMENT 테이블 BOARD_DEL_FL CHECK 제약 조건 추가*/
ALTER TABLE "COMMENT"
ADD CONSTRAINT "CHK_COMMENT_DEL_FL"
CHECK(COMMENT_DEL_FL IN ('Y', 'N'));



