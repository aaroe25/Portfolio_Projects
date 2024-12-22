/* 
Cleaning data in MySQL
*/


-- Looking at the data we will be workign with
SELECT * 
FROM portfolio_project.hrdataset_mysql;

-- Breaking Employee_Name column into 3 separate columns: (using SUBSTRING)
SELECT Employee_Name,
SUBSTRING_INDEX(Employee_Name, ',', 1) AS Employee_Last_Name,
SUBSTRING_INDEX(Employee_Name, ',', -1) AS Employee_First_Name
FROM `portfolio_project`.`hrdataset_mysql`;

-- Updating table
ALTER TABLE `portfolio_project`.`hrdataset_mysql`
ADD Employee_Last_Name NVARCHAR(255);

UPDATE `portfolio_project`.`hrdataset_mysql`
SET Employee_Last_Name = SUBSTRING_INDEX(Employee_Name, ',', 1);

ALTER TABLE `portfolio_project`.`hrdataset_mysql`
ADD Employee_First_Name NVARCHAR(255);

UPDATE `portfolio_project`.`hrdataset_mysql`
SET Employee_First_Name = SUBSTRING_INDEX(Employee_Name, ',', -1);

-- Trimming text in Employee_First_Name
SELECT TRIM(Employee_First_Name)
FROM `portfolio_project`.`hrdataset_mysql`;

-- Updating table
UPDATE `portfolio_project`.`hrdataset_mysql`
SET Employee_First_Name = TRIM(Employee_First_Name);

-- Changing format for column MarriedID (using CASE statement): Changing "1" to "Yes" and "0" to "No"
SELECT DISTINCT(MarriedID)
FROM `portfolio_project`.`hrdataset_mysql`;

SELECT MarriedID, 
CASE
	WHEN MarriedID = "0" THEN "No"
    WHEN MarriedID = "1" THEN "Yes"
END
FROM `portfolio_project`.`hrdataset_mysql`;

-- Updating table
UPDATE `portfolio_project`.`hrdataset_mysql`
SET MarriedID = CASE
	WHEN MarriedID = "0" THEN "No"
    WHEN MarriedID = "1" THEN "Yes"
END;

-- Changing format for column MaritalStatusID (using CASE statement): Changing "0" to "Single", "1" to "Married", "2" to "Divorsed", "3" to "Widowed", and "4" to "Common-law Married"
SELECT DISTINCT (MaritalStatusID)
FROM `portfolio_project`.`hrdataset_mysql`;

SELECT MaritalStatusID,
CASE
	WHEN MaritalStatusID = "0" THEN "Single"
    WHEN MaritalStatusID = "1" THEN "Married"
    WHEN MaritalStatusID = "2" THEN "Divorsed"
    WHEN MaritalStatusID = "3" THEN "Widowed"
    WHEN MaritalStatusID = "4" THEN "Common-law Married"
END 
FROM `portfolio_project`.`hrdataset_mysql`;

-- Updating table
UPDATE `portfolio_project`.`hrdataset_mysql`
SET MaritalStatusID = CASE
	WHEN MaritalStatusID = "0" THEN "Single"
    WHEN MaritalStatusID = "1" THEN "Married"
    WHEN MaritalStatusID = "2" THEN "Divorsed"
    WHEN MaritalStatusID = "3" THEN "Widowed"
    WHEN MaritalStatusID = "4" THEN "Common-law Married"
END;

-- Changing format for column GenderID (using CASE statement): Changing "1" to "Male" and "0" to "Female"
SELECT DISTINCT (GenderID)
FROM `portfolio_project`.`hrdataset_mysql`;

SELECT GenderID,
CASE 
	WHEN GenderID = "0" THEN "Female"
    WHEN GenderID = "1" THEN "Male"
END
FROM `portfolio_project`.`hrdataset_mysql`;

-- Updating table
UPDATE `portfolio_project`.`hrdataset_mysql`
SET GenderID = CASE 
	WHEN GenderID = "0" THEN "Female"
    WHEN GenderID = "1" THEN "Male"
END;

-- Changing format for column FromDiversityJobFairID (using CASE statement): Changing "1" to "Yes" and "0" to "No"
SELECT DISTINCT (FromDiversityJobFairID)
FROM `portfolio_project`.`hrdataset_mysql`;

