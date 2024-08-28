SELECT author_lname, COUNT(*) FROM books GROUP BY author_lname;

-- +----------------+----------+
-- | author_lname   | COUNT(*) |
-- +----------------+----------+
-- | Lahiri         |        2 |
-- | Gaiman         |        3 |
-- | Eggers         |        3 |
-- +----------------+----------+

SELECT 
    CONCAT (author_fname, ' ', author_lname) AS 'full name', COUNT(*) AS 'number' 
FROM books 
GROUP BY author_fname, author_lname;

-- +----------------------+--------+
-- | full name            | number |
-- +----------------------+--------+
-- | Jhumpa Lahiri        |      2 |
-- | Neil Gaiman          |      3 |
-- | Dave Eggers          |      3 |
-- | Michael Chabon       |      1 |
-- +----------------------+--------+

-- it will group by unique author_lname and author_fname combination

SELECT CONCAT('In ', released_year, ' ', COUNT(*), ' book(s) released')
    AS 'books per year'
    FROM books 
    WHERE released_year BETWEEN 2000 AND 2010
    GROUP BY released_year
    ORDER BY released_year DESC;

-- +----------------------------+
-- | books per year             |
-- +----------------------------+
-- | In 2010 1 book(s) released |
-- | In 2005 1 book(s) released |
-- | In 2004 1 book(s) released |
-- | In 2003 2 book(s) released |
-- | In 2001 3 book(s) released |
-- | In 2000 1 book(s) released |
-- +----------------------------+

select author_lname, released_year, COUNT(*) 
FROM books 
GROUP BY author_lname;

-- +----------------+---------------+----------+
-- | author_lname   | released_year | COUNT(*) |
-- +----------------+---------------+----------+
-- | Lahiri         |          2003 |        2 |
-- | Gaiman         |          2016 |        3 |
-- | Eggers         |          2012 |        3 |
-- +----------------+---------------+----------+

select author_lname, released_year from books;

-- +----------------+---------------+
-- | author_lname   | released_year |
-- +----------------+---------------+
-- | Lahiri         |          2003 |
-- | Gaiman         |          2016 |
-- | Gaiman         |          2001 |
-- | Lahiri         |          1996 |
-- +----------------+---------------+