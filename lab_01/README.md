# 🐘 Лабораторная работа №1 🐘 
## 🪽 Вариант 9 🪽

👩‍🎓**Студент:** Еськова Маргарита Ивановна 

👥**Группа:** ЦИБ-241

---

## 🔍 Цель работы

Научиться формировать запросы на выборку данных (SELECT) с использованием фильтрации, сортировки и логических операторов. Освоить операции манипулирования данными (CRUD) в безопасной локальной среде.

---
## 🛠️ Ход работы

### 💻 Среда выполнения

Лабораторная работа выполнялась в двух средах:

- **База данных преподавателя** (`bi_sql_data_student`) использовалась для выполнения заданий 1.1, 1.2, 2.1 и 2.2 (SELECT-запросы). Подключение осуществлялось с домашнего компьютера через DBeaver.

- **Локальная база данных** (`mylocaldb`) использовалась для выполнения заданий 1.3* и 2.3* (CRUD-операции). Работа выполнялась на виртуальной машине в среде Oracle VirtualBox.

> 🎓 Виртуальная машина с предустановленным программным обеспечением была предоставлена преподавателем **Босенко Тимуром Муртазовичем**.  
> Образ виртуальной машины доступен для скачивания по ссылке:  
> 🔗 [Скачать образ ВМ (OVA)](https://disk.yandex.ru/d/QifTz8pa5XJX-A)

---

## 📦 Подготовка базы данных преподавателя в DBeaver

### 1. Подключение к базе данных преподавателя

В DBeaver было создано новое подключение к PostgreSQL с параметрами, выданными преподавателем:

<img width="545" height="435" alt="{820BF23F-A51D-424A-93A7-0647E957277E}" src="https://github.com/user-attachments/assets/3b51a9d3-b90b-47c3-98e9-6168eb30c2ae" />

### 2. Проверка подключения

После ввода данных была выполнена проверка через **"Test Connection"** – получен статус **"Connected"**, значит нажимаем **'Ok'**

<img width="542" height="436" alt="{12E0BDB0-DC32-49EA-AC80-F1E487986251}" src="https://github.com/user-attachments/assets/6fa10ab8-69ac-46a4-8b63-bdc6a0e5fe9a" />

### 3. Просмотр таблиц в базе преподавателя

В базе данных видны таблицы: `customers`, `salespeople`, `products`, `sales`, `emails`, `dealerships` и другие.

<img width="338" height="375" alt="{1D72E888-42F7-41F5-9578-B35B00B691FA}" src="https://github.com/user-attachments/assets/15375134-5129-4ff2-b545-b4d3fc2f9a34" />

---

## 📦 Подготовка локальной среды (mylocaldb)

### 1. Создание базы данных и пользователя (в терминале виртуальной машины)

Для выполнения CRUD-операций была создана локальная база данных `mylocaldb` и пользователь `myuser` с паролем `1`.

```bash
sudo -u postgres psql -p 5433             -- вход в консоль PostgreSQL, появление приглашения postgres=#.
[sudo] password for dev: 
psql (14.22 (Ubuntu 14.22-0ubuntu0.22.04.1))
Type "help" for help.

postgres=# CREATE DATABASE mylocaldb;    -- создаёт новую базу данных 'mylocaldb'
CREATE DATABASE

postgres=# CREATE USER myuser WITH PASSWORD '1';   -- создаёт нового пользователя 'myuser' с паролем '1'
CREATE ROLE

postgres=# GRANT ALL PRIVILEGES ON DATABASE mylocaldb TO myuser;   -- выдаёт пользователю все права
GRANT

postgres=# \q      -- выход из консоли psql
dev@dev-vm:~$      -- возврат в обычный терминал dev@dev-vm:~$
```
### 2. Подключение к моей базе данных

База данных была создана, теперь можем подключиться к ней в DBeaver на виртуальной машине. Вводим все необходимые для подключения параметры.

<img width="542" height="594" alt="{D0293B8B-8F9F-4C31-AD7B-22712840A456}" src="https://github.com/user-attachments/assets/d7a3b184-86b4-4a71-802c-fe2c07e1aeb7" />

### 3. Проверка подключения

После ввода данных была выполнена проверка через **"Test Connection"** – получен статус **"Connected"**, значит нажимаем **'Ok'**.

<img width="541" height="594" alt="{C3E6C223-BCB5-4526-BF47-A0BB5CA97725}" src="https://github.com/user-attachments/assets/fa27ecdd-135b-4450-8ae0-f88702abdc2d" />

### 4. Просмотр базы данных

Результатом выполнения команды стало добавление базы данных mylocaldb в DBeaver на виртуальной машине, в которую я теперь спокойно могу скопировать любую талблицу из базы данных преподавателя

<img width="362" height="231" alt="{9FA1E5AF-9888-4399-8E9D-5BC74B3A2F52}" src="https://github.com/user-attachments/assets/86cabc54-5698-427e-8d9e-73395014c19a" />

## 📦 Подготовка базы данных преподавателя в Oracle VirtualBox

### 1. Настройка общей папки для доступа к файлам дампа

Дамп базы данных `teacher_data` был предоставлен преподавателем. Файлы дампа доступны для скачивания по ссылке:

🔗 [Скачать файлы дампа (Яндекс.Диск)](https://disk.yandex.ru/d/p3ga3WZpmAw8-Q)

Чтобы передать файлы дампа с домашнего компьютера на виртуальную машину, была создана **общая папка** `SQL_dumb` и добавлена в Oracle VirtualBox. Это позволило подключить каталог хоста к гостевой системе и работать с файлами внутри виртуального окружения.

![Создание общей папки](https://github.com/user-attachments/assets/9cf91448-eea4-482b-ad2a-c8573bdccbb5)

### 2. Восстановление базы данных из дампа

После размещения файлов дампа в общей папке, на виртуальной машине в терминале была выполнена команда для восстановления базы данных `teacher_data`:

```bash
psql -h localhost -p 5433 -U postgres -d teacher_data < /mnt/sql_dumb/bi_sql_data_student_dump.sql

passsword: 1
```

### 3. Подключение к восстановленной базе в DBeaver

После успешного восстановления база данных teacher_data автоматически стала доступна для работы в DBeaver. Подключение отобразилось в списке баз данных, что позволило сразу приступить к выполнению SELECT-запросов.

<img width="564" height="537" alt="{F2AD3D58-A831-4227-B1CD-834CE458E786}" src="https://github.com/user-attachments/assets/ea40c91a-a3e0-4a30-8425-dee87b2587b2" />

## 📝 Часть 1. Общие задания (Guided Labs)

### 1.1. Персонал (Salespeople)

**Задание:** вывести `username` первых 10 нанятых женщин-продавцов. Отсортировать по `hire_date` от самой ранней к самой поздней. Написать аналогичный запрос для мужчин-продавцов.

**Запрос 1.1.1. Первые 10 женщин-продавцов**

```sql
select username
from salespeople
where gender = 'Female'
order by hire_date 
limit 10;
```

<img width="170" height="323" alt="{1FD147BE-FCE5-4B2A-945A-F7FDCB111C08}" src="https://github.com/user-attachments/assets/76edb3cc-3f9b-4e12-91b1-6c5ccfe0a382" />


**Запрос 1.1.2. Первые 10 мужчин-продавцов**

``` sql
select username
from salespeople
where gender = 'Male'
order by hire_date
limit 10;
```

<img width="160" height="326" alt="{01E938B9-5E20-439B-B946-43A12C050950}" src="https://github.com/user-attachments/assets/567223d2-194b-4b73-b820-50804a1a65e4" />

---

### 1.2. Клиенты (Customers)

**Задания:**

1. Получить все email клиентов из штата Флорида (FL), отсортированные в алфавитном порядке.

2. Получить имена, фамилии и email клиентов из города Нью-Йорк (New York City), штат Нью-Йорк (NY). Отсортировать по фамилии, затем по имени.

3. Получить всех клиентов с их номерами телефонов, отсортированных по дате добавления в базу (date_added).

**Запрос 1.2.1. Email клиентов из Florida (FL)**

``` sql
select email
from customers
where state = 'FL'
order by email;
```

<img width="185" height="467" alt="{02983DE1-C5D4-4A0D-95AA-E007BA559DD6}" src="https://github.com/user-attachments/assets/fbb09363-aa5c-4b34-a9f8-33817e3154d2" />


**Запрос 1.2.2. Клиенты из New York City, NY**

``` sql
select last_name, first_name, email
from customers
where city = 'New York City' and state = 'NY'
order by last_name, first_name;
```

<img width="376" height="464" alt="{0DE6400B-3B62-46C7-BCF3-AB39B327F9E0}" src="https://github.com/user-attachments/assets/778f1f07-f74a-4352-bd6c-b3f19c79d6a9" />


**Запрос 1.2.3. Клиенты с телефоном**

``` sql
select customer_id, first_name, last_name, phone, date_added
from customers
where phone is not null
order by date_added;
```

<img width="517" height="467" alt="{ACD621D2-3293-4F77-83BB-9953B8EC0DB7}" src="https://github.com/user-attachments/assets/41fc913b-4040-4649-b998-cd5c13103d9e" />

---

### 1.3*. CRUD операции (локально, mylocaldb)

**Задания:**

1. Создать таблицу `customers_nyc`, скопировав данные клиентов из города New York City (штат NY).
2. Удалить из новой таблицы клиентов с индексом 10014.
3. Добавить текстовый столбец `event`.
4. Заполнить столбец `event` значением 'thank-you party'.

#### 📂 Подготовка: копирование исходной таблицы `customers`

Перед выполнением CRUD-операций исходная таблица `customers` (50 000 записей) была скопирована из базы преподавателя `teacher_data` в мою локальную базу `mylocaldb`. Для этого в терминале виртуальной машины была выполнена команда:

```bash
pg_dump -h localhost -p 5433 -U postgres -t customers teacher_data | psql -h localhost -p 5433 -U postgres -d mylocaldb
```

**Результат команды:**

<img width="668" height="455" alt="{AB786445-7CBC-498E-8818-D9BA7AEA19B1}" src="https://github.com/user-attachments/assets/1ab851b1-345f-4232-b31a-93b04f2d5178" />

**Таблица в 'mylocaldb'**

<img width="597" height="465" alt="{F5111477-76B7-4EF0-AA9E-8C00B0108D47}" src="https://github.com/user-attachments/assets/52a2a86f-ed81-4ad8-9bfc-864dce12c9ce" />

---

#### ⚙️ Выполнение заданий

**Создание таблицы customers_nyc, скопировав данные клиентов из города New York City (штат NY)**

``` sql
create table customers_nyc as
select * from customers
where city = 'New York City' and state = 'NY';
```

<img width="559" height="484" alt="16" src="https://github.com/user-attachments/assets/5f74fe09-cf7e-4531-9f31-12c29dcae685" />

**Проверка: сколько записей скопировалось**

``` sql
select count(*) from customers_nyc;
```

<img width="474" height="375" alt="{65B3148C-A0C5-4247-8FD9-A7A40ED8A540}" src="https://github.com/user-attachments/assets/05562ede-d74b-49f1-b365-7aec689cd79d" />

**Удаление клиентов с индексом 10014**

``` sql
delete from customers_nyc
where postal_code = '10014';
```


**Проверка: сколько осталось после удаления**

``` sql
select count(*) from customers_nyc;
```
<img width="513" height="372" alt="{DA64D53D-2FB0-49FE-AF30-2D3F6E0E3A86}" src="https://github.com/user-attachments/assets/77d2267f-9620-4324-81e4-4f555c569695" />

**Добавление столбца event**

``` sql
alter table customers_nyc
add column event text;
```
<img width="527" height="402" alt="{97361BD3-7ACA-4BCE-808E-644E84C55DBE}" src="https://github.com/user-attachments/assets/2bc782d6-ed8b-4e7b-8a2b-f68d95315c4e" />

**Заполнение столбца event**

``` sql
update customers_nyc
set event = 'thank-you party';
```
<img width="549" height="402" alt="{F0787FA8-D490-4794-BE68-14BD9639D4C0}" src="https://github.com/user-attachments/assets/2ffe48d3-5d01-4ce3-abe7-0d2f8902e1f7" />

**Финальная проверка**

``` sql
select customer_id, first_name, last_name, postal_code, event
from customers_nyc
limit 20;
```
<img width="682" height="492" alt="{74884F84-B71E-4EF1-B99A-D54C3D34786B}" src="https://github.com/user-attachments/assets/9410d7bb-f3ad-43dd-a3f5-dba95b7192f0" />

---

## 🎯 Часть 2. Индивидуальные задания (вариант 9)

### Задание 2.1. Товары типа 'scooter' дороже 500

**Задание:** вывести все товары типа `'scooter'` с ценой (`base_msrp`) больше 500. Отсортировать результат по цене от самой высокой к самой низкой (по убыванию).

``` sql
select *
from products
where product_type = 'scooter' and base_msrp > 500
order by base_msrp desc;
```

<img width="767" height="439" alt="{75A5A730-6B2B-417C-9408-6B01B87C4F97}" src="https://github.com/user-attachments/assets/536157e4-57d5-47fd-9437-2c579a8d3796" />

### Задание 2.2. Продажи через интернет от 15000 до 30000

**Задание:** вывести все продажи, совершенные через канал 'internet', с суммой продажи (sales_amount) в диапазоне от 15000 до 30000 включительно.

``` sql
select *
from sales
where channel = 'internet' and sales_amount between 15000 and 30000;
```

<img width="703" height="654" alt="{6CEEAC33-9CD2-44CC-90A6-0C461F798AE5}" src="https://github.com/user-attachments/assets/284a7488-2ea9-4380-aed9-3b0eea807be4" />

### Задание 2.3*. CRUD (локально, mylocaldb)

**Задания:**

1. Создать таблицу `high_price` как копию товаров дороже 1000.

2. Увеличить цену на 10%.

3. Удалить товары, произведённые до 2012 года.

#### 📂 Подготовка: копирование исходной таблицы `products`

Для выполнения этого задания потребовалась таблица `products` из базы преподавателя. Она была скопирована в мою локальную базу `mylocaldb` командой в терминале виртуальной машины:

```bash
pg_dump -h localhost -p 5433 -U postgres -t products teacher_data | psql -h localhost -p 5433 -U postgres -d mylocaldb
password:1
```
**Результат команды:**

<img width="623" height="443" alt="{FE0E5550-53B6-4538-8994-7405E93230D5}" src="https://github.com/user-attachments/assets/731fe1e6-faaf-4e48-a7e1-016f17d4b58e" />

**Таблица в 'mylocaldb'**

Решила проверить наличие таблицы через select-запрос с выводом в 5 строк

<img width="685" height="463" alt="{EA296305-52BD-40CF-AAD2-AAB6DF12C9E1}" src="https://github.com/user-attachments/assets/9c70edd7-04a0-49c5-bf43-a78e7b452999" />

---



#### ⚙️ Выполнение заданий

**Создание таблицы `high_price` как копию товаров дороже 1000**

``` sql
create table high_price as
select * from products
where base_msrp > 1000;
```

<img width="465" height="392" alt="{EA9B44C0-82B9-491D-BB2B-2E32BC60E228}" src="https://github.com/user-attachments/assets/a82bac27-d203-4155-8859-c683dd58fb4c" />

**Проверка: сколько записей скопировалось**

```sql
select count(*) from high_price;
```

<img width="260" height="220" alt="{0FD0E911-25DB-4D2B-91FA-330917FC1357}" src="https://github.com/user-attachments/assets/24437e61-d5c3-4edf-9ebe-142715695c08" />

**Увеличение цены на 10%**

``` sql
update high_price
set base_msrp = base_msrp * 1.1;
```

<img width="310" height="295" alt="{5F4832FF-8427-4E6C-952B-6BEB6102692D}" src="https://github.com/user-attachments/assets/9f7e0173-9f0b-48af-ad4f-40c2dce430ba" />

**Проверка изменения цен**

```sql
select base_msrp from high_price;
```

<img width="277" height="281" alt="{987F21E4-314F-4568-A6A2-19BB547E3FAC}" src="https://github.com/user-attachments/assets/61c84755-4740-452d-a8cd-476461be8baf" />

**Удаление товаров, произведённых до 2012 года**

``` sql
delete from high_price
where production_start_date < '2012-01-01';
```

<img width="424" height="326" alt="{1E5B6380-1DE0-47EA-915A-F3B664F448B7}" src="https://github.com/user-attachments/assets/01d789c2-b1e1-4ad2-8bb8-33e4b98f0b11" />

**Финальная проверка**

``` sql
select * from high_price;
```

<img width="431" height="262" alt="{E1688A5F-62F5-4F66-9C92-A6E6AC3CCF9E}" src="https://github.com/user-attachments/assets/362e1e18-8c3f-4962-806a-7b7419ab8852" />

---

## 📌 Вывод

В ходе лабораторной работы были освоены:

✅ SELECT с фильтрацией, сортировкой и ограничением

✅ CRUD операции (CREATE, DELETE, ALTER, UPDATE)

✅ Работа с локальной и удалённой/восстановленной базой данных

✅ Подключение к PostgreSQL через DBeaver

✅ Копирование таблиц между базами данных

Все запросы выполнены корректно, результаты соответствуют ожидаемым.

## 🔗 Ссылки и ресурсы

| Ресурс | Описание | Ссылка |
|--------|----------|--------|
| 📚 **Репозиторий GitHub** | Все материалы лабораторной работы | [`practicum-sql`](https://github.com/Margarita-Eskova/practicum-sql) |
| 📄 **Отчёт (README)** | Текущий файл с отчётом | [`lab_01/README.md`](https://github.com/Margarita-Eskova/practicum-sql/blob/main/lab_01/README.md) |
| 💾 **SQL-запросы** | Все запросы в одном файле | [`lab_01/sql/lab_01.sql`](https://github.com/Margarita-Eskova/practicum-sql/blob/main/lab_01/sql/lab_01.sql) |
| 🖥️ **Образ ВМ** | Виртуальная машина от преподавателя | [🔗 Скачать OVA](https://disk.yandex.ru/d/QifTz8pa5XJX-A) |
| 🗄️ **Файлы дампа** | Дамп базы данных преподавателя | [🔗 Яндекс.Диск](https://disk.yandex.ru/d/p3ga3WZpmAw8-Q) |

---

## 🎉 Благодарность

Выражаю благодарность преподавателю **Босенко Тимуру Муртазовичу** за предоставленную виртуальную машину и дамп базы данных.
