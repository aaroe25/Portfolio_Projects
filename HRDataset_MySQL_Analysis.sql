/*
Analysing data in MySQL
*/

-- Review data
SELECT *
FROM `portfolio_project`.`hrdataset_mysql`;

-- 1. Demographics analysis
-- a) Gender distribution
SELECT GenderID, COUNT(GenderID)
FROM `portfolio_project`.`hrdataset_mysql`
GROUP BY GenderID;

SELECT GenderID, (COUNT(*) / (SELECT COUNT(*) FROM `portfolio_project`.`hrdataset_mysql`))*100 AS Gender_Percentage_Distribution
FROM `portfolio_project`.`hrdataset_mysql`
GROUP BY GenderID;

-- b) Marital Status distribution
SELECT MAritalStatusID, COUNT(MaritalStatusID)
FROM `portfolio_project`.`hrdataset_mysql`
GROUP BY MaritalStatusID;

SELECT MaritalStatusID, (COUNT(*) / (SELECT COUNT(*) FROM `portfolio_project`.`hrdataset_mysql`)) * 100 AS Marital_Status_Percentage_Distrinution
FROM `portfolio_project`.`hrdataset_mysql`
GROUP BY MaritalStatusID
ORDER BY Marital_Status_Percentage_Distrinution DESC;

-- c) Race distribution
SELECT RaceDesc, COUNT(RaceDesc)
FROM `portfolio_project`.`hrdataset_mysql`
GROUP BY RaceDesc;

SELECT RaceDesc, (COUNT(*)/(SELECT COUNT(*) FROM `portfolio_project`.`hrdataset_mysql`)) * 100 AS Race_Percentage_Distribution
FROM `portfolio_project`.`hrdataset_mysql`
GROUP BY RaceDesc
ORDER BY Race_Percentage_Distribution DESC;

-- d) Age distribution
SELECT DOB_Converted, FLOOR(DATEDIFF(CURDATE(), DOB_Converted) / 365.25) AS Age
FROM `portfolio_project`.`hrdataset_mysql`;

ALTER TABLE `portfolio_project`.`hrdataset_mysql`
ADD Age NVARCHAR(255);

UPDATE `portfolio_project`.`hrdataset_mysql`
SET Age = FLOOR(DATEDIFF(CURDATE(), DOB_Converted) / 365.25);

SELECT Age,
CASE
	WHEN Age <= 24 THEN "Under 25"
    WHEN Age BETWEEN 25 AND 34 THEN "25-34"
    WHEN Age BETWEEN 35 AND 44 THEN "35-44"
    WHEN Age BETWEEN 45 AND 54 THEN "45-54"
    WHEN Age >= 55 THEN "Over 55"
END AS Age_Group
FROM `portfolio_project`.`hrdataset_mysql`;

ALTER TABLE `portfolio_project`.`hrdataset_mysql`
ADD Age_Group NVARCHAR(255);

UPDATE `portfolio_project`.`hrdataset_mysql`
SET Age_Group = CASE
	WHEN Age <= 24 THEN "Under 25"
    WHEN Age BETWEEN 25 AND 34 THEN "25-34"
    WHEN Age BETWEEN 35 AND 44 THEN "35-44"
    WHEN Age BETWEEN 45 AND 54 THEN "45-54"
    WHEN Age >= 55 THEN "Over 55"
END;

SELECT Age_Group, (COUNT(*)/(SELECT COUNT(*) FROM `portfolio_project`.`hrdataset_mysql`)) * 100 AS Age_Group_Percentage_Distribution
FROM `portfolio_project`.`hrdataset_mysql`
GROUP BY Age_Group
ORDER BY Age_Group_Percentage_Distribution DESC;


-- 2. Employment details analysis
-- a) Distribution of employers per department
SELECT Department, COUNT(Department)
FROM `portfolio_project`.`hrdataset_mysql`
GROUP BY Department;

SELECT Department, (COUNT(*)/(SELECT COUNT(*) FROM `portfolio_project`.`hrdataset_mysql`)) * 100 AS Employer_Distribution_per_Department
FROM `portfolio_project`.`hrdataset_mysql`
GROUP BY Department
ORDER BY Employer_Distribution_per_Department DESC;

-- b) Voluntary Termination vs For-causeTermination
SELECT EmploymentStatus, COUNT(EmploymentStatus)
FROM `portfolio_project`.`hrdataset_mysql`
GROUP BY EmploymentStatus;

-- c) Average salary per department
SELECT Department, ROUND(AVG(Salary), 2) AS Ave_Salary
FROM `portfolio_project`.`hrdataset_mysql`
GROUP BY Department;

--  d) Department with highest salary
SELECT Department, MAX(Salary) AS Department_Total_Salary
FROM `portfolio_project`.`hrdataset_mysql`
GROUP BY Department
ORDER BY Department_Total_Salary;

-- e) Analysis of employee performance
SELECT PerformanceScore, COUNT(PerformanceScore)
FROM `portfolio_project`.`hrdataset_mysql`
GROUP BY PerformanceScore;

SELECT PerformanceScore, (COUNT(*)/(SELECT COUNT(*) FROM `portfolio_project`.`hrdataset_mysql`)) * 100 AS Performance_Score_Percentage
FROM `portfolio_project`.`hrdataset_mysql`
GROUP BY PerformanceScore
ORDER BY Performance_Score_Percentage DESC;

-- f) Analysis of employee satisfaction
SELECT EmpSatisfaction, COUNT(EmpSatisfaction)
FROM `portfolio_project`.`hrdataset_mysql`
GROUP BY EmpSatisfaction; 

SELECT EmpSatisfaction, (COUNT(*)/(SELECT COUNT(*) FROM `portfolio_project`.`hrdataset_mysql`)) * 100 AS Emp_Satisfaction_Percentage
FROM `portfolio_project`.`hrdataset_mysql`
GROUP BY EmpSatisfaction
ORDER BY Emp_Satisfaction_Percentage DESC;

-- g) Analysis of special project - Department with highest amount of special projects
SELECT Employee_Name, SpecialProjectsCount
FROM `portfolio_project`.`hrdataset_mysql`
ORDER BY SpecialProjectsCount DESC;

SELECT Department, MAX(SpecialProjectsCount) AS Department_Total_SpecialProjects
FROM `portfolio_project`.`hrdataset_mysql`
GROUP BY Department
ORDER BY Department_Total_SpecialProjects;


