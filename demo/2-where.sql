use WideWorldImporters;

-----------------------
--where - фильтрация строк по условию
--условие - логическое выражение
--для каждой строки проверяем условие 
--	true - строка попадает в выборку
--	false - не попадет
-----------------------
-- логическое выражение: true, false
select s.Size, *
from Warehouse.StockItems as s
where 1=0

---логическое выражение 
--для SQL - логическое выражение: true, false, и еще что-то
--229 строк
select s.Size, * 
from Warehouse.StockItems as s 

--9 строк
select s.Size, * 
from Warehouse.StockItems as s 
where s.Size = '1/12 scale'

--154 строки
select s.Size, * 
from Warehouse.StockItems as s 
where s.Size != '1/12 scale'

--9+154 <> 229? где остальные строки?
--сколько строк?
select s.Size, * 
from Warehouse.StockItems as s 
where s.Size = null --логическое выражение

-----------------------
--обработка null
--where: is null, is not null
--колонки: isnull(), coalesce()
select s.Size, s.StockItemId
	, isnull(s.Size, '-') as [isnull()] --если не указан s.Size - выводим '-' (смотрим на тип)
	, coalesce(s.Size, cast(s.StockItemId as varchar), '-') as [coalesce()] --если не указан s.Size - выводим '-'
	, s.StockItemName
from Warehouse.StockItems as s
--where s.Size is null 
order by s.Size offset 65 rows --66 строк с s.Size is null 


--SARGable - предикаты (условия, позволяющие использовать индекс)
select s.StockItemID 
from Warehouse.StockItems as s 
where s.StockItemID = 10 --sargable index seek

select s.StockItemID 
from Warehouse.StockItems as s 
where sqrt(s.StockItemID) = 10 --не sargable (функция)

select s.StockItemID 
from Warehouse.StockItems as s 
where s.StockItemID between 10 and 20 --sargable поиск по индексу

select s.StockItemID 
from Warehouse.StockItems as s 
where s.StockItemID like '%39%' --не sargable

select s.StockItemID 
from Warehouse.StockItems as s 
where s.Barcode like '8%' --не sargable

/* если успеваем
-- isnull vs coalesce  
;with cte as (
	select 1 as val
	union all 
	select null
)
select val, isnull(val, 1.4) as [isnull], coalesce(val, 1.4) as [coalesce]
from cte 
*/
-------------
-- несколько условий
-- условие - логическое выражение 
-- операции над логическими выражениями AND, OR, NOT
-- NOT - отрицание (уже встречались как not null)
-------------
-- Нужно вывести StockItems, где цена от 350 до 500 и
-- название начинается с USB или Ride.
-- Все правильно?
select RecommendedRetailPrice, *
from Warehouse.StockItems
where
    RecommendedRetailPrice between 350 and 500 --цена от 350 до 500
	and StockItemName like 'USB%' --название начинается с USB
 	or StockItemName like 'Ride%' --название начинается с Ride
--pgdn







--AND, OR - очередность выполнения вначале все AND, затем OR
--смена приоритета - скобки
-- Нужно вывести StockItems, где цена от 350 до 500 и
-- название начинается с USB или Ride.
select RecommendedRetailPrice, *
from Warehouse.StockItems
where
    RecommendedRetailPrice between 350 and 500 --цена от 350 до 500
	and (StockItemName like 'USB%' --название начинается с USB
    or StockItemName like 'Ride%') --название начинается с Ride