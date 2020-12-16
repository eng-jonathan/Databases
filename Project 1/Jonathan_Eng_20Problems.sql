--Easy Q1.E1
/*1. Show the Orders that were made in 2016 but have no ship date*/
USE Northwinds2020TSQLV6;
SELECT C.CustomerId,
       O.OrderId,
       O.OrderDate,
       O.ShipToDate
FROM Sales.Customer AS C
    INNER JOIN Sales.[Order] AS O
        ON O.CustomerId = C.CustomerId
WHERE ShipToDate IS NULL
      AND YEAR(OrderDate) = '2016'
ORDER BY OrderDate,
         CustomerId;

--Uncomment Below to get JSON output
--FOR JSON PATH, ROOT (''Orders From 2016 Without Ship Dates'), INCLUDE_NULL_VALUES;

--Easy Q2.E2
--2. Show Customer's Orders along with the Discount given if it has one
USE Northwinds2020TSQLV6;

SELECT OD.OrderId,
       O.CustomerId,
       OD.DiscountPercentage
FROM Sales.[Order] AS O
    LEFT OUTER JOIN Sales.[OrderDetail] AS OD
        ON OD.OrderId = O.OrderId
WHERE OD.DiscountPercentage > 0
GROUP BY OD.DiscountPercentage,
         O.CustomerId,
         OD.OrderId
ORDER BY OD.DiscountPercentage DESC;

--Uncomment Below to get JSON output
--FOR JSON PATH, ROOT ('Customer Orders and Discount'), INCLUDE_NULL_VALUES;


--Easy Q3.E3
--3. Show the Customers who left reviews and their Yearly Income
USE AdventureWorksDW2017;

SELECT FSR.CustomerKey,
       DC.YearlyIncome
FROM dbo.FactSurveyResponse AS FSR
    LEFT OUTER JOIN dbo.DimCustomer AS DC
        ON FSR.CustomerKey = DC.CustomerKey
GROUP BY FSR.CustomerKey,
         DC.YearlyIncome;

--Uncomment Below to get JSON output
--FOR JSON PATH, ROOT ('Income of Customers Who Left Reviews'), INCLUDE_NULL_VALUES;

--Easy Q4.E4
--4. Show the OrderDates for each order from all Companies
USE Northwinds2020TSQLV6;
SELECT SC.CustomerCompanyName,
       DS.OrderId,
       DS.OrderDate
FROM Sales.[Customer] AS SC
    LEFT OUTER JOIN Sales.[Order] AS DS
        ON DS.CustomerId = SC.CustomerId
ORDER BY SC.CustomerCompanyName,
         DS.OrderDate;

--Uncomment Below to get JSON output
--FOR JSON PATH, ROOT ('OrderDate for Company Orders'), INCLUDE_NULL_VALUES;


--Easy Q5.E5
--5. Show the Supplier for each Product
USE Northwinds2020TSQLV6;
SELECT PP.ProductId,
       PS.SupplierCompanyName
FROM Production.[Product] AS PP
    LEFT OUTER JOIN Production.[Supplier] AS PS
        ON PS.SupplierId = PP.SupplierId
ORDER BY PP.ProductId,
         PS.SupplierCompanyName;

--Uncomment Below to get JSON output
--FOR JSON PATH, ROOT ('Supplier for Each Product'), INCLUDE_NULL_VALUES;


-- Medium Q6.M1
/*6. Shows the Total Units each Employee has sold to Each Customer*/
USE Northwinds2020TSQLV6;
SELECT O.EmployeeId,
       C.CustomerId,
       SUM(OD.Quantity) AS TotalUnitsSold
FROM Sales.Customer AS C
    INNER JOIN Sales.[Order] AS O
        ON O.CustomerId = C.CustomerId
    INNER JOIN Sales.OrderDetail AS OD
        ON OD.OrderId = O.OrderId
GROUP BY O.EmployeeId,
         C.CustomerId
ORDER BY O.EmployeeId;

--Uncomment Below to get JSON output
--FOR JSON PATH, ROOT ('Employee Units Sold to Each Customer'), INCLUDE_NULL_VALUES;


--Tables involved: Sales.Customers and Sales.Orders
--MEDIUM Q7.M2
/*7. Show the OrderDate and ShipToDate and Find the amount of days it will take until arrival */
USE Northwinds2020TSQLV6;
SELECT C.CustomerId,
       O.OrderId,
       O.OrderDate,
       O.ShipToDate,
       DATEDIFF(DAY, O.OrderDate, O.ShipToDate) AS DaysFromOrderToShip
FROM Sales.Customer AS C
    INNER JOIN Sales.[Order] AS O
        ON O.CustomerId = C.CustomerId
WHERE ShipToDate IS NOT NULL
GROUP BY DATEDIFF(DAY, O.OrderDate, O.ShipToDate),
         C.CustomerId,
         O.OrderId,
         O.OrderDate,
         O.ShipToDate
ORDER BY DaysFromOrderToShip;

--Uncomment Below to get JSON output
--FOR JSON PATH, ROOT (Days Until Arrival'), INCLUDE_NULL_VALUES;


--Medium Q8.M3
/*8. Shows the Order, along with the City and Quantiy being delivered*/
USE Northwinds2020TSQLV6;
SELECT C.CustomerId,
       O.OrderId,
       O.ShipToCity,
       SUM(OD.Quantity) AS totalqty
FROM Sales.Customer AS C
    INNER JOIN Sales.[Order] AS O
        ON O.CustomerId = C.CustomerId
    INNER JOIN Sales.OrderDetail AS OD
        ON OD.OrderId = O.OrderId
WHERE C.CustomerCountry = N'SPAIN'
GROUP BY C.CustomerId,
         O.OrderId,
         O.ShipToCity;

--Uncomment Below to get JSON output
--FOR JSON PATH, ROOT ('USA City Orders and Quantity'), INCLUDE_NULL_VALUES; 


--Medium Q9.M4
/*9. Shows the amount of orders going to each country*/
USE Northwinds2020TSQLV6;
SELECT C.CustomerCountry,
       O.OrderId,
       SUM(OD.Quantity) AS TotalUnitsSold
FROM Sales.Customer AS C
    INNER JOIN Sales.[Order] AS O
        ON O.CustomerId = C.CustomerId
    INNER JOIN Sales.OrderDetail AS OD
        ON OD.OrderId = O.OrderId
GROUP BY C.CustomerCountry,
         O.OrderId;

--Uncomment Below to get JSON output
--FOR JSON PATH, ROOT ('Amount of Orders in Each Country'), INCLUDE_NULL_VALUES;


--Medium Q10.M5
--.10. Show Products that are no longer in stock (Quantity Zero)
USE AdventureWorks2017;
SELECT PP.ProductID,
       PP.Name,
       PINV.Quantity
FROM Production.[Product] AS PP
    LEFT OUTER JOIN Production.[ProductInventory] AS PINV
        ON PP.ProductID = PINV.ProductID
GROUP BY PP.ProductID,
         PP.Name,
         PINV.Quantity
HAVING SUM(PINV.Quantity) = 0;

--Uncomment Below to get JSON output
--FOR JSON PATH, ROOT ('Out of Stock Items'), INCLUDE_NULL_VALUES;


--Medium Q11.M7
--11. Show the FullName of each person and their PhoneNumber
USE AdventureWorks2017;
SELECT CONCAT(P.FirstName, ' ', P.LastName) AS FullName,
       PP.PhoneNumber
FROM Person.[Person] AS P
    LEFT OUTER JOIN Person.[PersonPhone] AS PP
        ON P.BusinessEntityID = PP.BusinessEntityID
GROUP BY CONCAT(P.FirstName, ' ', P.LastName),
         PP.PhoneNumber;

--Uncomment Below to get JSON output
--FOR JSON PATH, ROOT ('Person Full Names and Phone Numbers'), INCLUDE_NULL_VALUES;


--Medium Q12.M8
--12. Show the Average Pay Rate of the different Job Titles
USE AdventureWorks2017;
SELECT DISTINCT
       HE.JobTitle,
       AVG(HP.Rate) AS AverageRate
FROM HumanResources.[Employee] AS HE
    LEFT OUTER JOIN HumanResources.EmployeePayHistory AS HP
        ON HE.BusinessEntityID = HP.BusinessEntityID
GROUP BY HE.JobTitle
ORDER BY AverageRate DESC;

--Uncomment Below to get JSON output
--FOR JSON PATH, ROOT ('Average Salary Per Position'), INCLUDE_NULL_VALUES;


--Complex Q13.C1
--13. Show the cost of products in a specified customer’s orders
USE Northwinds2020TSQLV6;
DROP FUNCTION IF EXISTS dbo.get_cost_of_products_for_customer_order;
GO
CREATE FUNCTION dbo.get_cost_of_products_for_customer_order
(
    @customer AS INT
)
RETURNS TABLE
AS
RETURN SELECT CustomerId,
              OrderId
       FROM Sales.[Order]
       WHERE CustomerId = @customer;
GO
DECLARE @CustomerNumber INT;
SET @CustomerNumber = 50;
SELECT SO.CustomerId,
       GC.OrderId,
       SOD.ProductId,
       (SOD.UnitPrice * SOD.Quantity) AS TotalCost
FROM dbo.get_cost_of_products_for_customer_order(@CustomerNumber) AS GC
    INNER JOIN Sales.[Customer] AS SO
        ON GC.CustomerId = SO.CustomerId
    INNER JOIN Sales.[OrderDetail] AS SOD
        ON SOD.OrderId = GC.OrderId
GROUP BY (SOD.UnitPrice * SOD.Quantity),
         SO.CustomerId,
         GC.OrderId,
         SOD.ProductId;

--Uncomment Below to get JSON output
--FOR JSON PATH, ROOT ('Cost of Products for Specific Customer'), INCLUDE_NULL_VALUES

DROP FUNCTION IF EXISTS dbo.get_cost_of_products_for_customer_order;


--Complex Q14.C2
--14. Shows the amount of days until a specified order will arrive
USE Northwinds2020TSQLV6;
DROP FUNCTION IF EXISTS dbo.get_days_until_ship;

GO
CREATE FUNCTION dbo.get_days_until_ship
(
    @ordernumber INT
)
RETURNS INT
AS
BEGIN
    DECLARE @days_until_ship INT;
    SELECT @days_until_ship = DATEDIFF(DAY, OrderDate, ShipToDate)
    FROM Sales.[Order]
    WHERE OrderId = @ordernumber;
    RETURN @days_until_ship;
END;
GO

DECLARE @order_number INT;
SET @order_number = 10270;

SELECT SO.CustomerId,
       SO.OrderId,
       dbo.get_days_until_ship(@order_number) AS DAYSUNTILSHIP
FROM Sales.[Order] AS SO
    INNER JOIN Sales.[OrderDetail] AS OD
        ON SO.OrderId = OD.OrderId
    INNER JOIN Sales.[Customer] AS SC
        ON SO.CustomerId = SC.CustomerId
WHERE SO.OrderId = @order_number
GROUP BY SO.CustomerId,
         SO.OrderId;

--Uncomment Below to get JSON output
--FOR JSON PATH, ROOT ('Days Until Order is Shipped'), INCLUDE_NULL_VALUES

DROP FUNCTION IF EXISTS dbo.get_days_until_ship;

--Complex Q15.C3
/*15. Write a function that shows the total quantity going to each region of specified country*/
USE Northwinds2020TSQLV6;
DROP FUNCTION IF EXISTS dbo.UnitsToCountry;

GO
CREATE FUNCTION dbo.UnitsToCountry
(
    @Country NVARCHAR(50)
)
RETURNS TABLE
AS
RETURN SELECT SUM(SOD.Quantity) AS TotalUnits,
              SO.ShipToRegion
       FROM Sales.[Order] AS SO
           LEFT JOIN Sales.[OrderDetail] AS SOD
               ON SO.OrderId = SOD.OrderId
           LEFT JOIN Sales.[Customer] AS SC
               ON SO.CustomerId = SC.CustomerId
       GROUP BY SO.ShipToRegion,
                SO.ShipToCountry
       HAVING SO.ShipToCountry = @Country;
GO

DECLARE @COUNTRY NVARCHAR(50);
SET @COUNTRY = 'USA';

SELECT C.ShipToRegion,
       C.TotalUnits
FROM dbo.UnitsToCountry(@COUNTRY) AS C
ORDER BY C.ShipToRegion;

--Uncomment Below to get JSON output
--FOR JSON PATH, ROOT ('Quantity Amount going to Country Regions'), INCLUDE_NULL_VALUES

DROP FUNCTION IF EXISTS dbo.UnitsToCountry;


--Complex Q16.C4
/*16. Write a function that shows all orders going to a specified City*/
USE Northwinds2020TSQLV6;
DROP FUNCTION IF EXISTS dbo.UnitsToCity;

GO
CREATE FUNCTION dbo.UnitsToCity
(
    @City NVARCHAR(50)
)
RETURNS TABLE
AS
RETURN SELECT SO.OrderId,
              SO.CustomerId,
              SO.ShipToCity
       FROM Sales.Customer AS C
           INNER JOIN Sales.[Order] AS SO
               ON C.CustomerId = SO.CustomerId
           INNER JOIN Sales.OrderDetail AS OD
               ON OD.OrderId = SO.OrderId
       WHERE SO.ShipToCity = @City
       GROUP BY SO.OrderId,
                SO.CustomerId,
                SO.ShipToCity;
GO

DECLARE @City NVARCHAR(50);
SET @City = N'London';

SELECT OrderId,
       CustomerId,
       ShipToCity
FROM dbo.UnitsToCity(@City)
GROUP BY OrderId,
         CustomerId,
         ShipToCity
ORDER BY OrderId,
         CustomerId;

--Uncomment Below to get JSON output
--FOR JSON PATH, ROOT ('Orders to Each Country'), INCLUDE_NULL_VALUES

DROP FUNCTION IF EXISTS dbo.UnitsToCity;

--Complex Q17.C5
/*17. Shows the Total Units each Employee has sold to Each Customer*/
USE Northwinds2020TSQLV6;

DROP FUNCTION IF EXISTS dbo.EmployeeSaleAmountPerCustomer;
GO
CREATE FUNCTION dbo.EmployeeSaleAmountPerCustomer
(
    @EmployeeID INT
)
RETURNS TABLE
AS
RETURN SELECT SUM(OD.Quantity) AS NumSold,
              C.CustomerId,
              O.EmployeeId
       FROM Sales.Customer AS C
           INNER JOIN Sales.[Order] AS O
               ON O.CustomerId = C.CustomerId
           INNER JOIN Sales.OrderDetail AS OD
               ON OD.OrderId = O.OrderId
       WHERE O.EmployeeId = @EmployeeID
       GROUP BY C.CustomerId,
                O.EmployeeId;
GO

DECLARE @EmployeeId INT;
SET @EmployeeId = 1;

SELECT EmployeeId,
       CustomerId,
       NumSold
FROM dbo.EmployeeSaleAmountPerCustomer(@EmployeeId);

--Uncomment Below to get JSON output
--FOR JSON PATH, ROOT ('Units sold to Customers from Each Employee'), INCLUDE_NULL_VALUES

DROP FUNCTION IF EXISTS dbo.EmployeeSaleAmountPerCustomer;

--Complex Q18.C5
/*18. Shows Average discount given to a specific Customer*/
USE Northwinds2020TSQLV6;

DROP FUNCTION IF EXISTS dbo.AvgerageCustomerDiscount;
GO
CREATE FUNCTION dbo.AvgerageCustomerDiscount
(
    @CustomerID INT
)
RETURNS TABLE
AS
RETURN SELECT C.CustomerId,
              AVG(OD.DiscountPercentage) AS AverageDiscountPercent
       FROM Sales.Customer AS C
           INNER JOIN Sales.[Order] AS O
               ON O.CustomerId = C.CustomerId
           INNER JOIN Sales.OrderDetail AS OD
               ON OD.OrderId = O.OrderId
       WHERE O.CustomerId = @CustomerID
       GROUP BY C.CustomerId;
GO

DECLARE @CustomerId INT;
SET @CustomerId = 1;

SELECT CustomerId,
       AverageDiscountPercent
FROM dbo.AvgerageCustomerDiscount(@CustomerId);

--Uncomment Below to get JSON output
--FOR JSON PATH, ROOT ('Average Customer Discount'), INCLUDE_NULL_VALUES

DROP FUNCTION IF EXISTS dbo.AvgerageCustomerDiscount;

--Complex Q19.C6
/*19. Returns the Customers Favorite Item (Defined by largest Quantity Ordered)*/
USE Northwinds2020TSQLV6;

DROP FUNCTION IF EXISTS dbo.CustomersFavoriteItem;
GO
CREATE FUNCTION dbo.CustomersFavoriteItem
(
    @CustomerID INT
)
RETURNS TABLE
AS
RETURN SELECT TOP (1)
              C.CustomerId,
              OD.Quantity,
              OD.ProductId
       FROM Sales.Customer AS C
           INNER JOIN Sales.[Order] AS O
               ON O.CustomerId = C.CustomerId
           INNER JOIN Sales.OrderDetail AS OD
               ON OD.OrderId = O.OrderId
       WHERE O.CustomerId = @CustomerID
       GROUP BY C.CustomerId,
                OD.Quantity,
                OD.ProductId
       ORDER BY OD.Quantity DESC;
GO

DECLARE @CustomerId INT;
SET @CustomerId = 1;

SELECT CustomerId,
       ProductId,
       Quantity
FROM dbo.CustomersFavoriteItem(@CustomerId);

--Uncomment Below to get JSON output
--FOR JSON PATH, ROOT ('Largest Customer Quantity Order'), INCLUDE_NULL_VALUES

DROP FUNCTION IF EXISTS dbo.CustomersFavoriteItem;

--Complex Q20.C7
/*20. Returns the Employee's Favorite Customer (Defined by The Most Orders between the Employee and Customer)*/
USE Northwinds2020TSQLV6;

DROP FUNCTION IF EXISTS dbo.EmployeesFavoriteCustomer;
GO
CREATE FUNCTION dbo.EmployeesFavoriteCustomer
(
    @EmployeeId INT
)
RETURNS TABLE
AS
RETURN SELECT TOP (1)
              O.EmployeeId,
              COUNT(C.CustomerId) AS CustomerCount,
              C.CustomerId
       FROM Sales.Customer AS C
           INNER JOIN Sales.[Order] AS O
               ON O.CustomerId = C.CustomerId
           INNER JOIN Sales.OrderDetail AS OD
               ON OD.OrderId = O.OrderId
       WHERE O.EmployeeId = @EmployeeId
       GROUP BY O.EmployeeId,
                C.CustomerId
       ORDER BY COUNT(C.CustomerId) DESC;
GO

DECLARE @EmployeeId INT;
SET @EmployeeId = 1;

SELECT EmployeeId,
       CustomerId,
       CustomerCount
FROM dbo.EmployeesFavoriteCustomer(@EmployeeId);

--Uncomment Below to get JSON output
--FOR JSON PATH, ROOT ('Most Orders between an Employee and Customer'), INCLUDE_NULL_VALUES

DROP FUNCTION IF EXISTS dbo.EmployeesFavoriteCustomer;