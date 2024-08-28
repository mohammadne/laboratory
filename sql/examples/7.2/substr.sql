SELECT SUBSTRING('Hello world', 1, 4);

-- +--------------------------------+
-- | SUBSTRING('Hello world', 1, 4) |
-- +--------------------------------+
-- | Hell                           |
-- +--------------------------------+

SELECT 
    author_fname as 'f_name',
    SUBSTRING(title, 1, 10) as 'short title'
FROM books;

-- +---------+-------------+
-- | f_name  | short title |
-- +---------+-------------+
-- | Jhumpa  | The Namesa  |
-- | Neil    | Norse Myth  |
-- +---------+-------------+

SELECT 
    author_fname as 'f_name',
    CONCAT (author_fname, ' ', author_lname),
    SUBSTRING(title, 1, 10) as 'short title'
FROM books;

-- +---------+------------------------------------------+-------------+
-- | fname   | CONCAT (author_fname, ' ', author_lname) | short title |
-- +---------+------------------------------------------+-------------+
-- | Jhumpa  | Jhumpa Lahiri                            | The Namesa  |
-- | Neil    | Neil Gaiman                              | Norse Myth  |
-- +---------+------------------------------------------+-------------+
