﻿use WideWorldImporters;

drop table if exists #cafe1, #cafe2
create table #cafe1 (id int identity, name nvarchar(10))
create table #cafe2 (id int identity, name nvarchar(10))

insert #cafe1 (name) values(N'яблоки'), (N'груши'), (N'бананы')
insert #cafe2 (name) values(N'яблоки'), (N'груши'), (null)

select * from #cafe1
select * from #cafe2

--cross join
--все комбинации из строк двух таблиц
select *
from #cafe1 as c1
cross join #cafe2 as c2 

--типовая задача: составить все возможные варианты рецептов смузи из 2х фруктов для кафе1

select c1.name, c2.name 
from #cafe1 as c1
cross join #cafe1 as c2 
--where 

--inner join - внутреннее соединение по условию
--типовая задача: найти фрукты, которые есть в кафе1 и кафе2
select * from #cafe1
select * from #cafe2

select c1.name, c2.name 
from #cafe1 as c1
inner join #cafe2 as c2 on c2.name = c1.name

--проблема - если связываем таблицы по неуникальному полю
--добавим дубли
insert #cafe1 (name) values(N'яблоки')
insert #cafe2 (name) values(N'яблоки')

select * from #cafe1
select * from #cafe2

--сколько фруктов есть в обоих кафе?
--а сколько строк вернет запрос?
select c1.name, c2.name 
from #cafe1 as c1
inner join #cafe2 as c2 on c2.name = c1.name


--удалим дубли (но помним про проблемы)
delete from #cafe1 where id = 4
delete from #cafe2 where id = 4

select * from #cafe1
select * from #cafe2

/*
для WideWorldImporters 
задача: товары каких поставщиков есть на складе?
--1. выбираем таблицы
табл. товары на складе - Warehouse.StockItems
табл. поставщики - Purchasing.Suppliers
--2. выбираем условие для связи
обычно внешний ключ  - fk_... ()
Warehouse.StockItems - keys - FK_Warehouse_StockItems_SupplierID_Purchasing_Suppliers

--Warehouse.StockItems.SupplierID = Purchasing.Suppliers.SupplierID

проверяем себя
работает корректно (229 записей, ничего не потеряли), потому что 
- связь по полю из pk (нет дублей) (SupplierID)
- нет null
*/
select s.SupplierName, si.StockItemName
from Warehouse.StockItems as si
inner join Purchasing.Suppliers as s on s.SupplierID = si.SupplierID
order by s.SupplierName, si.StockItemName

----------------------------
--left join
--типовая задача: 
-- какие фрукты есть в кафе1, но нет в кафе2
-- какой фильтр в where задать, чтобы отфильтровать отсутствие фруктов в кафе2
select *
from #cafe1 as c1
left join #cafe2 as c2 on c2.name = c1.name



/*
дополнить список фруктов из кафе1 данными по фруктам из кафе2, 
название которых начинается на Я 
*/

select *
from #cafe1 as c1
left join #cafe2 as c2 on c2.name = c1.name 
where c2.name like N'я%'


select *
from #cafe1 as c1
left join #cafe2 as c2 on c2.name = c1.name and c2.name like N'я%'

--right join - применяется редко, обычно пишем left join
-- какие фрукты есть в кафе2, но нет в кафе1
select *
from #cafe1 as c1
right join #cafe2 as c2 on c2.name = c1.name
--where с1.id is null

--full join - left join + right join
--все фрукты из cafe1, дополненные информацией из cafe2
--все фрукты из cafe2 которые не попали в итоговую таблицу
select *
from #cafe1 as c1
full join #cafe2 as c2 on c2.name = c1.name

