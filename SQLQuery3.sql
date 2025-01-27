--Viết câu lệnh SQL lấy ra tên của tấ cả các sản phẩm 

SELECT[ProductName]
FROM [dbo].[Products]

--Viết câu lệnh SQL lấy ra tên sản phẩm , giá bán trên mỗi đơn vị, số lượng sản phẩm trên đơn vị
SELECT[ProductName],[UnitPrice],[QuantityPerUnit]
FROM [dbo].[Products];

--Viết câu lệnh SQL lấy ra tên công ty của khách hàng và quốc gia của các khách hàng đó
SELECT[CompanyName],[Country]
FROM[dbo].[Customers];

SELECT CompanyName, Country
FROM dbo.Suppliers;

SELECT *
FROM dbo.Products;

SELECT DISTINCT Country --chọn không bị trùng 
FROM dbo.Customers;

SELECT DISTINCT ShipVia
FROM dbo.Orders;

--Viết câu lệnh SQL lấy ra 05 dòng đầu tiền trong bảng Customers
SELECT TOP 10*
FROM dbo.Customers;

--Viết câu lệnh SQL lấy ra 30% nhân viên của công ty hiện tại
SELECT TOP 100 PERCENT *
FROM dbo.Employees;

--Viết câu lệnh SQL lấy ra các mã đơn hàng trong bảng Orders với quy định là mã khách hàng không được trùng lặp, chỉ lấy 5 dòng dữ liệu đầu tiên.
SELECT DISTINCT TOP 5 CustomerID
FROM dbo.Orders;

--Lấy ra các sản phẩm có mã thể loại không bị trùng lặp, và chỉ lấy ra 3 dòng đầu tiên
SELECT DISTINCT TOP 3 ProductID
FROM dbo.Products;

--ALIAS các cột: Đặt tên thay thế cho các cột 
SELECT CompanyName  AS [Công ty],
	   PostalCode  [Mã bưu điện]
FROM dbo.Customers;

SELECT LastName AS [Họ],
	   FirstName [Tên]
FROM dbo.Employees;

SELECT TOP 15 o.*
FROM dbo.Orders AS o;

SELECT TOP 5 ProductName AS [Tên sản phẩm],
			 SupplierID AS [Mã nhà cung cấp],
			 CategoryID AS [Mã thể loại]
FROM dbo.Products AS p;

--Tìm giá trị nhỏ/lớn nhất của một cột 
SELECT MIN(UnitPrice) AS MINPRICE
FROM dbo.Products;

SELECT MAX(OrderDate) AS MAXDATE
FROM dbo.Orders;

SELECT MAX(UnitsInStock) AS MAXUNITS
FROM dbo.Products;

SELECT MIN(BirthDate) AS MAXAGE
FROM dbo.Employees;

--Hàm COUNT đếm số lượng dữ liệu (khác NULL) trong một cột
--Sử dụng COUNT* khi muốn đếm số lượng bản ghi
--Hàm SUM để tính tổng giá trị của một cột. Nếu một cột có giá trị bất kỳ là NULL thì hàm SUM trả về NULL
--Hàm AVG tính giá trị trung bình cho một cột. Nếu chỉ có một vài gía trị NULL thì AVG sẽ bỏ qua NULL và tính AVG cho giá trị khác
SELECT COUNT(*) AS [Numbers of Customers]
FROM dbo.Customers;

SELECT SUM(Freight) AS [Total Money]
FROM dbo.Orders;

SELECT AVG(QUANTITY) AS [AverageQuantity]
FROM dbo.[Order Details];

SELECT COUNT(*) AS [Numbers of products],
		SUM(UnitsInStock) AS [Total Units in Stock],
		AVG(UnitPrice) AS [Average Unit Price]
FROM dbo.Products;

SELECT COUNT(*) AS [Numbers of orders]
FROM dbo.Orders;

SELECT COUNT(OrderID) AS[Numbers of orders]
FROM dbo.Orders;

--ORDER BY sắp xếp kết quả trả về của truy vấn 
-- ASC(ascending): Sắp xếp tăng dần (mặc định nếu không ghi)   ;   DESC(descending): Sắp xếp giảm dần

SELECT *
FROM dbo.Suppliers
ORDER BY CompanyName ASC;

SELECT *
FROM dbo.Products
ORDER BY UnitPrice DESC;

SELECT *
FROM dbo.Employees
ORDER BY LASTNAME ASC,FIRSTNAME ASC; 

SELECT TOP 1 *
FROM dbo.[Order Details]
ORDER BY QUANTITY DESC;

SELECT OrderID
FROM dbo.Orders
ORDER BY OrderDate DESC;

SELECT ProductName,UnitPrice,UnitsInStock
FROM dbo.Products
ORDER BY UnitsInStock DESC; 

--Các toán hạng trong SQL +-*/%
SELECT ProductID,
		ProductName,
		(UnitsInStock - UnitsOnOrder) AS StockRemaining
FROM dbo.Products;

