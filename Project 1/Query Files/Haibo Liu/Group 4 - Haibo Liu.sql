--simple examples
-- find the customers who did not place order.
use Northwinds2020TSQLV6;
SELECT C.CustomerId
	,C.CustomerCompanyName
FROM Sales.[Customer] AS C
LEFT OUTER JOIN Sales.[Order] AS O ON C.CustomerId = O.CustomerId
WHERE O.orderid IS NULL;
--FOR JSON PATH, ROOT ('Simple Query 1'), INCLUDE_NULL_VALUES
--1

-- return the orders between 20200101 and 20201009, order by orderdate
USE Northwinds2020TSQLV6;
SELECT DATEADD(day, Nums.N - 1, CAST('20200101' AS DATE)) AS orderdate
	,O.OrderId
	,O.CustomerId
	,O.EmployeeId
FROM dbo.Nums
LEFT OUTER JOIN Sales.[Order] AS O ON DATEADD(DAY, Nums.N - 1, CAST('20200101' AS DATE)) = O.orderdate
WHERE Nums.N <= DATEDIFF(DAY, '20200101', '20201009') + 1
ORDER BY orderdate;
--FOR JSON PATH, ROOT ('Simple Query 52'), INCLUDE_NULL_VALUES
--2

-- return mumber of orders of each customer placed
SELECT C.CustomerId
	,COUNT(*) AS numorders
FROM Sales.Customer AS C
LEFT OUTER JOIN Sales.[Order] AS O ON C.CustomerId = O.CustomerId
GROUP BY C.CustomerId;
--FOR JSON PATH, ROOT ('Simple Query 3'), INCLUDE_NULL_VALUES
--3

--return order between 20160212 and 20160312,without null order
use Northwinds2020TSQLV6;
SELECT C.CustomerId,
       C.CustomerCompanyName, ​
       O.orderid, ​
       O.orderdate​
FROM   [Sales].[Customer] AS C​
       LEFT OUTER JOIN ​
       [Sales].[Order] AS O​
       ON O.CustomerId = C.CustomerId​
       AND O.orderdate between '20160212' and '20160312'​
where O.OrderId is not null
--FOR JSON PATH, ROOT ('Simple Query 4'), INCLUDE_NULL_VALUES
--4

-- return the spanish version of the date from DimDate.
USE AdventureWorksDW2017;

SELECT fcr.DateKey
	,CONCAT (
		dd.SpanishMonthName
		,' '
		,dd.SpanishDayNameOfWeek
		,' '
		,dd.CalendarYear
		) AS spanishdate
FROM dbo.DimDate AS dd
INNER JOIN dbo.FactCurrencyRate AS fcr ON dd.DateKey = fcr.DateKey
GROUP BY fcr.DateKey
	,dd.SpanishMonthName
	,dd.SpanishDayNameOfWeek
	,dd.CalendarYear
ORDER BY fcr.DateKey;
--FOR JSON PATH, ROOT ('Simple Query 5'), INCLUDE_NULL_VALUES
--5

-- medium examples
-- this query generates five copies of each employee row
use Northwinds2020TSQLV6;
SELECT E.EmployeeId
	,E.EmployeeFirstName
	,E.EmployeeLastName
	,N.N
FROM HumanResources.Employee AS E
CROSS JOIN dbo.Nums AS N
WHERE N.N <= 5
ORDER BY n
	,EmployeeId;
--FOR JSON PATH, ROOT ('Medium Query 1'), INCLUDE_NULL_VALUES
--6

-- this query returns a row for each employee and day in the range August 5,2010 through December 29 2011
SELECT E.EmployeeId
	,DATEADD(day, D.n - 1, CAST('20100805' AS DATE)) AS dt
FROM HumanResources.Employee AS E
CROSS JOIN dbo.Nums AS D
WHERE D.n <= DATEDIFF(day, '20100805', '20111229') + 1
ORDER BY EmployeeId
	,dt;
FOR JSON PATH, ROOT ('Medium Query 2'), INCLUDE_NULL_VALUES
--7


Use AdventureWorks2017;​

    SELECT COUNT(OD.ProductID) [Count],       ​

    OD.ProductID, PP.[Name],               ​

    SUM(LineTotal) TotalSale,PRP.Rating, PRP.ReviewerName, PRP.Comments  ​

    FROM Sales.SalesOrderDetail  AS OD ​

    JOIN Production.Product AS PP ON PP.ProductID = OD.ProductID  ​

    JOIN Production.ProductReview AS PRP ON PRP.ProductID = PP.ProductID  ​

    GROUP BY OD.ProductID, PP.[Name], PRP.Rating, PRP.ReviewerName, PRP.Comments
