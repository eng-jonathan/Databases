USE AdventureWorks2017;

--Medium #1--
SELECT HREDH.DepartmentID,
       HRD.Name,
	   COUNT(HREDH.DepartmentID) AS 'Employee Number',
       HREDH.ShiftID
FROM HumanResources.Department AS HRD
    INNER JOIN HumanResources.EmployeeDepartmentHistory AS HREDH
        ON HRD.DepartmentID = HREDH.DepartmentID
GROUP BY HREDH.DepartmentID,
		 HREDH.ShiftID,
         HRD.Name
ORDER BY HREDH.DepartmentID
FOR JSON PATH, ROOT ('NumberofEmployeesinDepartment'), INCLUDE_NULL_VALUES;
---------------------------------------------
--Medium #2--
SELECT CONCAT(PP.LastName, ' ', PP.FirstName) AS Name,
       HRE.JobTitle
FROM HumanResources.Employee AS HRE
    INNER JOIN Person.Person AS PP
        ON HRE.BusinessEntityID = PP.BusinessEntityID
WHERE HRE.JobTitle <> 'Buyer'
GROUP BY PP.LastName,
         PP.FirstName,
		 HRE.JobTitle
ORDER BY HRE.JobTitle
FOR JSON PATH, ROOT ('Non-Buyer Employees'), INCLUDE_NULL_VALUES;

---------------------------------------------
--Medium #3--
SELECT SCC.CardType,
	   COUNT(SCC.CardType) AS 'Number of Credit Cards expired'
FROM Sales.CreditCard AS SCC
    INNER JOIN Sales.PersonCreditCard AS SPCC
        ON SCC.CreditCardID = SPCC.CreditCardID
WHERE SCC.ExpYear = '2008' AND YEAR(SPCC.ModifiedDate) <> '2011'
GROUP BY SCC.CardType, SCC.ExpYear
ORDER BY SCC.CardType ASC
FOR JSON PATH, ROOT ('Credit Card expired'), INCLUDE_NULL_VALUES;
---------------------------------------------
--Medium #4--
SELECT PTH.ProductID,
       COUNT(PP.ProductID) AS 'Number of Items Sold',
       PP.Name
FROM Production.Product AS PP
    INNER JOIN Production.TransactionHistory AS PTH
        ON PP.ProductID = PTH.ProductID
GROUP BY PTH.ProductID,
         PP.Name
ORDER BY [Number of Items Sold]
FOR JSON PATH, ROOT ('Items sold'), INCLUDE_NULL_VALUES;
---------------------------------------------
--Simple #1--
SELECT DISTINCT PA.City,
       PA.StateProvinceID,
       PSP.StateProvinceCode,
       PSP.Name
FROM Person.StateProvince AS PSP
    INNER JOIN Person.Address AS PA
	ON PA.StateProvinceID = PSP.StateProvinceID
ORDER BY PA.StateProvinceID
FOR JSON PATH, ROOT ('CityName'), INCLUDE_NULL_VALUES;
----------------------------------------------
--Simple #2--
SELECT HREDH.BusinessEntityID,
       HREDH.DepartmentID,
       HREDH.ShiftID,
	   HRE.JobTitle
FROM HumanResources.EmployeeDepartmentHistory AS HREDH
INNER JOIN HumanResources.Employee AS HRE
ON HRE.BusinessEntityID = HREDH.BusinessEntityID
ORDER BY HREDH.DepartmentID, HREDH.ShiftID
FOR JSON PATH, ROOT ('Employee Shifts'), INCLUDE_NULL_VALUES;
----------------------------------------------
--Simple #3--
SELECT PA.AddressLine1,
	   PA.PostalCode,
       PA.City,
	   PBEA.AddressTypeID
FROM Person.Address AS PA
INNER JOIN Person.BusinessEntityAddress AS PBEA
ON PBEA.AddressID = PA.AddressID
WHERE PA.AddressLine2 IS NULL
ORDER BY PA.PostalCode, PA.City
FOR JSON PATH, ROOT ('No Address Line 2'), INCLUDE_NULL_VALUES;
----------------------------------------------
----------------------------------------------
USE Northwinds2020TSQLV6;

--Simple #4--
SELECT SS.studentid AS 'Student ID',
	   SS.TestId AS 'Test ID',
       SS.TestScore AS 'Test Score'
FROM Stats.Test AS ST
    INNER JOIN Stats.Score AS SS
        ON ST.TestId = SS.TestId
ORDER BY SS.studentid, [Test ID]
FOR JSON PATH, ROOT ('Test Scores'), INCLUDE_NULL_VALUES;

--Medium #5
SELECT COUNT(PP.CategoryId) AS 'Number of Products in this Category',
       PC.CategoryName,
       PC.Description
FROM Production.Product AS PP
    INNER JOIN Production.Category AS PC
        ON PP.CategoryId = PC.CategoryId
