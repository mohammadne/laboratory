-- Q: find max released book pages of any author?

SELECT 
    CONCAT(author_fname, ' ', author_lname) AS author,
    Max(pages) AS 'longets book'
FROM books
GROUP BY author_fname, author_lname;

-- +----------------------+--------------+
-- | author               | longets book |
-- +----------------------+--------------+
-- | Jhumpa Lahiri        |          291 |
-- | Neil Gaiman          |          465 |
-- | Dave Eggers          |          504 |
-- | Michael Chabon       |          634 |
-- | Patti Smith          |          304 |
-- +----------------------+--------------+

-- Q: find the year each author published their longest book?

-- select w.userID,count(w.id) 
-- FROM (select id,max(bidAmount),userID from Bids group by id, userID) w 
-- group by w.userID

SELECT 
    CONCAT (author_fname, ' ', author_lname) AS 'author',
    released_year
FROM (SELECT * FROM books GROUP BY author_fname, author_lname ORDER BY pages) w;

SELECT *
FROM (SELECT author_fname, COUNT(*) as 'number' FROM books GROUP BY author_fname, author_lname ORDER BY pages);

--  SELECT author_fname, COUNT(*) as 'number' FROM books GROUP BY author_fname, author_lname ORDER BY pages;

-- SELECT
--     CONCAT (author_fname, ' ', author_lname) AS 'author',
--     Max(pages) AS 'longets book',
--     released_year
-- FROM books
-- ORDER BY released_year DESC
-- GROUP BY author_fname, author_lname;
