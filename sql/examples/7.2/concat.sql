SELECT author_fname, author_lname FROM books;

-- +--------------+----------------+
-- | author_fname | author_lname   |
-- +--------------+----------------+
-- | Jhumpa       | Lahiri         |
-- | Neil         | Gaiman         |
-- +--------------+----------------+

SELECT CONCAT ('Hello', '...', 'World');

-- +----------------------------------+
-- | CONCAT ('Hello', '...', 'World') |
-- +----------------------------------+
-- | Hello...World                    |
-- +----------------------------------+

SELECT CONCAT (author_fname, ' ', author_lname) FROM books;

-- +------------------------------------------+
-- | CONCAT (author_fname, ' ', author_lname) |
-- +------------------------------------------+
-- | Jhumpa Lahiri                            |
-- | Neil Gaiman                              |
-- +------------------------------------------+

SELECT CONCAT(author_fname, ' ', author_lname) AS 'fullname' FROM books;

-- +----------------------+
-- | fullname             |
-- +----------------------+
-- | Jhumpa Lahiri        |
-- | Neil Gaiman          |
-- +----------------------+

SELECT author_fname as fname, author_lname as lname, 
CONCAT (author_fname, ' ', author_lname) AS 'full name' 
FROM books;

-- +---------+----------------+----------------------+
-- | fname   | lname          | full name            |
-- +---------+----------------+----------------------+
-- | Jhumpa  | Lahiri         | Jhumpa Lahiri        |
-- | Neil    | Gaiman         | Neil Gaiman          |
-- +---------+----------------+----------------------+


SELECT CONCAT_WS(' - ', title, author_fname, author_lname) AS 'description' FROM books;

-- +-------------------------------------------------+
-- | description                                     |
-- +-------------------------------------------------+
-- | The Namesake - Jhumpa - Lahiri                  |
-- | Norse Mythology - Neil - Gaiman                 |
-- +-------------------------------------------------+
