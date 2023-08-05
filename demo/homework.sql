use WideWorldImporters;

--поиск по интервалу - between
select s.UnitPrice, * 
from Warehouse.StockItems as s
where s.UnitPrice between 10 and 20
-- то же самое, что и 
select s.UnitPrice, * 
from Warehouse.StockItems as s
where s.UnitPrice >= 10 and s.UnitPrice <= 20


--в названии города встречается burg
select * from Application.Cities where CityName like '%burg%'

--название города заканчивается на burg
select * from Application.Cities where CityName like '%burg'

--название города начинается на burg
select * from Application.Cities where CityName like 'burg%'



-- isnull vs coalesce  
;with cte as (
	select 1 as val
	union all 
	select null
)
select val
	, isnull(val, 1.4) as [isnull] --приводит к типу val (потеря точности)
	, coalesce(val, 1.4) as [coalesce] --нет потери точности
from cte 



declare @dt datetime = getdate() --04.08.2023

select year(@dt) as [Год]  --2023
	, month(@dt) as [Месяц] --8
	, datepart(quarter, @dt) as [Квартал] --4
	, datename(month, @dt) as [Месяц] --August
	, format(@dt, 'MMMM', 'ru-ru') as [Месяц Ru] --Август
	, convert(varchar, @dt, 104) as [Дата] --04.08.2023

--дата в условии where - удобен формат 'YYYYmmdd'
select * 
from Sales.Orders 
where OrderDate = '20150527'



-- -------------------------------
-- TOP WITH TIES - топ + строки с данными, попавшими на границу сортировки
-- сортировка обязательна
-- -------------------------------
-- `select top N with ties` - выводит N строк + все строки с граничным значением столбцов сортировки

select top 3 CityID, CityName, StateProvinceID
from Application.Cities
order by CityName

select top 3 with ties CityID, CityName, StateProvinceID
from Application.Cities
order by CityName

--типовая задача
--найти тройку самых распространенных названий городов в Application.Cities
select top 3 with ties CityName, count(*) as qtyState
from Application.Cities
group by CityName
order by qtyState desc

