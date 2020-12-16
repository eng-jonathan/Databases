-- using AdventureWorksDW2017 make a table that joins the dbo.DimProduct table and FactProductInventory table 
-- e1

use AdventureWorksDW2017
select E.ProductKey, E.ProductAlternateKey, O.UnitCost, O.UnitsBalance
From dbo.DimProduct as E
    Inner Join dbo.FactProductInventory as O
        on E.ProductKey = O.ProductKey


-- using Northwinds2020TSQLV6 make a table that joins the sales order table and Sales.OrderDetail table such that each row 
-- returns the OrderId, CustomerId, EmployeeId, ShipToCountry, ProductId, UnitPrice
-- e2
use Northwinds2020TSQLV6;

SELECT E.OrderId, E.CustomerId, E.EmployeeId, E.ShipToCountry, O.ProductId, O.UnitPrice
FROM Sales.[Order] as E
    INNER JOIN Sales.OrderDetail as O
        on E.OrderId = O.OrderId


-- using AdventureWorks2017 make a table that joins the SalesOrderHeaderSalesReason table along with the SalesOrderHeader such that the table
-- shows the SalesOrderID, SalesReasonID, CustomerID, ModifiedDate, AccountNumber
--e3
use AdventureWorks2017

SELECT O.SalesOrderID, E.SalesReasonID, O.CustomerID, E.ModifiedDate, O.AccountNumber
FROM Sales.SalesOrderHeaderSalesReason as E
    LEFT JOIN sales.SalesOrderHeader as O
        on E.ModifiedDate = O.ModifiedDate

--using AdventureWorks2017 make a table that joins the Currency table along with the CurrencyRate such that the table
--shows all the rows of the two tables
--e4
use AdventureWorks2017

SELECT *
From sales.Currency as E
    CROSS JOIN Sales.CurrencyRate as O

--Using AdventureWorks2017 make a table that joins PurchaseOrderDetail and PurchaseOrderHeader such that the table
--shows the PurchaseOrderID, PurchaseOrderDetailID, TotalDue, TaxAmt
--e5
use AdventureWorks2017

SELECT E.PurchaseOrderID, E.PurchaseOrderDetailID, O.TotalDue, O.TaxAmt
From Purchasing.PurchaseOrderDetail as E
    RIGHT JOIN Purchasing.PurchaseOrderHeader as O
    on E.PurchaseOrderID = O.PurchaseOrderID

--m1
--using northwinds create a table that shows the number of employees in each of their respective city
use Northwinds2020TSQLV6;

SELECT O.EmployeeCity, count(E.EmployeeId) as NumberOfEmployees
FROM Sales.[Order] as E
    INNER JOIN HumanResources.Employee as O
        on E.EmployeeId = O.EmployeeId
        GROUP BY  O.EmployeeCity


-- m2 
-- using northwinds Make a table that shows the amount of times an employee's last name appears within the table
use Northwinds2020TSQLV6;

SELECT count(E.ShipToCity) as appearances, O.EmployeeLastName
FROM Sales.[Order] as E
    INNER JOIN HumanResources.Employee as O
        on E.EmployeeId = O.EmployeeId
        GROUP BY O.EmployeeLastName

--m3 
--create a table that shows the amount of times an Employee's frist name appeared in each country. 
use Northwinds2020TSQLV6;

SELECT count(E.EmployeeId) as appearances, O.EmployeeFirstName, E.ShipToCountry
FROM Sales.[Order] as E
    INNER JOIN HumanResources.Employee as O
        on E.EmployeeId = O.EmployeeId
        GROUP BY O.EmployeeFirstName, E.ShipToCountry


-- m4
-- using Adventureworks make a table that returns the number of sales for each ID along with the total due for it
use AdventureWorks2017

SELECT COUNT(O.SalesOrderID) as NumberOfSales, E.SalesReasonID, O.TotalDue
FROM Sales.SalesOrderHeaderSalesReason as E
    LEFT JOIN sales.SalesOrderHeader as O
        on E.ModifiedDate = O.ModifiedDate
    WHERE O.ModifiedDate = (SELECT MIN(O.ModifiedDate) FROM sales.SalesOrderHeader AS O)
    GROUP BY E.SalesReasonID, O.TotalDue
    ORDER BY O.TotalDue;


-- m5
--Using AdventureWorks2017 make a table that joins PurchaseOrderDetail and PurchaseOrderHeader such that the table
--shows the PurchaseOrderID, PurchaseOrderDetailID, TotalDue, TaxAmt order the table by the tax amount
use AdventureWorks2017

SELECT E.PurchaseOrderID, E.PurchaseOrderDetailID, O.TotalDue, O.TaxAmt
From Purchasing.PurchaseOrderDetail as E
    RIGHT JOIN Purchasing.PurchaseOrderHeader as O
    on E.PurchaseOrderID = O.PurchaseOrderID
    Group By E.PurchaseOrderID, E.PurchaseOrderDetailID, O.TotalDue, O.TaxAmt
    ORDER BY O.TotalDue;

