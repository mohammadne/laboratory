SELECT author_fname FROM books ORDER BY author_lname DESC;

-- +--------------+
-- | author_fname |
-- +--------------+
-- | John         |
-- | Patti        |
-- +--------------+

SELECT title, released_year FROM books ORDER BY released_year;

-- +-----------------------------------------------------+---------------+
-- | title                                               | released_year |
-- +-----------------------------------------------------+---------------+
-- | Cannery Row                                         |          1945 |
-- | What We Talk About When We Talk About Love: Stories |          1981 |
-- | White Noise                                         |          1985 |
-- | Where I'm Calling From: Selected Stories            |          1989 |
-- | Interpreter of Maladies                             |          1996 |
-- +-----------------------------------------------------+---------------+

SELECT title, released_year FROM books ORDER BY 2;

-- it will filter based on released_year column
-- same as above

SELECT DISTINCT author_fname, author_lname 
FROM books 
ORDER BY author_lname, author_fname;

-- +--------------+----------------+
-- | author_fname | author_lname   |
-- +--------------+----------------+
-- | Raymond      | Carver         |
-- | Michael      | Chabon         |
-- | Don          | DeLillo        |
-- | Dave         | Eggers         |
-- | David        | Foster Wallace |
-- | Neil         | Gaiman         |
-- +--------------+----------------+
