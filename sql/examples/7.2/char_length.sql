SELECT CHAR_LENGTH ('Hello World') AS length;

-- +--------+
-- | length |
-- +--------+
-- |     11 |
-- +--------+

SELECT author_lname, CHAR_LENGTH (author_lname) AS 'length' FROM books;

-- +----------------+--------+
-- | author_lname   | length |
-- +----------------+--------+
-- | Lahiri         |      6 |
-- | Gaiman         |      6 |
-- +----------------+--------+


SELECT 
    CONCAT (author_lname, ' is ', Char_length (author_lname), ' characters long') AS 'author description'
FROM books;

-- +-------------------------------------+
-- | author description                  |
-- +-------------------------------------+
-- | Lahiri is 6 characters long          |
-- | Gaiman is 6 characters long          |
-- +-------------------------------------+
