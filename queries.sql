DROP VIEW GOAT;
CREATE VIEW Goat AS 
	SELECT animal_id AS goat_id, sex, overall_adg
	FROM Animal;	

DROP VIEW Picklist;
CREATE VIEW Picklist AS
	SELECT picklistvalue_id, value
	FROM PicklistValue;

DROP VIEW Trait;
CREATE VIEW Trait AS 
	SELECT animal_id, trait_code, alpha_value AS value
	FROM SessionAnimalTrait; 

SELECT value, overall_adg, animal_id
FROM Trait JOIN Goat ON goat_id=animal_id
WHERE trait_code=(
	SELECT picklistvalue_id FROM Picklist WHERE value='Vigor Score'
)
ORDER BY value DESC;