SELECT OrderID,
	   ProductID,
	   (UnitPrice * Quantity) AS OrderDetailValue
FROM dbo.[Order Details];

SELECT	(AVG(Freight)/MAX(Freight)) AS FreigthRatio
FROM dbo.Orders;

SELECT *,
		(UnitPrice* 0.9) AS DiscountPrice
FROM dbo.Products;

SELECT (AVG(UnitPrice) % 10) AS Challenge
FROM dbo.Products;

--Mệnh đề WHERE (lọc các bản ghi)
SELECT *
FROM dbo.Employees
WHERE City = 'London'
ORDER BY LastName ASC;

SELECT COUNT(*) AS [Numbers of Late Shipped Products]
FROM dbo.Orders
WHERE ShippedDate > RequiredDate;

SELECT *
FROM dbo.[Order Details]
Where Discount > 0.1;

SELECT *
FROM dbo.Orders
Where ShipCountry = 'France';

SELECT *
FROM Products
WHERE UnitsInStock > 20;

SELECT ProductID,ProductName
FROM Products
WHERE UnitPrice >= 2* (SELECT MIN(UnitPrice) FROM Products)
ORDER BY UnitPrice ASC;

-- AND, OR, NOT
SELECT ProductID, ProductName
FROM Products
WHERE UnitsInStock < 50 OR UnitsInStock > 100

SELECT *
FROM Orders
WHERE ShipCountry = 'Brazil' AND ShippedDate > RequiredDate;

SELECT *
FROM Products
WHERE NOT(UnitPrice >=100 OR CategoryID =1);

SELECT *
FROM Orders 
WHERE FREIGHT >= 50 AND FREIGHT <= 100;

SELECT *
FROM PRODUCTS
WHERE NOT(UnitsInStock <= 20 OR UnitsOnOrder >=20);

-- Toán tử BETWEEN
SELECT *
FROM Products 
WHERE UnitPrice BETWEEN 10 AND 20;

SELECT *
FROM Orders
WHERE OrderDate BETWEEN '1996-07-01' AND '1996-07-31';

SELECT SUM(Freight) AS [TotalJukyFreight]
FROM Orders
WHERE OrderDate BETWEEN '1996-07-01' AND ' 1996-07-31';

SELECT *
FROM Orders
WHERE OrderDate BETWEEN '1997-1-1' AND '1997-12-31' AND ShipVia = 3;

--Toán tử LIKE (lọc dữ liệu trong chuỗi)
--Có hai ký tự đại diện thương được sử dụng với LIKE
--Dấu % đại diện cho không, một hoặc nhiều ký tự
--Dấu _ đại diện cho một ký tự đơn 

SELECT *
FROM Customers
WHERE Country LIKE 'A%';

SELECT*
FROM Orders
WHERE ShipCity LIKE '%a%';

SELECT*
FROM Orders
WHERE ShipCountry LIKE 'U_';

SELECT *
FROM Orders
Where ShipCountry Like 'U%';

SELECT *
FROM Suppliers
Where CompanyName  LIKE '%b%';

--WILDCARD (Ký tự đại diện)
--Dấu % đại diện cho không, một hoặc nhiều ký tự
--Dấu _ đại diện cho một ký tự đơn 
--Dấu [] đại diện cho một ký tự bất kỳ xuất hiện trong ngoặc EX: h[oat] finds hot and hat
--Dấu ^ làm đảo ngược dấu [] EX: h[^oa]t finds hit, but not hot and hat
--Dấu - đại diện cho một khoảng ký tự EX: h[a-c]t finds hat, hbt, hct 

SELECT * 
FROM Customers
WHERE ContactName LIKE 'A%';

SELECT *
FROM Customers
WHERE ContactName LIKE 'H_%';

SELECT *
FROM Orders
WHERE ShipCity LIKE 'L[uo]%';

SELECT *
FROM Orders
WHERE ShipCity LIKE 'L[^uo]%';

SELECT *
FROM Orders
WHERE ShipCity LIKE 'L[a-e]%';

SELECT *
FROM Suppliers
WHERE CompanyName LIKE 'A' AND NOT CompanyName LIKE '%B%'
select *
 from Suppliers
 where CompanyName like 'A[^b]%';

 --IN/ NOT IN operator (tìm kiếm giá trị trong danh sách)
 SELECT *
 FROM Orders
 WHERE ShipCountry NOT IN ('Germany','UK','Brazil');

 SELECT *
 FROM Employees
 WHERE TitleOfCourtesy IN ('Mr.','Dr.');

 SELECT *
 FROM Employees
 WHERE TitleOfcourtesy IN ('Mrs.');

 SELECT *
 FROM Customers
 WHERE City IN ('Berlin','London','Warszawa');

 --IS NULL/ IS NOT NULL (kiểm tra giá trị NULL)
 SELECT COUNT(*)
 FROM Orders
 WHERE ShippedDate IS NULL;

 SELECT *
 FROM Customers
 WHERE Region IS NOT NULL;

 SELECT *
 FROM Customers
 WHERE CompanyName IS NOT NULL;

 SELECT *
 FROM Orders
 WHERE ShippedDate IS NULL AND ShipRegion IS NOT NULL;

 --GROUP BY (Nhóm các dòng dữ liệu có cùng gía trị với nhau) (thường được dùng với các hàng COUNT, MAX, MIN, SUM, AVG)
 SELECT CustomerID, COUNT(OrderID) AS TotalOrders
 FROM Orders
 GROUP BY CustomerID;

 SELECT SupplierID, AVG(UnitPrice) AS AVGPrice
 FROM Products
 GROUP BY SupplierID;

 SELECT ProductName, SUM(UnitsInStock) AS Summmm
 FROM Products
 GROUP BY ProductName

 SELECT ShipCity,ShipCountry,
		MIN(Freight) AS [MinFreight],
		MAX(Freight) AS [MaxFreight]