GROUP BY PC.CategoryName,
         PC.Description
ORDER BY PC.CategoryName
FOR JSON PATH, ROOT ('# of Products'), INCLUDE_NULL_VALUES;

--Simple #5--
SELECT SupplierId,
       SupplierCompanyName,
       SupplierPhoneNumber
FROM Production.Supplier
ORDER BY SupplierCompanyName
FOR JSON PATH, ROOT ('Basic Supplier Info'), INCLUDE_NULL_VALUES;

--Medium #6--
SELECT SOD.ProductId,
       PP.ProductName,
       PP.UnitPrice
FROM Sales.OrderDetail AS SOD
    INNER JOIN Production.Product AS PP
        ON SOD.ProductId = PP.ProductId
GROUP BY SOD.ProductId,
         PP.ProductName,
         PP.UnitPrice
ORDER BY PP.ProductName
FOR JSON PATH, ROOT ('Product Prices'), INCLUDE_NULL_VALUES;
-------------------------------------------------------
USE AdventureWorksDW2017;

--Medium #7--
SELECT DBC.FirstName,
       DBC.LastName,
       MAX(DFSR.Date) AS Date
FROM dbo.DimCustomer AS DBC
    INNER JOIN dbo.FactSurveyResponse AS DFSR
        ON DBC.CustomerKey = DFSR.CustomerKey
GROUP BY DBC.FirstName,
         DBC.LastName
ORDER BY DBC.LastName
FOR JSON PATH, ROOT ('Survey Responses'), INCLUDE_NULL_VALUES;

--Medium #8--
SELECT CONCAT(DBE.FirstName, ' ', DBE.LastName) AS EmployeeName,
       FSQ.CalendarQuarter,
       SUM(FSQ.SalesAmountQuota) AS Quota
FROM dbo.DimEmployee AS DBE
    INNER JOIN dbo.FactSalesQuota AS FSQ
        ON DBE.EmployeeKey = FSQ.EmployeeKey
GROUP BY DBE.LastName,
		 DBE.FirstName,
         FSQ.CalendarQuarter
ORDER BY DBE.LastName
FOR JSON PATH, ROOT ('Sales Quota'), INCLUDE_NULL_VALUES;

---------------------------------------------------------
USE AdventureWorks2017;

CREATE FUNCTION fnd_name
(@BusinessEntityID int)
RETURNS varchar(15)
BEGIN
    RETURN
    (
        SELECT LastName
        FROM Person.Person
        WHERE BusinessEntityID = @BusinessEntityID
    );
END;

/*Complex #1*/
SELECT PA.City,
       PP.FirstName,
       PP.LastName,
	   PP.BusinessEntityID
FROM Person.BusinessEntityAddress AS PBEA
    INNER JOIN Person.Address AS PA
        ON PA.AddressID = PBEA.AddressID
    INNER JOIN Person.Person AS PP
        ON PP.BusinessEntityID = PBEA.BusinessEntityID
WHERE PP.LastName <= dbo.fnd_name(273)
GROUP BY PA.City,
         PP.LastName,
         PP.FirstName,
		 PP.BusinessEntityID
ORDER BY PA.City, PP.LastName
FOR JSON PATH, ROOT ('Fellow Business Entityies'), INCLUDE_NULL_VALUES;
-------------------------------------------------------
/*Complex #2*/
SELECT PBEA.BusinessEntityID, CONCAT(PP.FirstName, ' ', PP.MiddleName, ' ', PP.LastName) AS Name, PBEA.AddressID, PBEA.ModifiedDate
FROM Person.BusinessEntityAddress AS PBEA
INNER JOIN Person.Person AS PP
ON PP.BusinessEntityID = PBEA.BusinessEntityID
INNER JOIN HumanResources.EmployeeDepartmentHistory AS HREDH
ON PP.BusinessEntityID = HREDH.BusinessEntityID
WHERE PP.LastName < dbo.fnd_name(11)
GROUP BY CONCAT(PP.FirstName, ' ', PP.MiddleName, ' ', PP.LastName), PBEA.AddressID, PBEA.ModifiedDate, PBEA.BusinessEntityID
ORDER BY [Name] ASC
FOR JSON PATH, ROOT ('Modified Address'), INCLUDE_NULL_VALUES;

-------------------------------------------------------
USE Northwinds2020TSQLV6;

CREATE FUNCTION fnd_suppliernm
(@SupplierID int)
RETURNS varchar(15)
BEGIN
	RETURN
	(
	SELECT SupplierCompanyName
	FROM Production.Supplier
	WHERE SupplierId = @SupplierID
	);
