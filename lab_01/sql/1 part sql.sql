-- Часть 1. Общие задания

-- 1.1. Персонал

-- Запрос 1.1.1. Вывести username первых 10 нанятых женщин-продавцов, отсортированных по дате найма от ранней к поздней:

select username
from salespeople
where gender = 'Female'
order by hire_date 
limit 10;

-- Запрос 1.1.2. Аналогичный запрос для мужчин-продавцов

select username
from salespeople
where gender = 'Male'
order by hire_date
limit 10;

-- 1.2. Клиенты

-- Запрос 1.2.1. Все email клиентов из 'FL', сортировка по алфавиту.

select email
from customers
where state = 'FL'
order by email;

-- Запрос 1.2.2.Имена и email клиентов из 'New York City', 'NY'. Сортировка: Фамилия, затем Имя.

select last_name, first_name, email
from customers
where city = 'New York City' and state = 'NY'
order by last_name, first_name;

-- Запрос 1.2.3. Все клиенты с телефоном, сортировка по дате регистрации.

select customer_id, first_name, last_name, phone, date_added
from customers
where phone is not null
order by date_added;

-- 1.3*. CRUD операции (локально, в mylocaldb)

-- 1. Создать таблицу customers_nyc как копию клиентов из New York City, NY

create table customers_nyc as
select * from customers
where city = 'New York City' and state = 'NY';

-- 2. Удалить клиентов с индексом (postal_code) 10014

delete from customers_nyc
where postal_code = '10014';

-- 3. Добавить текстовый столбец event

alter table customers_nyc
add column event text;

-- 4. Заполнить столбец event значением 'thank-you party'

update customers_nyc
set event = 'thank-you party';

-- 5. Проверка результата

select customer_id, first_name, last_name, postal_code, event
from customers_nyc
limit 20;