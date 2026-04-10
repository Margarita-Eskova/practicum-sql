-- =============================================
-- Практическая работа №1 (продвинутые возможности PostgreSQL)
-- Выбраны задания: А1, А3, В11, Г18
-- =============================================

-- ------------------------------------------------------------------
-- Задание 1 (А). Дни недели продаж
-- ------------------------------------------------------------------
-- Цель: определить, в какой день недели совершается наибольшее количество продаж.
-- Используемые функции:
--   EXTRACT(DOW FROM date) — извлекает номер дня недели (0=воскресенье ... 6=суббота)
--   CASE — преобразует числовой номер в текстовое название дня
--   COUNT(*) — считает количество продаж в каждом дне недели
--   GROUP BY — группирует результаты по дню недели
--   ORDER BY — сортирует от большего к меньшему
-- Результат: вторник — 5 456 продаж (наибольшее количество)

SELECT 
    CASE EXTRACT(DOW FROM sales_transaction_date)
        WHEN 0 THEN 'Воскресенье'
        WHEN 1 THEN 'Понедельник'
        WHEN 2 THEN 'Вторник'
        WHEN 3 THEN 'Среда'
        WHEN 4 THEN 'Четверг'
        WHEN 5 THEN 'Пятница'
        WHEN 6 THEN 'Суббота'
    END AS day_of_week,
    COUNT(*) AS number_of_sales
FROM sales
GROUP BY EXTRACT(DOW FROM sales_transaction_date)
ORDER BY number_of_sales DESC;


-- ------------------------------------------------------------------
-- Задание 3 (А). Квартальный отчет
-- ------------------------------------------------------------------
-- Цель: вывести сумму продаж с разбивкой по кварталам и годам.
-- Используемые функции:
--   EXTRACT(YEAR FROM date) — извлекает год
--   EXTRACT(QUARTER FROM date) — извлекает номер квартала (1-4)
--   CONCAT() — объединяет строки в формат "Q1 2010"
--   SUM(sales_amount) — считает общую сумму продаж за квартал
--   GROUP BY — группирует по году, кварталу и метке
--   ORDER BY — сортирует по году и кварталу
-- Результат: таблица с годами, кварталами и суммами продаж (например, Q1 2010 → 4 759,88)

SELECT 
    EXTRACT(YEAR FROM sales_transaction_date) AS year,
    EXTRACT(QUARTER FROM sales_transaction_date) AS quarter,
    CONCAT('Q', EXTRACT(QUARTER FROM sales_transaction_date), ' ', EXTRACT(YEAR FROM sales_transaction_date)) AS quarter_label,
    SUM(sales_amount) AS total_sales
FROM sales
GROUP BY year, quarter, quarter_label
ORDER BY year, quarter;


-- ------------------------------------------------------------------
-- Задание 11 (В). JSON-история покупок
-- ------------------------------------------------------------------
-- Цель: сформировать JSON-объект для каждого клиента с его покупками.
-- Используемые функции:
--   JSONB_BUILD_OBJECT() — создаёт JSON-объект из пар ключ-значение
--   COALESCE() — заменяет NULL на пустой массив
--   ARRAY_AGG(DISTINCT ...) — собирает уникальные типы продуктов в массив
--   ARRAY[]::TEXT[] — пустой массив для клиентов без покупок
--   LIMIT 20 — ограничиваем вывод для наглядности
-- Результат: {"id": 1, "name": "Arlena Riveles", "products": ["s"]}

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    JSONB_BUILD_OBJECT(
        'id', c.customer_id,
        'name', c.first_name || ' ' || c.last_name,
        'products', COALESCE(
            (SELECT ARRAY_AGG(DISTINCT p.product_type) 
             FROM sales s 
             JOIN products p ON s.product_id = p.product_id 
             WHERE s.customer_id = c.customer_id), 
            ARRAY[]::TEXT[]
        )
    ) AS customer_json
FROM customers c
LIMIT 20;


-- ------------------------------------------------------------------
-- Задание 18 (Г). Категоризация отзывов
-- ------------------------------------------------------------------
-- Цель: разделить отзывы на категории по ключевым словам.
-- Используемые функции:
--   ILIKE '%слово%' — регистронезависимый поиск подстроки
--   CASE WHEN ... THEN ... ELSE ... END — условное присвоение категории
--   ORDER BY rating DESC — сортировка по убыванию оценки
-- Категории:
--   'Service' — если есть слова service или staff
--   'Product' — если есть слова bike, scooter или quality
--   'Other' — все остальные отзывы
-- Результат: каждый отзыв помечен категорией (Service, Product, Other)

SELECT 
    rating,
    feedback,
    CASE 
        WHEN feedback ILIKE '%service%' OR feedback ILIKE '%staff%' THEN 'Service'
        WHEN feedback ILIKE '%bike%' OR feedback ILIKE '%scooter%' OR feedback ILIKE '%quality%' THEN 'Product'
        ELSE 'Other'
    END AS category
FROM customer_survey
ORDER BY rating DESC;