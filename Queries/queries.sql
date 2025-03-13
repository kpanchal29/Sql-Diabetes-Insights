-- Creating the table for the diabetes dataset
CREATE TABLE diabetesdataset (
    ID INT PRIMARY KEY,
    Age INT,
    Gender VARCHAR(10),
    Ethnicity VARCHAR(50),
    Income DECIMAL(10, 2),
    BMI DECIMAL(5, 2),
    Blood_Pressure DECIMAL(5, 2),
    Cholesterol DECIMAL(5, 2),
    Family_History_Diabetes BOOLEAN,
    Glucose_Level DECIMAL(5, 2),
    HbA1c DECIMAL(3, 1),
    Insulin_Resistance DECIMAL(5, 2),
    Heart_Disease_History BOOLEAN,
    Stress_Level VARCHAR(10),
    Diabetes_Diagnosis BOOLEAN
);

-- Creating the table for the habits status dataset
CREATE TABLE habits (
    ID INT PRIMARY KEY,
    Exercise_Hours_Per_Week DECIMAL(4, 1),
    Alcohol_Consumption_Per_Week INT,
    Smoking_Status VARCHAR(10),
    Physical_Activity_Level VARCHAR(20),
    Fast_Food_Intake_Per_Week INT,
    Processed_Food_Intake_Per_Week INT,
    Daily_Caloric_Intake INT,
    Medication_Use BOOLEAN,
    Sleep_Hours_Per_Night DECIMAL(3, 1)
);



-- Loading data into DiabetesDataset
LOAD DATA LOCAL INFILE "D:/FTN/SQL/Projects/my-projects/Diabetes project/diabetes_dataset.csv"
INTO TABLE DiabetesDataset
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ID, Age, Gender, Ethnicity, Income, BMI, Blood_Pressure, Cholesterol, 
 Family_History_Diabetes, Glucose_Level, HbA1c, Insulin_Resistance, 
 Heart_Disease_History, Stress_Level, Diabetes_Diagnosis);

-- Loading data into HabitsStatus
LOAD DATA LOCAL INFILE "D:/FTN/SQL/Projects/my-projects/Diabetes project/habits_status.csv"
INTO TABLE habits
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ID, Exercise_Hours_Per_Week, Alcohol_Consumption_Per_Week, Smoking_Status, 
 Physical_Activity_Level, Fast_Food_Intake_Per_Week, Processed_Food_Intake_Per_Week, 
 Daily_Caloric_Intake, Medication_Use, Sleep_Hours_Per_Night);


-- 1. How  many peoples are diabetes 
SELECT count(*)
FROM diabetesdataset 
WHERE Diabetes_Diagnosis = 1;
-- Total 25104 peoples are diabetes and the total peoples in the dataset are 50000, so almost 50% of the population is diagnosed by the Diabetes

SELECT count(*)
FROM diabetesdataset;

-- 2. Total number of males who are diagnosed by diabetes
SELECT count(*)
FROM diabetesdataset 
WHERE Diabetes_Diagnosis = 1 and Gender = "Male"; 

-- 3. Total number of females who are diagnosed by diabetes
SELECT count(*)
FROM diabetesdataset 
WHERE Diabetes_Diagnosis = 1 and Gender = "Female";

-- Total 12434 males are diagnosed by diabetes and 12670 females are diagnosed by diabetes 

-- 4. Find the peoples who are diagnosed by diabetes and divide them by stress level 
SELECT 
		count(CASE WHEN Stress_Level = "Low" THEN 1 END) AS Low_Stress_Level,
		count(CASE WHEN Stress_Level = "Moderate" THEN 1 END) AS Moderate_Stress_Level,
		count(CASE WHEN Stress_Level = "High" THEN 1 END) AS High_Stress_Level,
        count(*) AS Total_Stress
FROM diabetesdataset
	Where Diabetes_Diagnosis = 1;
-- As per the dataset it is found that the stress level does not affect that the patient from being diagnosed by diabetes 

