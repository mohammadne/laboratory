-- Q: average stock quantity for books released in the same year?

SELECT
    released_year,
    AVG(stock_quantity) 
FROM books
GROUP BY released_year;

-- Q: average pages of each author? 

SELECT
    CONCAT (author_fname, ' ', author_lname) AS 'author',
    AVG(pages) AS 'average pages'
FROM books
GROUP BY author_fname, author_lname;

-- +----------------------+---------------+
-- | author               | average pages |
-- +----------------------+---------------+
-- | Jhumpa Lahiri        |      105.0000 |
-- | Neil Gaiman          |      325.6667 |
-- | Dave Eggers          |      431.0000 |
-- | Michael Chabon       |      634.0000 |
-- +----------------------+---------------+

