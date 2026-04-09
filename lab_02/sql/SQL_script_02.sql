/* Часть 1. Общие задания (Guided Labs) */

-- Задание 1.1. Поиск покупателей авто (INNER JOIN)
-- Получить контактные данные всех клиентов, купивших автомобиль, для обзвона. 

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.phone
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN products p ON s.product_id = p.product_id
WHERE p.product_type = 'automobile'
  AND c.phone IS NOT NULL;

-- Задание 1.2. Вечеринка в Лос-Анджелесе (UNION)
-- Составить список приглашенных на мероприятие. Это клиенты И сотрудники из Лос-Анджелеса.

SELECT 
    first_name,
    last_name,
    'Customer' AS guest_type
FROM customers
WHERE city = 'Los Angeles'

UNION

SELECT 
    sp.first_name,
    sp.last_name,
    'Employee' AS guest_type
FROM salespeople sp
INNER JOIN dealerships d ON sp.dealership_id = d.dealership_id
WHERE d.city = 'Los Angeles';

-- Задание 1.3. Создание витрины данных (Data Transformation)
-- Подготовить "плоскую" таблицу для аналитиков данных. 

SELECT 
    s.sales_amount,
    COALESCE(s.dealership_id, -1) AS dealership_id,
    c.customer_id,
    c.first_name,
    c.last_name,
    p.product_id,
    p.model,
    p.base_msrp,
    CASE 
        WHEN (p.base_msrp - s.sales_amount) > 500 THEN 1
        ELSE 0
    END AS high_savings
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN products p ON s.product_id = p.product_id
LEFT JOIN dealerships d ON s.dealership_id = d.dealership_id;

/* Часть 2. Индивидуальные задания */
-- 9 вариант

-- Задача 1 (JOIN). Клиенты, кликнувшие по ссылке в письме
-- Условие: Вывести имена клиентов, которые кликнули (clicked = 't') по ссылке в письме.

SELECT DISTINCT
    c.first_name,
    c.last_name,
    c.email
FROM customers c
INNER JOIN emails e ON c.customer_id = e.customer_id
WHERE e.clicked = 't';

-- Задача 2 (UNION). Список городов дилеров и клиентов
-- Условие: Вывести уникальные города из таблиц customers и dealerships.

SELECT city FROM customers
UNION
SELECT city FROM dealerships;

-- Задача 3 (Data Prep). Преобразование года выпуска в текстовый формат
-- Условие: В таблице products привести год (production_start_date) к текстовому формату и создать столбец "Model Year: 20XX".

SELECT 
    model,
    product_type,
    base_msrp,
    EXTRACT(YEAR FROM production_start_date) AS production_year,
    CONCAT('Model Year: ', EXTRACT(YEAR FROM production_start_date)) AS "Model Year: 20XX"
FROM products;




















