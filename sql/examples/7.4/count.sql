SELECT COUNT(DISTINCT author_fname) FROM books;

-- +------------------------------+
-- | COUNT(DISTINCT author_fname) |
-- +------------------------------+
-- |                           12 |
-- +------------------------------+

SELECT DISTINCT author_lname, author_fname  FROM books  WHERE title  LIKE '%the%';

-- +--------------+--------------+
-- | author_lname | author_fname |
-- +--------------+--------------+
-- | Lahiri       | Jhumpa       |
-- | Eggers       | Dave         |
-- | Chabon       | Michael      |
-- +--------------+--------------+

SELECT COUNT(DISTINCT author_lname, author_fname) AS 'selection count'
FROM books 
WHERE title 
LIKE '%the%';

-- +-----------------+
-- | selection count |
-- +-----------------+
-- |               3 |
-- +-----------------+

SELECT CONCAT('In ', released_year, ' ', COUNT(*), ' book(s) released') AS year 
FROM books 
GROUP BY released_year;

-- +----------------------------+
-- | year                       |
-- +----------------------------+
-- | In 2003 2 book(s) released |
-- | In 2016 1 book(s) released |
-- | In 2001 2 book(s) released |
-- | In 1996 1 book(s) released |
-- | In 2012 1 book(s) released |
-- | In 2013 1 book(s) released |
-- | In 2000 1 book(s) released |
-- +----------------------------+