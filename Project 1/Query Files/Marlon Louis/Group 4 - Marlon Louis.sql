--Author: Marlon Louis

--(Simple 1) Find all customers who placed orders from US and the name and region of the employee who serviced them
USE Northwinds2020TSQLV6;
SELECT C.CustomerCountry,
       C.CustomerId,
       C.CustomerContactName,
       E.EmployeeFirstName,
       E.EmployeeId
FROM Sales.Customer AS C
    INNER JOIN Sales.[Order] AS O
        ON C.CustomerId = O.CustomerId
    INNER JOIN HumanResources.Employee AS E
        ON E.EmployeeId = O.EmployeeId
WHERE C.CustomerCountry = N'USA'
ORDER BY C.CustomerId,
         E.EmployeeId
FOR JSON PATH, ROOT('Simple 1 Output'), INCLUDE_NULL_VALUES;

--(Simple 2) Find all product names, price, and the name of the product supplier
USE Northwinds2020TSQLV6;
SELECT P.ProductName,
       P.UnitPrice,
       S.SupplierContactName,
       S.SupplierContactTitle,
       S.SupplierCompanyName
FROM Production.Product AS P
    INNER JOIN Production.Supplier AS S
        ON P.SupplierId = S.SupplierId
ORDER BY P.UnitPrice DESC
FOR JSON PATH, ROOT('Simple 2 Output'), INCLUDE_NULL_VALUES;


--(Simple 3) List all employee titles and their current pay
USE AdventureWorks2017;
SELECT E.BusinessEntityID,
       E.JobTitle,
       P.Rate AS HourlyWage
FROM HumanResources.Employee AS E
    INNER JOIN HumanResources.EmployeePayHistory AS P
        ON E.BusinessEntityID = P.BusinessEntityID
ORDER BY HourlyWage DESC
FOR JSON PATH, ROOT('Simple 3 Output'), INCLUDE_NULL_VALUES;

--(Simple 4) List all employee names and their phone number
USE AdventureWorks2017;
SELECT n.FirstName,
       n.LastName,
       p.PhoneNumber
FROM Person.PersonPhone AS p
    INNER JOIN Person.Person AS n
        ON p.BusinessEntityID = n.BusinessEntityID
ORDER BY p.BusinessEntityID
FOR JSON PATH, ROOT('Simple 4 Output'), INCLUDE_NULL_VALUES;

--(Simple 5) List sales people in order from previous year earnings
USE AdventureWorks2017;
SELECT p.BusinessEntityID,
       p.FirstName,
       p.LastName,
       s.SalesYTD,
       s.SalesLastYear
FROM Sales.SalesPerson AS s
    INNER JOIN Person.Person AS p
        ON s.BusinessEntityID = p.BusinessEntityID
ORDER BY SalesLastYear DESC
FOR JSON PATH, ROOT('Simple 5 Output'), INCLUDE_NULL_VALUES;

USE Northwinds2020TSQLV6;

--(Medium 1) Find the product name and Id that was purchased the most amongst all customers
USE Northwinds2020TSQLV6;
SELECT O.ProductId,
       P.ProductName,
       P.UnitPrice,
       COUNT(*) AS numSales
FROM Sales.[OrderDetail] AS O
    INNER JOIN Production.Product AS P
        ON O.ProductId = P.ProductId
GROUP BY O.ProductId,
         P.ProductName,
         P.UnitPrice
ORDER BY numSales DESC
FOR JSON PATH, ROOT('Medium 1 Output'), INCLUDE_NULL_VALUES;

--(Medium 2) Find the customers who spent the most on purchasing products.
USE Northwinds2020TSQLV6;
SELECT TOP 5
       o.CustomerId,
       c.CustomerContactName,
       SUM(d.UnitPrice * d.Quantity) AS totalSpent
FROM Sales.OrderDetail AS d
    INNER JOIN Sales.[Order] AS o
        ON d.OrderId = o.OrderId
    INNER JOIN Sales.Customer AS c
        ON o.CustomerId = c.CustomerId
