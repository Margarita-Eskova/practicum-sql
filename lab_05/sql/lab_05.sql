-- =============================================
-- ЗАДАНИЕ 1 (выполняется на сервере преподавателя)
-- =============================================
-- Анализ запроса без индекса (только EXPLAIN ANALYZE, индекс не создаётся)
-- Запрос: найти продажи по каналу 'dealership'

EXPLAIN ANALYZE
SELECT * FROM sales WHERE channel = 'dealership';

-- =============================================
-- ПОДГОТОВКА ЛОКАЛЬНОЙ СРЕДЫ (mylocaldb)
-- =============================================
-- Копирование таблиц из teacher_data в mylocaldb

-- Копирование таблицы sales
-- pg_dump -h localhost -p 5433 -U postgres -t sales teacher_data | psql -h localhost -p 5433 -U postgres -d mylocaldb

-- Копирование таблицы salespeople
-- pg_dump -h localhost -p 5433 -U postgres -t salespeople teacher_data | psql -h localhost -p 5433 -U postgres -d mylocaldb

-- =============================================
-- ЗАДАНИЕ 2. Оптимизация запроса по каналу channel
-- =============================================

-- 2.1. Проверка плана выполнения БЕЗ индекса (ожидается Seq Scan)
EXPLAIN ANALYZE
SELECT * FROM sales WHERE channel = 'dealership';

-- 2.2. Создание индекса B-Tree на столбце channel
CREATE INDEX idx_sales_channel ON sales(channel);

-- 2.3. Проверка плана выполнения С индексом (ожидается Index Scan или Bitmap Index Scan)
EXPLAIN ANALYZE
SELECT * FROM sales WHERE channel = 'dealership';

-- 2.4. Удаление индекса (после проверки)
DROP INDEX idx_sales_channel;

-- =============================================
-- ЗАДАНИЕ 3. Оптимизация поиска по диапазону дат (hire_date)
-- =============================================

-- 3.1. Проверка плана выполнения БЕЗ индекса (ожидается Seq Scan)
EXPLAIN ANALYZE
SELECT * FROM salespeople 
WHERE hire_date BETWEEN '2015-01-01' AND '2017-12-31';

-- 3.2. Создание индекса B-Tree на столбце hire_date
CREATE INDEX idx_salespeople_hire_date ON salespeople(hire_date);

-- 3.3. Проверка плана выполнения С индексом (ожидается Index Scan)
EXPLAIN ANALYZE
SELECT * FROM salespeople 
WHERE hire_date BETWEEN '2015-01-01' AND '2017-12-31';

-- 3.4. Удаление индекса (после проверки)
DROP INDEX idx_salespeople_hire_date;

-- =============================================
-- ДОПОЛНИТЕЛЬНО: проверка наличия таблиц в mylocaldb
-- =============================================
-- \dt

-- =============================================
-- ВАЖНО:
-- 1. Задание 1 выполняется ТОЛЬКО на сервере преподавателя
-- 2. Задания 2 и 3 выполняются ТОЛЬКО в mylocaldb
-- 3. Индексы создаются временно, после проверки удаляются
-- =============================================