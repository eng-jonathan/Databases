--Simple Queries

--1
--Find credit card IDs of all business entities that have used credit cards.

USE AdventureWorks2017;
SELECT DISTINCT
       p.BusinessEntityID,
       pc.CreditCardID
FROM Person.Person AS p
    INNER JOIN Sales.PersonCreditCard AS pc
        ON p.BusinessEntityID = pc.BusinessEntityID
ORDER BY pc.CreditCardID;
--FOR JSON PATH, ROOT ('BusinessCCID'), INCLUDE_NULL_VALUES;

--2
--Find credit card information of all business entities that have used credit cards using their credit card IDs.

USE AdventureWorks2017;
SELECT DISTINCT
       pc.BusinessEntityID,
	   pc.CreditCardID,
	   cc.CardType,
	   cc.CardNumber,
	   cc.ExpMonth,
	   cc.ExpYear,
	   cc.ModifiedDate
FROM Sales.CreditCard AS cc
    INNER JOIN Sales.PersonCreditCard AS pc
        ON cc.CreditCardID = pc.CreditCardID
ORDER BY pc.CreditCardID;
--FOR JSON PATH, ROOT ('BusinessCCInfo'), INCLUDE_NULL_VALUES;

--3
--Using credit card ID, find SalesOrderID, OrderDate, DueDate, ShipDate and Status.

USE AdventureWorks2017;
SELECT cc.CreditCardID,
       oh.OrderDate,
       oh.DueDate,
       oh.ShipDate,
       oh.[Status]
FROM Sales.CreditCard AS cc
    INNER JOIN Sales.SalesOrderHeader AS oh
        ON cc.CreditCardID = oh.CreditCardID
ORDER BY oh.CreditCardID, oh.OrderDate;
--FOR JSON PATH, ROOT ('CCOrderInfo'), INCLUDE_NULL_VALUES;

--4
--Find all respective email addresses for each business using BusinessID.

USE AdventureWorks2017;
SELECT p.BusinessEntityID,
       e.EmailAddress
FROM Person.Person AS p
    INNER JOIN Person.EmailAddress AS e
        ON e.BusinessEntityID = p.BusinessEntityID
ORDER BY p.BusinessEntityID;
--FOR JSON PATH, ROOT ('BusinessEmail'), INCLUDE_NULL_VALUES;

--5
--Find all respective phone numbers for each business using BusinessID.

USE AdventureWorks2017;
SELECT p.BusinessEntityID,
       pp.PhoneNumber
FROM Person.Person AS p
    INNER JOIN Person.PersonPhone AS pp
        ON p.BusinessEntityID = pp.BusinessEntityID
ORDER BY p.BusinessEntityID;
--FOR JSON PATH, ROOT ('BusinessPhone'), INCLUDE_NULL_VALUES;

--Medium Queries

--6
--Find the sum of unitsin in FactProductInventory in each calendar year using the datekey from FactProductInventory and DimDate.

USE AdventureWorksDW2017;
SELECT dd.CalendarYear,
       SUM(fpi.UnitsIn) AS sumunitsin
FROM dbo.DimDate AS dd
    INNER JOIN dbo.FactProductInventory AS fpi
        ON dd.DateKey = fpi.DateKey
GROUP BY dd.CalendarYear;
--FOR JSON PATH, ROOT ('SumUnits'), INCLUDE_NULL_VALUES;	
	
--7
--Using the datekey from FactCurrencyRate, find the spanish version of the date from DimDate.

USE AdventureWorksDW2017;
SELECT fcr.DateKey,
       CONCAT(dd.SpanishMonthName, ' ', dd.SpanishDayNameOfWeek, ' ', dd.CalendarYear) AS spanishdate
FROM dbo.DimDate AS dd
    INNER JOIN dbo.FactCurrencyRate AS fcr
        ON dd.DateKey = fcr.DateKey
GROUP BY fcr.DateKey,
         dd.SpanishMonthName,
         dd.SpanishDayNameOfWeek,
         dd.CalendarYear
ORDER BY fcr.DateKey;
--FOR JSON PATH, ROOT ('SpanishDate'), INCLUDE_NULL_VALUES;	

--8
--Find the minimum average rate of each fiscal year from FactCurrencyRate using DateKey from DimDate.

USE AdventureWorksDW2017;
SELECT dd.FiscalYear,
       MIN(fcr.AverageRate) AS minaveragerate
FROM dbo.DimDate AS dd
    INNER JOIN dbo.FactCurrencyRate AS fcr
        ON dd.DateKey = fcr.DateKey