FROM Orders
GROUP BY ShipCity, ShipCountry;

SELECT Country, COUNT(*)
FROM Employees
GROUP BY Country;

--DAY,MONTH,YEAR (Hàm lấy ngày, tháng, năm)
SELECT YEAR([OrderDate]) AS  [Year], COUNT(*) AS TotalOrders, CustomerID
FROM Orders
WHERE YEAR([OrderDate])=1997
GROUP BY YEAR(OrderDate),CustomerID;

SELECT YEAR(OrderDate) AS YEAR, MONTH (OrderDate) AS MONTH, DAY(OrderDate) AS DAY, OrderID, Count(*)
FROM Orders
WHERE YEAR(OrderDate) = 1996 AND MONTH (OrderDate) = 9 AND DAY(OrderDate) = 4
GROUP BY DAY(OrderDate), MONTH (OrderDate),YEAR(OrderDate),OrderID

SELECT CustomerID, Month(OrderDate) AS MONTHH, COUNT(*) AS NumbersOfOrders
FROM Orders
WHERE YEAR(OrderDate) = 1998 
GROUP BY MONTH(OrderDate), CustomerID
ORDER BY MONTH(OrderDate);

SELECT *
FROM Orders
Where MONTH(ShippedDate) = 5
ORDER BY YEAR(ShippedDate);

--HAVING (lọc dữ liệu sau GROUP BY)
SELECT COUNT(*) AS [NumbersOfOrders], CustomerID
FROM Orders
GROUP BY CustomerID
Having COUNT(*) > 20
Order by NumbersOfOrders DESC

SELECT SupplierID, SUM(UnitsInStock) AS TotalStock, AVG(UnitPrice) AS AVGPrice
FROM Products
Group by SupplierID
HAVING SUM(UnitsInStock) > 30 AND AVG(UnitPrice) <50

SELECT MONTH(ShippedDate) AS MONTHH, SUM(Freight) AS TotalMoney
FROM Orders
WHERE ShippedDate BETWEEN '1996-07-01' AND '1996-12-31'
GROUP BY MONTH(ShippedDate)
Order by MONTHH ASC;

SELECT ShipCity, COUNT(*) AS TotalOrders
FROM Orders
Group by ShipCity
Having Count(*) > 16
Order by TotalOrders DESC;

SELECT CustomerID, COUNT(*) AS TotalOrders
From Orders
GROUP BY CustomerID
Having COUNT(*) >20
Order By Count(*) DESC;

SELECT EmployeeID, COUNT(*) AS TotalOrders
From Orders
Group by EmployeeID
Having Count(*) >=100
Order by Count(*) DESC;

SELECT CategoryID, Count(*) AS TotalProducts
From Products
Group by CategoryID
Having Count(*) > 11;

SELECT CategoryID, SUM(UnitsInStock) AS TotalUnitsInStock
From Products
Group by CategoryID
Having SUM(UnitsInStock) > 350;

SELECT ShipCountry, COUNT(CustomerID) AS TotalCustomers
FROM Orders
Group by ShipCountry
Having COUNT(CustomerID) > 7;

SELECT ShippedDate, Count(*) AS TotalOrders
From Orders
Group by ShippedDate
Having Count(*) >5
Order by TotalOrders ASC;

Select ShipCountry, Count(*) AS TotalOrders
From Orders
Where ShipCountry LIKE 'A%' OR ShipCountry LIKE 'G%'
Group By ShipCountry
Having Count(*) > 29
Order By Count(*) DESC;

Select ShipCity, Count(*) AS TotalOrders
From Orders
Where ShippedDate Between '1997-04-01' AND '1997-08-31'
Group by ShipCity
--Having Count(*) <> 1 AND Count(*) <> 2;
Having Count(*) NOT IN (1,2);

--Truy vấn đữ liệu từ nhiều table

SELECT p.ProductID, p.ProductName, c.CategoryID, c.CategoryName 
FROM Products AS P, Categories AS C
WHERE c.CategoryID = p.CategoryID

