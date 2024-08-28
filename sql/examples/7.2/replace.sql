SELECT REPLACE ('Hello World', 'Hell', '&%#@');

-- +----------------------------------------+
-- | REPLACE('Hello World', 'Hell', '&%#@') |
-- +----------------------------------------+
-- | &%#@o World                            |
-- +----------------------------------------+

SELECT 
    REPLACE (SUBSTRING(title, 1, 10), 'e', '3') AS 'Wierd String'
FROM books;

-- +--------------+
-- | weird string |
-- +--------------+
-- | Th3 Nam3sa   |
-- | Nors3 Myth   |
-- +--------------+