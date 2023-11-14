use HR;

/*
create index ix_employees_last_name_first_name on   employees (last_name, first_name)
create index ix_employees_last_name_phone_number on employees (last_name) include(phone_number)
create index ix_employees_last_name_email on        employees (last_name) include(email)
*/

--есть ли лишние индексы? мб возможно какие-то удалить?
select phone_number from employees where last_name = 'King'
select email from employees where last_name = 'King'
select employee_id from employees where last_name = 'King' and first_name = 'Steven' 


--pgdn










--решение - скомбинировать все 3 индекса
create index ix_employees_last_name_first_name_complex on   employees (last_name, first_name) include(email, phone_number)


/*
drop index ix_employees_last_name_first_name on employees
drop index ix_employees_last_name_phone_number on employees
drop index ix_employees_last_name_email on employees

drop index ix_employees_last_name_first_name_complex on employees
*/