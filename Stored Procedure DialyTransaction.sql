CREATE PROCEDURE dbo.usp_DailyTransaction
    @start_date DATE,
    @end_date DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        TransactionDate AS [Date],
        COUNT(TransactionID) AS [Total Transactions],
        SUM(Amount) AS [Total Amount]
    FROM 
        dbo.FactTransaction
    WHERE 
        TransactionDate BETWEEN @start_date AND @end_date
    GROUP BY 
        TransactionDate
    ORDER BY 
        TransactionDate ASC;
END;