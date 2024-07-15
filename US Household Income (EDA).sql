# US Household Income Exploratory Data Analysis

SELECT *
FROM us_project.us_household_income;

SELECT *
FROM us_project.us_household_income_statistics
;

# Exploring States Land And Water Area
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.us_household_income
GROUP BY State_Name;


# Exploring Top 10 States By Land
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10;

# Exploring Top 10 States By Water
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY 3 DESC
LIMIT 10;

# Joining Tables Together
SELECT *
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
    ON u.id = us.id
WHERE Mean <> 0;
 
# Mean And Median Household Income By State
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
    ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
;

# Mean And Median Household Income By Type OF Area
SELECT Type, COUNT(Type), ROUND(AVG(MEAN),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
    ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
;

# Exploring Which States Have Community areas
SELECT *
FROM us_household_income
WHERE Type = 'Community';

# Filtering Out the Outliers
SELECT Type, COUNT(Type), ROUND(AVG(MEAN),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
    ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
HAVING COUNT(Type) > 100
;

# Highest Mean And Median Household Income Cities
SELECT u.State_Name, City, ROUND(AVG(MEAN),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
JOIN us_project.us_household_income_statistics us
     ON u.id = us.id
GROUP BY u.State_Name, City
ORDER BY ROUND(AVG(MEAN),1) DESC
;
  
