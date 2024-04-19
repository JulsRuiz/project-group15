
--Get the Average adg for each vigor score
SELECT CAST(alpha_value AS integer) AS vigor, AVG(CAST(overall_adg AS float)) AS average_adg
FROM Trait LEFT JOIN Goat 
ON Trait.goat_id=Goat.goat_id
WHERE trait_code=(
	SELECT picklistvalue_id FROM Picklist WHERE value='Vigor Score'
)
GROUP BY vigor
ORDER BY vigor;

--Get the life span of each goat

CREATE VIEW Births AS
	SELECT goat_id, dob AS date
	FROM Goat;

CREATE VIEW Deaths AS
	SELECT goat_id, status_date AS date
	FROM Goat
	WHERE status = 'Dead';

CREATE VIEW Lifespan AS
	SELECT Births.goat_id, Deaths.date - Births.date AS Lifespan
	FROM Births JOIN Deaths ON Births.goat_id = Deaths.goat_id;

--Lifespan of every goat that died on the farm
SELECT *
FROM Lifespan;

DROP VIEW Lifespan;
DROP VIEW Births;
DROP VIEW Deaths;

--Get the average birth weight for each year

CREATE VIEW BirthWeight AS
	SELECT goat_id, CAST(alpha_value as float) as weight
	FROM Trait
	WHERE trait_code = '357' AND NOT alpha_value = '0.0' AND NOT alpha_value = '-1';

CREATE VIEW BirthYear AS
	SELECT goat_id, sex, EXTRACT('Year' FROM dob) AS Year
	FROM Goat;

CREATE VIEW GoatBW AS
	SELECT Year, ROUND(AVG(weight):: numeric, 3) as bw
	FROM BirthWeight JOIN BirthYear ON BirthWeight.goat_id = BirthYear.goat_id
	GROUP BY Year
	ORDER BY Year;

CREATE VIEW MaleBW AS
	SELECT Year, ROUND(AVG(weight):: numeric, 3) as Mbw
	FROM BirthWeight JOIN BirthYear ON BirthWeight.goat_id = BirthYear.goat_id
	WHERE sex = 'Male' OR sex = 'Wether' OR sex = 'M' OR sex = 'Desexed M'
	GROUP BY Year
	ORDER BY Year;

CREATE VIEW FemaleBW AS
	SELECT Year, ROUND(AVG(weight):: numeric, 3) as Fbw
	FROM BirthWeight JOIN BirthYear ON BirthWeight.goat_id = BirthYear.goat_id
	WHERE sex = 'Female'
	GROUP BY Year
	ORDER BY Year;

--Just their birthweights
SELECT *
FROM GoatBW;

--Female birthweights
SELECT *
FROM MaleBW;

--Male birthweights
SELECT *
FROM FemaleBW;

DROP VIEW GoatBW;
DROP VIEW MaleBW;
DROP VIEW FemaleBW;
DROP VIEW BirthYear;
DROP VIEW BirthWeight;