-- 5. Find out the peoples who are diagnosed by diabetes and divide them by their physical activity level 
SELECT 
		count(CASE WHEN Physical_Activity_Level = "Low" THEN 1 END) AS Low_activity,
		count(CASE WHEN Physical_Activity_Level = "Moderate" THEN 1 END) AS Moderate_activity,
		count(CASE WHEN Physical_Activity_Level = "High" THEN 1 END) AS high_activity,
        count(*) AS Total_Activity
FROM habits h 
	JOIN diabetesdataset d 
		ON h.ID = d.ID 
WHERE d.Diabetes_Diagnosis = 1;
-- People with high and moderate physical activity have less changes of getting diagnosed by diabetes compare to peoples with low physical activity level 

-- 6. Find people who use medicines affect the diagnosis of diabetes 
SELECT COUNT(h.Medication_Use)
FROM habits h 
	JOIN diabetesdataset d 
		ON h.ID = d.ID
WHERE 
	d.Diabetes_Diagnosis = 1
AND 	
	h.Medication_Use = 0;
    
-- There are total 18205 peoples who are under any medication and are daignosed with the diabetes and there total 10525 peoples who are under any medication and are not daignosed with the diabetes.

-- 7. Find out that which ethinicity group has the highest number of peoples diagnosed with the diabetes.
SELECT 
	COUNT(CASE WHEN Ethnicity = "Other" THEN 1 END ) AS Other,
	COUNT(CASE WHEN Ethnicity = "Asian" THEN 1 END ) AS Asian,
    COUNT(CASE WHEN Ethnicity = "Black" THEN 1 END ) AS Other,
    COUNT(CASE WHEN Ethnicity = "White" THEN 1 END ) AS White,
    COUNT(CASE WHEN Ethnicity = "Hispanic" THEN 1 END ) AS Hispanic,
    COUNT(*) AS Final 
FROM diabetesdataset
WHERE Diabetes_Diagnosis = 1;
-- AS per here we found that there is very monir difference between each ethnicity, and found that it does not depend where the person belongs to which ethnicity and to does not depend on the ethnicity that wheather person will diagnosed by diabetes or not.

-- 8. People who have family history of diabetes are more tend to have diabetes ?
SELECT COUNT(Family_History_Diabetes)
FROM diabetesdataset
WHERE Family_History_Diabetes = 1 AND Diabetes_Diagnosis = 1;

-- Yes it is true that those whose family history has a diabetes patient are more tend to have the diabetes and also those who family does not have a diabetes patient have less changes of being diagnosed by diabetes

-- 9. AVG Hba1c, Glucose, Cholestrol, Blood_Pressure, BMI of a diabetes patient
SELECT 
	   AVG(HbA1c) AS Avg_HbA1c, 
	   AVG(Glucose_Level) AS Avg_Glucose_Level, 
       AVG(Cholesterol) AS Avg_Cholesterol,
       AVG(Blood_Pressure) AS Avg_Blood_Pressure,
       AVG(BMI) AS Avg_BMI
FROM diabetesdataset
WHERE Diabetes_Diagnosis = 1;
-- The Average Hba1c is 7.00690, Glusode level is 135.087341, Cholesterol is 199.852457, Blood Pressure is 135.114661, BMI is 31.823237

-- 10. Does having a heart disease history increses the chnaged of person being diagnosed by diabetes 
SELECT COUNT(Heart_Disease_History)
FROM diabetesdataset
WHERE Heart_Disease_History = 1 AND Diabetes_Diagnosis = 1;
-- Person with heart disease has higher chances of being diagnosed by diabetes

-- 11. Average Insulin Resitance of a diabetes diagnosed person vs not diagnosed with diabetes
SELECT AVG(Insulin_Resistance)
FROM diabetesdataset
WHERE Diabetes_Diagnosis = 1;
-- The Average insulin reisitance of person not diagnosed by the diabetes is less than the person diagnosed by diabetes

-- 12. Average Age of male and female both who are daignosed with diabetes
SELECT AVG(Age)
FROM diabetesdataset
WHERE Gender = "Male" and Diabetes_Diagnosis = 0;
-- As per this query we found that the average age for which the person is diagnosed with the diabetes is 53 is both male and Female.

