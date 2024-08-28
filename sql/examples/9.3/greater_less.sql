-- Q: Select books released after the year 2000?

SELECT * FROM books
WHERE released_year > 2000;

-- What Do You Expect?

SELECT 99 > 1; -- 1
SELECT 0 > 1; -- 0

-- Q: Select books released before the year 2000?

SELECT * FROM books
WHERE released_year < 2000;

-- Q: Select books released after or equal the year 2000?

SELECT * FROM books
WHERE released_year >= 2000;