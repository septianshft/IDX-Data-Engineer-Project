-- filling out DimBranch
INSERT INTO dbo.DimBranch (BranchID, BranchName, BranchLocation)
SELECT 
    CAST(branch_id AS INT), 
    branch_name, 
    branch_location
FROM dbo.Staging_Branch
WHERE branch_id NOT IN (SELECT BranchID FROM dbo.DimBranch);