GROUP BY o.CustomerId,
         c.CustomerContactName
ORDER BY totalSpent DESC
FOR JSON PATH, ROOT('Medium 2 Output'), INCLUDE_NULL_VALUES;



--(Medium 3) Find the city where most customers reside and list them all
USE AdventureWorksDW2017;
SELECT g.City,
       c.FirstName,
       c.LastName,
       c.EmailAddress,
       c.BirthDate,
       c.Gender,
       c.YearlyIncome
FROM dbo.DimCustomer AS c
    INNER JOIN dbo.DimGeography AS g
        ON c.GeographyKey = g.GeographyKey
WHERE g.City =
(
    SELECT City
    FROM
    (
        SELECT TOP 1
               g.City,
               COUNT(*) AS custLocal
        FROM dbo.DimCustomer AS c
            INNER JOIN dbo.DimGeography AS g
                ON g.GeographyKey = c.GeographyKey
        GROUP BY g.City
        ORDER BY custLocal DESC
    ) AS gu
)
ORDER BY YearlyIncome DESC
FOR JSON PATH, ROOT('Medium 3 Output'), INCLUDE_NULL_VALUES;

USE AdventureWorksDW2017;

--(Medium 4) Find the salaried employees who had the higest sales quotas to meet from 2010-2013
USE AdventureWorksDW2017;
SELECT TOP 10
       e.Title,
       e.EmployeeKey,
       e.FirstName,
       e.LastName,
       q.CalendarYear,
       q.SalesAmountQuota,
       t.SalesTerritoryRegion,
       t.SalesTerritoryCountry
FROM dbo.DimEmployee AS e
    INNER JOIN dbo.FactSalesQuota AS q
        ON e.EmployeeKey = q.EmployeeKey
    INNER JOIN dbo.DimSalesTerritory AS t
        ON e.SalesTerritoryKey = t.SalesTerritoryKey
WHERE e.SalariedFlag = 1
ORDER BY SalesAmountQuota DESC
FOR JSON PATH, ROOT('Medium 4 Output'), INCLUDE_NULL_VALUES;



--(Medium 5) Find the resellers who sold the most value. List some information abot their operations
USE AdventureWorksDW2017;
SELECT sales.ResellerKey,
       rs.ResellerName,
       rs.AnnualSales,
       rs.NumberEmployees,
       terr.SalesTerritoryCountry,
       terr.SalesTerritoryRegion
FROM dbo.DimReseller AS rs
    INNER JOIN dbo.FactResellerSales AS sales
        ON rs.ResellerKey = sales.ResellerKey
    INNER JOIN dbo.DimSalesTerritory AS terr
        ON sales.SalesTerritoryKey = terr.SalesTerritoryKey
WHERE rs.AnnualSales =
(
    SELECT MAX(AnnualSales) FROM dbo.DimReseller
)
GROUP BY sales.ResellerKey,
         rs.ResellerName,
         rs.AnnualSales,
         rs.NumberEmployees,
         terr.SalesTerritoryCountry,
         terr.SalesTerritoryRegion
FOR JSON PATH, ROOT('Medium 5 Output'), INCLUDE_NULL_VALUES;


--(Medium 6) List the most popular items from internet sales and give some details
USE AdventureWorksDW2017;
SELECT sales.ProductKey,
       prod.EnglishProductName,
       sales.UnitPrice,
       COUNT(*) AS NumSales,
       sales.UnitPrice * COUNT(*) AS ValueSold
FROM dbo.FactInternetSales AS sales
    INNER JOIN dbo.DimProduct AS prod
        ON sales.ProductKey = prod.ProductKey
GROUP BY sales.ProductKey,
         prod.EnglishProductName,
         sales.UnitPrice
ORDER BY COUNT(*) DESC
FOR JSON PATH, ROOT('Medium 6 Output'), INCLUDE_NULL_VALUES;