GROUP BY dd.FiscalYear
ORDER BY dd.FiscalYear;
--FOR JSON PATH, ROOT ('FiscalMinAvg'), INCLUDE_NULL_VALUES;	

--9
--Find the number of scenario keys and display scenario names for each key.

USE AdventureWorksDW2017;
SELECT ff.ScenarioKey,
       ds.ScenarioName,
       COUNT(ff.ScenarioKey) AS scenariocount
FROM dbo.FactFinance AS ff
    INNER JOIN dbo.DimScenario AS ds
        ON ff.ScenarioKey = ds.ScenarioKey
GROUP BY ff.ScenarioKey,
         ds.ScenarioName
ORDER BY ff.ScenarioKey;
--FOR JSON PATH, ROOT ('ScenarioKeyCountAndName'), INCLUDE_NULL_VALUES;	

--10
--Use the department key in FactFinance to figure out if any ParentDepartmentGroupKey in DimDepartmentGroup are NULL, then coalesce them to '0'.

USE AdventureWorksDW2017;
SELECT ff.DepartmentGroupKey,
       COALESCE(ddg.ParentDepartmentGroupKey, 0) AS ParentDepartmentGroupKey
FROM dbo.FactFinance AS ff
    INNER JOIN dbo.DimDepartmentGroup AS ddg
        ON ff.DepartmentGroupKey = ddg.DepartmentGroupKey
GROUP BY ff.DepartmentGroupKey,
         ddg.ParentDepartmentGroupKey
ORDER BY ff.DepartmentGroupKey;
--FOR JSON PATH, ROOT ('CheckKeyForNull'), INCLUDE_NULL_VALUES;	

--11
--Convert the percentage of ownership out of all organizations with their keys from DimOrganization using the OrganizationKey from FactFinance to decimal.

USE AdventureWorksDW2017;
SELECT ff.OrganizationKey,
       (CONVERT(DECIMAL(5, 2), do.PercentageOfOwnership)) AS percentageasdecimal
FROM dbo.DimOrganization AS do
    INNER JOIN dbo.FactFinance AS ff
        ON ff.OrganizationKey = do.OrganizationKey
GROUP BY ff.OrganizationKey,
         do.PercentageOfOwnership
ORDER BY ff.OrganizationKey;
--FOR JSON PATH, ROOT ('ConvertToDecimal'), INCLUDE_NULL_VALUES;

--12
--Using the DateKey from DimDate, find the difference between the DueDate and OrderDate from FactResellerSales.

USE AdventureWorksDW2017;
SELECT dd.DateKey,
       DATEDIFF(DAY, frs.OrderDate, frs.DueDate) AS datedifference
FROM dbo.DimDate AS dd
    INNER JOIN dbo.FactResellerSales AS frs
        ON dd.DateKey = frs.OrderDateKey
GROUP BY dd.DateKey,
         frs.DueDate,
         frs.OrderDate
ORDER BY dd.DateKey;
--FOR JSON PATH, ROOT ('ShipTime'), INCLUDE_NULL_VALUES;

--13
--Using the DateKey from DimDate, find the average amount of unitbalance from FactProductInventory for each calendar year.

USE AdventureWorksDW2017;
SELECT dd.CalendarYear,
       AVG(fpi.UnitsBalance) AS avgunitbal
FROM dbo.DimDate AS dd
    INNER JOIN dbo.FactProductInventory AS fpi
        ON dd.DateKey = fpi.DateKey
GROUP BY dd.CalendarYear
ORDER BY dd.CalendarYear;
--FOR JSON PATH, ROOT ('AVGUnitsBalance'), INCLUDE_NULL_VALUES;

--Complex

--14
--Create a scalar function to combine the first name and last name of each employee from HumanResources.Employee and the contact name and title in Sales.Customer using the OrderID from Sales.[Order].

USE Northwinds2020TSQLV6;
GO

CREATE OR ALTER FUNCTION Sales.udf_FullName
(
    @firstname NVARCHAR(100),
    @lastname NVARCHAR(100)
)
RETURNS NVARCHAR(100)
AS
BEGIN
    RETURN @firstname + ' ' + @lastname;
END;
GO

USE Northwinds2020TSQLV6;
SELECT so.OrderId,
       Sales.udf_FullName(hr.EmployeeFirstName, hr.EmployeeLastName) AS employeefullname,
       Sales.udf_FullName(sc.CustomerContactName, sc.CustomerContactTitle) AS customerfullname
