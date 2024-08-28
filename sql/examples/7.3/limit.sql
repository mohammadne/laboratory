SELECT title FROM books ORDER BY pages DESC LIMIT 3;

-- +-------------------------------------------+
-- | title                                     |
-- +-------------------------------------------+
-- | The Amazing Adventures of Kavalier & Clay |
-- | Where I'm Calling From: Selected Stories  |
-- | The Circle                                |
-- +-------------------------------------------+
-- 3 rows in set (0.00 sec)

SELECT title FROM books ORDER BY pages DESC LIMIT 1,3;

-- +------------------------------------------+
-- | title                                    |
-- +------------------------------------------+
-- | Where I'm Calling From: Selected Stories |
-- | The Circle                               |
-- | American Gods                            |
-- +------------------------------------------+
-- 3 rows in set (0.00 sec)
