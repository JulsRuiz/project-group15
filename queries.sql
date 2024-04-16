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

CREATE VIEW Lifespan AS
SELECT Births.goat_id, Deaths.date - Births.date AS Lifespan
FROM Births JOIN Deaths ON Births.goat_id = Deaths.goat_id;

DROP VIEW Lifespan;
DROP VIEW Births;
DROP VIEW Deaths;



