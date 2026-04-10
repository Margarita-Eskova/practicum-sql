-- =============================================
-- Часть 1. Общие задания (Guided Labs)
-- =============================================

-- ------------------------------------------------------------------
-- Задание 1.1. Поиск покупателей авто (INNER JOIN)
-- ------------------------------------------------------------------
-- Цель: получить контактные данные всех клиентов, купивших автомобиль, для обзвона.
-- Используются таблицы: sales (продажи), customers (клиенты), products (товары).
-- INNER JOIN гарантирует, что в результат попадут только клиенты,
-- у которых есть и продажа, и телефон, и товар — автомобиль.
-- Условие p.product_type = 'automobile' фильтрует только автомобили.
-- Условие c.phone IS NOT NULL исключает клиентов без телефона.
-- Выводятся: id клиента, имя, фамилия, телефон.

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

-- ------------------------------------------------------------------
-- Задание 1.2. Вечеринка в Лос-Анджелесе (UNION)
-- ------------------------------------------------------------------
-- Цель: составить список приглашённых на мероприятие (клиенты + сотрудники из Лос-Анджелеса).
-- Первая часть запроса: клиенты из city = 'Los Angeles', тип 'Customer'.
-- Вторая часть: продавцы, работающие в дилерских центрах в 'Los Angeles', тип 'Employee'.
-- UNION объединяет оба набора и удаляет дубликаты.
-- INNER JOIN с dealerships нужен, чтобы найти сотрудников конкретного дилерского центра.

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

-- ------------------------------------------------------------------
-- Задание 1.3. Создание витрины данных (Data Transformation)
-- ------------------------------------------------------------------
-- Цель: подготовить "плоскую" таблицу для аналитиков.
-- INNER JOIN с customers и products: оставляем только продажи с известными клиентами и товарами.
-- LEFT JOIN с dealerships: сохраняем продажи даже без дилера (значения будут NULL).
-- COALESCE(s.dealership_id, -1): заменяет NULL на -1 для удобства анализа.
-- CASE WHEN (p.base_msrp - s.sales_amount) > 500 THEN 1 ELSE 0 END:
--   создаёт бинарный признак high_savings: 1 — экономия более 500, 0 — иначе.

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

-- =============================================
-- Часть 2. Индивидуальные задания (вариант 9)
-- =============================================

-- ------------------------------------------------------------------
-- Задача 1 (JOIN). Клиенты, кликнувшие по ссылке в письме
-- ------------------------------------------------------------------
-- Условие: вывести имена клиентов, которые кликнули (clicked = 't') по ссылке в письме.
-- INNER JOIN связывает клиентов с таблицей emails по customer_id.
-- Условие e.clicked = 't' оставляет только письма с кликом.
-- DISTINCT убирает дубликаты (один клиент мог кликнуть по нескольким письмам).
-- Выводятся: имя, фамилия, email клиента.

SELECT DISTINCT
    c.first_name,
    c.last_name,
    c.email
FROM customers c
INNER JOIN emails e ON c.customer_id = e.customer_id
WHERE e.clicked = 't';

-- ------------------------------------------------------------------
-- Задача 2 (UNION). Список городов дилеров и клиентов
-- ------------------------------------------------------------------
-- Условие: вывести уникальные города из таблиц customers и dealerships.
-- Первый SELECT: все города из customers.
-- Второй SELECT: все города из dealerships.
-- UNION объединяет результаты и автоматически удаляет дубликаты.

SELECT city FROM customers
UNION
SELECT city FROM dealerships;

-- ------------------------------------------------------------------
-- Задача 3 (Data Prep). Преобразование года выпуска в текстовый формат
-- ------------------------------------------------------------------
-- Условие: в таблице products привести год (production_start_date) к текстовому формату
--          и создать столбец "Model Year: 20XX".
-- EXTRACT(YEAR FROM production_start_date): извлекает числовой год из даты.
-- CONCAT('Model Year: ', ...): собирает строку вида 'Model Year: 2023'.
-- Псевдоним в двойных кавычках сохраняет пробелы в имени столбца.
-- Дополнительно выводятся модель, тип продукта и базовая цена для наглядности.

SELECT 
    model,
    product_type,
    base_msrp,
    EXTRACT(YEAR FROM production_start_date) AS production_year,
    CONCAT('Model Year: ', EXTRACT(YEAR FROM production_start_date)) AS "Model Year: 20XX"
FROM products;




















