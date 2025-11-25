
/*
Develop a user-defined function in SQL Server to calculate the profitability ratio for each product category 
an employee has sold, and then apply this function to generate a report that sorts each employee's product categories
by their profitability ratio.
*/
CREATE FUNCTION dbo.ProfitRate
(
    @EmployeeID INT,
    @Category NVARCHAR(50)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @ProfitRate DECIMAL(10,2);
    
    SELECT @ProfitRate = 
        CASE 
            WHEN SUM(SALES) > 0 THEN SUM(PROFIT) * 1.0 / SUM(SALES)
            ELSE 0
        END
    FROM ORDERS o
    JOIN PRODUCT p ON o.PRODUCT_ID = p.ID
    WHERE o.ID_EMPLOYEE = @EmployeeID 
        AND p.CATEGORY = @Category;
    
    RETURN ISNULL(@ProfitRate, 0);
END;
GO


SELECT 
    e.ID_EMPLOYEE,
    p.CATEGORY,
    CAST(SUM(o.SALES) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(SUM(o.PROFIT) AS DECIMAL(10,2)) AS Total_Profit,
    dbo.ProfitRate(e.ID_EMPLOYEE, p.CATEGORY) AS Profitability_Ratio
FROM ORDERS o
JOIN EMPLOYEES e ON o.ID_EMPLOYEE = e.ID_EMPLOYEE
JOIN PRODUCT p ON o.PRODUCT_ID = p.ID
GROUP BY e.ID_EMPLOYEE, e.NAME, p.CATEGORY
ORDER BY e.ID_EMPLOYEE, dbo.ProfitRate(e.ID_EMPLOYEE, p.CATEGORY) DESC;