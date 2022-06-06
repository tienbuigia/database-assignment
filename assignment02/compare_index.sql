-- #1
SELECT CustomerID, AccountNumber
FROM Sales.Customer_NoIndex
WHERE CustomerID = 11001;
-- #2
SELECT CustomerID, AccountNumber
FROM Sales.Customer_Index
WHERE CustomerID = 11001;