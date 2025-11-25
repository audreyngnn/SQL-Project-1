/* 
Total sales of furniture products, grouped by each quarter of the year, 
and order the results chronologically. 
*/

SELECT 
    CONCAT('Q', DATEPART(QUARTER, ORDER_DATE), '-', YEAR(ORDER_DATE)) AS Quarter_Year,
    CAST(SUM(SALES) AS DECIMAL(10,2)) AS Total_Sales
FROM ORDERS o
JOIN PRODUCT p ON o.PRODUCT_ID = p.ID
WHERE p.NAME = 'Furniture'
GROUP BY YEAR(ORDER_DATE), DATEPART(QUARTER, ORDER_DATE)
ORDER BY YEAR(ORDER_DATE), DATEPART(QUARTER, ORDER_DATE);


/* 
Analyze the impact of different discount levels on sales performance across product categories, 
specifically looking at the number of orders and total profit generated for each discount classification.

Discount level condition:
No Discount = 0
0 < Low Discount <= 0.2
0.2 < Medium Discount <= 0.5
High Discount > 0.5 
*/

WITH DiscountCategories AS (
    SELECT 
        o.*,
        p.CATEGORY,
        CASE 
            WHEN DISCOUNT = 0 THEN 'No Discount'
            WHEN DISCOUNT > 0 AND DISCOUNT <= 0.2 THEN 'Low Discount'
            WHEN DISCOUNT > 0.2 AND DISCOUNT <= 0.5 THEN 'Medium Discount'
            WHEN DISCOUNT > 0.5 THEN 'High Discount'
        END AS Discount_Level
    FROM ORDERS o
    JOIN PRODUCT p ON o.PRODUCT_ID = p.ID
)
SELECT 
    CATEGORY,
    Discount_Level,
    COUNT(DISTINCT ORDER_ID) AS Total_Orders,
    CAST(SUM(PROFIT) AS DECIMAL(10,2)) AS Total_Profit
FROM DiscountCategories
GROUP BY CATEGORY, Discount_Level
ORDER BY CATEGORY, 
    CASE Discount_Level
        WHEN 'No Discount' THEN 1
        WHEN 'Low Discount' THEN 2
        WHEN 'Medium Discount' THEN 3
        WHEN 'High Discount' THEN 4
    END;


/* 
Determine the top-performing product categories within each customer segment based on sales and profit, 
focusing specifically on those categories that rank within the top two for profitability. 
*/
WITH Profitability AS (
    SELECT 
        c.SEGMENT,
        p.CATEGORY,
        SUM(o.SALES) AS Total_Sales,
        SUM(o.PROFIT) AS Total_Profit,
        ROW_NUMBER() OVER (PARTITION BY c.SEGMENT ORDER BY SUM(o.PROFIT) DESC) AS Profit_Rank,
        ROW_NUMBER() OVER (PARTITION BY c.SEGMENT ORDER BY SUM(o.SALES) DESC) AS Sales_Rank
    FROM ORDERS o
    JOIN CUSTOMER c ON o.CUSTOMER_ID = c.ID
    JOIN PRODUCT p ON o.PRODUCT_ID = p.ID
    GROUP BY c.SEGMENT, p.CATEGORY
)
SELECT 
    SEGMENT,
    CATEGORY,
    Sales_Rank,
    Profit_Rank
FROM Profitability
WHERE Profit_Rank <= 2
ORDER BY SEGMENT, Profit_Rank;


/*
Create a report that displays each employee's performance across different product categories, showing not only the 
total profit per category but also what percentage of their total profit each category represents, with the result 
ordered by the percentage in descending order for each employee.
*/

WITH ProfitCon AS (
    SELECT 
        e.ID_EMPLOYEE,
        p.CATEGORY,
        CAST(SUM(PROFIT) AS DECIMAL(10,2)) AS Rounded_Total_Profit
    FROM ORDERS o
    JOIN EMPLOYEES e ON o.ID_EMPLOYEE = e.ID_EMPLOYEE
    JOIN PRODUCT p ON o.PRODUCT_ID = p.ID
    GROUP BY e.ID_EMPLOYEE, p.CATEGORY
),
TotalProfitCon AS (
    SELECT 
        ID_EMPLOYEE,
        SUM(Rounded_Total_Profit) AS Total_Profit
    FROM ProfitCon
    GROUP BY ID_EMPLOYEE
)
SELECT 
    pc.ID_EMPLOYEE,
    pc.CATEGORY,
    pc.Rounded_Total_Profit,
    CAST(ROUND((pc.Rounded_Total_Profit * 100.0 / tpc.Total_Profit), 2) AS DECIMAL(5,2)) AS Profit_Percentage
FROM ProfitCon pc
JOIN TotalProfitCon tpc ON pc.ID_EMPLOYEE = tpc.ID_EMPLOYEE
ORDER BY pc.ID_EMPLOYEE, Profit_Percentage DESC;