SELECT FromDiversityJobFairID,
CASE 
	WHEN FromDiversityJobFairID = "0" THEN "No"
    WHEN FromDiversityJobFairID = "1" THEN "Yes"
END
FROM `portfolio_project`.`hrdataset_mysql`;

-- Updating table
UPDATE `portfolio_project`.`hrdataset_mysql`
SET FromDiversityJobFairID = CASE 
	WHEN FromDiversityJobFairID = "0" THEN "No"
    WHEN FromDiversityJobFairID = "1" THEN "Yes"
END;    


-- Changing format for column Termd (using CASE statement): Changing "1" to "Yes" and "0" to "No"
SELECT DISTINCT (Termd)
FROM `portfolio_project`.`hrdataset_mysql`;

SELECT Termd,
CASE 
	WHEN Termd = "0" THEN "No"
    WHEN Termd = "1" THEN "Yes"
END
FROM `portfolio_project`.`hrdataset_mysql`;

-- Updating table 
UPDATE `portfolio_project`.`hrdataset_mysql`
SET Termd = CASE 
	WHEN Termd = "0" THEN "No"
    WHEN Termd = "1" THEN "Yes"
END;

-- Changing DOB column date format
SELECT DOB, CONVERT(DOB, Date)
FROM `portfolio_project`.`hrdataset_mysql`;

UPDATE `portfolio_project`.`hrdataset_mysql`
SET DOB = CONVERT(DOB, Date);

ALTER TABLE `portfolio_project`.`hrdataset_mysql`
ADD DOB_Converted Date;

UPDATE `portfolio_project`.`hrdataset_mysql`
SET DOB_Converted = CONVERT(DOB, Date); 

-- Changing DateofHire column date format
SELECT DateofHire, CONVERT(DateofHire, Date)
FROM `portfolio_project`.`hrdataset_mysql`;

UPDATE `portfolio_project`.`hrdataset_mysql`
SET DateofHire = CONVERT(DateofHire, Date);

ALTER TABLE `portfolio_project`.`hrdataset_mysql`
ADD DateofHire_Converted Date;

UPDATE `portfolio_project`.`hrdataset_mysql`
SET DateofHire_Converted = CONVERT(DateofHire, Date); 

-- Changing DateofTermination column date format
SELECT DateofTermination, CONVERT(DateofTermination, Date)
FROM `portfolio_project`.`hrdataset_mysql`;

UPDATE `portfolio_project`.`hrdataset_mysql`
SET DateofTerminarion = CONVERT(DateofTermination, Date);

ALTER TABLE `portfolio_project`.`hrdataset_mysql`
ADD DateofTermination_Converted Date;

UPDATE `portfolio_project`.`hrdataset_mysql`
SET DateofTermination_Converted = CONVERT(DateofTermination, Date);

-- Changing LastPerformanceReview_Date column date format
SELECT LastPerformanceReview_Date, CONVERT(LastPerformanceReview_Date, Date)
FROM `portfolio_project`.`hrdataset_mysql`;

UPDATE `portfolio_project`.`hrdataset_mysql`
SET LastPerformanceReview_Date = CONVERT(LastPerformanceReview_Date, Date);

ALTER TABLE `portfolio_project`.`hrdataset_mysql`
ADD LastPerformanceReview_Date_Converted Date;

UPDATE `portfolio_project`.`hrdataset_mysql`
SET LastPerformanceReview_Date_Converted = CONVERT(LastPerformanceReview_Date, Date);


-- Populate ManagerID (Webster Butler)
UPDATE `portfolio_project`.`hrdataset_mysql`
SET ManagerID = NULL WHERE ManagerID='';

SELECT *
FROM `portfolio_project`.`hrdataset_mysql`
WHERE ManagerID IS NULL;

SELECT ManagerID,
CASE 
	WHEN ManagerID IS NULL THEN '39'
ELSE ManagerID
END
FROM `portfolio_project`.`hrdataset_mysql`;

UPDATE `portfolio_project`.`hrdataset_mysql`
SET ManagerID = CASE 
	WHEN ManagerID IS NULL THEN '39'
ELSE ManagerID
END;
