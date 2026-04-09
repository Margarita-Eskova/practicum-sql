-- Часть 2. Индивидуальные задания (вариант 9)

-- Задание 2.1. Товары типа 'scooter' дороже $500

-- Вывести все товары типа 'scooter' с ценой больше 500, отсортированные по цене по убыванию

select *
from products
where product_type = 'scooter' and base_msrp > 500
order by base_msrp desc;

-- Задание 2.2. Продажи через интернет на сумму от 15 000 до 30 000

-- Вывести все продажи через канал 'internet' с суммой от 15000 до 30000

select *
from sales
where channel = 'internet' and sales_amount between 15000 and 30000;

-- Задание 2.3*. CRUD операции (локально, в mylocaldb)

-- 1. Создать таблицу high_price как копию товаров дороже 1000
create table high_price as
select * from products
where base_msrp > 1000;

-- 2. Проверка: сколько записей скопировалось
select count(*) from high_price;

-- 3. Увеличить цену на 10%
update high_price
set base_msrp = base_msrp * 1.1;

-- 4. Проверка изменения цен (первые 5 строк)
select base_msrp from high_price limit 5;

-- 5. Удалить товары, произведённые до 2012 года
delete from high_price
where production_start_date < '2012-01-01';

-- 6. Проверка: сколько осталось после удаления
select count(*) from high_price;

-- 7. Финальная проверка результата
select *
from high_price;