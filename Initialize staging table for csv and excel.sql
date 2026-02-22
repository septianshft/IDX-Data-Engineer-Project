-- 1. Staging table for CSV
CREATE TABLE dbo.Staging_Transaction_CSV (
    transaction_id VARCHAR(50),
    account_id VARCHAR(50),
    transaction_date VARCHAR(50), 
    amount DECIMAL(18, 2),
    transaction_type VARCHAR(50),
    branch_id VARCHAR(50)
);


-- 2. Staging table for excel
CREATE TABLE dbo.Staging_Transaction_Excel (
    transaction_id VARCHAR(50),
    account_id VARCHAR(50),
    transaction_date VARCHAR(50), 
    amount DECIMAL(18, 2),
    transaction_type VARCHAR(50),
    branch_id VARCHAR(50)
);