-- 1. Вывести наименование продукта, цену продукта и столбец со значениями
-- too expensive если цена больше или равно 100
-- average если цена  больше или равно 50 но меньше 100
-- low price если цена меньше 50

SELECT product_name, unit_price,
CASE WHEN unit_price >= 100 THEN 'too expensive'
	 WHEN unit_price >= 50 AND unit_price < 100 THEN 'average'
	 ELSE 'low price'
END AS Категория_ценового_диапазона
FROM products
ORDER BY unit_price DESC; 

-- 2. Найти заказчиков, не сделавших ни одного заказа. Вывести имя заказчика и значение 'no orders' если order_id = NULL.

SELECT DISTINCT contact_name, COALESCE(order_id::text, 'no orders')
FROM customers
LEFT JOIN orders USING(customer_id)
WHERE order_id IS NULL;

-- 3. Вывести ФИО сотрудников и их должности. 
-- В случае если должность = Sales Representative вывести вместо неё Sales Stuff.

SELECT CONCAT(last_name, ' ', first_name) ФИО, 
	COALESCE(NULLIF(title,'Sales Representative'), 'Sales Stuff') Должность
FROM employees;