END;
-------------------------------------------------------
/*Complex #3*/
SELECT PrPr.ProductId, PrPr.ProductName, PrC.CategoryId
FROM Production.Product AS PrPr
    INNER JOIN Production.Category AS PrC
        ON PrPr.CategoryId = PrC.CategoryId
    INNER JOIN Production.Supplier AS PrS
        ON PrS.SupplierId = PrPr.SupplierId
WHERE PrS.SupplierCompanyName <= dbo.fnd_suppliernm(11)
GROUP BY PrC.CategoryId, PrPr.ProductName, PrPr.ProductId
ORDER BY PrC.CategoryId
FOR JSON PATH, ROOT ('Product from this Supplier'), INCLUDE_NULL_VALUES;

/*Complex #4*/
SELECT SO.OrderId, SUM((SOD.Quantity * SOD.UnitPrice)) AS 'Total Undiscounted Price', PrPr.ProductName, PrPr.SupplierId, PrS.SupplierCompanyName
FROM Sales.[Order] AS SO
INNER JOIN Sales.OrderDetail AS SOD
ON SO.OrderId = SOD.OrderId
INNER JOIN Production.Product AS PrPr
ON PrPr.ProductId = SOD.ProductId
INNER JOIN Production.Supplier AS PrS
ON PrS.SupplierId = PrPr.SupplierId
WHERE PrS.SupplierCompanyName = dbo.fnd_suppliernm(11)
GROUP BY PrPr.SupplierId, SO.OrderId, PrPr.ProductName, PrS.SupplierCompanyName
ORDER BY [Total Undiscounted Price]
FOR JSON PATH, ROOT ('UndiscountedPriceProducts'), INCLUDE_NULL_VALUES;

/*Complex #5*/
SELECT SO.OrderId, SOD.Quantity AS 'Number of items', PP.ProductName, PrS.SupplierCompanyName 
FROM Sales.[Order] AS SO
INNER JOIN Sales.OrderDetail AS SOD
ON SO.OrderId = SOD.OrderId
INNER JOIN Production.Product AS PP
ON SOD.ProductId = PP.ProductId
INNER JOIN Production.Supplier AS PrS
ON PrS.SupplierId = PP.SupplierId
WHERE PrS.SupplierCompanyName = dbo.fnd_suppliernm(11)
GROUP BY PP.ProductName, SO.OrderId, PrS.SupplierCompanyName, SOD.Quantity
ORDER BY SOD.Quantity ASC, SO.OrderId, PP.ProductName
FOR JSON PATH, ROOT ('Number of items from this supplier in each order'), INCLUDE_NULL_VALUES;

--------------------------------------------------------
USE AdventureWorksDW2017

CREATE FUNCTION fnd_city
(
    @GeoKey int
)
RETURNS varchar(15)
BEGIN
    RETURN
    (
        SELECT SalesTerritoryKey
        FROM dbo.DimGeography
        WHERE GeographyKey = @GeoKey
    );
END;
---------------------------------------------------------------
/*Complex #6*/
SELECT DG.City,
       CONCAT(DE.LastName, ' ', DE.FirstName, ' ', DE.MiddleName) AS Name,
       COUNT(FRS.SalesOrderNumber) AS '# of orders',
	   FRS.OrderDate
FROM dbo.DimGeography AS DG
    INNER JOIN dbo.DimEmployee AS DE
        ON DE.SalesTerritoryKey = DG.SalesTerritoryKey
    INNER JOIN dbo.FactResellerSales AS FRS
        ON FRS.EmployeeKey = DE.EmployeeKey
WHERE FRS.SalesTerritoryKey = dbo.fnd_city(155) AND FRS.OrderDate > '20130101'
GROUP BY DG.City,
         FRS.OrderDate,
		 CONCAT(DE.LastName, ' ', DE.FirstName, ' ', DE.MiddleName)
ORDER BY DG.City
FOR JSON PATH, ROOT ('Handled Orders by this employee'), INCLUDE_NULL_VALUES;
-----------------------------------------------------------------
/*Complex #7*/
SELECT CONCAT(DE.LastName, ' ', DE.FirstName, ' ', DE.MiddleName) AS Name, SUM(FSQ.SalesAmountQuota) AS 'Total Sales Quota', DST.SalesTerritoryCountry
FROM dbo.DimEmployee AS DE
INNER JOIN dbo.FactSalesQuota AS FSQ
ON FSQ.EmployeeKey = DE.EmployeeKey
INNER JOIN dbo.DimSalesTerritory AS DST
ON DST.SalesTerritoryKey = DE.SalesTerritoryKey
WHERE DE.SalesTerritoryKey <= dbo.fnd_city(155)
GROUP BY DST.SalesTerritoryCountry, CONCAT(DE.LastName, ' ', DE.FirstName, ' ', DE.MiddleName)
ORDER BY DST.SalesTerritoryCountry,[Total Sales Quota]
FOR JSON PATH, ROOT ('Sales Quota from Territory'), INCLUDE_NULL_VALUES;