--(Medium 7) Order departments based on the number of employees in each department 
USE AdventureWorks2017;
SELECT depohist.DepartmentID,
       depo.Name AS DepartmentName,
       COUNT(E.BusinessEntityID) AS NumEmployees
FROM HumanResources.Employee AS E
    INNER JOIN HumanResources.EmployeeDepartmentHistory AS depohist
        ON E.BusinessEntityID = depohist.BusinessEntityID
    INNER JOIN HumanResources.Department AS depo
        ON depohist.DepartmentID = depo.DepartmentID
GROUP BY depohist.DepartmentID,
         depo.Name
ORDER BY COUNT(E.BusinessEntityID) DESC
FOR JSON PATH, ROOT('Medium 7 Output'), INCLUDE_NULL_VALUES;

--(Medium 8) Find the most profitable products
USE AdventureWorks2017;
SELECT prod.ProductID,
       prod.Name AS ProductName,
       AVG(cost.StandardCost) AS AvgCostToProd,
       AVG(list.ListPrice) AS AvgSellPrice,
       AVG(list.ListPrice) - AVG(cost.StandardCost) AS AvgProfit
FROM Production.Product AS prod
    INNER JOIN Production.ProductCostHistory AS cost
        ON prod.ProductID = cost.ProductID
    INNER JOIN Production.ProductListPriceHistory AS list
        ON prod.ProductID = list.ProductID
GROUP BY prod.ProductID,
         prod.Name
ORDER BY AvgProfit DESC
FOR JSON PATH, ROOT('Medium 8 Output'), INCLUDE_NULL_VALUES;


/*
* Complex 1 -Find the average amount of days between order and ship date for each customer. Give some additional information on customers
*/

USE Northwinds2020TSQLV6;

DROP FUNCTION IF EXISTS [Sales].[calcDateAvg];
GO
CREATE FUNCTION [Sales].[calcDateAvg]
(
    @id INT
)
RETURNS INT
AS
BEGIN
    DECLARE @avg INT;

    SET @avg =
    (
        SELECT AVG(DATEDIFF(DAY, OrderDate, ShipToDate))
        FROM Sales.[Order]
        WHERE CustomerId = @id
        GROUP BY CustomerId
    );

    RETURN @avg;
END;
GO


DROP FUNCTION IF EXISTS [Sales].[favEmployee];
GO
CREATE FUNCTION [Sales].[favEmployee]
(
    @custId INT
)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @favEmp NVARCHAR(100);
    DECLARE @empl INT;

    SET @empl =
    (
        SELECT TOP 1
               EmployeeId
        FROM Sales.[Order]
        WHERE CustomerId = @custId
        GROUP BY CustomerId,
                 EmployeeId
        ORDER BY COUNT(EmployeeId) DESC
    );
    SET @favEmp =
    (
        SELECT EmployeeFirstName
        FROM HumanResources.Employee
        WHERE EmployeeId = @empl
    ) + N' ' +
    (
        SELECT EmployeeLastName
        FROM HumanResources.Employee
        WHERE EmployeeId = @empl
    );

    RETURN @favEmp;
END;
GO


USE Northwinds2020TSQLV6;
SELECT c.CustomerId,
       c.CustomerContactName,
       c.CustomerCity,
       [Sales].[calcDateAvg](c.CustomerId) AS AvgResponseInDays,
       COUNT(so.CustomerId) AS NumOrders,
       [Sales].[favEmployee](c.CustomerId) AS FreqHandBy
FROM Sales.[Order] AS so
    INNER JOIN Sales.Customer AS c
        ON so.CustomerId = c.CustomerId
    INNER JOIN HumanResources.Employee AS e
        ON so.EmployeeId = e.EmployeeId
GROUP BY c.CustomerId,
         c.CustomerContactName,
         c.CustomerCity
ORDER BY AvgResponseInDays ASC
FOR JSON PATH, ROOT('Complex 1 Output'), INCLUDE_NULL_VALUES;


