SELECT *
FROM TB_MEMBER;

--김영희 회원과 같은 지역에 사는 회원들의 지역명, 아이디, 이름, 등급명을 이름 오름차순으로 조회
SELECT AREA_NAME 지역명, MEMBER_ID 아이디, MEMBER_NAME 이름, GRADE_NAME 등급명

FROM TB_MEMBER

JOIN TB_GRADE ON(GRADE = GRADE_CODE)

JOIN TB_AREA USING(AREA_CODE)

WHERE AREA_CODE = (

SELECT AREA_CODE FROM TB_MEMBER

WHERE MEMBER_NAME = '김영희')

ORDER BY 이름 ASC;

--ON (AREA_CODE = AREA_CODE)
--이름 = '김영희'
-- DESC
