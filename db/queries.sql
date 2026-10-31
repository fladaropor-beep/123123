-- ShoeShop: полный файл SQL-запросов для MySQL Workbench
-- База данных: shoe_shop
-- Рекомендация: запускайте запросы по одному, выделяя нужный блок.
-- Этот файл не удаляет и не изменяет существующие товары.

USE shoe_shop;

-- 1. Проверка количества записей
SELECT COUNT(*) AS products_count FROM products;
SELECT COUNT(*) AS users_count FROM users;
SELECT COUNT(*) AS categories_count FROM categories;

-- 2. Просмотр первых 10 товаров
SELECT *
FROM products
LIMIT 10;

-- 3. Каталог товаров с названиями категорий, производителей и поставщиков
SELECT
    p.id,
    p.article,
    p.name,
    p.unit,
    p.price,
    p.discount,
    p.stock_qty,
    p.description,
    p.photo,
    c.name AS category,
    m.name AS manufacturer,
    s.name AS supplier
FROM products AS p
LEFT JOIN categories AS c ON c.id = p.category_id
LEFT JOIN manufacturers AS m ON m.id = p.manufacturer_id
LEFT JOIN suppliers AS s ON s.id = p.supplier_id
ORDER BY p.name ASC;

-- 4. Поиск товара по названию.
-- Измени значение @search_text на нужное слово.
SET @search_text = '';
SELECT
    id, article, name, price, discount, stock_qty
FROM products
WHERE CAST(name AS BINARY) LIKE CAST(CONCAT('%', @search_text, '%') AS BINARY)
ORDER BY name ASC;

-- 5. Сортировка товаров по цене: от дешёвых к дорогим
SELECT id, article, name, price, stock_qty
FROM products
ORDER BY price ASC, name ASC;

-- 6. Сортировка товаров по остатку: от большего к меньшему
SELECT id, article, name, price, stock_qty
FROM products
ORDER BY stock_qty DESC, name ASC;

-- 7. Справочники для фильтров
SELECT id, name FROM categories ORDER BY name;
SELECT id, name FROM manufacturers ORDER BY name;
SELECT id, name FROM suppliers ORDER BY name;

-- 8. Просмотр товара с минимальным ID
SET @product_id = (SELECT MIN(id) FROM products);
SELECT *
FROM products
WHERE id = @product_id;

-- 9. Проверка использования товара в заказах.
-- Запрос предполагает, что таблица prodorders содержит поле product_id.
SELECT COUNT(*) AS used_in_orders
FROM prodorders
WHERE product_id = @product_id;

-- 10. Пример авторизации.
-- Замените значения на реальные данные пользователя.
-- BINARY помогает избежать конфликта collation при сравнении.
SET @login = 'admin';
SET @password = 'admin';
SELECT u.*
FROM users AS u
WHERE BINARY u.login = BINARY @login
  AND BINARY u.password = BINARY @password;

-- 11. ШАБЛОН ДОБАВЛЕНИЯ ТОВАРА — закомментирован, автоматически не выполняется.
-- Перед использованием проверьте обязательные поля и ID справочников.
 /*
INSERT INTO products
(article, name, unit, price, discount, stock_qty, description, photo,
 category_id, manufacturer_id, supplier_id)
VALUES
('NEW-001', 'Тестовый товар', 'шт.', 100.00, 0, 10, 'Описание товара', '',
 1, 1, 1);
*/

-- 12. ШАБЛОН ИЗМЕНЕНИЯ ТОВАРА — закомментирован.
 /*
UPDATE products
SET name = 'Новое название', price = 150.00, stock_qty = 20
WHERE id = 1;
*/

-- 13. ШАБЛОН УДАЛЕНИЯ ТОВАРА — закомментирован.
-- Перед удалением обязательно проверьте связи с заказами.
 /*
DELETE FROM products
WHERE id = 1;
*/