SELECT o.EmployeeID, e.LastName, e.FirstName , COUNT(o.OrderID) AS TotalOrders
FROM Orders AS o, Employees AS e
Where o.EmployeeID = e.EmployeeID
Group by o.EmployeeID, e.LastName,e.FirstName;

SELECT c.CustomerID, c.CompanyName, c.ContactName, Count(o.OrderID) AS ToralOrders
FROM Customers AS c, Orders AS o
WHERE o.ShipCountry = 'UK' AND o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CompanyName, c.ContactName;

SELECT o.ShipName, s.CompanyName, SUM(o.Freight) AS TotalMoney
FROM Orders AS o, Shippers AS s
WHERE o.ShipVia = s.ShipperID
Group by o.ShipName, s.CompanyName
Order by TotalMoney DESC;

SELECT TOP 1 s.SupplierID, s.CompanyName, COUNT(p.ProductID) AS TotalProduct
FROM Products AS p, Suppliers AS s
Where s.SupplierID = p.SupplierID
Group by s.SupplierID, s.CompanyName
Order by TotalProduct DESC;

SELECT
FROM Orders AS o, [--Viết câu lệnh SQL lấy ra tên của tấ cả các sản phẩm 

SELECT[ProductName]
FROM [dbo].[Products]

--Viết câu lệnh SQL lấy ra tên sản phẩm , giá bán trên mỗi đơn vị, số lượng sản phẩm trên đơn vị
SELECT[ProductName],[UnitPrice],[QuantityPerUnit]
FROM [dbo].[Products];

--Viết câu lệnh SQL lấy ra tên công ty của khách hàng và quốc gia của các khách hàng đó
SELECT[CompanyName],[Country]
FROM[dbo].[Customers];

SELECT CompanyName, Country
FROM dbo.Suppliers;

SELECT *
FROM dbo.Products;

SELECT DISTINCT Country --chọn không bị trùng 
FROM dbo.Customers;

SELECT DISTINCT ShipVia
FROM dbo.Orders;

--Viết câu lệnh SQL lấy ra 05 dòng đầu tiền trong bảng Customers
SELECT TOP 10*
FROM dbo.Customers;

--Viết câu lệnh SQL lấy ra 30% nhân viên của công ty hiện tại
SELECT TOP 100 PERCENT *
FROM dbo.Employees;

--Viết câu lệnh SQL lấy ra các mã đơn hàng trong bảng Orders với quy định là mã khách hàng không được trùng lặp, chỉ lấy 5 dòng dữ liệu đầu tiên.
SELECT DISTINCT TOP 5 CustomerID
FROM dbo.Orders;

--Lấy ra các sản phẩm có mã thể loại không bị trùng lặp, và chỉ lấy ra 3 dòng đầu tiên
SELECT DISTINCT TOP 3 ProductID
FROM dbo.Products;

--ALIAS các cột: Đặt tên thay thế cho các cột 
SELECT CompanyName  AS [Công ty],
	   PostalCode  [Mã bưu điện]
FROM dbo.Customers;

SELECT LastName AS [Họ],
	   FirstName [Tên]
FROM dbo.Employees;

SELECT TOP 15 o.*
FROM dbo.Orders AS o;

SELECT TOP 5 ProductName AS [Tên sản phẩm],
			 SupplierID AS [Mã nhà cung cấp],
			 CategoryID AS [Mã thể loại]
FROM dbo.Products AS p;

--Tìm giá trị nhỏ/lớn nhất của một cột 
SELECT MIN(UnitPrice) AS MINPRICE
FROM dbo.Products;

SELECT MAX(OrderDate) AS MAXDATE
FROM dbo.Orders;

SELECT MAX(UnitsInStock) AS MAXUNITS
FROM dbo.Products;

SELECT MIN(BirthDate) AS MAXAGE
FROM dbo.Employees;

--Hàm COUNT đếm số lượng dữ liệu (khác NULL) trong một cột
--Sử dụng COUNT* khi muốn đếm số lượng bản ghi
--Hàm SUM để tính tổng giá trị của một cột. Nếu một cột có giá trị bất kỳ là NULL thì hàm SUM trả về NULL
--Hàm AVG tính giá trị trung bình cho một cột. Nếu chỉ có một vài gía trị NULL thì AVG sẽ bỏ qua NULL và tính AVG cho giá trị khác
SELECT COUNT(*) AS [Numbers of Customers]
FROM dbo.Customers;

SELECT SUM(Freight) AS [Total Money]
FROM dbo.Orders;

SELECT AVG(QUANTITY) AS [AverageQuantity]
FROM dbo.[Order Details];

SELECT COUNT(*) AS [Numbers of products],
		SUM(UnitsInStock) AS [Total Units in Stock],
		AVG(UnitPrice) AS [Average Unit Price]
FROM dbo.Products;

SELECT COUNT(*) AS [Numbers of orders]
FROM dbo.Orders;

SELECT COUNT(OrderID) AS[Numbers of orders]
FROM dbo.Orders;

--ORDER BY sắp xếp kết quả trả về của truy vấn 
-- ASC(ascending): Sắp xếp tăng dần (mặc định nếu không ghi)   ;   DESC(descending): Sắp xếp giảm dần

SELECT *
FROM dbo.Suppliers
ORDER BY CompanyName ASC;

SELECT *
FROM dbo.Products
ORDER BY UnitPrice DESC;

SELECT *
FROM dbo.Employees
ORDER BY LASTNAME ASC,FIRSTNAME ASC; 

SELECT TOP 1 *
FROM dbo.[Order Details]
ORDER BY QUANTITY DESC;

SELECT OrderID
FROM dbo.Orders
ORDER BY OrderDate DESC;

SELECT ProductName,UnitPrice,UnitsInStock
FROM dbo.Products
ORDER BY UnitsInStock DESC; 

--Các toán hạng trong SQL +-*/%
SELECT ProductID,
		ProductName,
		(UnitsInStock - UnitsOnOrder) AS StockRemaining
FROM dbo.Products;

SELECT OrderID,
	   ProductID,
	   (UnitPrice * Quantity) AS OrderDetailValue
FROM dbo.[Order Details];

SELECT	(AVG(Freight)/MAX(Freight)) AS FreigthRatio
FROM dbo.Orders;

SELECT *,
		(UnitPrice* 0.9) AS DiscountPrice
FROM dbo.Products;

SELECT (AVG(UnitPrice) % 10) AS Challenge
FROM dbo.Products;

--Mệnh đề WHERE (lọc các bản ghi)
SELECT *
FROM dbo.Employees
WHERE City = 'London'
ORDER BY LastName ASC;

SELECT COUNT(*) AS [Numbers of Late Shipped Products]
FROM dbo.Orders
WHERE ShippedDate > RequiredDate;

SELECT *
FROM dbo.[Order Details]
Where Discount > 0.1;

SELECT *
FROM dbo.Orders
Where ShipCountry = 'France';

SELECT *
FROM Products
WHERE UnitsInStock > 20;

SELECT ProductID,ProductName
FROM Products
WHERE UnitPrice >= 2* (SELECT MIN(UnitPrice) FROM Products)
ORDER BY UnitPrice ASC;

-- AND, OR, NOT
SELECT ProductID, ProductName
FROM Products
WHERE UnitsInStock < 50 OR UnitsInStock > 100

SELECT *
FROM Orders
WHERE ShipCountry = 'Brazil' AND ShippedDate > RequiredDate;

SELECT *
FROM Products
WHERE NOT(UnitPrice >=100 OR CategoryID =1);

SELECT *
FROM Orders 
WHERE FREIGHT >= 50 AND FREIGHT <= 100;

SELECT *
FROM PRODUCTS
WHERE NOT(UnitsInStock <= 20 OR UnitsOnOrder >=20);

-- Toán tử BETWEEN
SELECT *
FROM Products 
WHERE UnitPrice BETWEEN 10 AND 20;

SELECT *
FROM Orders
WHERE OrderDate BETWEEN '1996-07-01' AND '1996-07-31';

SELECT SUM(Freight) AS [TotalJukyFreight]
FROM Orders
WHERE OrderDate BETWEEN '1996-07-01' AND ' 1996-07-31';

SELECT *
FROM Orders
WHERE OrderDate BETWEEN '1997-1-1' AND '1997-12-31' AND ShipVia = 3;

--Toán tử LIKE (lọc dữ liệu trong chuỗi)
--Có hai ký tự đại diện thương được sử dụng với LIKE
--Dấu % đại diện cho không, một hoặc nhiều ký tự
--Dấu _ đại diện cho một ký tự đơn 

SELECT *
FROM Customers
WHERE Country LIKE 'A%';

SELECT*
FROM Orders
WHERE ShipCity LIKE '%a%';

SELECT*
FROM Orders
WHERE ShipCountry LIKE 'U_';

SELECT *
FROM Orders
Where ShipCountry Like 'U%';

SELECT *
FROM Suppliers
Where CompanyName  LIKE '%b%';

--WILDCARD (Ký tự đại diện)
--Dấu % đại diện cho không, một hoặc nhiều ký tự
--Dấu _ đại diện cho một ký tự đơn 
--Dấu [] đại diện cho một ký tự bất kỳ xuất hiện trong ngoặc EX: h[oat] finds hot and hat
--Dấu ^ làm đảo ngược dấu [] EX: h[^oa]t finds hit, but not hot and hat
--Dấu - đại diện cho một khoảng ký tự EX: h[a-c]t finds hat, hbt, hct 

SELECT * 
FROM Customers
WHERE ContactName LIKE 'A%';

SELECT *
FROM Customers
WHERE ContactName LIKE 'H_%';

SELECT *
FROM Orders
WHERE ShipCity LIKE 'L[uo]%';

SELECT *
FROM Orders
WHERE ShipCity LIKE 'L[^uo]%';

SELECT *
FROM Orders
WHERE ShipCity LIKE 'L[a-e]%';

SELECT *
FROM Suppliers
WHERE CompanyName LIKE 'A' AND NOT CompanyName LIKE '%B%'
select *
 from Suppliers
 where CompanyName like 'A[^b]%';

 --IN/ NOT IN operator (tìm kiếm giá trị trong danh sách)
 SELECT *
 FROM Orders
 WHERE ShipCountry NOT IN ('Germany','UK','Brazil');

 SELECT *
 FROM Employees
 WHERE TitleOfCourtesy IN ('Mr.','Dr.');

 SELECT *
 FROM Employees
 WHERE TitleOfcourtesy IN ('Mrs.');

 SELECT *
 FROM Customers
 WHERE City IN ('Berlin','London','Warszawa');

 --IS NULL/ IS NOT NULL (kiểm tra giá trị NULL)
 SELECT COUNT(*)
 FROM Orders
 WHERE ShippedDate IS NULL;

 SELECT *
 FROM Customers
 WHERE Region IS NOT NULL;

 SELECT *
 FROM Customers
 WHERE CompanyName IS NOT NULL;

 SELECT *
 FROM Orders
 WHERE ShippedDate IS NULL AND ShipRegion IS NOT NULL;

 --GROUP BY (Nhóm các dòng dữ liệu có cùng gía trị với nhau) (thường được dùng với các hàng COUNT, MAX, MIN, SUM, AVG)
 SELECT CustomerID, COUNT(OrderID) AS TotalOrders
 FROM Orders
 GROUP BY CustomerID;

 SELECT SupplierID, AVG(UnitPrice) AS AVGPrice
 FROM Products
 GROUP BY SupplierID;

 SELECT ProductName, SUM(UnitsInStock) AS Summmm
 FROM Products
 GROUP BY ProductName

 SELECT ShipCity,ShipCountry,
		MIN(Freight) AS [MinFreight],
		MAX(Freight) AS [MaxFreight]
FROM Orders
GROUP BY ShipCity, ShipCountry;

SELECT Country, COUNT(*)
FROM Employees
GROUP BY Country;

--DAY,MONTH,YEAR (Hàm lấy ngày, tháng, năm)
SELECT YEAR([OrderDate]) AS  [Year], COUNT(*) AS TotalOrders, CustomerID
FROM Orders
WHERE YEAR([OrderDate])=1997
GROUP BY YEAR(OrderDate),CustomerID;

SELECT YEAR(OrderDate) AS YEAR, MONTH (OrderDate) AS MONTH, DAY(OrderDate) AS DAY, OrderID, Count(*)
FROM Orders
WHERE YEAR(OrderDate) = 1996 AND MONTH (OrderDate) = 9 AND DAY(OrderDate) = 4
GROUP BY DAY(OrderDate), MONTH (OrderDate),YEAR(OrderDate),OrderID

SELECT CustomerID, Month(OrderDate) AS MONTHH, COUNT(*) AS NumbersOfOrders
FROM Orders
WHERE YEAR(OrderDate) = 1998 
GROUP BY MONTH(OrderDate), CustomerID
ORDER BY MONTH(OrderDate);

SELECT *
FROM Orders
Where MONTH(ShippedDate) = 5
ORDER BY YEAR(ShippedDate);

--HAVING (lọc dữ liệu sau GROUP BY)
SELECT COUNT(*) AS [NumbersOfOrders], CustomerID
FROM Orders
GROUP BY CustomerID
Having COUNT(*) > 20
Order by NumbersOfOrders DESC

SELECT SupplierID, SUM(UnitsInStock) AS TotalStock, AVG(UnitPrice) AS AVGPrice
FROM Products
Group by SupplierID
HAVING SUM(UnitsInStock) > 30 AND AVG(UnitPrice) <50

SELECT MONTH(ShippedDate) AS MONTHH, SUM(Freight) AS TotalMoney
FROM Orders
WHERE ShippedDate BETWEEN '1996-07-01' AND '1996-12-31'
GROUP BY MONTH(ShippedDate)
Order by MONTHH ASC;

SELECT ShipCity, COUNT(*) AS TotalOrders
FROM Orders
Group by ShipCity
Having Count(*) > 16
Order by TotalOrders DESC;

SELECT CustomerID, COUNT(*) AS TotalOrders
From Orders
GROUP BY CustomerID
Having COUNT(*) >20
Order By Count(*) DESC;

SELECT EmployeeID, COUNT(*) AS TotalOrders
From Orders
Group by EmployeeID
Having Count(*) >=100
Order by Count(*) DESC;

SELECT CategoryID, Count(*) AS TotalProducts
From Products
Group by CategoryID
Having Count(*) > 11;

SELECT CategoryID, SUM(UnitsInStock) AS TotalUnitsInStock
From Products
Group by CategoryID
Having SUM(UnitsInStock) > 350;

SELECT ShipCountry, COUNT(CustomerID) AS TotalCustomers
FROM Orders
Group by ShipCountry
Having COUNT(CustomerID) > 7;

SELECT ShippedDate, Count(*) AS TotalOrders
From Orders
Group by ShippedDate
Having Count(*) >5
Order by TotalOrders ASC;

Select ShipCountry, Count(*) AS TotalOrders
From Orders
Where ShipCountry LIKE 'A%' OR ShipCountry LIKE 'G%'
Group By ShipCountry
Having Count(*) > 29
Order By Count(*) DESC;

Select ShipCity, Count(*) AS TotalOrders
From Orders
Where ShippedDate Between '1997-04-01' AND '1997-08-31'
Group by ShipCity
--Having Count(*) <> 1 AND Count(*) <> 2;
Having Count(*) NOT IN (1,2);

--Truy vấn đữ liệu từ nhiều table

SELECT p.ProductID, p.ProductName, c.CategoryID, c.CategoryName 
FROM Products AS P, Categories AS C
WHERE c.CategoryID = p.CategoryID

SELECT o.EmployeeID, e.LastName, e.FirstName , COUNT(o.OrderID) AS TotalOrders
FROM Orders AS o, Employees AS e
Where o.EmployeeID = e.EmployeeID
Group by o.EmployeeID, e.LastName,e.FirstName;

SELECT c.CustomerID, c.CompanyName, c.ContactName, Count(o.OrderID) AS ToralOrders
FROM Customers AS c, Orders AS o
WHERE o.ShipCountry = 'UK' AND o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CompanyName, c.ContactName;

SELECT o.ShipName, s.CompanyName, SUM(o.Freight) AS TotalMoney
FROM Orders AS o, Shippers AS s
WHERE o.ShipVia = s.ShipperID
Group by o.ShipName, s.CompanyName
Order by TotalMoney DESC;

SELECT TOP 1 s.SupplierID, s.CompanyName, COUNT(p.ProductID) AS TotalProduct
FROM Products AS p, Suppliers AS s
Where s.SupplierID = p.SupplierID
Group by s.SupplierID, s.CompanyName
Order by TotalProduct DESC;

SELECT od.OrderID, SUM(od.UnitPrice*od.Quantity) AS TotalMoney
FROM Orders AS o, [Order Details] AS od
Where od.OrderID = o.OrderID
Group BY od.OrderID;

SELECT o.OrderID, e.LastName, e.FirstName, SUM(od.UnitPrice * od.Quantity) AS TotalMoney
FROM [Order Details] AS od, Orders AS o,  Employees AS e
Where od.OrderID = o.OrderID AND o.EmployeeID = e.EmployeeID
Group by  o.OrderID, e.LastName, e.FirstName;

SELECT o.OrderID, c.CustomerID , s.CompanyName, o.ShipCountry, YEAR(o.ShippedDate)
FROM Customers AS c, Orders AS o, Shippers AS s
Where c.CustomerID = o.CustomerID AND o.ShipVia = s.ShipperID AND o.ShipCountry = 'UK' AND YEAR(o.ShippedDate) = '1997';

Select c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM Products AS p, Categories AS c
Where c.CategoryID = p.CategoryID AND c.CategoryName = 'Seafood'; 

SELECT s.SupplierID, s.Country, p.ProductID, p.ProductName
FROM Products AS p, Suppliers AS s
Where s.Country = 'Germany' AND s.SupplierID = p.SupplierID;

SELECT o.OrderID, c.ContactName, s.CompanyName
FROM Customers c, Orders o, Shippers s
Where c.CustomerID = o.CustomerID AND o.ShipVia = s.ShipperID AND c.City = 'London';

SELECT o.OrderID, c.ContactName, s.CompanyName, o.RequiredDate, o.ShippedDate
FROM Customers c, Orders o, Shippers s
Where o.RequiredDate <o.ShippedDate AND c.CustomerID = o.CustomerID AND o.ShipVia = s.ShipperID;

SELECT COUNT(o.OrderID) AS [Number of orders], o.ShipCountry 
FROM Orders o, Customers c, Shippers s 
WHERE c.CustomerID = o.CustomerID AND o.ShipVia = s.ShipperID AND o.ShipCountry <> 'USA'
Group by o.ShipCountry
Having COUNT(o.OrderID) > 100;

--UNION/UNION ALL (kết hợp các kết quả)
 
SELECT OrderID
FROM [Order Details] od
Where UnitPrice BETWEEN 100 AND 200; --22

SELECT OrderID
FROM [Order Details] od
Where Quantity IN (10,20); --433

SELECT OrderID
FROM [Order Details] 
Where(UnitPrice BETWEEN 100 AND 200)AND Quantity IN (10,20); --7

SELECT OrderID
FROM [Order Details] 
Where(UnitPrice BETWEEN 100 AND 200) OR Quantity IN (10,20); -- 448

SELECT DISTINCT OrderID
FROM [Order Details] 
Where(UnitPrice BETWEEN 100 AND 200) OR Quantity IN (10,20); --360

SELECT OrderID
 FROM [Order Details] od
  Where UnitPrice BETWEEN 100 AND 200 --22
UNION -- 360
SELECT OrderID
 FROM [Order Details] od
  Where Quantity IN (10,20); --433

  
SELECT OrderID
 FROM [Order Details] od
  Where UnitPrice BETWEEN 100 AND 200 --22
UNION ALL --455
SELECT OrderID
 FROM [Order Details] od
  Where Quantity IN (10,20); --433

SELECT DISTINCT Country
FROM Suppliers
UNION ALL
SELECT DISTINCT Country
FROM Customers;

--INNER JOIN (JOIN): trả về tất cả các hàng khi có ít nhất một giá trị ở cả hai bảng 
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM Categories c
INNER JOIN Products p
ON c.CategoryID = p.CategoryID;

SELECT c.CategoryID, c.CategoryName, COUNT(p.ProductID)
FROM Products AS p
--WHERE p.CategoryID = c.CategoryID
INNER JOIN Categories c
ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryID, c.CategoryName;

SELECT o.OrderID, c.CompanyName
FROM Orders AS o, Customers  c
--INNER JOIN Customers  c
--ON o.CustomerID = c.CustomerID
WHERE o.CustomerID = c.CustomerID;

--LEFT OUTER JOIN(LEFT JOIN): Trả lại tất cả các dòng từ bảng bên trái, và các dòng đúng với điều kiện từ bảng bên phải 
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM Categories c
INNER JOIN Products p
ON c.CategoryID = p.CategoryID;

SELECT c.CategoryID, c.CategoryName, COUNT(p.ProductID)
FROM Categories c
LEFT JOIN Products p
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName;

--RIGHT OUTER JOIN(RIGHT JOIN): ngược lại so với LEFT OUTER JOIN
SELECT o.OrderID, c.CompanyName
FROM Orders AS o
RIGHT JOIN Customers  c
ON o.CustomerID = c.CustomerID

--FULL JOIN: Trả về tất cả các dòng trong các bảng 
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM Categories c
FULL JOIN Products p
ON c.CategoryID = p.CategoryID;

SELECT e.LastName,e.FirstName, o.CustomerID
FROM Employees e
INNER JOIN Orders o
ON e.EmployeeID = o.EmployeeID;

SELECT s.CompanyName, p.ProductName
FROM Products p
LEFT JOIN Suppliers s
ON s.SupplierID = p.SupplierID;

SELECT c.ContactName, o.OrderID
FROM Orders o
RIGHT JOIN Customers c
ON o.CustomerID = c.CustomerID;

SELECT p.CategoryID, s.SupplierID
FROM Products p
FULL JOIN Suppliers S
ON s.SupplierID = p.SupplierID ;

SELECT DISTINCT od.ProductID, p.ProductName, s.CompanyName 
FROM [Order Details] od
INNER JOIN Products p
ON p.ProductID = od.ProductID
INNER JOIN Orders o
ON od.OrderID = o.OrderID;

SELECT o.CustomerID, (e.LastName + e.FirstName) AS HoTen
FROM Orders o
LEFT JOIN Employees e
ON e.EmployeeID = o.EmployeeID

SELECT o.OrderID, e.LastName, e.FirstName,c.CompanyName 
FROM Orders o
RIGHT JOIN Customers c
ON o.CustomerID = c.CustomerID
RIGHT JOIN Employees e
ON e.EmployeeID =o.EmployeeID;

-- Tạo cơ sở dữ liệu mới 
CREATE DATABASE employees
DROP DATABASE employees

CREATE TABLE Person(
	PersonID int,
	LastName varchar(255),
	FirstName varchar(255),
	Age int,
	Gender char(1),
	City varchar(255)
);

INSERT INTO Person
VALUES(1,'Hiddles','Stom',23,'F','Florida');

INSERT INTO Person
VALUES(2,'Watson','Angela',18,'F','Texas'),
(3,'Clooney','Pandora',34,'U','Arizona'),
(4,'Crane','Amory',52,'M','California'),
(5,'Clooney','Bush',67,'M','Arizona'),
(6,'Schwimmer','Geoffrey',19,'U','Hawaii');

SELECT FirstName, LastName INTO Person2 From Person;

--INDEX trong database
--INDEX là cấu trúc dữ liệu được dùng để định vị và truy cập nhanh nhất vào dữ liệu trong các bảng database
CREATE INDEX idx_CustomerName ON Customers(CustomerName);

--view trong database 
 --view là sự trình bày data theo y mướn được trích xuất từ một hoặc nhiều table/view khác nhau 
 CREATE VIEW MonthlySales AS
 SELECT Year([OrderDate]) as "Nam",
		Month([OrderDate]) as "Tháng",
		COUNT([OrderID]) as "Số lượng đơn hàng"
FROM Orders
Group by Year([OrderDate]), Month([OrderDate]);

--Stored Procedures 





