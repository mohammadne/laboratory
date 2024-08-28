SELECT MIN(released_year) FROM books;

-- +--------------------+
-- | MIN(released_year) |
-- +--------------------+
-- |               1945 |
-- +--------------------+

-- Q: question: show the title of maximum book which have max pages?

-- WRONG answer: 
SELECT MAX(pages), title 
FROM books;
-- it's wrong because the title is independent from Max(page)
-- it will return just one row and then, the first title in our data
-- will fill the blank space.

-- A1: using subqueries
-- disadvantage: it's a little bit slow because it's 2 independent query
SELECT title, pages 
FROM books 
WHERE pages = (SELECT MIN(pages) FROM books);

-- A2: trick
SELECT title, pages 
FROM books 
ORDER BY pages DESC 
LIMIT 1;
