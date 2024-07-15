# US Houshold Income (Data Cleaning)

SELECT *
FROM us_project.us_household_income;

SELECT * 
FROM us_project.us_household_income_statistics;

#Fixing column name 
ALTER TABLE us_project.us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`;

#Counting how many rows were imported
SELECT COUNT(id)
FROM us_project.us_household_income;

SELECT COUNT(id)
FROM us_project.us_household_income_statistics;

#Identifying Duplicates
SELECT COUNT(id)
FROM us_project.us_household_income_statistics;

SELECT id, COUNT(id)
FROM us_project.us_household_income
GROUP BY id
HAVING COUNT(id) >1;

SELECT *
FROM(
SELECT row_id,
id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
FROM us_project.us_household_income
) duplicates
WHERE row_num > 1
;

#Deleting Duplicates
DELETE FROM us_household_income
WHERE row_id IN (
    SELECT row_id
	FROM (
        SELECT row_id,
		id,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
		FROM us_project.us_household_income
		) duplicates
WHERE row_num > 1)
;

#Fixing spelling  mistakes in States
SELECT DISTINCT State_Name
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY 1
;

UPDATE us_project.us_household_income
SET State_Name = 'Georgia'
WHERE State_name = 'georia';

UPDATE us_project.us_household_income
SET State_Name = 'Alabama'
WHERE State_name = 'alabama';

#Populating missing values in Place
SELECT *
FROM us_project.us_household_income
WHERE County = 'Autauga County'
ORDER BY 1
;

UPDATE us_project.us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont';

#Updating values in Type
SELECT Type, COUNT(TYPE)
FROM us_project.us_household_income
GROUP BY 1
;

UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;


