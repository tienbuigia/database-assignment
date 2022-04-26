-- #1
SELECT
    Title, FirstName, MiddleName, LastName
FROM
    Person.Person;
-- #2
SELECT
    ISNULL(Title, '') + ' ' + FirstName + ' ' + LastName AS PersonName
FROM
    Person.Person;
-- #3
SELECT
    AddressLine1 + ' ' + ISNULL(AddressLine2, '') AS AddressLine, City
FROM
    Person.Address;
-- #4
SELECT DISTINCT City
FROM
    Person.Address;
-- #5
SELECT TOP 10
    *
FROM Person.Address;
-- #6
SELECT AVG(Rate) AS AverageRate
FROM HumanResources.EmployeePayHistory;
-- #7
SELECT COUNT(*) AS #Employees
FROM HumanResources.Employee;
-- #8
WITH
    SalesPerCustomer
    AS
    (
        SELECT
            c.CustomerID,
            NumberOfSales = COUNT(soh.SalesOrderID)
        FROM
            Sales.Customer c
            INNER JOIN
            Sales.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID
        GROUP BY    
        c.CustomerID
    )
SELECT
    p.FirstName + ' ' + p.LastName AS CustomerName,
    spc.NumberOfSales
FROM
    SalesPerCustomer spc
    JOIN
    Person.Person p ON p.BusinessEntityID = spc.CustomerID
WHERE 
	spc.NumberOfSales > 10;
-- #9
SELECT
    Name
FROM
    Production.Product
WHERE ProductID NOT IN (
    SELECT ProductID
    FROM
        Sales.SalesOrderDetail
);
-- #10
-- #11