-- 13. What is the average income of person being diagnosed by diabetes compare to who is not diagnosed
SELECT AVG(Income) 
FROM diabetesdataset
WHERE Diabetes_Diagnosis = 1;
-- The average income for the person being diagnosed with diabetes and the normal person is pretty much equal and it does not affect the person from being diagnosed by diabetes or not.

-- 14. Now lets see people who are smoker, non-smoker and formal smoker have chances of being diagnosed by diabetes or not ?
SELECT 
		count(CASE WHEN Smoking_Status = "Current" THEN 1 END) AS Current_Smoker,
		count(CASE WHEN Smoking_Status = "Former" THEN 1 END) AS Former_Smoker,
		count(CASE WHEN Smoking_Status = "Never" THEN 1 END) AS Non_Smoker
FROM habits h 
	JOIN diabetesdataset d 
		ON h.ID = d.ID 
WHERE d.Diabetes_Diagnosis = 1;
-- It shows that the person who smokes have high changes of being diagnosed by diabetes and former and non-smoker have less chances

-- 15. Check that person who consume alcohol have chances of being diagnosed by diabetes or not
SELECT 
		AVG(Alcohol_Consumption_Per_Week)
FROM habits h 
	JOIN diabetesdataset d 
		ON h.ID = d.ID 
WHERE d.Diabetes_Diagnosis = 1;
-- It shows that the person who consumes alcohol have high chances of being diagnosed by diabetes

-- 16. Average calorie intake of a normal person vs the diabetic person 
SELECT 
	AVG(Daily_Caloric_Intake) AS Calorie_Intake
FROM habits h 
	JOIN diabetesdataset d 
		ON h.ID = d. ID
WHERE d.Diabetes_Diagnosis = 1;
-- It is pretty much the same 

-- 17.  Average Sleep per night of a diabetic person vs the normal person 
SELECT 
	AVG(Sleep_Hours_Per_Night)
FROM habits h 
	JOIN diabetesdataset d
		ON h.ID = d.ID
WHERE d.Diabetes_Diagnosis = 0;
-- A Diabetic person sleeps more than the normal persona and they require more sleep compare to normal person 

-- 18. Find the Fast food intake per week and processed food intake per week person's chances of being diagnosed by diabetes
SELECT 
	AVG(Fast_Food_Intake_Per_Week),
    AVG(Processed_Food_Intake_Per_Week)
FROM habits h 
	JOIN diabetesdataset d
		ON h.ID = d.ID
WHERE d.Diabetes_Diagnosis = 1;
-- Person who consume processed food and fast food have more chances of being diagnosed by diabetes

-- 19. Find out that the person who exercise more than average and thier chances of being diagnosed by Diabetes
SELECT COUNT(h.ID)
FROM habits h 
	JOIN diabetesdataset d 
		on h.ID = d.ID
WHERE h.Exercise_Hours_Per_Week > (SELECT AVG(Exercise_Hours_Per_Week) FROM habits) 
and d.Diabetes_Diagnosis = 1;
-- The person who execise more have less chances of being diagnosed by diabetes compare to who does not exercise or exercise less

-- 20. TOP 5 ethinic groups with the highest diabetes daignosis rates
SELECT Ethnicity, 
       COUNT(*) AS Total_Patients, 
       SUM(Diabetes_Diagnosis) AS Diabetes_Cases, 
       ROUND(100.0 * SUM(Diabetes_Diagnosis) / COUNT(*), 2) AS Diabetes_Rate
FROM diabetesdataset
GROUP BY Ethnicity
ORDER BY Diabetes_Rate DESC
LIMIT 3;
-- The top 5 groups are Black, White and Hispanic

-- 21. Identify high-risk patients based on multiple health conditions
SELECT ID, Age, Gender, BMI, Blood_Pressure, Cholesterol, Glucose_Level, HbA1c
FROM diabetesdataset
WHERE BMI > (SELECT AVG(BMI) FROM diabetesdataset) 
  AND Blood_Pressure > (SELECT AVG(Blood_Pressure) FROM diabetesdataset)
  AND Cholesterol > (SELECT AVG(Cholesterol) FROM diabetesdataset)
  AND Glucose_Level > 140;
