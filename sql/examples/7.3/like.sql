SELECT author_fname FROM books WHERE author_fname LIKE '%da%';

-- +--------------+
-- | author_fname |
-- +--------------+
-- | Dave         |
-- | David        |
-- | Dan          |
-- | Freida       |
-- +--------------+

SELECT title, author_fname FROM books WHERE author_fname LIKE 'da%';

SELECT title FROM books WHERE  title LIKE 'the';

-- Empty set (0.00 sec)

SELECT title FROM books WHERE  title LIKE '%the';

-- Empty set (0.00 sec)

SELECT title FROM books WHERE title LIKE '%the%';

-- +-------------------------------------------+
-- | title                                     |
-- +-------------------------------------------+
-- | The Namesake                              |
-- | A Hologram for the King: A Novel          |
-- | The Circle                                |
-- +-------------------------------------------+

SELECT title, stock_quantity FROM books WHERE stock_quantity LIKE '____';

-- +----------------------+----------------+
-- | title                | stock_quantity |
-- +----------------------+----------------+
-- | Lincoln In The Bardo |           1000 |
-- +----------------------+----------------+

SELECT title FROM books WHERE title LIKE '%\%%';

-- +-------------+
-- | title       |
-- +-------------+
-- | 10% Happier |
-- +-------------+

SELECT title FROM books WHERE title LIKE '%\_%';

-- +-----------+
-- | title     |
-- +-----------+
-- | fake_book |
-- +-----------+