FROM Sales.[Order] AS so
    INNER JOIN HumanResources.Employee AS hr
        ON so.EmployeeId = hr.EmployeeId
    INNER JOIN Sales.Customer AS sc
        ON so.CustomerId = sc.CustomerId
GROUP BY so.OrderId,
         hr.EmployeeFirstName,
         hr.EmployeeLastName,
         sc.CustomerContactName,
         sc.CustomerContactTitle
ORDER BY so.OrderId;
--FOR JSON PATH, ROOT ('FullName'), INCLUDE_NULL_VALUES;

--15
--Create a scalar function that returns average unit price from Production.Product and the ship date from Sales.[Order] using the OrderId in Sales.OrderDetail.

USE Northwinds2020TSQLV6;
GO

CREATE OR ALTER FUNCTION Sales.udf_AverageUnit
(
    @unitprice MONEY
)
RETURNS MONEY
BEGIN
    DECLARE @average MONEY;
    SELECT @average = (SUM(@unitprice) / COUNT(@unitprice));
    RETURN @average;
END;
GO

USE Northwinds2020TSQLV6;
SELECT od.OrderId,
       Sales.udf_AverageUnit(pp.UnitPrice) AS avgunitprice,
       o.ShipToDate AS shiptodate
FROM Sales.[Order] AS o
    INNER JOIN Sales.OrderDetail AS od
        ON od.OrderId = o.orderid
    INNER JOIN Production.Product AS pp
        ON od.ProductId = pp.ProductId
GROUP BY od.OrderId,
         pp.UnitPrice,
         o.ShipToDate
ORDER BY od.OrderId;
--FOR JSON PATH, ROOT ('FullName'), INCLUDE_NULL_VALUES;

--16
--Create a column for the nextorderid in Sales.[Order], display ProductId from Sales.OrderDetail and ProductName from Production.Product.

USE Northwinds2020TSQLV6;
GO

CREATE OR ALTER FUNCTION Sales.udf_NextOrder
(
    @currentorder INT
)
RETURNS INT
BEGIN
    DECLARE @nextorder INT;
    SELECT @nextorder = @currentorder + 1;
    RETURN @nextorder;
END;
GO

USE Northwinds2020TSQLV6;
SELECT o.OrderId,
       Sales.udf_NextOrder(o.OrderId) AS nextorderid,
       od.ProductId,
       pp.ProductName
FROM Sales.[Order] AS o
    INNER JOIN Sales.OrderDetail AS od
        ON od.OrderId = o.OrderId
    INNER JOIN Production.Product AS pp
        ON od.ProductId = pp.ProductId
GROUP BY o.OrderId,
         od.ProductId,
         pp.ProductName
ORDER BY o.OrderId;
--FOR JSON PATH, ROOT ('NextOrder'), INCLUDE_NULL_VALUES;

--17
--Find the calendar year quarter of the OrderDate from Sales.Order, the ProductID from Sales.OrderDetail and the ProductName from Production.Product.

USE Northwinds2020TSQLV6;

GO
CREATE OR ALTER FUNCTION Sales.udf_CalendarYearQuarter
(
    @orderdate DATE
)
RETURNS NVARCHAR(20)
BEGIN
    DECLARE @CalendarDate VARCHAR(20);

    SELECT @CalendarDate = CASE
                               WHEN MONTH(@orderdate) >= 1
                                    AND MONTH(@orderdate) <= 3 THEN
                                   'Q1'
                               WHEN MONTH(@orderdate) >= 4
                                    AND MONTH(@orderdate) <= 6 THEN
                                   'Q2'
                               WHEN MONTH(@orderdate) >= 7
                                    AND MONTH(@orderdate) <= 9 THEN
                                   'Q3'
                               WHEN MONTH(@orderdate) >= 10
                                    AND MONTH(@orderdate) <= 12 THEN
                                   'Q4'
                               ELSE
                                   'N/A'
                           END;
    RETURN @CalendarDate;
END;
GO

USE Northwinds2020TSQLV6;
SELECT o.OrderId,
	   YEAR(o.OrderDate) AS orderyear,
       Sales.udf_CalendarYearQuarter(o.OrderDate) AS calendaryearquarter,
       od.ProductId,
       pp.ProductName
FROM Sales.[Order] AS o
    INNER JOIN Sales.OrderDetail AS od
        ON od.OrderId = o.OrderId
    INNER JOIN Production.Product AS pp
        ON od.ProductId = pp.ProductId
