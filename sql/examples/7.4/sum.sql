-- Q: sum all pages of each author

SELECT 
    CONCAT (author_fname, ' ', author_lname) as 'author',
    SUM(pages) AS 'total pages'
FROM books
GROUP BY author_fname, author_lname;

-- +----------------------+-------------+
-- | author               | total pages |
-- +----------------------+-------------+
-- | Jhumpa Lahiri        |         210 |
-- | Neil Gaiman          |         977 |
-- | Dave Eggers          |        1293 |
-- | Michael Chabon       |         634 |
-- +----------------------+-------------+
