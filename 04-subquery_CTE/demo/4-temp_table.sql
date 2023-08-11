CREATE TABLE #test 
(PersonID INT, 
PetName VARCHAR(50));
	
INSERT INTO #test 
(PersonID, PetName)
VALUES 
	(1, 'Alice'),
	(2, 'Jacky'),
	(3, 'Layka');

select * from #test

			
DECLARE @test_var TABLE
	(PersonID INT, 
	PetName VARCHAR(50));


INSERT INTO @test_var 
(PersonID, PetName)
VALUES 
	(1, 'Alice'),
	(2, 'Jacky'),
	(3, 'Layka');

SELECT *
FROM #test;	

SELECT *
FROM @test_Var;

SELECT *
FROM #test AS test
	JOIN Application.People AS P
	ON P.PersonID = test.PersonID;

SELECT *
FROM @test_var AS test
	JOIN Application.People AS P
	ON P.PersonID = test.PersonID;


DROP TABLE #test;

---------------------------------------

----------- Глобальные временные таблицы
CREATE TABLE ##test 
	(PersonID INT, 
	PetName VARCHAR(50));

CREATE TABLE ##test 
	(PersonID2 INT, 
	PetName2 VARCHAR(50));
	
INSERT INTO ##test 
(PersonID, PetName)
VALUES 
	(1, 'Alice'),
	(2, 'Jacky'),
	(3, 'Layka');


SELECT *
FROM ##test;

DROP TABLE ##test;