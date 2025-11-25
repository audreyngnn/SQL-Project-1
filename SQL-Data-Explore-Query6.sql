/* 
A stored procedure to calculate the total sales and profit for a specific EMPLOYEE_ID over a specified date range. 
The procedure should accept EMPLOYEE_ID, StartDate, and EndDate as parameters.
*/

CREATE PROCEDURE GetEmployeeSalesProfit
    @EmployeeID INT,
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT 
        e.NAME AS EMPLOYEE_NAME,
        CAST(SUM(o.SALES) AS DECIMAL(10,2)) AS TOTAL_SALES,
        CAST(SUM(o.PROFIT) AS DECIMAL(10,2)) AS TOTAL_PROFIT
    FROM ORDERS o
    JOIN EMPLOYEES e ON o.ID_EMPLOYEE = e.ID_EMPLOYEE
    WHERE o.ID_EMPLOYEE = @EmployeeID
        AND o.ORDER_DATE BETWEEN @StartDate AND @EndDate
    GROUP BY e.NAME;
END;

EXEC GetEmployeeSalesProfit
    @EmployeeID = 3, 
    @StartDate = '2016-12-01', 
    @EndDate = '2016-12-31';
