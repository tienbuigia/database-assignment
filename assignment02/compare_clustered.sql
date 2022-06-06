-- #1: Clustered Index
SELECT CustomerID, AccountNumber
FROM Sales.Customer
WHERE CustomerID = 11001;
-- #2: Non-Clustered
SELECT CustomerID, AccountNumber
FROM Sales.Customer_Index
WHERE CustomerID = 11001;