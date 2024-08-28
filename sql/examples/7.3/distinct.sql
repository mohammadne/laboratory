SELECT author_lname FROM books;

-- +----------------+
-- | author_lname   |
-- +----------------+
-- | Lahiri         |
-- | Gaiman         |
-- | Gaiman         |
-- | Lahiri         |
-- | Eggers         |
-- | Eggers         |
-- | Chabon         |
-- | Smith          |
-- | Eggers         |
-- | Gaiman         |
-- | Carver         |
-- | Carver         |
-- | DeLillo        |
-- | Steinbeck      |
-- | Foster Wallace |
-- | Foster Wallace |
-- +----------------+
-- 16 rows in set (0.00 sec)

SELECT DISTINCT author_lname FROM books;

-- +----------------+
-- | author_lname   |
-- +----------------+
-- | Lahiri         |
-- | Gaiman         |
-- | Eggers         |
-- | Chabon         |
-- | Smith          |
-- | Carver         |
-- | DeLillo        |
-- | Steinbeck      |
-- | Foster Wallace |
-- +----------------+
-- 9 rows in set (0.00 sec)

SELECT DISTINCT 
    CONCAT (author_fname,' ', author_lname) AS 'full name',
    SUBSTRING(title, 1, 10) AS 'short title'
FROM books;

-- +----------------------+-------------+
-- | full name            | short title |
-- +----------------------+-------------+
-- | Jhumpa Lahiri        | The Namesa  |
-- | Neil Gaiman          | Norse Myth  |
-- | Neil Gaiman          | American G  |
-- | Jhumpa Lahiri        | Interprete  |
-- | Dave Eggers          | A Hologram  |
-- | Dave Eggers          | The Circle  |
-- | Michael Chabon       | The Amazin  |
-- | Patti Smith          | Just Kids   |
-- | Dave Eggers          | A Heartbre  |
-- | Neil Gaiman          | Coraline    |
-- | Raymond Carver       | What We Ta  |
-- | Raymond Carver       | Where I'm   |
-- | Don DeLillo          | White Nois  |
-- | John Steinbeck       | Cannery Ro  |
-- | David Foster Wallace | Oblivion:   |
-- | David Foster Wallace | Consider t  |
-- +----------------------+-------------+
-- 16 rows in set (0.00 sec)
