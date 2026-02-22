-- Filling out DimCustomer
INSERT INTO dbo.DimCustomer (CustomerID, CustomerName, Address, CityName, StateName, Age, Gender, Email)
SELECT 
    c.customer_id,
    UPPER(c.customer_name), 
    UPPER(c.address),
    UPPER(ci.city_name),   
    UPPER(s.state_name), 
    c.age,
    UPPER(c.gender),
    UPPER(c.email)
FROM dbo.Staging_Customer c
LEFT JOIN dbo.Staging_City ci ON c.city_id = ci.city_id
LEFT JOIN dbo.Staging_State s ON ci.state_id = s.state_id
WHERE c.customer_id NOT IN (SELECT CustomerID FROM dbo.DimCustomer);