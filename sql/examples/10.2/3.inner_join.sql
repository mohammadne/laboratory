-- Q: give every customer corresponding order?

-- IMPLICIT INNER JOIN

SELECT *
FROM customers, orders
WHERE customers.id = orders.customer_id;

-- +----+------------+-----------+------------------+----+------------+--------+-------------+
-- | id | first_name | last_name | email            | id | order_date | amount | customer_id |
-- +----+------------+-----------+------------------+----+------------+--------+-------------+
-- |  1 | Boy        | George    | george@gmail.com |  1 | 2016-02-10 |  99.99 |           1 |
-- |  1 | Boy        | George    | george@gmail.com |  2 | 2017-11-11 |  35.50 |           1 |
-- |  2 | George     | Michael   | gm@gmail.com     |  3 | 2014-12-12 | 800.67 |           2 |
-- |  2 | George     | Michael   | gm@gmail.com     |  4 | 2015-01-03 |  12.50 |           2 |
-- |  5 | Bette      | Davis     | bette@aol.com    |  5 | 1999-04-11 | 450.25 |           5 |
-- +----+------------+-----------+------------------+----+------------+--------+-------------+

-- EXPLICIT INNER JOIN

SELECT *
FROM customers
JOIN orders ON customers.id = orders.customer_id;

-- OR

SELECT *
FROM orders
JOIN customers ON customers.id = orders.customer_id;

-- OR, inner join is most common, so the pure join == inner join

SELECT *
FROM orders
INNER JOIN customers ON customers.id = orders.customer_id;

-- focus that you can have a meaningless arbitrary join as follow

SELECT *
FROM customers
JOIN orders ON customers.id = orders.id;

-- +----+------------+-----------+------------------+----+------------+--------+-------------+
-- | id | first_name | last_name | email            | id | order_date | amount | customer_id |
-- +----+------------+-----------+------------------+----+------------+--------+-------------+
-- |  1 | Boy        | George    | george@gmail.com |  1 | 2016-02-10 |  99.99 |           1 |
-- |  2 | George     | Michael   | gm@gmail.com     |  2 | 2017-11-11 |  35.50 |           1 |
-- |  3 | David      | Bowie     | david@gmail.com  |  3 | 2014-12-12 | 800.67 |           2 |
-- |  4 | Blue       | Steele    | blue@gmail.com   |  4 | 2015-01-03 |  12.50 |           2 |
-- |  5 | Bette      | Davis     | bette@aol.com    |  5 | 1999-04-11 | 450.25 |           5 |
-- +----+------------+-----------+------------------+----+------------+--------+-------------+

SELECT *
FROM orders
JOIN customers ON customers.id = orders.customer_id
ORDER BY amount;

-- +----+------------+--------+-------------+----+------------+-----------+------------------+
-- | id | order_date | amount | customer_id | id | first_name | last_name | email            |
-- +----+------------+--------+-------------+----+------------+-----------+------------------+
-- |  4 | 2015-01-03 |  12.50 |           2 |  2 | George     | Michael   | gm@gmail.com     |
-- |  2 | 2017-11-11 |  35.50 |           1 |  1 | Boy        | George    | george@gmail.com |
-- |  1 | 2016-02-10 |  99.99 |           1 |  1 | Boy        | George    | george@gmail.com |
-- |  5 | 1999-04-11 | 450.25 |           5 |  5 | Bette      | Davis     | bette@aol.com    |
-- |  3 | 2014-12-12 | 800.67 |           2 |  2 | George     | Michael   | gm@gmail.com     |
-- +----+------------+--------+-------------+----+------------+-----------+------------------+

SELECT CONCAT (first_name, ' ', last_name) AS 'customer', COUNT(*)
FROM customers
JOIN orders ON customers.id = orders.customer_id
GROUP BY orders.customer_id;

-- +----------------+----------+
-- | customer       | COUNT(*) |
-- +----------------+----------+
-- | Boy George     |        2 |
-- | George Michael |        2 |
-- | Bette Davis    |        1 |
-- +----------------+----------+

-- Q: find the total spending for each customer?

SELECT 
    first_name,
    last_name,
    order_date,
    SUM(amount) as 'total spent'
FROM customers
JOIN orders ON customers.id = orders.customer_id
GROUP BY orders.customer_id
ORDER BY total_spent DESC;

-- +------------+-----------+-------------+
-- | first_name | last_name | total spent |
-- +------------+-----------+-------------+
-- | George     | Michael   |      813.17 |
-- | Bette      | Davis     |      450.25 |
-- | Boy        | George    |      135.49 |
-- +------------+-----------+-------------+
