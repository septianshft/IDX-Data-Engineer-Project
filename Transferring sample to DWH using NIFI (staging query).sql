-- 1. Staging Branch
CREATE TABLE dbo.Staging_Branch (
    branch_id int,
    branch_name varchar(255),
    branch_location varchar(255)
);

-- 2. Staging Account
CREATE TABLE dbo.Staging_Account (
    account_id int,
    customer_id int,
    account_type varchar(50),
    balance decimal(18,2),
    date_opened date,
    status varchar(50)
);

-- 3. Staging Customer 
CREATE TABLE dbo.Staging_Customer (
    customer_id int,
    customer_name varchar(255),
    address varchar(255),
    city_id int,
    age int,
    gender varchar(10),
    email varchar(255)
);

-- 4. Staging City
CREATE TABLE dbo.Staging_City (
    city_id int,
    city_name varchar(255),
    state_id int
);

-- 5. Staging State
CREATE TABLE dbo.Staging_State (
    state_id int,
    state_name varchar(255)
);

-- 6. Staging Transaction

CREATE TABLE dbo.Staging_Transaction_DB (
    transaction_id int,
    account_id int,
    transaction_date date,
    amount decimal(18,2),
    transaction_type varchar(50),
    branch_id int
);