--FOR JSON PATH, ROOT ('Medium Query 3'), INCLUDE_NULL_VALUES
--8


--Performs an Inner join and returns credit card id, number and the business entity associated with it ordered by the credit card id which is greater than 18000
USE AdventureWorks2017;

SELECT MIN(C.CreditCardID) AS [Min card]
	,C.CardNumber
	,B.BusinessEntityID
FROM Sales.CreditCard AS C
INNER JOIN Sales.PersonCreditCard AS B ON B.CreditCardID = C.CreditCardID
	AND C.CreditCardID > 18000
GROUP BY C.CardNumber
	,B.BusinessEntityID;
--FOR JSON PATH, ROOT ('Medium Query 4'), INCLUDE_NULL_VALUES
--9


-- this query return all customers, and for each return a Yes/No value depending on whether the customer placed orders on December 29, 2011(best)
use Northwinds2020TSQLV6;
SELECT DISTINCT C.CustomerID
	,C.CustomerCompanyName
	,CASE 
		WHEN O.OrderId IS NOT NULL
			THEN 'YES'
		ELSE 'NO'
		END AS HasOrderOn20111229
FROM Sales.Customer AS C
LEFT OUTER JOIN Sales.[Order] AS O ON O.CustomerID = C.CustomerID
	AND O.OrderDate = '20111229';
--FOR JSON PATH, ROOT ('Medium Query 5'), INCLUDE_NULL_VALUES
--10


-- this query return customers who placed orders in 2000 but not in 2001
use TSQLV4;
--How many orders were there per month in descending order.
--Tables used: Sales.OrderDetails, Sales.Orders
select sum(od.qty) as Quantity, month(o.orderdate) as [Month]
from Sales.OrderDetails as od
	 inner join Sales.Orders as O
		on od.orderid = O.orderid
group by month(o.orderdate)
Order by Quantity desc
--for json path, root('Medium Query 6'), INCLUDE_NULL_VALUES
--11

--what are the job candidates pay history
--use human resources.jobcandidate and humanresources.employeepayhistory tables
use AdventureWorks2017
select jc.businessEntityID as beid, Max(eph.rate) as [pay rate]
from HumanResources.JobCandidate as jc
	inner join
	HumanResources.EmployeePayHistory as eph
		on jc.BusinessEntityID = eph.BusinessEntityID
group by jc.BusinessEntityID
order by [pay rate]
--for json path, root('Medium Query 7'), INCLUDE_NULL_VALUES
--12


-- this query returnan empty set because of the comparison with the NULL.
use Northwinds2020TSQLV6;
SELECT CustomerId
	,CustomerCompanyName
FROM Sales.Customer AS C
WHERE NOT EXISTS (
		SELECT *
		FROM Sales.[Order] AS O
		WHERE O.CustomerId = C.CustomerId
		)
--FOR JSON PATH, ROOT ('Medium Query 8'), INCLUDE_NULL_VALUES
--13


--complex examples
-- return the customers who place order that contain product 12
SELECT CustomerId
	,CustomerCompanyName
FROM Sales.Customer AS C
WHERE EXISTS (
		SELECT *
		FROM Sales.[Order] AS O
		WHERE O.CustomerId = C.CustomerId
			AND EXISTS (
				SELECT *
				FROM Sales.OrderDetail AS OD
				WHERE OD.OrderId = O.OrderId
					AND OD.ProductId = 12
				)
		)
FOR JSON PATH, ROOT ('complex query 1'), INCLUDE_NULL_VALUES
--14


-- return US customers, and for each customer return the total number of order and total quantities
SELECT C.CustomerId
	,count(DISTINCT O.orderid) AS numorders
	,SUM(OD.Quantity) AS totalqty
FROM Sales.Customer AS C
INNER JOIN Sales.[Order] AS O ON O.CustomerId = C.CustomerId
INNER JOIN Sales.OrderDetail AS OD ON OD.OrderId = O.OrderId
WHERE C.CustomerCountry = N'USA'
GROUP BY C.CustomerId
--FOR JSON PATH, ROOT ('complex query 2'), INCLUDE_NULL_VALUES
--15

--return all customers with their other orders made in the year 2016 and total price they are paying per order
use  DB1045_LiuHaibo413;
drop function if exists [dbo].totalDiscoutPrice
go
create function [dbo].totalDiscountPrice(@unitPrice decimal(7,2), @qty int, @discount decimal(4,3))
returns decimal(7,2)
as 
begin 
	declare @result decimal(7,2)
	set @result = (@unitPrice * @qty) - (@unitPrice * @qty*@discount)