/*
* Complex 2 -Rank Suppliers based on the number of deliveries they completed and find their most frequent customer
*/

USE Northwinds2020TSQLV6;

DROP FUNCTION IF EXISTS Sales.freqCust;
GO
CREATE FUNCTION Sales.[freqCust]
(
    @supid INT
)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @custid INT;
    DECLARE @custName NVARCHAR(100);

    SET @custid =
    (
        SELECT TOP 1
               CustomerId
        FROM Sales.[Order]
        WHERE ShipperId = @supid
        GROUP BY ShipperId,
                 CustomerId
        ORDER BY COUNT(CustomerId) DESC
    );
    SET @custName =
    (
        SELECT CustomerContactName FROM Sales.Customer WHERE CustomerId = @custid
    );

    RETURN @custName;
END;
GO


USE Northwinds2020TSQLV6;
SELECT s.ShipperId,
       s.ShipperCompanyName,
       COUNT(o.ShipperId) AS NumDeliveries,
       Sales.[freqCust](s.ShipperId) AS FreqCust
FROM Sales.[Order] AS o
    INNER JOIN Sales.OrderDetail AS od
        ON o.OrderId = od.OrderId
    INNER JOIN Sales.Shipper AS s
        ON s.ShipperId = o.ShipperId
GROUP BY s.ShipperId,
         s.ShipperCompanyName
ORDER BY NumDeliveries DESC
FOR JSON PATH, ROOT('Complex 2 Output'), INCLUDE_NULL_VALUES;


/*
* Complex 3 -Rank suppliers based on the total value of their catalogs
*/

USE Northwinds2020TSQLV6;

