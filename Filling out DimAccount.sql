-- Filling out DimAccount
INSERT INTO dbo.DimAccount (AccountID, CustomerID, AccountType, Balance, DateOpened, Status)
SELECT 
    account_id,
    customer_id,
    account_type,
    balance,
    date_opened,
    status
FROM dbo.Staging_Account
WHERE account_id NOT IN (SELECT AccountID FROM dbo.DimAccount);

