/*
Using dynamic SQL query to calculate the total profit for the last six quarters in the datasets, 
pivoted by quarter of the year, for each state.
*/

DECLARE @SQL NVARCHAR(MAX);
DECLARE @Columns NVARCHAR(MAX);

-- Get distinct quarters first, then select top 6
SELECT @Columns = STRING_AGG(QUOTENAME(Q_Year), ', ') 
WITHIN GROUP (ORDER BY Sort_Order DESC)
FROM (
    SELECT TOP 6
        CONCAT('Q', Quarter, '-', Year) AS Q_Year,
        Year * 10 + Quarter AS Sort_Order
    FROM (
        SELECT DISTINCT 
            YEAR(ORDER_DATE) AS Year,
            DATEPART(QUARTER, ORDER_DATE) AS Quarter
        FROM ORDERS
    ) AS DistinctQuarters
    ORDER BY Year * 10 + Quarter DESC
) AS LastSixQuarters;

-- Now build and execute the dynamic SQL
SET @SQL = N'
WITH QuarterlyProfit AS (
    SELECT 
        c.STATE,
        CONCAT(''Q'', DATEPART(QUARTER, o.ORDER_DATE), ''-'', YEAR(o.ORDER_DATE)) AS Quarter_Year,
        CAST(o.PROFIT AS DECIMAL(10,2)) AS PROFIT
    FROM ORDERS o
    JOIN CUSTOMER c ON o.CUSTOMER_ID = c.ID
)
SELECT STATE, ' + @Columns + N'
FROM (
    SELECT STATE, Quarter_Year, PROFIT
    FROM QuarterlyProfit
) AS SourceTable
PIVOT (
    SUM(PROFIT)
    FOR Quarter_Year IN (' + @Columns + N')
) AS PivotTable
ORDER BY STATE;';

EXEC sp_executesql @SQL;