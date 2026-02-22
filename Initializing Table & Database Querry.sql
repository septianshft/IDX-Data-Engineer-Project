create database DWH

use dwh


-- Creating table dimension (branch_id, branch_name, branch_location)
CREATE TABLE DimBranch (
    BranchID int NOT NULL PRIMARY KEY,
    BranchName varchar(50),
    BranchLocation varchar(100)
);

-- Creating DimAccount (account)
CREATE TABLE DimAccount (
    AccountID int NOT NULL PRIMARY KEY,
    CustomerID int NOT NULL, 
    AccountType varchar(20),
    Balance decimal(18,2),
    DateOpened datetime,
    Status varchar(20)
);

--Creating Dim Cust (cust + city + state)
CREATE TABLE DimCustomer (
    CustomerID int NOT NULL PRIMARY KEY,
    CustomerName varchar(100),
    Address varchar(255),
    CityName varchar(100),
    StateName varchar(100),
    Age int,
    Gender varchar(10),
    Email varchar(100)
);

-- Creating Fact Transact
CREATE TABLE FactTransaction (
    TransactionID int NOT NULL PRIMARY KEY, 
    AccountID int NOT NULL,
    BranchID int,
    TransactionDate datetime,
    Amount decimal(18,2),
    TransactionType varchar(50),
    CONSTRAINT FK_Fact_Account FOREIGN KEY (AccountID) REFERENCES DimAccount(AccountID),
    CONSTRAINT FK_Fact_Branch FOREIGN KEY (BranchID) REFERENCES DimBranch(BranchID),
    CONSTRAINT FK_Fact_Customer FOREIGN KEY (AccountID) REFERENCES DimAccount(AccountID) 
);


