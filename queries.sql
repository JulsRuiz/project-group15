SELECT CAST(alpha_value AS integer) AS vigor, AVG(CAST(overall_adg AS float)) AS average_adg
FROM Trait LEFT JOIN Goat 
ON Trait.goat_id=Goat.goat_id
WHERE trait_code=(
	SELECT picklistvalue_id FROM Picklist WHERE value='Vigor Score'
)
GROUP BY vigor
ORDER BY vigor;

CREATE VIEW Births AS
	SELECT goat_id, dob AS date
	FROM Goat;

CREATE VIEW Deaths AS
	SELECT goat_id, status_date AS date
	FROM Goat
	WHERE status = 'Dead';

CREATE VIEW Dead AS
SELECT Births.goat_id, Deaths.date - Births.date AS Lifespan
FROM Births JOIN Deaths ON Births.goat_id = Deaths.goat_id
WHERE Deaths.date - Births.date <= '2922 days';

CREATE VIEW Total AS
SELECT Births.goat_id, Deaths.date - Births.date AS Lifespan
FROM Births JOIN Deaths ON Births.goat_id = Deaths.goat_id;

SELECT CAST(alpha_value AS integer) AS vigor, Count(Dead) as Dead_count, Count(Total) as Total_count, (Count(Dead)::numeric / Count(Total)) as Death_rate
FROM Trait JOIN (Dead RIGHT JOIN Total ON Dead.goat_id = Total.goat_id) ON Trait.goat_id = Total.goat_id
WHERE trait_code = '230'
GROUP BY vigor
ORDER BY vigor;

DROP VIEW Births;
DROP VIEW Deaths;
DROP VIEW Dead;
DROP VIEW Total;



