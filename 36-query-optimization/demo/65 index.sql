/*
Отсутствуют сведения об индексе из 60 query.sql - localhost.WideWorldImporters (VIMPELCOM_MAIN\KNKucherova (132))
Обработчик запросов считает, что реализация следующего индекса может сократить стоимость запроса на 8.14912%.
*/

/*
USE [WideWorldImporters]
GO
CREATE NONCLUSTERED INDEX IX_OrderLines_PickedQuantity
ON [Sales].[OrderLines] ([PickedQuantity])
INCLUDE ([OrderID],[StockItemID],[PackageTypeID])
GO
*/