--m6
--Using northWinds Make a table that shows the full name of each employee along with their employeeid
use Northwinds2020TSQLV6;

SELECT CONCAT(O.EmployeeFirstName, ' ', O.EmployeeLastName) as Name, E.EmployeeId
FROM Sales.[Order] as E
    INNER JOIN HumanResources.Employee as O
        on E.EmployeeId = O.EmployeeId
        GROUP BY O.EmployeeFirstName, E.EmployeeId, O.EmployeeLastName
        ORDER BY O.EmployeeFirstName

--m7 
-- using AdventureWorksDW2017 make a table that outputs the english name of a product, the spanish name and its spanish subcategory name when spanish product name exists
use AdventureWorksDW2017
select E.EnglishProductName, E.SpanishProductName, O.SpanishProductSubcategoryName
From dbo.DimProduct as E
    Inner Join dbo.DimProductSubcategory as O
        on E.ProductSubcategoryKey = O.ProductSubcategoryKey
        WHERE SpanishProductName IS NOT NULL
        GROUP BY E.EnglishProductName, E.SpanishProductName, O.SpanishProductSubcategoryName
        ORDER BY E.EnglishProductName

--m8 
-- using adventure works show the amount of times each toCurrency appeared
use AdventureWorks2017

SELECT COUNT(E.Name) as NumberOfSales, O.ToCurrencyCode
From sales.Currency as E
    CROSS JOIN Sales.CurrencyRate as O
    GROUP BY O.ToCurrencyCode

--c1
--use Northwinds2020TSQLV6 to create a function that returns the total price of each item without the discount, rounded to the nearest hunderth, ordered from cheapest
-- total price to most expensive. Return the orderid total price and shipper company name. 
use Northwinds2020TSQLV6;
GO
CREATE OR ALTER FUNCTION Sales.calculateTotal(
    @currency money,
    @quantity smallint
)
RETURNS money
AS
BEGIN
    RETURN @currency*@quantity
end;
GO

SELECT ROUND(Sales.calculateTotal(O.UnitPrice, O.Quantity), 2) as totalPrice, E.OrderId, D.ShipperCompanyName
FROM Sales.[Order] as E
    INNER JOIN Sales.OrderDetail as O
        on E.OrderId = O.OrderId
    INNER JOIN Sales.Shipper as D
        on D.ShipperId = E.ShipperId
    GROUP BY E.OrderId, D.ShipperCompanyName, O.UnitPrice, O.Quantity
    ORDER BY totalPrice


--c2
-- create a custom scalar function that combines the products name, category name, and subcategory name and returns them all together 
-- and then make a table with two columns that outputs the english and spanish full name

USE AdventureWorksDW2017;
GO

CREATE OR ALTER FUNCTION dbo.compProductName
(
    @ProductName NVARCHAR(50),
    @productcategoryname NVARCHAR(50),
    @productsubcategoryname NVARCHAR(50)
)
RETURNS NVARCHAR(50)
AS
BEGIN
    RETURN @ProductName + ' ' + @productcategoryname + ' ' + @productsubcategoryname;
END;
GO

use AdventureWorksDW2017
select dbo.compProductName(E.EnglishProductName, O.EnglishProductSubcategoryName, D.EnglishProductCategoryName) as FullEnglishName, 
       dbo.compProductName(E.SpanishProductName, O.SpanishProductSubcategoryName, D.SpanishProductCategoryName) as FullSpanishName
From dbo.DimProduct as E
    Inner Join dbo.DimProductSubcategory as O
        on E.ProductSubcategoryKey = O.ProductSubcategoryKey
    INNER JOIN dbo.DimProductCategory as D
        on D.ProductCategoryKey = O.ProductCategoryKey
        WHERE SpanishProductName IS NOT NULL
        GROUP BY E.EnglishProductName, E.SpanishProductName, O.SpanishProductSubcategoryName, D.SpanishProductCategoryName, O.EnglishProductSubcategoryName, D.EnglishProductCategoryName
        ORDER BY E.EnglishProductName

--c3
-- make a scalar function that calulates the amount of money paid out for sick leave and vacation days.
-- then use that information to construct a table with job column and amount paid for non work days.
use AdventureWorks2017
GO
CREATE OR ALTER FUNCTION HumanResources.PaidNonWorkHours(
    @vacationhours smallint,
    @sickleavehours smallint,
    @rate money
)
RETURNS money
AS
BEGIN
    RETURN (@vacationhours*@rate) + (@sickleavehours*@rate)
end;
GO

SELECT E.JobTitle, HumanResources.PaidNonWorkHours(E.VacationHours, E.SickLeaveHours, D.Rate) paidNonWorkCost

FROM HumanResources.Employee as E
    INNER JOIN HumanResources.EmployeeDepartmentHistory as O
        on E.BusinessEntityID = O.BusinessEntityID
    INNER JOIN HumanResources.EmployeePayHistory as D
        on E.BusinessEntityID = D.BusinessEntityID
    GROUP BY E.JobTitle, E.VacationHours, E.SickLeaveHours, D.Rate
    ORDER By paidNonWorkCost;