return @result
end;
go 
-------
select C.customerId, C.CustomerCompanyName,concat(C.CustomerCity,C.CustomerCountry) as Location,
	O.orderId, O.OrderDate, OD.ProductId,OD.UnitPrice,OD.Quantity, OD.DiscountPercentage,
	[dbo].totalDiscountPrice(OD.UnitPrice,OD.Quantity, OD.DiscountPercentage) as TotalDiscountedPrice
from [sales].[customer] as C
	inner join [sales].[order] as O
		on C.customerId = O.customerId
	inner join [sales].[OrderDetail] as OD 
		on O.orderId = OD.orderId
where year(O.orderdate) = 2016
group by C.customerId, C.CustomerCompanyName,concat(C.CustomerCity,C.CustomerCountry),
	O.orderId, O.OrderDate, OD.ProductId,OD.UnitPrice,OD.Quantity, OD.[DiscountPercentage],
	[dbo].totalDiscountPrice(OD.UnitPrice,OD.Quantity, OD.DiscountPercentage)
order by orderdate desc
--FOR JSON PATH, ROOT ('complex query 3'), INCLUDE_NULL_VALUES

--this code return customers with no orders in the output with left outer join in the second join(WORST)
SELECT C.CustomerId
	,O.OrderId
	,OD.ProductId
	,OD.Quantity
FROM Sales.Customer AS C
LEFT OUTER JOIN Sales.[Order] AS O ON C.CustomerId = O.CustomerId
LEFT OUTER JOIN Sales.OrderDetail AS OD ON O.OrderId = OD.OrderId
--FOR JSON PATH, ROOT ('complex query 4'), INCLUDE_NULL_VALUES
--17


--return all the orders abd tgeur travel from production to cutomer in 2016
use Northwinds2020TSQLV6;

select S.SupplierId, S.SupplierCompanyName, LOCATIONE = concat(S.SupplierCity,', ', S.SupplierCountry),
		P.ProductId,P.ProductName,
		O.OrderId, O.OrderDate, C.CustomerCompanyName,
		LOCATION = concat(C.CustomerCity,', ',CustomerCountry)
from Production.Supplier as S
		inner join Production.Product as P
			on S.SupplierId = P.SupplierId
		inner join Sales.[Order] as O
			on P.SupplierId = O.ShipperId
		inner join Sales.[Customer] as C
			on C.CustomerId = O.CustomerId 
where year(O.orderdate) = 2016
group by S.SupplierId, S.SupplierCompanyName,concat(S.SupplierCity,', ', S.SupplierCountry),
		 P.ProductId,P.ProductName,
		 O.OrderId, O.OrderDate, C.CustomerCompanyName,concat(C.CustomerCity,', ',CustomerCountry)
order by O.orderdate desc
--FOR JSON PATH, ROOT ('complex query 5'), INCLUDE_NULL_VALUES
--18

--return the totalprice for each customer placed
use DB1045_LiuHaibo413;
DROP FUNCTION IF exists sales.udf_GetTotalPrice
GO
CREATE FUNCTION Sales.udf_GetTotalPrice(
	@Quantity INT,
	@UnitPrice DEC(10,2),
	@DiscountPercentage DEC(4,2)
)
RETURNS DEC(10,2)
AS
BEGIN
	RETURN @quantity * @UnitPrice * (1 - @DiscountPercentage);
END;
GO
SELECT
	OD.OrderId,
	SUM(Sales.udf_GetTotalPrice(Quantity, UnitPrice, DiscountPercentage)) net_amount
FROM
	Sales.OrderDetail AS OD
GROUP BY
	OD.OrderId
ORDER BY
	net_amount DESC
--FOR JSON PATH, ROOT ('complex query 6'), INCLUDE_NULL_VALUES
--19

--this query returns customers who ordered product 20 with nesting EXISTS predicates with correlated subqueries. (best)
SELECT CustomerId
	,CustomerCompanyName
FROM Sales.Customer AS C
WHERE EXISTS (
		SELECT *
		FROM Sales.[Order] AS O
		WHERE O.CustomerId = C.CustomerId
			AND EXISTS (
				SELECT *
				FROM Sales.OrderDetail AS OD
				WHERE OD.OrderId = O.OrderId
					AND OD.ProductId = 20
				)
		)
--FOR JSON PATH, ROOT ('complex query 7'), INCLUDE_NULL_VALUES
	--20
