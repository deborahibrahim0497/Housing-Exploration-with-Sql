SELECT *
  FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL]


  -- Create a new table with the same structure
SELECT *
INTO [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL_Backup]
FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL];

-- Total Revenue
SELECT SUM(CAST (Sales_Amount AS Float)) AS total_revenue
FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL];

--Total Cost (using Assessed_Value)
SELECT SUM(CAST (Assessed_Value AS FLOAT)) AS total_cost
FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL];


--Total Profit
SELECT 
    (SUM(CAST (Sales_Amount AS FLOAT)) - SUM(CAST (Assessed_Value AS FLOAT))) AS total_profit
FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL];

--Total Revenue
SELECT 
    SUM(CAST (Sales_Amount AS FLOAT)) AS total_revenue,
    (SUM(CAST (Sales_Amount AS FLOAT)) - SUM(CAST (Assessed_Value AS FLOAT))) AS total_profit
FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL];


--Count the total number of properties in the dataset
SELECT COUNT(*) AS total_properties
FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL];

--Get a breakdown of property types (e.g., Residential, Commercial)
SELECT Property_Type, COUNT(*) AS property_count
FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL]
GROUP BY Property_Type;


--Calculate the average assessed value and sales amount for each town
SELECT Town, 
       AVG(CAST (Assessed_Value AS FLOAT)) AS avg_assessed_value, 
       AVG(CAST (Sales_Amount AS Float)) AS avg_sales_amount
FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL]
GROUP BY Town;


--Find the top 5 most expensive properties by sales amount
SELECT Top 5 Town, Address, Sales_Amount
FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL]
ORDER BY Sales_Amount DESC;

--Get a list of properties with a Sales Ratio lower than 0.5
SELECT Town, Address, Assessed_Value, Sales_Amount, CAST(Sales_Ratio AS DECIMAL(10, 4)) AS Sales_Ratio
FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL]
WHERE CAST(Sales_Ratio AS DECIMAL(10, 4)) < 0.5;

SELECT Town, Address, Assessed_Value, Sales_Amount, 
       CASE 
           WHEN ISNUMERIC(Sales_Ratio) = 1 THEN CAST(Sales_Ratio AS DECIMAL(10, 4)) 
           ELSE NULL 
       END AS Sales_Ratio
FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL]
WHERE ISNUMERIC(Sales_Ratio) = 1 
      AND CAST(Sales_Ratio AS DECIMAL(10, 4)) < 0.5;

	  SELECT Sales_Ratio
FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL]
WHERE ISNUMERIC(Sales_Ratio) = 1
  AND TRY_CAST(Sales_Ratio AS DECIMAL(38, 18)) IS NULL;

  SELECT Town, Address, Assessed_Value, Sales_Amount, 
       TRY_CAST(Sales_Ratio AS FLOAT) AS Sales_Ratio
FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL]
WHERE ISNUMERIC(Sales_Ratio) = 1
  AND TRY_CAST(Sales_Ratio AS FLOAT) < 0.5;


--Find the properties sold in a specific year (e.g., 2021)
SELECT Town, Address, Assessed_Value, Sales_Amount, Date
FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL]
WHERE YEAR(Date) = 2021;

--Total properties for 2021
SELECT COUNT(*) AS total_properties_sold
FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL]
WHERE YEAR(Date) = 2021;

--Total properties sold per year
SELECT YEAR(Date) AS Year_Sold, 
       COUNT(*) AS Total_Properties_Sold
FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL]
GROUP BY YEAR(Date)
ORDER BY Year_Sold;

--Find the highest and lowest Sales Ratios
SELECT 
    MAX(CAST(Sales_Ratio AS FLOAT)) AS highest_sales_ratio, 
    MIN(CAST(Sales_Ratio AS FLOAT)) AS lowest_sales_ratio
FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL];


--Get the total sales amount by property type
SELECT Property_Type, SUM(CAST (Sales_Amount AS FLOAT)) AS total_sales_amount
FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL]
GROUP BY Property_Type;


--Get the top 5 towns with the highest average Sales Amount
SELECT Top 5 Town, AVG(CAST (Sales_Amount AS FLOAT)) AS avg_sales_amount
FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL]
GROUP BY Town
ORDER BY avg_sales_amount DESC;

--Find properties that have been assessed for more than $500,000 and their respective sales amounts
SELECT Town, Address, Assessed_Value, Sales_Amount
FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL]
WHERE Assessed_Value > 500000;

SELECT *, 
       LEAD(Property_Type) OVER (ORDER BY Serial_Number) AS next_property_type
FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL];

WITH CTE AS (
    SELECT Serial_Number, 
           Property_Type, 
           LEAD(Property_Type) OVER (ORDER BY Serial_Number) AS next_property_type
    FROM [HOUSING].[dbo].[Real_Estate_Sales_2001-2021_GL]
)
UPDATE CTE
SET Property_Type = next_property_type
WHERE Property_Type IS NULL;










