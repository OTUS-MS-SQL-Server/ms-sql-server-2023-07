use WideWorldImporters;

-- (*) с осторожностью на больших таблицах 
-- смотрим планы, стоимость и кол-во чтений
select * from Sales.OrderLines
select OrderID from Sales.OrderLines


--------------------------
select c.CityID, c.CityName 
from Application.Cities as c
--удаление дублей - какой оператор?
--удалит дубли? 
--возможно ли удалить дубли на этом наборе колонок 
select distinct c.CityID, c.CityName 
from Application.Cities as c

---------------------------------------------------
--ограничение вывода кол-ва строк (вся таблица не нужна)
--top 10 - в каком порядке выведет информацию?
select top 10 c.CityID, c.CityName, c.StateProvinceID 
from Application.Cities as c

-- без сортировки порядок не гарантирован
select top 10 c.CityID, c.CityName, c.StateProvinceID 
from Application.Cities as c
order by c.CityName asc, c.StateProvinceID desc


-- так будет работать?
select top 10 c.CityID, c.CityName, c.StateProvinceID 
from Application.Cities as c
order by 2, 3 desc
-- pgdn




--сортировка изменится при добавлении колонок => сортировать лучше не по номеру колонки
select top 10 c.LastEditedBy, .CityID, c.CityName, c.StateProvinceID 
from Application.Cities as c
order by 2, 3 desc

--порядок сортировки зависит от типа данных
; with cte as (
	select 1 as val 
	union all select 5
	union all select 10
)
select * from cte order by val
--все то же самое, но тип - строка
--что получим при order by val?
; with cte as (
	select '1' as val 
	union all select '5'
	union all select '10'
)
select * from cte order by val
