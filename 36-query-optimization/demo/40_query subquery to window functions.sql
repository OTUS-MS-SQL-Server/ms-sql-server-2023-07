SET STATISTICS IO, TIME ON;
​


DECLARE @dt_from DATE, 
	@dt_to DATE

SET @dt_from = DATEFROMPARTS(YEAR(DATEADD(yy, -8, GETDATE())),01,01);

SET @dt_to = EOMONTH(@dt_from,11);

--select @dt_from, @dt_to
​
WITH Invoices AS 
(SELECT Inv.InvoiceDate, Inv.BillToCustomerID, 
	Inv.CustomerID, Inv.SalespersonPersonID, Inv.OrderID, Details.* 
FROM Sales.Invoices AS Inv
	JOIN Sales.InvoiceLines AS Details
		ON Inv.InvoiceID = Details.InvoiceID)
SELECT Client.CustomerName, 
	Inv.InvoiceID, 
	Inv.InvoiceDate, 
	Item.StockItemName, 
	Inv.Quantity, 
	SUM(Inv.Quantity) OVER (Partition BY Inv.StockItemID) AS TotalItems,
	MAX(Inv.Quantity) OVER (PARTITION BY Inv.CustomerID) AS MaxByClient,
	PayClient.CustomerName AS BillForCustomer,
	Pack.PackageTypeName,
	People.FullName AS SalePerson,
	OrdLines.PickedQuantity
FROM Invoices AS Inv
	JOIN Sales.Customers AS Client 
		ON Client.CustomerID = Inv.CustomerID
	JOIN Application.People AS People
		ON People.PersonID = Inv.SalespersonPersonID
	JOIN Sales.Customers AS PayClient 
		ON PayClient.CustomerID = Inv.BillToCustomerID
	JOIN Warehouse.StockItems AS Item 
		ON Item.StockItemID = Inv.StockItemID
	JOIN Sales.Orders AS Ord 
		ON Ord.OrderID = Inv.OrderID
	JOIN Sales.OrderLines AS OrdLines
		ON OrdLines.OrderID = Ord.OrderID
		AND OrdLines.StockItemID = Item.StockItemID
	JOIN Warehouse.PackageTypes AS Pack
		ON Pack.PackageTypeID = OrdLines.PackageTypeID
WHERE Inv.InvoiceDate BETWEEN @dt_from AND @dt_to
	 AND 
	 OrdLines.PickedQuantity > 0
ORDER BY TotalItems DESC, Quantity DESC, CustomerName;

