-- Here we have found the list of high risks patients

-- 22. Relationship between lifestyle habits and diabetes diagnosis
SELECT h.Physical_Activity_Level, 
       ROUND(AVG(d.BMI), 2) AS Avg_BMI, 
       ROUND(AVG(d.Blood_Pressure), 2) AS Avg_Blood_Pressure, 
       ROUND(AVG(d.Glucose_Level), 2) AS Avg_Glucose, 
       SUM(d.Diabetes_Diagnosis) AS Diabetes_Cases
FROM diabetesdataset d
JOIN habits h ON d.ID = h.ID
GROUP BY h.Physical_Activity_Level
ORDER BY Diabetes_Cases DESC;

-- Shows how physical activity affects BMI, blood pressure, glucose levels, and diabetes prevalence.

-- 23. Analyze the effect of sleep on diabetes
SELECT CASE 
            WHEN Sleep_Hours_Per_Night < 6 THEN 'Less than 6 Hours'
            WHEN Sleep_Hours_Per_Night BETWEEN 6 AND 8 THEN '6-8 Hours'
            ELSE 'More than 8 Hours'
       END AS Sleep_Category,
       COUNT(*) AS Total_Patients,
       SUM(Diabetes_Diagnosis) AS Diabetes_Cases,
       ROUND(100.0 * SUM(Diabetes_Diagnosis) / COUNT(*), 2) AS Diabetes_Rate
FROM diabetesdataset d
JOIN habits h ON d.ID = h.ID
GROUP BY Sleep_Category
ORDER BY Diabetes_Rate DESC;
--  Helps understand the impact of sleep duration on diabetes.

-- 24. Finding correlations between alcohol, smoking, and diabetes risk
SELECT Smoking_Status, 
       ROUND(AVG(Alcohol_Consumption_Per_Week), 2) AS Avg_Alcohol_Intake, 
       ROUND(AVG(BMI), 2) AS Avg_BMI, 
       SUM(Diabetes_Diagnosis) AS Diabetes_Cases
FROM diabetesdataset d
JOIN habits h ON d.ID = h.ID
GROUP BY Smoking_Status
ORDER BY Diabetes_Cases DESC;
-- Analyzes how smoking and alcohol consumption contribute to diabetes risk.

-- 25. CTE to Find Patients with Sedentary Lifestyle and High BMI
WITH SedentaryPatients AS (
    SELECT h.ID, h.Exercise_Hours_Per_Week, d.BMI, d.Diabetes_Diagnosis
    FROM habits h
    JOIN diabetesdataset d ON h.ID = d.ID
    WHERE h.Exercise_Hours_Per_Week < (SELECT AVG(Exercise_Hours_Per_Week) FROM habits)
)
SELECT ID, Exercise_Hours_Per_Week, BMI, 
       CASE 
           WHEN BMI > 30 THEN 'Obese'
           WHEN BMI BETWEEN 25 AND 30 THEN 'Overweight'
           ELSE 'Healthy Weight'
       END AS BMI_Category,
       Diabetes_Diagnosis
FROM SedentaryPatients
ORDER BY BMI DESC;
--  This helps in identifying patients who need lifestyle modifications.

-- 26. Fast Food instake effect on blood Sugar 
CREATE VIEW FastFood_Impact AS
SELECT d.ID, d.Glucose_Level, h.Fast_Food_Intake_Per_Week,
       CASE 
           WHEN h.Fast_Food_Intake_Per_Week > 5 AND d.Glucose_Level > 150 THEN 'High Risk'
           WHEN h.Fast_Food_Intake_Per_Week BETWEEN 3 AND 5 AND d.Glucose_Level BETWEEN 120 AND 150 THEN 'Moderate Risk'
           ELSE 'Low Risk'
       END AS Health_Impact
FROM diabetesdataset d
JOIN habits h ON d.ID = h.ID;

SELECT * FROM FastFood_Impact;






