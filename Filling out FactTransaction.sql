-- Filling out FactTransaction
INSERT INTO dbo.FactTransaction (TransactionID, AccountID, BranchID, 
TransactionDate, Amount, TransactionType)

-- From CSV
SELECT transaction_id, account_id, branch_id, CONVERT(DATE, transaction_date, 103), amount, transaction_type 
FROM dbo.Staging_Transaction_CSV
WHERE transaction_id NOT IN (SELECT TransactionID FROM dbo.FactTransaction)

UNION ALL

-- From Excel
SELECT transaction_id, account_id, branch_id, transaction_date, amount, transaction_type 
FROM dbo.Staging_Transaction_Excel
WHERE transaction_id NOT IN (SELECT TransactionID FROM dbo.FactTransaction)

UNION ALL

-- From Staging/sample
SELECT transaction_id, account_id, branch_id, transaction_date, amount, transaction_type 
FROM dbo.Staging_Transaction_DB
WHERE transaction_id NOT IN (SELECT TransactionID FROM dbo.FactTransaction);