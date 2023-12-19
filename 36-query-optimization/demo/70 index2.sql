/*
Отсутствуют сведения об индексе из 60 query.sql - localhost.WideWorldImporters (VIMPELCOM_MAIN\KNKucherova (132))
Обработчик запросов считает, что реализация следующего индекса может сократить стоимость запроса на 82.7887%.
*/

/*
USE [WideWorldImporters]
GO
CREATE NONCLUSTERED INDEX IX_Invoices_InvoiceDate
ON [Sales].[Invoices] ([InvoiceDate])
INCLUDE ([CustomerID],[BillToCustomerID],[OrderID],[SalespersonPersonID])
GO
*/
