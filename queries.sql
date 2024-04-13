SELECT CAST(alpha_value AS integer) AS vigor, AVG(CAST(overall_adg AS float)) AS average_adg
FROM Trait LEFT JOIN Goat 
ON Trait.goat_id=Goat.goat_id
WHERE trait_code=(
	SELECT picklistvalue_id FROM Picklist WHERE value='Vigor Score'
)
GROUP BY vigor
ORDER BY vigor;

