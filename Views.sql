-- 1. Создать представление, которое выводит следующие колонки:
-- order_date, required_date, shipped_date, ship_postal_code, company_name, contact_name, phone, last_name, first_name, title из таблиц orders, customers и employees.
-- Сделать select к созданному представлению, выведя все записи, где order_date больше 1го января 1997 года.

CREATE VIEW orders_customers_employees AS 
SELECT order_date, required_date, shipped_date, ship_postal_code, company_name, contact_name, phone, last_name, first_name, title
FROM orders
JOIN customers USING (customer_id)
JOIN employees USING (employee_id);

SELECT *
FROM orders_customers_employees
WHERE order_date > '1997-01-01';

-- 2. Создать представление, которое выводит следующие колонки:
-- order_date, required_date, shipped_date, ship_postal_code, ship_country, company_name, contact_name, phone, last_name, first_name, title из таблиц orders, customers, employees.
-- Попробовать добавить к представлению (после его создания) колонки ship_country, postal_code и reports_to. Убедиться, что проихсодит ошибка. Переименовать представление и создать новое уже с дополнительными колонками.
-- Сделать к нему запрос, выбрав все записи, отсортировав их по ship_county.
-- Удалить переименованное представление.

ALTER VIEW orders_customers_employees RENAME TO oce_new_view;

CREATE OR REPLACE VIEW orders_customers_employees AS 
SELECT order_date, required_date, shipped_date, ship_country,
ship_postal_code, company_name, contact_name, customers.postal_code, 
phone, last_name, first_name, title, reports_to
FROM orders
JOIN customers USING (customer_id)
JOIN employees USING (employee_id);

SELECT *
FROM orders_customers_employees
ORDER BY ship_country;

DROP VIEW IF EXISTS oce_new_view;

-- 3. Создать представление "активных" (discontinued = 0) продуктов, содержащее все колонки. Представление должно быть защищено от вставки записей, в которых discontinued = 1.
-- Попробовать сделать вставку записи с полем discontinued = 1 - убедиться, что не проходит.

CREATE VIEW active_products AS 
SELECT *
FROM products
WHERE discontinued <> 1
WITH LOCAL CHECK OPTION;

INSERT INTO active_products
VALUES 
(79, 'mac', 1, 2, 'duck', 3, 4, 5, 3, 1);
