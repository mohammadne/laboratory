SELECT *
FROM customers
LEFT JOIN orders 
    ON customers.id = orders.customer_id;

-- +----+------------+-----------+------------------+------+------------+--------+-------------+
-- | id | first_name | last_name | email            | id   | order_date | amount | customer_id |
-- +----+------------+-----------+------------------+------+------------+--------+-------------+
-- |  1 | Boy        | George    | george@gmail.com |    2 | 2017-11-11 |  35.50 |           1 |
-- |  1 | Boy        | George    | george@gmail.com |    1 | 2016-02-10 |  99.99 |           1 |
-- |  2 | George     | Michael   | gm@gmail.com     |    4 | 2015-01-03 |  12.50 |           2 |
-- |  2 | George     | Michael   | gm@gmail.com     |    3 | 2014-12-12 | 800.67 |           2 |
-- |  3 | David      | Bowie     | david@gmail.com  | NULL | NULL       |   NULL |        NULL |
-- |  4 | Blue       | Steele    | blue@gmail.com   | NULL | NULL       |   NULL |        NULL |
-- |  5 | Bette      | Davis     | bette@aol.com    |    5 | 1999-04-11 | 450.25 |           5 |
-- +----+------------+-----------+------------------+------+------------+--------+-------------+

SELECT 
    first_name,
    last_name,
    IFNULL(SUM(amount), 0) as 'total_spent'
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.id
ORDER BY total_spent DESC;

-- +------------+-----------+-------------+
-- | first_name | last_name | total spent |
-- +------------+-----------+-------------+
-- | David      | Bowie     |        0.00 |
-- | Blue       | Steele    |        0.00 |
-- | Boy        | George    |      135.49 |
-- | Bette      | Davis     |      450.25 |
-- | George     | Michael   |      813.17 |
-- +------------+-----------+-------------+
