#1번 영화 '퍼스트 맨'의 제작 연도, 영문 제목, 러닝 타임, 플롯을 출력하세요
SELECT ReleaseYear, Title, RunningTime, Plot
FROM Movie
WHERE KoreanTitle = '퍼스트 맨';

#2번 2003년에 개봉한 영화의 한글 제목과 영문 제목을 출력하세요
SELECT KoreanTitle, Title
FROM Movie
WHERE ReleaseYear = 2003;

#3번 영화 '글래디에이터'의 작곡가(Composer)의 한글 이름을 출력하세요
SELECT P.KoreanName
FROM Person AS P LEFT JOIN appear AS a ON P.PersonID = a.PersonID
	LEFT JOIN Role AS R ON a.RoleID = R.RoleID 
    LEFT JOIN Movie AS M ON M.MovieID = a.MovieID
WHERE M.KoreanTitle = '글래디에이터'
	AND R.RoleName = 'Composer';
    
#4번 영화 '매트릭스' 의 감독이 몇 명인지 출력하세요
SELECT COUNT(*)
FROM Person AS P LEFT JOIN appear AS a ON P.PersonID = a.PersonID
	LEFT JOIN Role AS R ON a.RoleID = R.RoleID 
    LEFT JOIN Movie AS M ON M.MovieID = a.MovieID
WHERE M.KoreanTitle = '매트릭스'
	AND R.RoleName = 'Director';
    
#5번 감독이 2명 이상인 영화의 정보를 다음 형식으로 출력하세요(하나의 컬럼)
SELECT  CONCAT(M.KoreanTitle, ' (', M.Title, ') - ', M.ReleaseYear) AS '한글영화제목(영문 영화제목) - 개봉년도'
FROM Person AS P LEFT JOIN appear AS a ON P.PersonID = a.PersonID
	LEFT JOIN Role AS R ON a.RoleID = R.RoleID 
    LEFT JOIN Movie AS M ON M.MovieID = a.MovieID
WHERE 
    R.RoleName = 'Director'
GROUP BY 
    M.MovieID
HAVING
	COUNT(P.PersonID) >= 2;

#6번 '한스 짐머'가 참여한 영화 중 아카데미를 수상한 영화의 한글 제목을 출력하세요
SELECT M.KoreanTitle
FROM Person AS P LEFT JOIN appear AS a ON P.PersonID = a.PersonID
    LEFT JOIN Movie AS M ON M.MovieID = a.MovieID
    LEFT JOIN awardinvolve AS AI ON a.AppearID = AI.AppearID
	LEFT JOIN awardyear AS AY ON AI.AwardYearID = AY.AwardYearID
    LEFT JOIN award AS AW ON AY.AwardID = AW.AwardID
WHERE P.KoreanName = '한스 짐머'
	AND AW.AwardID = 1;

#7번 감독이 '제임스 카메론'이고 '아놀드 슈워제네거'가 출연한 영화를 다음 형식으로 출력하세요(하나의 컬럼). 개봉 연도를 기준으로 내림차순 정렬되어야 합니다.
SELECT CONCAT(M.KoreanTitle, ' (', M.Title, ') - ', M.ReleaseYear) AS '한글영화제목(영문 영화제목) - 개봉년도'
FROM Person AS P1 LEFT JOIN appear AS a ON P1.PersonID = a.PersonID
	LEFT JOIN Role AS R1 ON a.RoleID = R1.RoleID 
    LEFT JOIN Movie AS M ON M.MovieID = a.MovieID
    LEFT JOIN appear AS a2 ON M.MovieID = a2.MovieID
    LEFT JOIN Person AS P2 ON P2.PersonID = a2.PersonID
WHERE P1.KoreanName = '제임스 카메론'
	AND R1.RoleName = 'Director'
    AND P2.KoreanName = '아놀드 슈워제네거'
ORDER BY 
    M.ReleaseYear DESC;

#8번 상영시간이 100분 이상인 영화 중 레오나르도 디카프리오가 출연한 한글 제목과 개봉 연도를 출력하세요. 개봉 연도를 기준으로 내림차순 정렬되어야 합니다.
SELECT M.KoreanTitle,M.ReleaseYear
FROM Person AS P LEFT JOIN appear AS a ON P.PersonID = a.PersonID
	LEFT JOIN Role AS R ON a.RoleID = R.RoleID 
    LEFT JOIN Movie AS M ON M.MovieID = a.MovieID
WHERE P.KoreanName = '레오나르도 디카프리오'
ORDER BY 
    M.ReleaseYear DESC;
    
#9번 청소년 관람불가 등급의 영화 중 가장 많은 수익을 얻은 영화를 고르시오
SELECT MAX(M.BoxOfficeWWGross) 
FROM Movie AS M LEFT JOIN gradeinkorea as G ON G.GradeinKoreaID = M.GradeinKoreaID
WHERE G.GradeInKoreaName = '청소년 관람불가';

#10번 1999년 이전에 제작된 영화의 수익 평균을 고르시오. 출력 형식은 통화 형식이어야 합니다.


#11번 가장 많은 제작비가 투입된 영화를 다음 형식으로 출력하세요.
SELECT CONCAT(M.KoreanTitle, ' (', M.Title, ') - ', M.ReleaseYear) AS '한글영화제목(영문 영화제목) - 개봉년도'
FROM Movie as M
WHERE 
    M.Budget = (SELECT MAX(Budget) FROM Movie);
    
#12번 제작한 영화의 제작비 총합이 가장 높은 감독을 다음 형식으로 출력하세요.
SELECT CONCAT(P.KoreanName, ' (',P.Name, ') ') AS '한글 이름(영문 이름)'
FROM Person AS P LEFT JOIN appear AS a ON P.PersonID = a.PersonID
	LEFT JOIN Role AS R ON a.RoleID = R.RoleID 
    LEFT JOIN Movie AS M ON M.MovieID = a.MovieID
WHERE 
	R.RoleName = 'Director'
GROUP BY
	P.personID, P.KoreanName, P.Name
ORDER BY
	SUM(M.Budget) DESC
LIMIT 1;

#13번 출연한 영화의 모든 수익을 합하여, 총 수입이 가장 많은 배우의 이름과 출생 연도를 출력하세요.(두 개의 컬럼)
SELECT P.KoreanName, P.BirthDate
FROM Person AS P LEFT JOIN appear AS a ON P.PersonID = a.PersonID
	LEFT JOIN Role AS R ON a.RoleID = R.RoleID 
    LEFT JOIN Movie AS M ON M.MovieID = a.MovieID
WHERE 
	R.RoleName = 'Actor'
GROUP BY
	P.personID, P.KoreanName, P.Name
ORDER BY
	SUM(M.Budget) DESC
LIMIT 1;

