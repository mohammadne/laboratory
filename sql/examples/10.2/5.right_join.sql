SELECT *
FROM customers
RIGHT JOIN orders 
    ON customers.id = orders.customer_id;

-- +------+------------+-----------+------------------+----+------------+--------+-------------+
-- | id   | first_name | last_name | email            | id | order_date | amount | customer_id |
-- +------+------------+-----------+------------------+----+------------+--------+-------------+
-- |    1 | Boy        | George    | george@gmail.com |  1 | 2016-02-10 |  99.99 |           1 |
-- |    1 | Boy        | George    | george@gmail.com |  2 | 2017-11-11 |  35.50 |           1 |
-- |    2 | George     | Michael   | gm@gmail.com     |  3 | 2014-12-12 | 800.67 |           2 |
-- |    2 | George     | Michael   | gm@gmail.com     |  4 | 2015-01-03 |  12.50 |           2 |
-- |    5 | Bette      | Davis     | bette@aol.com    |  5 | 1999-04-11 | 450.25 |           5 |
-- +------+------------+-----------+------------------+----+------------+--------+-------------+

-- in our case the right join is exactly the same as inner join
-- because we don't have any orders that don't have customer
-- if we could be wrong and delete some users, then some orders have no any customers
-- then the customer of orders in right join will be null
-- but in inner join we don't have them but becasue of foreign key constraints
-- it's not possible, so  drop tables and recreate them without foreign key.