--c4
-- Make a scalar function that will add n months to a enter date
-- then use this function with the dbo.nums to make a table with sales.order and sales.orderdetail that creates
-- new ship dates for each product where each shipment is delayed n number of months. 
USE Northwinds2020TSQLV6
GO

CREATE OR ALTER FUNCTION dbo.createDate
(
    @numberOfMonths INT,
    @date DATE
)
RETURNS DATE
AS
BEGIN
    DECLARE @month int;
    DECLARE @year int;
    SELECT @year =  @numberOfMonths / 12;
    SELECT @month = (@numberOfMonths % 12);
    SELECT @date = DATEADD(year, @year, @date);
    SELECT @date = DATEADD(month, @month, @date)
    RETURN @date;
END;
GO


SELECT D.n, O.ProductId, E.ShipToDate, dbo.createDate(D.n, E.ShipToDate) as NewShipToDate
    FROM dbo.Nums as D
        CROSS JOIN Sales.[Order] as E
        INNER JOIN Sales.OrderDetail as O
        ON E.OrderId = O.OrderId
    where n <= 365  and ShipToDate IS NOT NULL
    GROUP BY D.n, O.ProductId, E.ShipToDate, D.n, E.ShipToDate
    ORDER BY D.n

--c5
-- Create a scalar function which returns the gap in days between two dates
-- then use that function to create a table that shows the difference in days between the order date and required date
-- also includ the orderId EmployeeID and OrderDate from sales.order sales.orderDetail and HumanResources.Employee
USE Northwinds2020TSQLV6
GO
CREATE OR ALTER FUNCTION Sales.dateDiff
(
	@StartDate date,
	@EndDate date
)
RETURNS INT
AS
BEGIN
	RETURN DATEDIFF(day, @StartDate, @EndDate)
END
GO

SELECT O.OrderId, D.EmployeeId, E.OrderDate, E.RequiredDate, Sales.dateDiff(E.OrderDate, E.RequiredDate) as DeliveryTime
    FROM Sales.[Order] as E
        INNER JOIN Sales.OrderDetail as O
        on E.OrderId=O.OrderId
        INNER JOIN HumanResources.Employee AS D
        on D.EmployeeId = E.EmployeeId
    GROUP BY O.OrderId, D.EmployeeId, E.OrderDate, E.RequiredDate, Sales.dateDiff(E.OrderDate, E.RequiredDate)


--c6
-- Create a scalar function which returns the gap in months between two dates
-- then use that function to create a table that shows the difference in months between the birth date and the hire date of an employee
-- also includ the orderId EmployeeID birthdate and hire date from sales.order sales.orderDetail and HumanResources.Employee
USE Northwinds2020TSQLV6
GO
CREATE OR ALTER FUNCTION Sales.monthDiff
(
	@StartDate date,
	@EndDate date
)
RETURNS INT
AS
BEGIN
	RETURN DATEDIFF(MONTH, @StartDate, @EndDate)
END
GO

SELECT O.OrderId, D.EmployeeId, D.birthdate, D.HireDate, Sales.monthDiff(D.birthdate, D.HireDate) as TimeBetweenHiring
    FROM Sales.[Order] as E
        INNER JOIN Sales.OrderDetail as O
        on E.OrderId=O.OrderId
        INNER JOIN HumanResources.Employee AS D
        on D.EmployeeId = E.EmployeeId
        WHERE DATEDIFF(DAY, D.birthdate, D.HireDate) > 30
    GROUP BY O.OrderId, D.EmployeeId, D.birthdate, D.HireDate, Sales.monthDiff(D.birthdate, D.HireDate)
    ORDER BY Sales.monthDiff(D.birthdate, D.HireDate)

--c7
--make a scalar function to determine which quarter the DATE falls into
USE Northwinds2020TSQLV6;
GO
create or ALTER FUNCTION Sales.fq 
(
	@Date date
)
RETURNS NVARCHAR(50)
AS
BEGIN
	-- Declare the return variable here
    DECLARE @month INT;
	DECLARE @qtr NVARCHAR(50);
	SELECT @month = MONTH(@Date);
		IF(@month BETWEEN 1 AND 3)
			SELECT @qtr= 'QTR I'
		ELSE IF(@month BETWEEN 4 AND 6)
			SELECT @qtr= 'QTR II'
		ELSE IF(@month BETWEEN 7 AND 9)
			SELECT @qtr= 'QTR III'
		ELSE IF(@month BETWEEN 10 AND 12)
			SELECT @qtr= 'QTR IIII'
		ELSE 
			SELECT @qtr = 'Unknown QTR'
	RETURN @qtr
END
GO

SELECT O.OrderId, D.EmployeeId, E.ShipToDate, Sales.fq(E.ShipToDate) as Quarter
    FROM Sales.[Order] as E
        INNER JOIN Sales.OrderDetail as O
        on E.OrderId=O.OrderId
        INNER JOIN HumanResources.Employee AS D
        on D.EmployeeId = E.EmployeeId
    GROUP BY O.OrderId, D.EmployeeId, Sales.fq(E.ShipToDate), E.ShipToDate