--function to find avg val of all prods
DROP FUNCTION IF EXISTS Production.avgInvtValue;
GO
CREATE FUNCTION Production.[avgInvtValue]
(
    @supid INT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @avg FLOAT;


    SET @avg =
    (
        SELECT AVG(UnitPrice) FROM Production.Product WHERE SupplierId = @supid
    );

    RETURN @avg;
END;
GO


--function to find most expensive prod name
DROP FUNCTION IF EXISTS Production.mostExpProd;
GO
CREATE FUNCTION Production.[mostExpProd]
(
    @supid INT
)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @prodNam NVARCHAR(100);

    SET @prodNam =
    (
        SELECT TOP 1
               ProductName
        FROM Production.Product
        WHERE SupplierId = @supid
        ORDER BY UnitPrice DESC
    );

    RETURN @prodNam;
END;
GO


DROP FUNCTION IF EXISTS Production.mostExpProdCat;
GO
CREATE FUNCTION Production.[mostExpProdCat]
(
    @supid INT
)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @catNam NVARCHAR(100);
    DECLARE @catid INT;

    SET @catid =
    (
        SELECT TOP 1
               CategoryId
        FROM Production.Product
        WHERE SupplierId = @supid
        ORDER BY UnitPrice DESC
    );
    SET @catNam =
    (
        SELECT CategoryName FROM Production.Category WHERE CategoryId = @catid
    );

    RETURN @catNam;
END;
GO



USE Northwinds2020TSQLV6;
SELECT sup.SupplierId,
       sup.SupplierCompanyName,
       Production.avgInvtValue(sup.SupplierId) AS AvgCatelogValue,
       MAX(prod.UnitPrice) AS MostValProdPrice,
       Production.mostExpProd(sup.SupplierId) AS ProdName,
       Production.mostExpProdCat(sup.SupplierId) AS Category,
       cat.[Description]
FROM Production.Supplier AS sup
    INNER JOIN Production.Product AS prod
        ON sup.SupplierId = prod.SupplierId
    INNER JOIN Production.Category AS cat
        ON cat.CategoryName = Production.mostExpProdCat(sup.SupplierId)
GROUP BY sup.SupplierId,
         sup.SupplierCompanyName,
         cat.[Description]
ORDER BY AvgCatelogValue DESC
FOR JSON PATH, ROOT('Complex 3 Output'), INCLUDE_NULL_VALUES;


/*
* Complex 4 -Find the most productive qtr for each employee based on the number of sales completed
*/

USE Northwinds2020TSQLV6;

--function to convert the date to qtr of the year
DROP FUNCTION IF EXISTS Sales.yearQtr;
GO
CREATE FUNCTION Sales.[yearQtr]
(
    @date DATE
)
RETURNS NVARCHAR(10)
AS
BEGIN
    DECLARE @val NVARCHAR(10);
    DECLARE @month INT;

    SET @month = MONTH(@date);

    SELECT @val = CASE
                      WHEN @month
                           BETWEEN 1 AND 3 THEN
                          'QTR 1'
                      WHEN @month
                           BETWEEN 4 AND 6 THEN
                          'QTR 2'
                      WHEN @month
                           BETWEEN 7 AND 9 THEN
                          'QTR 3'
                      WHEN @month
                           BETWEEN 10 AND 12 THEN
                          'QTR 4'
                      ELSE
                          'Unknown QTR'
                  END;

    RETURN @val;
END;
GO


--function that selects each employees most productive qtr across all years of employment
DROP FUNCTION IF EXISTS Sales.mostProdQtr;
GO
CREATE FUNCTION Sales.[mostProdQtr]
(
    @empl INT
)
RETURNS NVARCHAR(10)
AS
BEGIN
    DECLARE @val NVARCHAR(10);

    SET @val =
    (
        SELECT TOP 1
               Sales.yearQtr(ShipToDate)
        FROM Sales.[Order]
        WHERE EmployeeId = @empl
        GROUP BY Sales.yearQtr(ShipToDate)
        ORDER BY COUNT(*) DESC
    );

    RETURN @val;
END;
GO


--function that returns numOrders from most productive qtr across all years of employment
DROP FUNCTION IF EXISTS Sales.numOrdersProd;
GO
CREATE FUNCTION Sales.[numOrdersProd]
(
    @empl INT
)
RETURNS INT
AS
BEGIN
    DECLARE @val INT;

    SET @val =
    (
        SELECT TOP 1
               COUNT(*)
        FROM Sales.[Order]
        WHERE EmployeeId = @empl
        GROUP BY Sales.yearQtr(ShipToDate)
        ORDER BY COUNT(*) DESC
    );

    RETURN @val;
END;
GO


--function to get num of all employee sales
DROP FUNCTION IF EXISTS Sales.totempsales;
GO
CREATE FUNCTION Sales.[totempsales]
(
    @empl INT
)
RETURNS INT
AS
BEGIN
    DECLARE @val INT;

    SET @val =
    (
        SELECT COUNT(*) FROM Sales.[Order] WHERE EmployeeId = @empl
    );

    RETURN @val;
END;
GO

USE Northwinds2020TSQLV6;
SELECT e.EmployeeId,
       e.EmployeeFirstName,
       e.EmployeeLastName,
       e.EmployeeTitle,
       Sales.mostProdQtr(e.EmployeeId) AS MostProdQtr,
       Sales.numOrdersProd(e.EmployeeId) AS MPQ_Sales,
       Sales.totempsales(e.EmployeeId) AS TotalSales
FROM Sales.[Order] AS o
    INNER JOIN HumanResources.Employee AS e
        ON o.EmployeeId = e.EmployeeId
GROUP BY e.EmployeeId,
         e.EmployeeFirstName,
         e.EmployeeLastName,
         e.EmployeeTitle
ORDER BY TotalSales DESC
FOR JSON PATH, ROOT('Complex 4 Output'), INCLUDE_NULL_VALUES;

/*
* Complex 5 -Rank products based on the total net profit gained accured 3 years
*/


USE AdventureWorks2017;

--function to find profit margins for each product
DROP FUNCTION IF EXISTS Production.profMarg;
GO
CREATE FUNCTION Production.[profMarg]
(
    @prodId INT,
    @year INT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @cost FLOAT;
    DECLARE @price FLOAT;
    DECLARE @res FLOAT;

    SET @cost =
    (
        SELECT StandardCost
        FROM Production.ProductCostHistory
        WHERE ProductID = @prodId
              AND YEAR(StartDate) = @year
    );
    SET @price =
    (
        SELECT ListPrice
        FROM Production.ProductListPriceHistory
        WHERE ProductID = @prodId
              AND YEAR(StartDate) = @year
    );
    SET @res = @price - @cost;

    RETURN @res;
END;
GO

--function to find total profits from each product across 3 years
DROP FUNCTION IF EXISTS Production.prodProfits;
GO
CREATE FUNCTION Production.[prodProfits]
(
    @prodId INT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @sum FLOAT;

    --profit margins times quantity gives total profit
    SET @sum =
    (
        SELECT SUM(Production.profMarg(@prodId, YEAR(TransactionDate)) * Quantity)
        FROM Production.TransactionHistory
        WHERE ProductID = @prodId
              AND TransactionType = 'S'
    );

    RETURN @sum;
END;
GO

--FUNCTION to return the total sales of a specified product
DROP FUNCTION IF EXISTS Production.totSales;
GO
CREATE FUNCTION Production.[totSales]
(
    @prodId INT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @sum FLOAT;

    SET @sum =
    (
        SELECT SUM(ActualCost)
        FROM Production.TransactionHistory
        WHERE ProductID = @prodId
              AND TransactionType = 'S'
    );

    RETURN @sum;
END;
GO


USE AdventureWorks2017;
SELECT prod.ProductID,
       prod.Name,
       mod.Name AS Model,
       AVG(cost.StandardCost) AS AvgProductionCost,
       AVG(price.ListPrice) AS AvgListPrice,
       AVG(price.ListPrice) - AVG(cost.StandardCost) AS AvgProfitMargs,
       Production.prodProfits(prod.ProductID) AS TotalProfits,
       Production.totSales(prod.ProductID) AS TotalSalesAmt
FROM Production.Product AS prod
    INNER JOIN Production.ProductModel AS mod
        ON prod.ProductModelID = mod.ProductModelID
    INNER JOIN Production.ProductListPriceHistory AS price
        ON prod.ProductID = price.ProductID
    INNER JOIN Production.ProductCostHistory AS cost
        ON prod.ProductID = cost.ProductID
GROUP BY prod.ProductID,
         prod.Name,
         mod.Name
ORDER BY TotalProfits DESC
FOR JSON PATH, ROOT('Complex 5 Output'), INCLUDE_NULL_VALUES;


/*
* Complex 6 -Find where employee sales were in relation to their quarter sales quota
*/


USE AdventureWorksDW2017;

--function to break the date into quarters (should return an int indicating the quarter)
DROP FUNCTION IF EXISTS dbo.dateToQtr;
GO
CREATE FUNCTION dbo.[dateToQtr]
(
    @date DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @val INT;
    DECLARE @month INT;

    SET @month = MONTH(@date);

    SELECT @val = CASE
                      WHEN @month
                           BETWEEN 1 AND 3 THEN
                          1
                      WHEN @month
                           BETWEEN 4 AND 6 THEN
                          2
                      WHEN @month
                           BETWEEN 7 AND 9 THEN
                          3
                      WHEN @month
                           BETWEEN 10 AND 12 THEN
                          4
                      ELSE
                          00000 --unknown qtr
                  END;

    RETURN @val;
END;
GO

--function that returns the avg quota amt for each quarter of each year for each employee (that was listed)
DROP FUNCTION IF EXISTS dbo.avgQtrQuota;
GO
CREATE FUNCTION dbo.[avgQtrQuota]
(
    @empkey INT,
    @calyear INT,
    @calqtr INT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @val FLOAT;

    SET @val =
    (
        SELECT AVG(SalesAmountQuota)
        FROM dbo.FactSalesQuota
        WHERE EmployeeKey = @empkey
              AND CalendarYear = @calyear
              AND CalendarQuarter = @calqtr
    );

    RETURN @val;
END;
GO

--function to find actual emp sales for specified year and qtr
DROP FUNCTION IF EXISTS dbo.[actQtrSales];
GO
CREATE FUNCTION dbo.[actQtrSales]
(
    @empkey INT,
    @calyear INT,
    @calqtr INT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @val FLOAT;

    SET @val =
    (
        SELECT SUM(SalesAmount)
        FROM dbo.FactResellerSales
        WHERE EmployeeKey = @empkey
              AND YEAR(ShipDate) = @calyear
              AND dbo.dateToQtr(ShipDate) = @calqtr
    );

    RETURN @val;
END;
GO


USE AdventureWorksDW2017;
SELECT emp.EmployeeKey,
       emp.FirstName,
       emp.LastName,
       emp.Title,
       terr.SalesTerritoryCountry,
       quota.CalendarYear,
       quota.CalendarQuarter,
       AVG(quota.SalesAmountQuota) AS QtrQuota,
       dbo.actQtrSales(emp.EmployeeKey, quota.CalendarYear, quota.CalendarQuarter) AS QuarterSales
FROM dbo.FactSalesQuota AS quota
    INNER JOIN dbo.DimEmployee AS emp
        ON emp.EmployeeKey = quota.EmployeeKey
    INNER JOIN dbo.DimSalesTerritory AS terr
        ON terr.SalesTerritoryKey = emp.SalesTerritoryKey
WHERE quota.CalendarYear != 2010
GROUP BY quota.CalendarYear,
         quota.CalendarQuarter,
         emp.EmployeeKey,
         emp.FirstName,
         emp.LastName,
         emp.Title,
         terr.SalesTerritoryCountry
ORDER BY emp.EmployeeKey,
         quota.CalendarYear,
         quota.CalendarQuarter
FOR JSON PATH, ROOT('Complex 6 Output'), INCLUDE_NULL_VALUES;



/*
* Complex 7 -Rank products based on combined internet and reseller sales
*/


USE AdventureWorksDW2017;
DROP FUNCTION IF EXISTS dbo.[numProdSold];
GO
CREATE FUNCTION dbo.[numProdSold]
(
    @prodId INT
)
RETURNS INT
AS
BEGIN
    DECLARE @val INT;
    DECLARE @sum1 INT;
    DECLARE @sum2 INT;

    SET @sum1 =
    (
        SELECT SUM(OrderQuantity)
        FROM dbo.FactInternetSales
        WHERE ProductKey = @prodId
    );
    SET @sum2 =
    (
        SELECT SUM(OrderQuantity)
        FROM dbo.FactResellerSales
        WHERE ProductKey = @prodId
    );
    SET @val = @sum1 + @sum2;

    RETURN @val;
END;
GO


USE AdventureWorksDW2017;
SELECT prod.ProductKey,
       prod.EnglishProductName,
       subcat.EnglishProductSubcategoryName,
       cat.EnglishProductCategoryName,
       prod.ListPrice,
       dbo.numProdSold(prod.ProductKey) AS TotalUnitsSold
FROM dbo.DimProductSubcategory AS subcat
    INNER JOIN dbo.DimProduct AS prod
        ON prod.ProductSubcategoryKey = subcat.ProductSubcategoryKey
    INNER JOIN dbo.DimProductCategory AS cat
        ON subcat.ProductCategoryKey = cat.ProductCategoryKey
GROUP BY prod.ProductKey,
         prod.EnglishProductName,
         subcat.EnglishProductSubcategoryName,
         cat.EnglishProductCategoryName,
         prod.ListPrice
ORDER BY TotalUnitsSold DESC
FOR JSON PATH, ROOT('Complex 7 Output'), INCLUDE_NULL_VALUES;