GROUP BY o.OrderId,
	     o.OrderDate,
         od.ProductId,
         pp.ProductName
ORDER BY o.OrderId;
--FOR JSON PATH, ROOT ('CalendarYearQuarter'), INCLUDE_NULL_VALUES;

--18
--Get total unit price and name of each product from Production.Product, using the ProductID and quantity from Sales.OrderDetail, OrderId from Sales.[Order].

USE Northwinds2020TSQLV6;

GO
CREATE OR ALTER FUNCTION Sales.udf_TotalUnitPrice
(
    @quantity INT,
    @unitprice MONEY,
    @discountpercentage NUMERIC(4, 3)
)
RETURNS MONEY
AS
BEGIN
    RETURN (@quantity * @unitprice) * (1. - @discountpercentage);
END;
GO

USE Northwinds2020TSQLV6;
SELECT o.OrderId,
       od.ProductId,
       pp.ProductName,
       Sales.udf_TotalUnitPrice(od.Quantity, pp.UnitPrice, od.DiscountPercentage) AS totalunitprice
FROM Sales.[Order] AS o
    INNER JOIN Sales.OrderDetail AS od
        ON od.OrderId = o.OrderId
    INNER JOIN Production.Product AS pp
        ON od.ProductId = pp.ProductId
GROUP BY o.OrderId,
         od.ProductId,
         pp.ProductName,
         od.Quantity,
         pp.UnitPrice,
         od.DiscountPercentage
ORDER BY o.OrderId;
--FOR JSON PATH, ROOT ('TotalUnitPrice'), INCLUDE_NULL_VALUES;

--19
--Create a column to determine if an order was placed at the end of the month from the OrderDates in Sales.[Order], show ProductName from Production.Product and ProductId from Sales.OrderDetails.

USE Northwinds2020TSQLV6;

GO
CREATE OR ALTER FUNCTION Sales.udf_EomonthCheck
(
    @date DATE
)
RETURNS NVARCHAR(3)
AS
BEGIN
    DECLARE @result NVARCHAR(3);
    DECLARE @endofmonth DATE = EOMONTH(@date);
    SELECT @result = CASE
                       WHEN @endofmonth = @date THEN
                           'YES'
                       ELSE
                           'NO'
                   END;
    RETURN @result;
END;
GO

USE Northwinds2020TSQLV6;
SELECT o.OrderId,
       Sales.udf_EomonthCheck(o.OrderDate) AS endofmonth,
       pp.ProductName,
       od.ProductId
FROM Sales.[Order] AS o
    INNER JOIN Sales.OrderDetail AS od
        ON  o.OrderId = od.OrderId
    INNER JOIN Production.Product AS pp
        ON pp.ProductId = od.ProductId
GROUP BY o.OrderId,
		 o.OrderDate,
         pp.ProductName,
         od.ProductId
ORDER BY o.OrderId;
--FOR JSON PATH, ROOT ('EndOfMonth'), INCLUDE_NULL_VALUES;

--20
--Create a scalar function that categorizes totalunitprice as cheap or expensive from Production.Product, showing OrderID from Sales.[Order] and ProductID from Sales.OrderDetail

USE Northwinds2020TSQLV6;

GO

CREATE OR ALTER FUNCTION Sales.udf_PriceCheck
(
    @totalunitprice MONEY
)
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @result NVARCHAR(20);
    SELECT @result = CASE
                         WHEN @totalunitprice < 1 THEN
                             'Cheapest'
                         WHEN @totalunitprice > 1 THEN
                             'Expensive'
                         ELSE
                             'N/A'
                     END;
    RETURN @result;
END;
GO

USE Northwinds2020TSQLV6;
SELECT o.OrderId,
       od.ProductId,
       pp.ProductName,
       Sales.udf_PriceCheck((Sales.udf_TotalUnitPrice(od.Quantity, pp.UnitPrice, od.DiscountPercentage))) AS PriceCheck
FROM Sales.[Order] AS o
    INNER JOIN Sales.OrderDetail AS od
        ON od.OrderId = o.OrderId
    INNER JOIN Production.Product AS pp
        ON od.ProductId = pp.ProductId
GROUP BY o.OrderId,
         od.ProductId,
         pp.ProductName,
         od.Quantity,
         pp.UnitPrice,
         od.DiscountPercentage
ORDER BY o.OrderId;
--FOR JSON PATH, ROOT ('TotalUnitPrice'), INCLUDE_NULL_VALUES;




