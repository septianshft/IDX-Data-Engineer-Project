CREATE PROCEDURE dbo.usp_BalancePerCustomer
    @CustomerName VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        c.CustomerName,
        a.AccountType,
        a.Balance AS [Saldo Awal],
        a.Balance + COALESCE(SUM(CASE 
                        WHEN t.TransactionType = 'Deposit' THEN t.Amount 
                        ELSE -t.Amount 
                      END), 0) AS [Saldo Sekarang]
    FROM 
        dbo.DimCustomer c
    JOIN 
        dbo.DimAccount a ON c.CustomerID = a.CustomerID
    LEFT JOIN 
        dbo.FactTransaction t ON a.AccountID = t.AccountID
    WHERE 
        c.CustomerName = @CustomerName
        AND a.Status = 'Active' 
    GROUP BY 
        c.CustomerName, a.AccountType, a.Balance;
END;
